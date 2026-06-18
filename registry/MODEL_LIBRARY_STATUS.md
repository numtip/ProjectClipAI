# Model Library Status

> Status of the shared model library configured for ProjectClipsAI.

## Configuration

| Field | Value |
|-------|-------|
| Configured Path | `F:\AIModels\` |
| Managed By | Stability Matrix (installed at `C:\Users\prinya\AppData\Local\StabilityMatrix\`) |
| Default SM Library | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Models\` (automatic) |
| Shared Root | `F:\AIModels\` (ready for GUI configuration) |

## Categories Detected

| Category | Path | Status |
|----------|------|--------|
| checkpoints | `F:\AIModels\checkpoints\` | empty — ready |
| lora | `F:\AIModels\lora\` | empty — ready |
| vae | `F:\AIModels\vae\` | empty — ready |
| controlnet | `F:\AIModels\controlnet\` | empty — ready |
| embeddings | `F:\AIModels\embeddings\` | empty — ready |
| video | `F:\AIModels\video\` | empty — ready |
| upscale | `F:\AIModels\upscale\` | empty — ready |
| ipadapter | `F:\AIModels\ipadapter\` | empty — ready |
| archive | `F:\AIModels\archive\` | empty — ready |

## Stability Matrix Internal Categories

Stability Matrix automatically creates the following model subdirectories in its Data/Models folder:

AfterDetailer, ApproxVAE, AudioEncoders, BackgroundRemoval, BSRGAN, ClipVision, Codeformer, ControlNet, DeepDanbooru, Diffusers, DiffusionModels, Embeddings, ESRGAN, GFPGAN, GLIGEN, Hypernetwork, IpAdapter, IpAdapters15, IpAdaptersXl, Karlo, LDSR, Lora, LyCORIS, ModelPatches, PromptExpansion, RealESRGAN, Sams, ScuNET, StableDiffusion, StyleModels, SVD, SwinIR, T2IAdapter, TextEncoders, Ultralytics, VAE

These are automatically managed by Stability Matrix. The shared library at `F:\AIModels\` should be configured via the Stability Matrix GUI to point to the external path.

## Status

- [x] Library path created at F:\AIModels
- [x] All category folders created
- [x] Stability Matrix model folders detected
- [x] Extra_model_paths.yaml configured for ComfyUI
- [x] Model downloaded: SDXL base 1.0 (6.6 GB) at F:\AIModels\checkpoints\
- [x] Model registered in registry/MODEL_REGISTRY.md (ID: 001)
- [ ] Stability Matrix configured to use F:\AIModels (requires GUI)
