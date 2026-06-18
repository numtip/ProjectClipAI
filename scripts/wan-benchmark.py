"""
ProjectClipsAI — Phase 2B WAN Benchmark Render (v2 with ModelSamplingSD3)
Creates a WAN I2V workflow via ComfyUI API using GGUF model + flow matching sampling.
"""

import json, time, urllib.request, os, shutil, sys
sys.stdout.reconfigure(line_buffering=True, write_through=True)
COMFY_HOST = "http://127.0.0.1:8188"
INPUT_IMAGE = r"F:\ProjectClipsAI\projects\000-first-clip\assets\first-render-001.png"
OUTPUT_DIR = r"F:\ProjectClipsAI\projects\000-first-clip\outputs"
WORKFLOW_DIR = r"F:\ProjectClipsAI\workflows\comfyui\wan-benchmark"
COMFY_INPUT_DIR = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\input"

os.makedirs(COMFY_INPUT_DIR, exist_ok=True)
input_filename = "first-render-001.png"
shutil.copy2(INPUT_IMAGE, os.path.join(COMFY_INPUT_DIR, input_filename))

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

WIDTH = 768
HEIGHT = 512
FRAMES = 121  # 5.04s @ 24fps
FPS = 24.0
SEED = 42

def build_workflow(seed=SEED):
    return {
        "1": {
            "class_type": "LoadImage",
            "inputs": {"image": input_filename}
        },
        "2": {
            "class_type": "UnetLoaderGGUF",
            "inputs": {"unet_name": "wan2.1-i2v-14b-480p-Q3_K_M.gguf"}
        },
        "3": {  # ModelSamplingSD3 for flow matching (WAN uses rectified flow)
            "class_type": "ModelSamplingSD3",
            "inputs": {
                "model": ["2", 0],
                "shift": 3.0
            }
        },
        "4": {
            "class_type": "CLIPLoader",
            "inputs": {
                "clip_name": "umt5_xxl_fp8_e4m3fn_scaled.safetensors",
                "type": "wan"
            }
        },
        "5": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": PROMPT, "clip": ["4", 0]}
        },
        "6": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": NEGATIVE, "clip": ["4", 0]}
        },
        "7": {
            "class_type": "VAELoader",
            "inputs": {"vae_name": "wan_2.1_vae.safetensors"}
        },
        "8": {
            "class_type": "CLIPVisionLoader",
            "inputs": {"clip_name": "clip_vision_h.safetensors"}
        },
        "9": {
            "class_type": "CLIPVisionEncode",
            "inputs": {
                "clip_vision": ["8", 0],
                "image": ["1", 0],
                "crop": "center"
            }
        },
        "10": {
            "class_type": "WanImageToVideo",
            "inputs": {
                "positive": ["5", 0],
                "negative": ["6", 0],
                "vae": ["7", 0],
                "width": WIDTH,
                "height": HEIGHT,
                "length": FRAMES,
                "batch_size": 1,
                "clip_vision_output": ["9", 0],
                "start_image": ["1", 0]
            }
        },
        "11": {
            "class_type": "KSampler",
            "inputs": {
                "seed": seed,
                "steps": 30,
                "cfg": 5.0,
                "sampler_name": "euler",
                "scheduler": "simple",
                "denoise": 1.0,
                "model": ["3", 0],
                "positive": ["10", 0],
                "negative": ["10", 1],
                "latent_image": ["10", 2]
            }
        },
        "12": {
            "class_type": "VAEDecode",
            "inputs": {"samples": ["11", 0], "vae": ["7", 0]}
        },
        "13": {
            "class_type": "CreateVideo",
            "inputs": {
                "images": ["12", 0],
                "fps": FPS
            }
        },
        "14": {
            "class_type": "SaveVideo",
            "inputs": {
                "video": ["13", 0],
                "filename_prefix": "wan-benchmark",
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

def wait_for_completion(prompt_id, timeout=3600):
    start = time.time()
    while time.time() - start < timeout:
        try:
            history = get_history(prompt_id)
            if prompt_id in history:
                return history[prompt_id]
        except: pass
        time.sleep(5)
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
    wf_path = os.path.join(WORKFLOW_DIR, "wan-benchmark.json")
    with open(wf_path, "w") as f:
        json.dump(workflow, f, indent=2)
    print(f"[OK] Workflow saved to {wf_path}")

    print(f"[*] Queuing WAN I2V ({WIDTH}x{HEIGHT}, {FRAMES}f, {FRAMES/FPS:.1f}s, seed={SEED})")
    print(f"[*] Model: Q3_K_M GGUF, UMT5 fp8, CLIP Vision, ModelSamplingSD3(shift=3.0)")
    
    result = queue_prompt(workflow)
    prompt_id = result["prompt_id"]
    print(f"[*] Prompt ID: {prompt_id}")
    print(f"[*] Waiting (with --lowvram, may take 10-30 min)...")

    start_t = time.time()
    history = wait_for_completion(prompt_id)
    elapsed = time.time() - start_t
    print(f"[*] Total wait: {elapsed:.0f}s")

    status = history.get("status", {})
    exec_time = status.get("execution_time", 0)
    if exec_time:
        print(f"[*] Execution time: {exec_time:.1f}s")

    error_msgs = []
    for msg in status.get("messages", []):
        if msg[0] == "execution_error":
            error_msgs.append(msg[1])
            print(f"[FAIL] Node {msg[1].get('node_id')}: {msg[1].get('exception_message')}")
    
    if error_msgs:
        print("[FAIL] Render failed")
        return False, prompt_id, elapsed, error_msgs

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
                            dst = os.path.join(OUTPUT_DIR, "wan-benchmark-001.mp4")
                            os.makedirs(OUTPUT_DIR, exist_ok=True)
                            shutil.copy2(src, dst)
                            size_mb = os.path.getsize(dst) / (1024*1024)
                            print(f"[OK] Video saved to {dst} ({size_mb:.1f} MB)")
                            found = True

    if not found:
        outputs_dir = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\output"
        print("[WARN] No output file found")
        if os.path.exists(outputs_dir):
            files = [f for f in os.listdir(outputs_dir) if "wan" in f.lower()]
            print(f"WAN-related files: {files[:10]}")

    return found, prompt_id, elapsed, None

if __name__ == "__main__":
    success, pid, elapsed, errors = main()
    sys.exit(0 if success else 1)
