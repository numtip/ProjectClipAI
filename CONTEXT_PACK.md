# AI Clips Factory — Context Pack

> Executive summary. Read this first, then proceed to `PROJECT_STATE.md`.
> Last updated: 2026-06-18 23:16

---

## Project Identity

**AI Clips Factory** is a Local-First AI Video Lab that produces short-form AI-generated video clips using open-source tools and a local NVIDIA RTX 3060 12GB GPU. Cloud AI (SuperGrok) is used exclusively for creative text tasks (script, storyboard, prompt engineering).

---

## Current Status

| Field | Value |
|-------|-------|
| **Current Phase** | Phase 5E — Context Preservation System (complete) |
| **Current Objective** | Awaiting Phase 6 — AI Clips Factory v2 |
| **Current Blockers** | None |
| **Current Next Action** | Phase 6 — AI Clips Factory v2 |

---

## Production Stack

| Layer | Component | Version |
|-------|-----------|---------|
| Environment Manager | Stability Matrix | 2.16.1 |
| Workflow Engine | ComfyUI | 0.25.0 |
| Image Gen Model | SDXL Base 1.0 | 1.0 |
| Video Model (I2V) | LTX Video 2B | v0.9.1 |
| Text Encoder | T5XXL fp8 | — |
| Video Processing | FFmpeg | 8.0.1 |
| GPU | NVIDIA RTX 3060 12GB | Driver 610.62 |
| Python Runtime | Python | 3.12.10 |
| Version Control | Git | 2.53.0 |

### Model Storage

| Model | Size | Path |
|-------|------|------|
| SDXL Base 1.0 | 6.94 GB | `F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors` |
| LTX Video 2B v0.9.1 | 5.72 GB | `F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors` |
| T5XXL fp8 | 4.56 GB | `...\ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors` |
| **Total** | **~17.2 GB** | |

---

## Key Decisions

1. **WAN 2.1 I2V 14B retired** — Not viable on RTX 3060 12GB at any quantization. 4.9h benchmark timeout. 26.2 GB recovered.
2. **LTX Video 2B v0.9.1 is production baseline** — ~113s per 5s clip at 768×512, 121 frames, 30 steps, CFG 4.0.
3. **Image-to-Video preferred over Text-to-Video** — All clips start from a generated SDXL key image.
4. **Stability Matrix manages ComfyUI** — Version management, model browsing, no custom nodes needed.
5. **No large assets in Git** — Models, renders, and exports stay outside the Git repository.
6. **Output mapping via extra_model_paths.yaml** — Points ComfyUI to `F:\AIModels\` checkpoints, loras, vae, controlnet.
7. **Phase 5C prompts** — Optimized with front-loaded motion, concrete physical descriptions, extended negative prompt baseline.

---

## Milestones

| Phase | Description | Date | Status |
|-------|-------------|------|--------|
| 1A-2B | Foundation, Readiness, WAN Benchmark & Cleanup | 2026-06-17 | Complete |
| 3A | Model & Workflow Audit | 2026-06-18 | Complete |
| 3C | First Real LTX Render | 2026-06-18 | **Success** |
| 4A | Multi-Shot Foundation (4 shots) | 2026-06-18 | **Success** |
| 4B | FFmpeg Assembly & Master Export | 2026-06-18 | **Success** |
| 5A | Production Template System | 2026-06-18 | **Success** |
| 5B | Batch Render Automation | 2026-06-18 | **Success** |
| 5C | Production QA & Prompt Optimization | 2026-06-18 | **Success** |
| 5D | Controlled Batch Render Test | 2026-06-18 | **Success** |
| 5E | Context Preservation System | 2026-06-18 | **Success** |

**Pipeline is validated end-to-end:** Topic → Script → Storyboard → Key Image → I2V (LTX) → FFmpeg Assembly → Final MP4

### Production Settings

- Resolution: 768×512
- Frames: 121 (5.04s @ 24fps)
- Steps: 30, CFG: 4.0, Sampler: Euler, Scheduler: Normal
- Average render time: ~113s per clip (RTX 3060 12GB)
- Assembly: Lossless concat (hard cuts) or xfade 0.4s CRF 18 (fades)

---

## Required Read Order for New Agents

1. `CONTEXT_PACK.md` — This file (executive summary)
2. `HANDOFF.md` — Current status handoff
3. `PROJECT_STATE.md` — Single source of truth
4. `kb/DECISION_LOG.md` — All decisions
5. `kb/CURRENT_TOOLCHAIN.md` — Runtime details
6. `kb/PHASE_STATUS.md` — Phase progress
7. `kb/SESSION_LOG.md` — Session history
8. `kb/PROJECT_GOVERNANCE.md` — Governance rules
9. `kb/TOKEN_SAVIOR_WORKFLOW.md` — Token efficiency rules
