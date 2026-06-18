# WAN Benchmark — Image-to-Video

## Workflow

- **Model:** WAN 2.1 I2V 14B 480p (GGUF Q3_K_M, 8.0 GB — optimized for 12GB VRAM)
- **Text Encoder:** UMT5 XXL fp8 (6.3 GB)
- **VAE:** WAN 2.1 VAE (0.2 GB)
- **CLIP Vision:** clip_vision_h (1.2 GB)
- **Resolution:** 768x512
- **Frames:** 121 (~5s at 24fps)
- **Sampler:** euler, simple scheduler, 30 steps, CFG 5.0

## Dependencies

| Node | Source | Why Required |
|------|--------|-------------|
| `UnetLoaderGGUF` | `ComfyUI-GGUF` (city96) | Load GGUF-quantized WAN model on 12GB VRAM |

All other nodes are built-in ComfyUI.

## Node Structure

1. `LoadImage` — input image
2. `UnetLoaderGGUF` — WAN GGUF model
3. `CLIPLoader` (type=wan) — UMT5 text encoder
4. `CLIPTextEncode` — positive prompt
5. `CLIPTextEncode` — negative prompt
6. `VAELoader` — WAN VAE
7. `CLIPVisionLoader` — CLIP Vision H
8. `CLIPVisionEncode` — encode image for I2V guidance
9. `WanImageToVideo` — I2V conditioning + latent
10. `KSampler` — latent sampling
11. `VAEDecode` — latent → frames
12. `CreateVideo` — images → video stream
13. `SaveVideo` — MP4 export

## Files

| File | Purpose |
|------|---------|
| `wan-benchmark.json` | ComfyUI workflow JSON |
| `README.md` | This file |

## Notes

- Q3_K_M GGUF is ~8.0 GB leaving ~4 GB VRAM headroom on RTX 3060 12GB
- WAN I2V needs CLIP Vision encoding (not needed for LTX)
- WAN uses separate VAE (not embedded like LTX)
- WAN requires UMT5 text encoder (not T5XXL)
