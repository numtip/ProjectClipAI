# Decision Log

> Permanent record of architectural and operational decisions.
> New decisions appended; existing decisions never deleted — only superseded.

---

## DECISION-001 — Local-First AI Video Architecture

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |
| Author | Project Constitution |

**Decision:** All GPU rendering runs locally. Cloud AI is used only for creative text tasks (script, storyboard, prompts).

**Rationale:** Cost control, data privacy, offline capability, predictable performance.

**Source:** `docs/AI_VIDEO_LAB_BLUEPRINT.md`, `PROJECT_CONSTITUTION.md`

---

## DECISION-002 — F:\AIModels is the external model library

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** All model weight files are stored at `F:\AIModels\` outside the project Git repository. Organized into subdirectories (checkpoints, video, vae, lora, etc.).

**Rationale:** Keeps Git repo small. Enables shared model access across projects. Follows MODEL_LIBRARY_STANDARD.md naming conventions.

**Source:** `docs/MODEL_LIBRARY_STANDARD.md`

---

## DECISION-003 — F:\ProjectClipsAI is the project workspace

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** All project metadata, workflows, prompts, registries, scripts, and project briefs live in `F:\ProjectClipsAI\` under Git.

**Source:** `context/PROJECT_CONTEXT.md`

---

## DECISION-004 — Stability Matrix manages ComfyUI

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** ComfyUI is installed and managed through Stability Matrix v2.16.1 at `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\`.

**Rationale:** Stability Matrix provides version management, updates, and model browsing. ComfyUI v0.25.0 includes built-in LTX support — no custom nodes needed.

**Source:** `reports/FULL_TOOLCHAIN_DISCOVERY.md` §3

---

## DECISION-005 — SDXL Base 1.0 is the image generation baseline

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** All key images for I2V pipeline are generated using SDXL Base 1.0 (`F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors`, 6.94 GB).

**Rationale:** Lightweight enough for RTX 3060 12GB. Adequate quality for 1024×1024 key frames. Baked-in VAE avoids separate VAE model download.

**Source:** `reports/FULL_TOOLCHAIN_DISCOVERY.md` §5

---

## DECISION-006 — LTX Video 2B v0.9.1 is the production video baseline

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active**, **Production Baseline** |

**Decision:** All video generation uses LTX Video 2B v0.9.1 (`F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors`, 5.72 GB) at 768×512 resolution.

**Rationale:** Validated on RTX 3060 12GB. ~116s for 5s clip. Previous successful render evidence exists (first-video-001.mp4, first-video-002.mp4).

**Source:** `registry/MODEL_REGISTRY.md` (ID 002), `reports/FULL_TOOLCHAIN_DISCOVERY.md`

---

## DECISION-007 — T5XXL fp8 is required for LTX workflows

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** LTX text conditioning requires T5XXL fp8 text encoder (`t5xxl_fp8_e4m3fn.safetensors`, 4.56 GB).

**Location:** `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors`

**Source:** `reports/FULL_TOOLCHAIN_DISCOVERY.md` §3

---

## DECISION-008 — Image-to-Video is preferred over Text-to-Video

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** All video clips start from a generated key image (SDXL) and are animated via I2V (LTX). Pure T2V is not used.

**Rationale:** More control over composition, framing, and subject matter.

**Source:** `docs/AI_VIDEO_LAB_BLUEPRINT.md`

---

## DECISION-009 — WAN 2.1 I2V 14B retired from production

| Field | Value |
|-------|-------|
| Date | 2026-06-17 |
| Status | **Superseded** (by LTX) |

**Decision:** WAN 2.1 I2V 14B is not production-viable on RTX 3060 12GB at any quantization. Retired after 4.9h benchmark timeout.

**Evidence:**
- Q4_K_M (10.6 GB): overflowed 12GB VRAM, never completed render
- Q3_K_M (8.0 GB): 16 min for 2s test clip, benchmark never completed
- 26.2 GB of WAN-only model files marked for removal

**Source:** `docs/WAN_CLEANUP_AUDIT.md`

---

## DECISION-010 — SuperGrok Cloud for creative direction

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** Cloud AI (SuperGrok) remains available for planning, prompting, and creative direction. All GPU rendering stays local.

**Source:** `context/TOOLCHAIN_CONTEXT.md`

---

## DECISION-011 — No large models or renders in Git

| Field | Value |
|-------|-------|
| Date | 2026-06-18 (retroactive) |
| Status | **Active** |

**Decision:** Model weight files (safetensors, ckpt, pt, pth), render outputs (mp4, png), and project exports (mp4) are never committed to Git.

**Rationale:** `.gitignore` configured. Registry entries and briefs go in Git. Large files stay in external paths.

**Source:** `docs/AI_VIDEO_LAB_BLUEPRINT.md`, `.gitignore`
