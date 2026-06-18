"""
ProjectClipsAI — First Realistic LTX Video Clip (002)
5s motion-first I2V with refined settings.
"""

import json, time, urllib.request, os, shutil, sys

COMFY_HOST = "http://127.0.0.1:8188"
INPUT_IMAGE = r"F:\ProjectClipsAI\projects\000-first-clip\assets\first-render-001.png"
OUTPUT_DIR = r"F:\ProjectClipsAI\projects\000-first-clip\outputs"
WORKFLOW_DIR = r"F:\ProjectClipsAI\workflows\comfyui\first-video"
COMFY_INPUT_DIR = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\input"

os.makedirs(COMFY_INPUT_DIR, exist_ok=True)
input_filename = "first-render-001.png"
shutil.copy2(INPUT_IMAGE, os.path.join(COMFY_INPUT_DIR, input_filename))

# Motion-first prompt (not scene-first)
# Emphasizes camera motion and atmospheric movement over subject description
PROMPT = (
    "slow cinematic push-in, subtle morning haze drifting, "
    "soft sunlight shimmer, gentle movement in trees and atmosphere, "
    "realistic camera motion, stable composition"
)
NEGATIVE = (
    "blurry, low quality, distorted, ugly, deformed, "
    "fast motion, jittery, flickering, bad anatomy, "
    "character, person, human, face, "
    "warping, morphing, artifacts, noise"
)

# 5 seconds @ 24fps = 120 frames
# LTX length must satisfy: length % 8 == 1
# 121 = 15*8 + 1 = 5.04s

FRAMES = 121
FPS = 24.0
SEED = 12345  # new seed for second attempt

def build_workflow(seed=SEED):
    return {
        "1": {
            "class_type": "LoadImage",
            "inputs": {"image": input_filename}
        },
        "2": {
            "class_type": "CheckpointLoaderSimple",
            "inputs": {"ckpt_name": "ltx-video-2b-v0.9.1.safetensors"}
        },
        "3": {
            "class_type": "CLIPLoader",
            "inputs": {
                "clip_name": "t5xxl_fp8_e4m3fn.safetensors",
                "type": "ltxv"
            }
        },
        "4": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": PROMPT, "clip": ["3", 0]}
        },
        "5": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": NEGATIVE, "clip": ["3", 0]}
        },
        "6": {
            "class_type": "LTXVImgToVideo",
            "inputs": {
                "positive": ["4", 0],
                "negative": ["5", 0],
                "vae": ["2", 2],
                "image": ["1", 0],
                "width": 768,
                "height": 512,
                "length": FRAMES,
                "batch_size": 1,
                "strength": 1.0
            }
        },
        "7": {
            "class_type": "KSampler",
            "inputs": {
                "seed": seed,
                "steps": 30,
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
        "8": {
            "class_type": "VAEDecode",
            "inputs": {"samples": ["7", 0], "vae": ["2", 2]}
        },
        "9": {
            "class_type": "CreateVideo",
            "inputs": {
                "images": ["8", 0],
                "fps": FPS
            }
        },
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
    try:
        with urllib.request.urlopen(f"{COMFY_HOST}/", timeout=5) as r:
            print(f"[OK] ComfyUI reachable (HTTP {r.status})")
    except Exception as e:
        print(f"[FAIL] Cannot reach ComfyUI: {e}")
        sys.exit(1)

    workflow = build_workflow(seed=SEED)
    os.makedirs(WORKFLOW_DIR, exist_ok=True)
    wf_path = os.path.join(WORKFLOW_DIR, "first-video-002.json")
    with open(wf_path, "w") as f:
        json.dump(workflow, f, indent=2)
    print(f"[OK] Workflow saved to {wf_path}")

    print(f"[*] Queuing LTX video render ({FRAMES}frames @ {FPS}fps = {FRAMES/FPS:.1f}s, 768x512, seed={SEED}, 30 steps)...")
    result = queue_prompt(workflow)
    prompt_id = result["prompt_id"]
    print(f"[*] Prompt ID: {prompt_id}")
    print(f"[*] Waiting (this will take longer due to 5s duration)...")

    history = wait_for_completion(prompt_id)
    status = history.get("status", {})
    exec_time = status.get("execution_time", 0)
    if exec_time:
        print(f"[*] Execution time: {exec_time:.1f}s")

    # Check errors
    error_msgs = []
    for msg in status.get("messages", []):
        if msg[0] == "execution_error":
            error_msgs.append(msg[1].get("exception_message", ""))
            print(f"[FAIL] Node {msg[1].get('node_id')}: {msg[1].get('exception_message')}")
    if error_msgs:
        print("[FAIL] Render failed")
        return False, prompt_id

    # Find and copy output
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
                            dst = os.path.join(OUTPUT_DIR, "first-video-002.mp4")
                            os.makedirs(OUTPUT_DIR, exist_ok=True)
                            shutil.copy2(src, dst)
                            size_mb = os.path.getsize(dst) / (1024*1024)
                            print(f"[OK] Video saved to {dst} ({size_mb:.1f} MB)")
                            found = True

    if not found:
        outputs_dir = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\output"
        print("[WARN] No output file found")
        if os.path.exists(outputs_dir):
            print(f"Files: {os.listdir(outputs_dir)[:20]}")

    return found, prompt_id

if __name__ == "__main__":
    success, pid = main()
    sys.exit(0 if success else 1)
