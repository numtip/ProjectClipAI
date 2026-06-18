"""
ProjectClipsAI — First Render Workflow
Creates and executes an SDXL image generation workflow via ComfyUI API.
"""

import json, time, urllib.request, urllib.parse, os, sys, shutil

COMFY_HOST = "http://127.0.0.1:8188"
OUTPUT_DIR = r"F:\ProjectClipsAI\projects\000-first-clip\assets"
WORKFLOW_DIR = r"F:\ProjectClipsAI\workflows\comfyui\first-render"
COMFY_OUTPUT_DIR = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\output"

PROMPT = "A futuristic agricultural research center at sunrise, cinematic lighting, photorealistic, volumetric god rays, glass domes over vertical farms, misty fields, highly detailed, 4K"
NEGATIVE = "blurry, low quality, distorted, ugly, deformed, extra limbs, bad anatomy"

# ── Build minimal SDXL workflow ──────────────────────────────────────
def build_workflow(seed=42):
    return {
        "3": {
            "class_type": "KSampler",
            "inputs": {
                "seed": seed,
                "steps": 20,
                "cfg": 7.0,
                "sampler_name": "euler",
                "scheduler": "normal",
                "denoise": 1.0,
                "model": ["4", 0],
                "positive": ["6", 0],
                "negative": ["7", 0],
                "latent_image": ["5", 0],
            }
        },
        "4": {
            "class_type": "CheckpointLoaderSimple",
            "inputs": {"ckpt_name": "sd_xl_base_1.0.safetensors"}
        },
        "5": {
            "class_type": "EmptyLatentImage",
            "inputs": {"width": 1024, "height": 1024, "batch_size": 1}
        },
        "6": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": PROMPT, "clip": ["4", 1]}
        },
        "7": {
            "class_type": "CLIPTextEncode",
            "inputs": {"text": NEGATIVE, "clip": ["4", 1]}
        },
        "8": {
            "class_type": "VAEDecode",
            "inputs": {"samples": ["3", 0], "vae": ["4", 2]}
        },
        "9": {
            "class_type": "SaveImage",
            "inputs": {"filename_prefix": "first-render", "images": ["8", 0]}
        }
    }

# ── ComfyUI API helpers ───────────────────────────────────────────────
def queue_prompt(workflow):
    data = json.dumps({"prompt": workflow}).encode("utf-8")
    req = urllib.request.Request(
        f"{COMFY_HOST}/prompt",
        data=data,
        headers={"Content-Type": "application/json"}
    )
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())

def get_history(prompt_id):
    with urllib.request.urlopen(f"{COMFY_HOST}/history/{prompt_id}") as resp:
        return json.loads(resp.read())

def wait_for_completion(prompt_id, timeout=300):
    start = time.time()
    while time.time() - start < timeout:
        try:
            history = get_history(prompt_id)
            if prompt_id in history:
                return history[prompt_id]
        except:
            pass
        time.sleep(2)
    raise TimeoutError("Render did not complete within timeout")

# ── Main ──────────────────────────────────────────────────────────────
def main():
    # Check ComfyUI connectivity
    try:
        with urllib.request.urlopen(f"{COMFY_HOST}/", timeout=5) as r:
            print(f"[OK] ComfyUI reachable at {COMFY_HOST} (HTTP {r.status})")
    except Exception as e:
        print(f"[FAIL] Cannot reach ComfyUI: {e}")
        sys.exit(1)

    # Build and save workflow JSON
    workflow = build_workflow(seed=42)
    wf_path = os.path.join(WORKFLOW_DIR, "first-render.json")
    with open(wf_path, "w") as f:
        json.dump(workflow, f, indent=2)
    print(f"[OK] Workflow saved to {wf_path}")

    # Queue prompt
    print(f"[*] Queuing prompt (seed=42, steps=20)...")
    result = queue_prompt(workflow)
    prompt_id = result["prompt_id"]
    print(f"[*] Prompt ID: {prompt_id}")

    # Wait for completion
    print(f"[*] Waiting for render to complete...")
    history = wait_for_completion(prompt_id)
    outputs = history.get("outputs", {})

    # Find generated image
    found = False
    for node_id, node_out in outputs.items():
        for key, images in node_out.items():
            if isinstance(images, list):
                for img in images:
                    src = os.path.join(COMFY_OUTPUT_DIR, img["filename"])
                    if os.path.exists(src):
                        dst = os.path.join(OUTPUT_DIR, "first-render-001.png")
                        shutil.copy2(src, dst)
                        print(f"[OK] Image saved to {dst} ({os.path.getsize(dst) // 1024} KB)")
                        found = True

    if not found:
        print("[WARN] No output image found in ComfyUI output directory")
        print(f"ComfyUI output directory: {COMFY_OUTPUT_DIR}")
        if os.path.exists(COMFY_OUTPUT_DIR):
            files = os.listdir(COMFY_OUTPUT_DIR)
            print(f"Files found: {files[:10]}")

    # Print performance data
    status = history.get("status", {})
    if "execution_time" in status:
        print(f"[*] Execution time: {status['execution_time']:.1f}s")
    if "queue_remaining" in status:
        print(f"[*] Queue remaining: {status['queue_remaining']}")

    return found

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
