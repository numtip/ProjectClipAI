# Phase 3A — Model Library Audit Report

> Date: 2026-06-18
> Scope: F:\AIModels
> Method: Direct filesystem scan

---

## Required Models

| Model | Found | Path | Size | Status |
|-------|-------|------|------|--------|
| SDXL Base 1.0 | YES | F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors | 6.94 GB | READY |
| LTX Video 2B v0.9.1 | YES | F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors | 5.72 GB | READY |
| T5XXL Encoder | NO | NOT FOUND | N/A | MISSING |

### Notes

- **SDXL Base 1.0**: Naming (`sd_xl_base_1.0.safetensors`) does not follow standard (`publisher-model-version`). Registry entry @ `registry/MODEL_REGISTRY.md` (ID 001) is present. Status: **READY** for use.
- **LTX Video 2B v0.9.1**: Naming (`ltx-video-2b-v0.9.1.safetensors`) follows standard. Registry entry @ `registry/MODEL_REGISTRY.md` (ID 002, `production_baseline`) present. Status: **READY**.
- **T5XXL Encoder**: Referenced at `ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors` in registry but **ComfyUI is not installed** and no `t5xxl*` file exists anywhere on F:\. Registry entry @ `registry/MODEL_REGISTRY.md` (ID 003, `active`) but file is absent. Status: **MISSING**.

---

## Storage Summary

| Metric | Value |
|--------|-------|
| Total model storage used | 11.79 GB |
| Video model inventory | 1 (LTX Video 2B v0.9.1) |
| Checkpoint inventory | 1 (SDXL Base 1.0) |
| Text encoder inventory | 0 (T5XXL MISSING) |
| Empty directories | controlnet, embeddings, lora, upscale, vae, ipadapter, archive |

---

## Directory Breakdown

| Directory | Files | Size |
|-----------|-------|------|
| F:\AIModels\checkpoints\ | 2 | 11.79 GB |
| F:\AIModels\controlnet\ | 0 | 0 B |
| F:\AIModels\embeddings\ | 0 | 0 B |
| F:\AIModels\lora\ | 0 | 0 B |
| F:\AIModels\upscale\ | 0 | 0 B |
| F:\AIModels\vae\ | 0 | 0 B |
| F:\AIModels\ipadapter\ | 0 | 0 B |
| F:\AIModels\video\ | 0 | 0 B |
| F:\AIModels\archive\ | 0 | 0 B |

---

## Findings

1. **T5XXL fp8 text encoder is MISSING** — Required for LTX Video conditioning. Workflow references `t5xxl_fp8_e4m3fn.safetensors`.
2. **No dedicated video model folder**: LTX checkpoint lives in `checkpoints\` instead of `video\` per MODEL_LIBRARY_STANDARD.md. No functional impact but violates convention.
3. **SDXL naming non-standard**: Uses underscores (`sd_xl_base_1.0`) instead of hyphens (`stabilityai-sdxl-base-1.0`). Registry references it by ID, so no immediate impact.

---

## Recommendation

- **Download T5XXL fp8 text encoder** before attempting any LTX render.
- Optional: Rename SDXL to match naming standard.
- Optional: Move LTX checkpoint to `F:\AIModels\video\`.
