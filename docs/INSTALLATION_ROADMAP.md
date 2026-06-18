# Installation Roadmap

> Governance document only. No software is installed through this document.
> This roadmap defines the sequential stages for setting up the local environment.

## Prerequisites

Before Stage 1, confirm:
- NVIDIA GPU with 8GB+ VRAM (12GB recommended)
- CUDA 12.x drivers installed
- Windows 10/11 up to date
- FFmpeg 8.0+ available (verified by scripts/ffmpeg-check.ps1)
- Git available (verified by scripts/check-env.ps1)

---

## Stage 1 — Stability Matrix

**Goal:** Install the environment launcher that manages ComfyUI and models.

**Expected outcome:** Stability Matrix is installed and configured with an external model library path.

**Validation criteria:**
- [ ] Stability Matrix launches without errors
- [ ] Model library path points to external drive (not inside repository)
- [ ] Default ComfyUI instance can be created from within Stability Matrix

---

## Stage 2 — ComfyUI

**Goal:** Install ComfyUI via Stability Matrix and verify it loads.

**Expected outcome:** ComfyUI web UI is accessible at localhost:8188.

**Validation criteria:**
- [ ] ComfyUI instance created and started within Stability Matrix
- [ ] Web UI loads at http://localhost:8188
- [ ] Default checkpoint model loads without errors
- [ ] First test image generates successfully

---

## Stage 3 — FFmpeg Verification

**Goal:** Confirm FFmpeg is available and can process video.

**Expected outcome:** FFmpeg is callable from ComfyUI export nodes and command line.

**Validation criteria:**
- [ ] `scripts/ffmpeg-check.ps1` passes (H.264, H.265, AAC encoders confirmed)
- [ ] FFmpeg is available in system PATH
- [ ] ComfyUI can call FFmpeg for video output (Save Video node works)

---

## Stage 4 — First Workflow Import

**Goal:** Import the first image-to-video workflow into ComfyUI.

**Expected outcome:** A working workflow from `workflows/comfyui/` loads in ComfyUI.

**Validation criteria:**
- [ ] Workflow JSON loads without errors in ComfyUI
- [ ] All required custom nodes are installed
- [ ] Model paths point to existing files in the external model library
- [ ] Workflow is registered in `registry/WORKFLOW_REGISTRY.md`
- [ ] `docs/skills/COMFYUI_WORKFLOW_REVIEW.md` checklist is satisfied

---

## Stage 5 — First Render

**Goal:** Run the image-to-video workflow and produce the first raw clip.

**Expected outcome:** A video file is written to `projects/000-first-clip/outputs/`.

**Validation criteria:**
- [ ] Render completes without CUDA/VRAM errors
- [ ] Output file plays without corruption
- [ ] Duration matches expected length
- [ ] `render-notes.md` is updated with render parameters
- [ ] `docs/skills/RENDER_QA.md` checklist is satisfied

---

## Post-Installation

After all 5 stages complete:
1. Update `registry/TOOLCHAIN_REGISTRY.md` with installed versions
2. Update `registry/MODEL_REGISTRY.md` with downloaded models
3. Run full `scripts/check-env.ps1` to confirm environment health
4. Begin clip assembly and export per `docs/skills/EXPORT_QA.md`
