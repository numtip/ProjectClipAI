import os, urllib.request, urllib.parse, json, time, shutil, sys
from huggingface_hub import hf_hub_download

# Paths
MODEL_DIR = r"F:\AIModels\checkpoints"
MODEL_FILENAME = "ltx-video-2b-v0.9.1.safetensors"
HF_REPO = "Lightricks/LTX-Video"
HF_FILE = "ltx-video-2b-v0.9.1.safetensors"
MODEL_PATH = os.path.join(MODEL_DIR, MODEL_FILENAME)

# Download model
print(f"Downloading {HF_REPO}/{HF_FILE}...")
path = hf_hub_download(
    HF_REPO,
    HF_FILE,
    local_dir=MODEL_DIR,
    local_dir_use_symlinks=False,
    resume_download=True
)
size_gb = os.path.getsize(path) / (1024**3)
print(f"[OK] Downloaded: {path} ({size_gb:.1f} GB)")
