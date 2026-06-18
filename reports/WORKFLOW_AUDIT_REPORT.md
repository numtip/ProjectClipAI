# Phase 3B — ComfyUI Workflow Audit Report

> Date: 2026-06-18
> Method: Filesystem scan + workflow JSON validation

---

## Component Status

| Component | Status | Details |
|-----------|--------|---------|
| ComfyUI | **FAIL** | Not installed on any drive (C:\, F:\ scanned). No `main.py` found. |
| SDXL | **PASS** | Checkpoint `sd_xl_base_1.0.safetensors` (6.94 GB) found. Workflow `first-render.json` references it directly. |
| T5XXL | **FAIL** | Text encoder `t5xxl_fp8_e4m3fn.safetensors` not found anywhere on F:\. Required by both LTX workflows. |
| LTX | **WARN** | Checkpoint `ltx-video-2b-v0.9.1.safetensors` (5.72 GB) found. But T5XXL dependency missing + input image `first-render-001.png` missing. |
| Workflow JSONs | **PASS** | All 3 workflow JSONs are syntactically valid. |

---

## Workflow Inventory

| Workflow | Path | Valid JSON | Key References | Loadable? |
|----------|------|------------|----------------|-----------|
| SDXL First Render | `workflows/comfyui/first-render/first-render.json` | YES | `sd_xl_base_1.0.safetensors` | NO (ComfyUI missing) |
| LTX Video (v1) | `workflows/comfyui/first-video/first-video.json` | YES | `ltx-video-2b-v0.9.1.safetensors`, `t5xxl_fp8_e4m3fn.safetensors`, `first-render-001.png` | NO (ComfyUI + T5XXL missing) |
| LTX Video (v2) | `workflows/comfyui/first-video/first-video-002.json` | YES | `ltx-video-2b-v0.9.1.safetensors`, `t5xxl_fp8_e4m3fn.safetensors`, `first-render-001.png` | NO (ComfyUI + T5XXL missing) |

---

## Missing Dependencies

| Dependency | Referenced By | Resolved? |
|------------|---------------|-----------|
| ComfyUI runtime | All 3 workflows | **NO** |
| `t5xxl_fp8_e4m3fn.safetensors` | Both LTX workflows (node 3: CLIPLoader) | **NO** |
| `first-render-001.png` | Both LTX workflows (node 1: LoadImage) | **NO** |
| `sd_xl_base_1.0.safetensors` | SDXL workflow (node 4: CheckpointLoaderSimple) | **YES** |
| `ltx-video-2b-v0.9.1.safetensors` | Both LTX workflows (node 2: CheckpointLoaderSimple) | **YES** |

---

## Custom Nodes Audit

ComfyUI custom_nodes directory does not exist (ComfyUI not installed).

No custom node packages were found on F:\ drive.

---

## External Model References

All model references are within the standard ComfyUI model directory structure:
- `ComfyUI\models\checkpoints\`
- `ComfyUI\models\text_encoders\`

These resolve only after ComfyUI is installed and model files are placed in the correct subdirectories.

---

## Findings

1. **ComfyUI is not installed** — No installation found on C:\ or F:\ drives.
2. **T5XXL fp8 text encoder is missing** — Required by both LTX workflows.
3. **Input image `first-render-001.png` is missing** — Both LTX workflows require this as the I2V source image. It must be generated first using the SDXL pipeline, or provided manually.
4. **Workflow JSONs are syntactically valid** — All parse correctly.

---

## Recommendation

- Install ComfyUI (portable or Python-based).
- Download `t5xxl_fp8_e4m3fn.safetensors` to `ComfyUI/models/text_encoders/`.
- Generate or copy `first-render-001.png` for I2V pipeline. The existing `mjuhight1.jpg` (1706×960, 403 KB) is available but must be renamed/processed for the workflow.
