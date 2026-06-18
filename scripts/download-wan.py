import os, shutil
from huggingface_hub import hf_hub_download

BASE = r"C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\models"

def ensure_file(repo, file_in_repo, dest_subdir, final_name, label):
    dest = os.path.join(BASE, dest_subdir)
    os.makedirs(dest, exist_ok=True)
    target = os.path.join(dest, final_name)
    
    if os.path.exists(target):
        print(f"[SKIP] {label}: {os.path.getsize(target)/(1024**3):.1f} GB")
        return
    
    print(f"[DL] {label}...")
    tmp = hf_hub_download(repo, file_in_repo, resume_download=True)
    if os.path.abspath(tmp) != os.path.abspath(target):
        shutil.move(tmp, target)
    print(f"[OK] {label}: {os.path.getsize(target)/(1024**3):.1f} GB")

ensure_file("city96/Wan2.1-I2V-14B-480P-gguf", "wan2.1-i2v-14b-480p-Q4_K_M.gguf", "unet", "wan2.1-i2v-14b-480p-Q4_K_M.gguf", "WAN I2V 14B Q4_K_M GGUF")
ensure_file("Comfy-Org/Wan_2.1_ComfyUI_repackaged", "split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors", "text_encoders", "umt5_xxl_fp8_e4m3fn_scaled.safetensors", "UMT5 XXL fp8 text encoder")
ensure_file("Comfy-Org/Wan_2.1_ComfyUI_repackaged", "split_files/vae/wan_2.1_vae.safetensors", "vae", "wan_2.1_vae.safetensors", "WAN VAE")
ensure_file("Comfy-Org/Wan_2.1_ComfyUI_repackaged", "split_files/clip_vision/clip_vision_h.safetensors", "clip_vision", "clip_vision_h.safetensors", "CLIP Vision H")

print("\n[DONE] All WAN components ready.")
