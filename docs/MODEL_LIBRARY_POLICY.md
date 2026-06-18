# Model Library Policy

## Core Principle

**Shared model library. No duplicates. Models outside Git.**

## Rules

1. **One copy only** — Never download the same model twice. Check `registry/MODEL_REGISTRY.md` first.
2. **External storage** — Models reside outside the Git repository. This repository contains only references and registry entries.
3. **No commits** — Never commit `.safetensors`, `.ckpt`, `.pt`, `.pth`, or `.onnx` files.
4. **Organized by type** — Maintain separate folders for checkpoints, LoRAs, VAEs, and video models.
5. **Document additions** — Update `registry/MODEL_REGISTRY.md` when adding a new model.

## Recommended Library Structure (External)

```
D:\AI_Models\
├── checkpoints\        # Stable Diffusion checkpoints
├── loras\              # LoRA adapters
├── vae\                # VAE models
├── video\              # WAN, LTX, and other video models
├── upscale\            # Upscaler models
└── clip\               # CLIP models
```

## Model Sources

- CivitAI (checkpoints, LoRAs)
- Hugging Face (WAN, LTX, upscalers)
- Official model repositories

## Policy Enforcement

- Always check `registry/MODEL_REGISTRY.md` before downloading
- Update registry with model name, type, source, and status
- If a model already exists, do not re-download
