# Project State

> Single Source of Truth for AI Clips Factory v1.1
> Last Updated: 2026-06-18 (Phase 5E complete)
> Authoritative source: `reports/FULL_TOOLCHAIN_DISCOVERY.md`

---

## Project Identity

| Field | Value |
|-------|-------|
| Project | AI Clips Factory |
| Version | **AI Clips Factory v1.1** |
| Status | **Production Proven - Context Preservation Ready** |
| Model Library | `F:\AIModels` |
| Workspace | `F:\ProjectClipsAI` |
| Git Repo | `F:\ProjectClipsAI` (no large files) |
| GPU | NVIDIA RTX 3060 12GB (CUDA 13.3, Driver 610.62) |

---

## Current Architecture

```
Cloud AI (SuperGrok)
      |
Storyboard / Script / Prompt Planning
      |
Stability Matrix v2.16.1
      |
ComfyUI v0.25.0
      |
SDXL Base 1.0 (image gen key frames)
      |
LTX Video 2B v0.9.1 (I2V video clips)
      |
FFmpeg 8.0.1 (assembly, transitions, export)
      |
Projects/<id>/exports/
```

---

## Runtime Stack

| Component | Version | Path | Status |
|-----------|---------|------|--------|
| Stability Matrix | 2.16.1 | `C:\Users\prinya\AppData\Local\StabilityMatrix\` | READY |
| ComfyUI | 0.25.0 | `...\StabilityMatrix\Data\Packages\ComfyUI\` | READY |
| Python | 3.12.10 | `C:\Users\prinya\AppData\Local\Programs\Python\Python312\` | READY |
| FFmpeg | 8.0.1 | `C:\Users\prinya\...\Gyan.FFmpeg...\bin\ffmpeg.exe` | READY |
| Git | 2.53.0 | `C:\Program Files\Git\cmd\git.exe` | READY |
| Node.js | v24.14.0 | `C:\Program Files\nodejs\node.exe` | READY |
| NVIDIA GPU | RTX 3060 12GB | Driver 610.62 | READY |

---

## Active Production Models

| Model | Type | Size | Location |
|-------|------|------|----------|
| SDXL Base 1.0 | Checkpoint (image gen) | 6.94 GB | `F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors` |
| LTX Video 2B v0.9.1 | Video (I2V) | 5.72 GB | `F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors` |
| T5XXL fp8 | Text Encoder | 4.56 GB | `...\StabilityMatrix\Data\Packages\ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors` |

**Total active model storage: ~17.2 GB**

---

## Retired Models

| Model | Reason | Reference |
|-------|--------|-----------|
| WAN 2.1 I2V 14B (all quants) | Not viable on RTX 3060 12GB. 4.9h benchmark timeout. | `docs/WAN_CLEANUP_AUDIT.md` |

---

## Model Library Structure (`F:\AIModels`)

| Directory | Content | Status |
|-----------|---------|--------|
| `checkpoints\` | sd_xl_base_1.0, ltx-video-2b-v0.9.1 | POPULATED |
| `video\` | empty | EMPTY |
| `vae\` | empty | EMPTY |
| `controlnet\` | empty | EMPTY |
| `embeddings\` | empty | EMPTY |
| `lora\` | empty | EMPTY |
| `upscale\` | empty | EMPTY |
| `ipadapter\` | empty | EMPTY |
| `archive\` | empty | EMPTY |

---

## Active Workflows

| Workflow | Path | Purpose |
|----------|------|---------|
| SDXL First Render | `workflows/comfyui/first-render/first-render.json` | Generate key image (1024x1024) |
| LTX Video v1 | `workflows/comfyui/first-video/first-video.json` | I2V: 97 frames, 25 steps, 768x512 |
| LTX Video v2 | `workflows/comfyui/first-video/first-video-002.json` | I2V: 121 frames, 30 steps, 768x512 |

---

## Known Gaps

1. ~~Input image `first-render-001.png` missing~~ **RESOLVED** -- Pipeline validated with mjuhight1.jpg.
2. **No VAE/ControlNet/LoRA models** -- All secondary model dirs empty. Not blockers for baseline LTX.
3. **WAN HuggingFace cache remnants** (~1 GB) -- `F:\AI\models\hub\` not symlinked into ComfyUI.

---

## Phase History

| Phase | Date | Status |
|-------|------|--------|
| 1A | -- | Foundation |
| 1B | 2026-06-17 | Readiness check |
| 2A | 2026-06-17 | WAN benchmark |
| 2B | 2026-06-17 | WAN cleanup |
| 3A | 2026-06-18 | Model + Workflow audit |
| 3A.0 | 2026-06-18 | Full toolchain discovery |
| 3A.3 | 2026-06-18 | Central memory bootstrap |
| 3A.4a | 2026-06-18 | Knowledge governance layer |
| 3A.4b | 2026-06-18 | Corrected production readiness |
| 3C | 2026-06-18 | First real LTX render -- SUCCESS |
| 4A | 2026-06-18 | Multi-shot foundation -- SUCCESS |
| 4B | 2026-06-18 | Assembly & Master Export -- SUCCESS |
| 5A | 2026-06-18 | Production Template System -- SUCCESS |
| 5B | 2026-06-18 | Batch Render Automation -- SUCCESS |
| 5C | 2026-06-18 | Production QA & Prompt Optimization -- SUCCESS |
| 5D | 2026-06-18 | Controlled Batch Render Test -- SUCCESS |
| 5E | 2026-06-18 | Context Preservation System -- SUCCESS |

---

## Key Decision Records

See `kb/DECISION_LOG.md` for full records.

Summary:
- Local-first architecture (DECISION-001)
- F:\AIModels as external model library (DECISION-002)
- LTX Video 2B is production baseline (DECISION-006)
- WAN 2.1 retired from production (DECISION-009)
- No large assets in Git (DECISION-011)

