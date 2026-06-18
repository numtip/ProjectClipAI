# Render Notes: First Clip

**Project:** 000-first-clip

## Overview

| Field | Value |
|-------|-------|
| Pipeline | Image Generation (SDXL) — Phase 1C → Video Generation (LTX I2V) — Phase 2A → WAN Benchmark — Phase 2B |
| Model | SDXL base 1.0 → LTX Video 2B v0.9.1 → WAN 2.1 I2V 14B 480p Q3_K_M |
| Resolution | 1024x1024 → 768x512 → 480x480 (WAN test) |
| Sampler | euler, normal/simple scheduler |
| Steps | 20 (image) / 25-30 (video) |
| CFG | 7.0 (image) / 4.0-5.0 (video) |
| Seed | 42, 12345 |
| Total renders | 1 image + 2 LTX videos + 1 WAN test + 1 WAN benchmark (queued) |

## Phase 1C — First Render (2026-06-17)

| Attempt | Date | Settings | Output | Issues |
|---------|------|----------|--------|--------|
| 001 | 2026-06-17 | SDXL base 1.0, 1024x1024, euler, 20 steps, CFG 7.0, seed=42 | assets/first-render-001.png (1574 KB) | None — first render successful |

## Phase 2A — First Video Generation (2026-06-17)

| Attempt | Date | Settings | Output | Issues |
|---------|------|----------|--------|--------|
| 001 | 2026-06-17 | LTX Video 2B v0.9.1, 768x512, euler, 25 steps, CFG 4.0, seed=42, 97 frames, 24fps, 4.0s | outputs/first-video-001.mp4 (430 KB) | T5XXL fp8 text encoder download required (~4.6 GB). Render took ~89s on RTX 3060 12GB |
| 002 | 2026-06-17 | LTX Video 2B v0.9.1, 768x512, euler, 30 steps, CFG 4.0, seed=12345, 121 frames, 24fps, 5.0s, motion-first prompt | outputs/first-video-002.mp4 (715 KB) | LTX-2.3-22B distilled not feasible on 12GB VRAM (requires 16GB min). Used 2B v0.9.1 instead. Render took ~116s |

## Phase 2B — WAN Benchmark (2026-06-17)

| Attempt | Date | Settings | Output | Issues |
|---------|------|----------|--------|--------|
| 001 | 2026-06-17 | WAN 2.1 I2V 14B 480p Q4_K_M GGUF (10.6 GB), 768x512, 121f, 30 steps, CFG 5.0, seed=42, euler, ModelSamplingSD3(3.0) | — | Q4_K_M + UMT5 (6.3 GB) + CLIP Vision (1.2 GB) > 12GB. Render never completed (>60 min). Switched to Q3_K_M |
| 002 | 2026-06-17 | WAN 2.1 I2V 14B 480p Q3_K_M GGUF (8.0 GB), 480x480, 49f, 20 steps, CFG 5.0, seed=42, euler, --lowvram, ModelSamplingSD3(3.0) | outputs/wan-test-001.mp4 (0.2 MB) | SUCCESS — 2.04s, 24fps, 480x480. Render took ~940s (16 min). Very slow due to constant VRAM offloading |
| 003 | 2026-06-17 | WAN 2.1 I2V 14B 480p Q3_K_M GGUF (8.0 GB), 768x512, 121f, 30 steps, CFG 5.0, seed=42, euler, --lowvram, ModelSamplingSD3(3.0) | outputs/wan-benchmark-001.mp4 (TBD) | Queued. Estimated 60-90 min render time based on test scaling |

**WAN Benchmark Conclusion:** WAN 2.1 I2V 14B is not production-viable on RTX 3060 12GB. Even at Q3_K_M (8.0 GB), the 14B parameter count combined with UMT5 text encoder (6.3 GB) requires constant GPU-to-RAM offloading, making renders 25-30x slower than LTX. **LTX Video 2B v0.9.1 remains the production baseline.**

## Lessons Learned

- SDXL renders at 1024x1024 in ~30s on RTX 3060 12GB
- ComfyUI API workflow execution is reliable
- extra_model_paths.yaml successfully points to shared F:\AIModels library
- No custom nodes needed for basic SDXL workflow
- LTX Video model requires separate T5XXL text encoder (not embedded in checkpoint)
- LTX I2V needs CLIPLoader(type="ltxv") instead of using CheckpointLoaderSimple's CLIP output
- LTX 97 frames at 768x512 takes ~89s on RTX 3060 12GB with fp8 T5 encoder
- Built-in ComfyUI `nodes_lt.py` nodes work without custom node packs
- New API SaveVideo node works with h264 codec at 24fps
- LTX 121 frames (5s) at 768x512 takes ~116s on RTX 3060 12GB
- Motion-first prompts produce more natural camera movement than scene-first
- LTX-2.3-22B requires minimum 16GB VRAM (RTX 3060 12GB not supported)
- Available alternative: GGUF Q4_K_M at ~13GB model size, but 20+ min render time with aggressive offloading
- FP8 matmul requires RTX 40xx series; RTX 30xx needs MXFP8 block-32 variant
- **WAN 2.1 I2V 14B is not production-viable on RTX 3060 12GB.** Even Q3_K_M (8.0 GB) is too large with UMT5 (6.3 GB) + CLIP Vision (1.2 GB). Requires ComfyUI-GGUF custom node.
- WAN requires `--lowvram` mode for 12GB VRAM. Without it, model fails to load.
- WAN requires `ModelSamplingSD3(shift=3.0)` for correct flow matching sampling in ComfyUI.
- WAN native resolution (480p) is 832x480. Our 480x480 test was a downscale — full benchmark at 768x512 will be even slower.
- **LTX Video 2B v0.9.1 confirmed as production baseline for ProjectClipsAI** on current hardware.
