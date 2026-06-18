# Model Registry

> Source of truth for models used in ProjectClipsAI.
> Models are stored outside the Git repository.

## Model Entries

| ID | Name | Type | Path (external) | Status | Notes |
|----|------|------|-----------------|--------|-------|
| 001 | sd-xl-base-1.0 | checkpoint | F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors | active | First image generation model. SDXL base 1.0 (6.6 GB) |
| 002 | ltx-video-2b-v0.9.1 | video | F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors | production_baseline | Production Baseline for ProjectClipsAI. Validated on RTX 3060 12GB. ~116s for 5s clip at 768x512. Requires separate T5XXL text encoder |
| 003 | t5xxl-fp8 | text_encoder | ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors | active | T5XXL text encoder for LTX video. fp8 quantized (4.6 GB). Required for LTX conditioning |
| 004 | wan-2.1-i2v-14b-480p-Q4_K_M | video | ComfyUI\models\unet\wan2.1-i2v-14b-480p-Q4_K_M.gguf | rejected | WAN 2.1 I2V 14B 480p GGUF Q4_K_M (10.6 GB). Retired. Overflowed 12GB VRAM. Never completed render |
| 005 | wan-2.1-i2v-14b-480p-Q3_K_M | video | ComfyUI\models\unet\wan2.1-i2v-14b-480p-Q3_K_M.gguf | rejected | WAN 2.1 I2V 14B 480p GGUF Q3_K_M (8.0 GB). Retired. Took 16 min for 2s test clip at 480x480. Not viable on 12GB |
| 006 | umt5-xxl-fp8 | text_encoder | ComfyUI\models\text_encoders\umt5_xxl_fp8_e4m3fn_scaled.safetensors | rejected | UMT5 XXL text encoder for WAN video. fp8 quantized (6.3 GB). Retired with WAN |
| 007 | wan-2.1-vae | vae | ComfyUI\models\vae\wan_2.1_vae.safetensors | rejected | WAN 2.1 VAE (0.2 GB). Retired with WAN |
| 008 | clip-vision-h | clip_vision | ComfyUI\models\clip_vision\clip_vision_h.safetensors | rejected | CLIP Vision H (1.2 GB). Required for WAN I2V conditioning. Retired with WAN |

## Status Legend

- **Production Baseline** — Core production model. Locked and validated
- **Active** — Currently in use and tested
- **Available** — Downloaded but not yet tested in workflow
- **Planned** — Identified for future use
- **Deprecated** — Replaced or no longer used
- **Rejected** — Evaluated and found unsuitable for current hardware

## Policies

1. No duplicate models — always check this registry before adding
2. Update this file when adding or removing models
3. All models reside in a shared external library, not in this repo
4. Never commit model weight files to Git

## Guidelines

- LTX models: production baseline for video generation on RTX 3060 12GB
- Checkpoint models: used for image generation in ComfyUI
