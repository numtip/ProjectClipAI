# Agent Start Here

> Mandatory startup instructions for every agent working on AI Clips Factory.

---

## Mandatory Startup Sequence

Every agent MUST read these files in order before taking any action:

| # | File | Purpose |
|---|------|---------|
| 1 | `CONTEXT_PACK.md` | Executive summary — project identity, status, stack, milestones |
| 2 | `HANDOFF.md` | Single-page status handoff — current phase, blockers, next actions |
| 3 | `PROJECT_STATE.md` | Single source of truth — project identity, architecture, active models, current phase |
| 4 | `kb/DECISION_LOG.md` | All architectural and operational decisions ever made |
| 5 | `kb/CURRENT_TOOLCHAIN.md` | Runtime versions, paths, and model locations |
| 6 | `kb/PHASE_STATUS.md` | Current phase, readiness status, pending blockers |
| 7 | `kb/SESSION_LOG.md` | Session history — what was done in previous sessions |
| 8 | `kb/PROJECT_GOVERNANCE.md` | Governance rules — phase close procedure, KB integrity |
| 9 | `kb/TOKEN_SAVIOR_WORKFLOW.md` | Token efficiency rules |

---

## Core Rules

1. **Never rely on memory alone** — Always verify actual paths before referencing them
2. **Never reinstall existing tools** — Stability Matrix, ComfyUI, Python, FFmpeg, Git are all installed
3. **Never propose WAN for production** — WAN 2.1 I2V 14B is retired. LTX Video 2B v0.9.1 is the production baseline
4. **Read PROJECT_STATE first** — It contains the current architecture and model inventory
5. **No large assets in Git** — Model files (safetensors, ckpt, pt, pth), renders (mp4, png), and exports stay outside Git
6. **No rendering before readiness validation** — Check `kb/PHASE_STATUS.md` for current blockers
7. **Follow Token Savior Workflow** — Read `kb/TOKEN_SAVIOR_WORKFLOW.md` before any scanning or generation

---

## Quick Reference

| Item | Path/Location |
|------|---------------|
| Project root | `F:\ProjectClipsAI\` |
| Model library | `F:\AIModels\` |
| ComfyUI (managed) | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\` |
| Stability Matrix | `C:\Users\prinya\AppData\Local\StabilityMatrix\StabilityMatrix.exe` |
| ComfyUI version | 0.25.0 |
| Python version | 3.12.10 |
| GPU | RTX 3060 12GB |
| Active models | SDXL Base 1.0, LTX Video 2B v0.9.1, T5XXL fp8 |
| Production video baseline | LTX Video 2B v0.9.1 |
| Retired video model | WAN 2.1 I2V 14B |

---

## What To Do If Stuck

1. Read `CONTEXT_PACK.md` and `HANDOFF.md` to recover project state quickly
2. Read `PROJECT_STATE.md` to understand current status
3. Check `kb/PHASE_STATUS.md` for known blockers
4. Check `kb/DECISION_LOG.md` for past decisions
5. Read `reports/FULL_TOOLCHAIN_DISCOVERY.md` for the complete system inventory
6. Only then propose actions or changes
