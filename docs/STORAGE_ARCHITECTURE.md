# Storage Architecture

> Recommended physical storage layout for ProjectClipsAI.
> Governance document only. No directories are created outside the workspace.

---

## External Model Library

**Recommended root:** `F:\AIModels`

```
F:\AIModels\
├── checkpoints\          # Stable Diffusion / Flux checkpoints
├── lora\                 # LoRA adapters
├── vae\                  # VAE models
├── controlnet\           # ControlNet models
├── embeddings\           # Textual inversion / CLIP embeddings
├── video\                # WAN, LTX, and other video models
├── upscale\              # Upscaler models (ESRGAN, etc.)
├── ipadapter\            # IP-Adapter models
└── archive\              # Deprecated or replaced models
```

### Rules

1. **Models never stored inside `F:\ProjectClipsAI`** — The repository contains only references and registry entries.
2. **Centrally managed** — All AI tools (ComfyUI, A1111, etc.) point to the same model library. No per-tool copies.
3. **No duplicates** — Every model file exists exactly once on disk. Check `registry/MODEL_REGISTRY.md` before downloading.
4. **Archive policy** — Deprecated models move to `archive/`. Never delete a model used in a completed project without verifying it's truly unused.

### Rationale

- Separating models from the repository keeps Git operations lightweight and avoids accidental commits of large binary files.
- A shared library across all tools prevents duplication (e.g., a checkpoint used by both ComfyUI and A1111 lives in one place).
- External storage is easier to back up independently.

---

## Repository Structure (existing)

```
F:\ProjectClipsAI\
├── context\              # Agent context packs
├── registry\             # Source-of-truth registries
├── docs\                 # Governance, docs, skills
├── workflows\            # ComfyUI JSONs, prompt templates, FFmpeg scripts
├── projects\             # Clip projects (numbered)
├── assets\               # Shared reference assets (images, audio, fonts)
├── models\               # Model references only (points to F:\AIModels)
├── exports\              # Global exports directory
├── scripts\              # Utility scripts
└── .cursor\              # Cursor IDE rules
```

### Model Directory Usage

`F:\ProjectClipsAI\models\README.md` explains the external library policy. No model files reside here.
