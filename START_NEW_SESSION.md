# AI Clips Factory — New Session Startup

> Read this before taking any action. You are the primary architect for AI Clips Factory.

---

## Mandatory Read Order

| # | File | Purpose |
|---|------|---------|
| 1 | `CONTEXT_PACK.md` | Executive summary — project identity, status, stack, milestones |
| 2 | `HANDOFF.md` | Single-page status handoff — current phase, blockers, next actions |
| 3 | `PROJECT_STATE.md` | Single source of truth — architecture, models, phase history |
| 4 | `kb/PHASE_STATUS.md` | Phase progress, production readiness, pending blockers |
| 5 | `kb/SESSION_LOG.md` | Session history — what was done in previous sessions |
| 6 | `kb/DECISION_LOG.md` | All architectural and operational decisions |
| 7 | `kb/CURRENT_TOOLCHAIN.md` | Runtime versions, paths, model locations |
| 8 | `kb/PROJECT_GOVERNANCE.md` | Governance rules — phase close procedure, KB integrity |
| 9 | `kb/TOKEN_SAVIOR_WORKFLOW.md` | Token efficiency rules |

---

## Core Rules

1. **Never reinstall existing tools** — Stability Matrix, ComfyUI, Python, FFmpeg, Git, Node.js are all installed.
2. **Never propose WAN for production** — WAN 2.1 I2V 14B is **retired**. LTX Video 2B v0.9.1 is the production baseline.
3. **No large assets in Git** — Model files (safetensors, ckpt, pt, pth), renders (mp4, png), and exports stay outside Git.
4. **No rendering before readiness validation** — Check `kb/PHASE_STATUS.md` for current blockers first.
5. **No random model downloads** — Check `registry/MODEL_REGISTRY.md` and `F:\AIModels\` first.
6. **Follow Token Savior Workflow** — Read `kb/TOKEN_SAVIOR_WORKFLOW.md` before any scanning or generation.
7. **Document renders** — Every render must be documented in the project's `render-notes.md`.
8. **Use validated workflow only** — LTX production workflow is `workflows/comfyui/first-video/first-video-002.json`.

---

## Important Decisions Summary

- **WAN 2.1 I2V 14B retired** — Not viable on RTX 3060 12GB. LTX Video 2B v0.9.1 is the production baseline.
- **Stability Matrix manages ComfyUI** — ComfyUI 0.25.0 at `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\`
- **RTX 3060 12GB** is the target hardware. Max stable resolution: 768×512 for LTX.
- **Image-to-Video first** — Generate SDXL key image, then animate via LTX I2V.
- **Model library** at `F:\AIModels\` — mapped via `extra_model_paths.yaml`.

---

## Continue From Latest State

Do **not** restart discovery. Do **not** suggest reinstalling existing tooling. The pipeline is validated and operational. Read the context pack, then continue from the current phase marker in `kb/PHASE_STATUS.md`.

---

## Quick Reference

| Item | Path/Location |
|------|---------------|
| Project root | `F:\ProjectClipsAI\` |
| Model library | `F:\AIModels\` |
| ComfyUI managed root | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\` |
| Stability Matrix | `C:\Users\prinya\AppData\Local\StabilityMatrix\StabilityMatrix.exe` |
| Python | `C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe` |
| Active workflows | `workflows/comfyui/first-video/first-video-002.json` (LTX production) |
| Batch render script | `scripts/render-batch-ltx.ps1` (PowerShell) |
| Batch assembly | `scripts/assemble-batch.bat` |
| Input image for I2V | `ComfyUI/input/first-render-001.png` |
| Example project | `projects/phase3-first-multishot/` |
| Phase 5D test project | `projects/001-controlled-batch-test/` |
