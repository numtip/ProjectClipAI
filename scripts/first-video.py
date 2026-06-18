"""
ProjectClipsAI — First LTX Video Render (v2 with separate CLIP loader)
Creates an LTX image-to-video workflow and executes it via ComfyUI API.
"""

import json, time, urllib.request, os, shutil, sys

COMFY_HOST = "http://127.0.0.1:8188"
INPUT_IMAGE = r"F:\ProjectClipsAI\projects\000-first-clip\assets\first-render-001.png"
OUTPUT_DIR = r"F:\ProjectClipsAI\projects\000-first-clip\outputs"
WORKFLOW_DIR = r"F:\ProjectClipsAI\workflows\comfyui\first-video"
COMFY_INPUT_DIR = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\input"

# Copy input image to ComfyUI input directory
os.makedirs(COMFY_INPUT_DIR, exist_ok=True)
input_filename = "first-render-001.png"
shutil.copy2(INPUT_IMAGE, os.path.join(COMFY_INPUT_DIR, input_filename))

PROMPT = "cinematic push-in, slow camera movement, gentle dolly forward, atmospheric, volumetric lighting, mist, sci-fi agricultural domes at sunrise, photorealistic"
NEGATIVE = "blurry, low quality, distorted, ugly, deformed, fast motion, jittery, flickering, bad anatomy"

def build_workflow(seed=42):
    return {
        # 1. Load image
        "1": {
            "class_type": "LoadImage",
            "inputs": {"image": input_filename}
        },
        # 2. Load LTX model checkpoint (model + vae, clip is None)
        "2": {
            "class_type": "CheckpointLoaderSimple",
            "inputs": {"ckpt_name": "ltx-video-2b-v0.9.1.safetensors"}
        },
        # 3. Load T5 text encoder separately for LTX
        "3": {
            "class_type": "CLIPLoader",
            "inputs": {
                "clip_name": "t5xxl_fp8_e4m3fn.safetensors",
                "type": "ltxv"
            }
        },
        # 4. CLIP text encode (positive) - using separate CLIP
        "4": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": PROMPT, "clip": ["3", 0]}
        },
        # 5. CLIP text encode (negative) - using separate CLIP
        "5": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": NEGATIVE, "clip": ["3", 0]}
        },
        # 6. LTXV image-to-video conditioning
        "6": {
            "class_type": "LTXVImgToVideo",
            "inputs": {
                "positive": ["4", 0],
                "negative": ["5", 0],
                "vae": ["2", 2],
                "image": ["1", 0],
                "width": 768,
                "height": 512,
                "length": 97,
                "batch_size": 1,
                "strength": 1.0
            }
        },
        # 7. KSampler
        "7": {
            "class_type": "KSampler",
            "inputs": {
                "seed": seed,
                "steps": 25,
                "cfg": 4.0,
                "sampler_name": "euler",
                "scheduler": "normal",
                "denoise": 1.0,
                "model": ["2", 0],
                "positive": ["6", 0],
                "negative": ["6", 1],
                "latent_image": ["6", 2]
            }
        },
        # 8. VAE decode
        "8": {
            "class_type": "VAEDecode",
            "inputs": {"samples": ["7", 0], "vae": ["2", 2]}
        },
        # 9. Create video from frames
        "9": {
            "class_type": "CreateVideo",
            "inputs": {
                "images": ["8", 0],
                "fps": 24.0
            }
        },
        # 10. Save video
        "10": {
            "class_type": "SaveVideo",
            "inputs": {
                "video": ["9", 0],
                "filename_prefix": "first-video",
                "format": "mp4",
                "codec": "h264"
            }
        }
    }

def queue_prompt(workflow):
    data = json.dumps({"prompt": workflow}).encode("utf-8")
    req = urllib.request.Request(
        f"{COMFY_HOST}/prompt", data=data,
        headers={"Content-Type": "application/json"}
    )
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())

def get_history(prompt_id):
    with urllib.request.urlopen(f"{COMFY_HOST}/history/{prompt_id}") as resp:
        return json.loads(resp.read())

def wait_for_completion(prompt_id, timeout=600):
    start = time.time()
    while time.time() - start < timeout:
        try:
            history = get_history(prompt_id)
            if prompt_id in history:
                return history[prompt_id]
        except: pass
        time.sleep(3)
    raise TimeoutError("Render did not complete within timeout")

def main():
    # Check connectivity
    try:
        with urllib.request.urlopen(f"{COMFY_HOST}/", timeout=5) as r:
            print(f"[OK] ComfyUI reachable (HTTP {r.status})")
    except Exception as e:
        print(f"[FAIL] Cannot reach ComfyUI: {e}")
        sys.exit(1)

    # Build and save workflow JSON
    workflow = build_workflow(seed=42)
    os.makedirs(WORKFLOW_DIR, exist_ok=True)
    wf_path = os.path.join(WORKFLOW_DIR, "first-video.json")
    with open(wf_path, "w") as f:
        json.dump(workflow, f, indent=2)
    print(f"[OK] Workflow saved to {wf_path}")

    # Queue prompt
    print(f"[*] Queuing LTX video render (768x512, 97 frames, seed=42)...")
    result = queue_prompt(workflow)
    prompt_id = result["prompt_id"]
    print(f"[*] Prompt ID: {prompt_id}")
    print(f"[*] Waiting for render (this may take several minutes)...")

    # Wait
    history = wait_for_completion(prompt_id)
    status = history.get("status", {})
    exec_time = status.get("execution_time", 0)
    print(f"[*] Execution time: {exec_time:.1f}s")

    # Check for errors
    error_msgs = []
    for msg in status.get("messages", []):
        if msg[0] == "execution_error":
            error_msgs.append(msg[1].get("exception_message", "Unknown error"))
            print(f"[FAIL] Node {msg[1].get('node_id')}: {msg[1].get('exception_message')}")
    
    if error_msgs:
        print("[FAIL] Render completed with errors")
        return False

    # Find output
    outputs = history.get("outputs", {})
    found = False
    for node_id, node_out in outputs.items():
        for key, val in node_out.items():
            if isinstance(val, list):
                for item in val:
                    if isinstance(item, dict) and "filename" in item:
                        src = os.path.join(
                            r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\output",
                            item["filename"]
                        )
                        if os.path.exists(src):
                            dst = os.path.join(OUTPUT_DIR, "first-video-001.mp4")
                            os.makedirs(OUTPUT_DIR, exist_ok=True)
                            shutil.copy2(src, dst)
                            size_mb = os.path.getsize(dst) / (1024*1024)
                            print(f"[OK] Video saved to {dst} ({size_mb:.1f} MB)")
                            found = True

    if not found:
        outputs_dir = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\output"
        print("[WARN] No output file found in ComfyUI output")
        if os.path.exists(outputs_dir):
            print(f"Files in output dir: {os.listdir(outputs_dir)[:20]}")

    return found

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
