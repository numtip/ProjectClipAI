# First Video — LTX Image-to-Video

## Workflow

- **Model:** LTX Video 2B v0.9.1 (checkpoints)
- **Text Encoder:** T5XXL fp8 (text_encoders)
- **VAE:** Embedded in LTX checkpoint
- **Resolution:** 768x512
- **Frames:** 97 (~4s at 24fps)
- **Sampler:** euler, normal scheduler, 25 steps, CFG 4.0
- **Motion:** Cinematic push-in, slow camera movement

## Node Structure

1. `LoadImage` — input image
2. `CheckpointLoaderSimple` — LTX model (CLIP output unused)
3. `CLIPLoader` (type=ltxv) — T5XXL text encoder
4. `CLIPTextEncode` — positive prompt
5. `CLIPTextEncode` — negative prompt
6. `LTXVImgToVideo` — image→video conditioning
7. `KSampler` — latent sampling
8. `VAEDecode` — latent→frames
9. `CreateVideo` — images→video stream
10. `SaveVideo` — MP4 export

## Files

| File | Purpose |
|------|---------|
| `first-video.json` | ComfyUI workflow JSON |
| `README.md` | This file |

## Notes

- LTX model does not embed text encoder; T5XXL must be loaded separately via CLIPLoader
- All nodes are built-in ComfyUI; no custom node packs required
- 97 frames at 768x512 takes ~89s on RTX 3060 12GB
- h264 codec, 24fps MP4 output
