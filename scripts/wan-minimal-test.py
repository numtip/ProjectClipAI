"""
WAN Minimal Test — Quick smoke test to verify WAN model loads and renders.
Uses minimal settings: 480p, 49 frames (~2s), 20 steps.
"""
import json, time, urllib.request, os, shutil, sys

sys.stdout.reconfigure(line_buffering=True, write_through=True)
COMFY_HOST = "http://127.0.0.1:8188"
INPUT_IMAGE = r"F:\ProjectClipsAI\projects\000-first-clip\assets\first-render-001.png"
OUTPUT_DIR = r"F:\ProjectClipsAI\projects\000-first-clip\outputs"
CI = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\input"

os.makedirs(CI, exist_ok=True)
shutil.copy2(INPUT_IMAGE, os.path.join(CI, "first-render-001.png"))

WF = {
    "1": {"class_type": "LoadImage", "inputs": {"image": "first-render-001.png"}},
    "2": {"class_type": "UnetLoaderGGUF", "inputs": {"unet_name": "wan2.1-i2v-14b-480p-Q3_K_M.gguf"}},
    "3": {"class_type": "ModelSamplingSD3", "inputs": {"model": ["2",0], "shift": 3.0}},
    "4": {"class_type": "CLIPLoader", "inputs": {"clip_name": "umt5_xxl_fp8_e4m3fn_scaled.safetensors", "type": "wan"}},
    "5": {"class_type": "CLIPTextEncode", "inputs": {"text": "slow cinematic push-in, soft light", "clip": ["4",0]}},
    "6": {"class_type": "CLIPTextEncode", "inputs": {"text": "blurry, low quality", "clip": ["4",0]}},
    "7": {"class_type": "VAELoader", "inputs": {"vae_name": "wan_2.1_vae.safetensors"}},
    "8": {"class_type": "CLIPVisionLoader", "inputs": {"clip_name": "clip_vision_h.safetensors"}},
    "9": {"class_type": "CLIPVisionEncode", "inputs": {"clip_vision": ["8",0], "image": ["1",0], "crop": "center"}},
    "10": {"class_type": "WanImageToVideo", "inputs": {"positive":["5",0], "negative":["6",0], "vae":["7",0], "width":480, "height":480, "length":49, "batch_size":1, "clip_vision_output":["9",0], "start_image":["1",0]}},
    "11": {"class_type": "KSampler", "inputs": {"seed":42, "steps":20, "cfg":5.0, "sampler_name":"euler", "scheduler":"simple", "denoise":1.0, "model":["3",0], "positive":["10",0], "negative":["10",1], "latent_image":["10",2]}},
    "12": {"class_type": "VAEDecode", "inputs": {"samples":["11",0], "vae":["7",0]}},
    "13": {"class_type": "CreateVideo", "inputs": {"images":["12",0], "fps":24.0}},
    "14": {"class_type": "SaveVideo", "inputs": {"video":["13",0], "filename_prefix":"wan-test", "format":"mp4", "codec":"h264"}},
}

def qp(wf):
    d = json.dumps({"prompt": wf}).encode()
    return json.loads(urllib.request.urlopen(urllib.request.Request(f"{COMFY_HOST}/prompt", data=d, headers={"Content-Type":"application/json"})).read())

print("[*] Queuing WAN minimal test (480x480, 49f, ~2s, 20 steps)...", flush=True)
result = qp(WF)
pid = result["prompt_id"]
print(f"[*] Prompt ID: {pid}", flush=True)

start = time.time()
timeout = 1200  # 20 min max
while time.time() - start < timeout:
    try:
        h = json.loads(urllib.request.urlopen(f"{COMFY_HOST}/history/{pid}").read())
        if pid in h:
            d = h[pid]
            s = d.get("status",{})
            elapsed = time.time() - start
            for msg in s.get("messages",[]):
                if msg[0]=="execution_error":
                    e=msg[1]
                    print(f"[FAIL] {e.get('exception_message','')[:200]}", flush=True)
                    sys.exit(1)
            exec_t = s.get("execution_time", 0)
            print(f"[OK] Render complete in {elapsed:.0f}s (exec: {exec_t}s)", flush=True)
            # Save output
            for nid, out in d.get("outputs",{}).items():
                for k,v in out.items():
                    if isinstance(v, list):
                        for item in v:
                            if isinstance(item, dict) and "filename" in item:
                                src = os.path.join(r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\output", item["filename"])
                                if os.path.exists(src):
                                    dst = os.path.join(OUTPUT_DIR, "wan-test-001.mp4")
                                    os.makedirs(OUTPUT_DIR, exist_ok=True)
                                    shutil.copy2(src, dst)
                                    size_mb = os.path.getsize(dst)/(1024*1024)
                                    print(f"[OK] Output: {dst} ({size_mb:.1f} MB)", flush=True)
            sys.exit(0)
    except Exception as e:
        pass
    time.sleep(10)

print(f"[FAIL] Timeout after {timeout}s", flush=True)
sys.exit(1)
