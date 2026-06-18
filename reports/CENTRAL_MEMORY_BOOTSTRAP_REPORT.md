# Central Memory Bootstrap Report

> Phase 3A.3
> Date: 2026-06-18

---

## Files Created

| File | Size | Purpose |
|------|------|---------|
| `kb/` | directory | Knowledge base folder |
| `PROJECT_STATE.md` | — | Single source of truth for project identity, architecture, models, phase |
| `kb/DECISION_LOG.md` | — | 11 architectural and operational decisions (DECISION-001 through DECISION-011) |
| `kb/CURRENT_TOOLCHAIN.md` | — | Runtime versions, paths, model storage summary |
| `kb/PHASE_STATUS.md` | — | Current phase, production readiness, blockers, next actions |
| `kb/AGENT_START_HERE.md` | — | Mandatory startup instructions for all future agents |
| `kb/TOKEN_SAVIOR_WORKFLOW.md` | — | Token efficiency rules for all agents |
| `reports/CENTRAL_MEMORY_BOOTSTRAP_REPORT.md` | — | This file — validation report |

---

## Source Documents Used

| Document | Purpose |
|----------|---------|
| `docs/AI_VIDEO_LAB_BLUEPRINT.md` | Architecture decisions, data flow |
| `docs/MODEL_LIBRARY_STANDARD.md` | Naming conventions, model categories |
| `docs/WAN_CLEANUP_AUDIT.md` | WAN retirement evidence |
| `reports/FULL_TOOLCHAIN_DISCOVERY.md` | Authoritative source for all toolchain data |
| `context/PROJECT_CONTEXT.md` | Project identity and constraints |
| `context/TOOLCHAIN_CONTEXT.md` | Tool descriptions |
| `context/WORKFLOW_CONTEXT.md` | Pipeline structure |
| `registry/MODEL_REGISTRY.md` | Model registry entries |

---

## Architecture Summary

```
Cloud AI (SuperGrok)
      ↓
Storyboard / Script / Prompt Planning
      ↓
Stability Matrix v2.16.1
      ↓
ComfyUI v0.25.0
      ↓
SDXL Base 1.0 → Key Images (1024×1024)
      ↓
LTX Video 2B v0.9.1 → Video Clips (768×512, I2V)
      ↓
FFmpeg 8.0.1 → Assembly, Transitions, Export
      ↓
Projects/<id>/exports/
```

---

## Active Models

| Model | Type | Size | Location | Status |
|-------|------|------|----------|--------|
| SDXL Base 1.0 | Checkpoint (image) | 6.94 GB | `F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors` | Production |
| LTX Video 2B v0.9.1 | Video (I2V) | 5.72 GB | `F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors` | Production Baseline |
| T5XXL fp8 | Text Encoder | 4.56 GB | `...\ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors` | Required for LTX |

---

## Retired Models

| Model | Reason | Evidence |
|-------|--------|----------|
| WAN 2.1 I2V 14B (all quants) | Not viable on RTX 3060 12GB. 4.9h benchmark timeout. 26.2 GB marked for removal. | `docs/WAN_CLEANUP_AUDIT.md`, DECISION-009 |

---

## Current Phase

**Phase 3A.3 — Central Memory Bootstrap** ✅ Complete

---

## Next Phase

**Phase 3A.4 — Corrected Production Readiness**

Goal: Resolve the one remaining blocker (`first-render-001.png` missing) and achieve `READY FOR FIRST LTX RENDER` status.

---

## Unresolved Items

| # | Item | Severity |
|---|------|----------|
| 1 | `first-render-001.png` missing (I2V input image) | **BLOCKER** — both LTX workflows require it |
| 2 | Candidate `mjuhight1.jpg` available (1706×960, 403 KB) | Workaround exists |
| 3 | No VAE/ControlNet/LoRA models | Low — not needed for baseline |
| 4 | WAN HuggingFace cache remnants (~1 GB) | Low — not active |

---

## Decisions Recorded

| ID | Title | Status |
|----|-------|--------|
| 001 | Local-First AI Video Architecture | Active |
| 002 | F:\AIModels as external model library | Active |
| 003 | F:\ProjectClipsAI as project workspace | Active |
| 004 | Stability Matrix manages ComfyUI | Active |
| 005 | SDXL Base 1.0 is image gen baseline | Active |
| 006 | LTX Video 2B is production video baseline | Active |
| 007 | T5XXL fp8 required for LTX | Active |
| 008 | Image-to-Video preferred over Text-to-Video | Active |
| 009 | WAN 2.1 I2V 14B retired from production | Superseded (by LTX) |
| 010 | SuperGrok Cloud for creative direction | Active |
| 011 | No large models or renders in Git | Active |
