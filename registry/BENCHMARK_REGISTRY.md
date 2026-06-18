# Benchmark Registry

> Source of truth for benchmark results comparing video generation models.

## Benchmarks

| ID | Date | Project | Input | Model | Workflow | Resolution | Frames | FPS | Duration | Steps | CFG | Seed | Render Time | VRAM Notes | Output | Realism | Motion Stability | Flicker | Camera Smoothness | Decision |
|----|------|---------|-------|-------|----------|------------|--------|-----|----------|-------|-----|------|-------------|-------------|--------|---------|-----------------|---------|-------------------|----------|
| 001 | 2026-06-17 | 000-first-clip | first-render-001.png | LTX Video 2B v0.9.1 | first-video-002.json | 768x512 | 121 | 24 | 5.04s | 30 | 4.0 | 12345 | ~116s | 12GB fits easily. T5XXL fp8 encoder. ~89s for 97f | outputs/first-video-002.mp4 (715 KB) | 3 | 3 | 4 | 3 | Baseline — acceptable quality, fast renders |
| 002 | 2026-06-17 | 000-first-clip | first-render-001.png | WAN 2.1 I2V 14B 480p Q4_K_M | wan-benchmark.json | 768x512 | 121 | 24 | 5.0s (est) | 30 | 5.0 | 42 | >3600s | Q4_K_M (10.6 GB) + UMT5 (6.3 GB) exceeded 12GB. Render never completed after 60+ min | — | — | — | — | — | Rejected — too heavy for 12GB VRAM |
| 003 | 2026-06-17 | 000-first-clip | first-render-001.png | WAN 2.1 I2V 14B 480p Q3_K_M | wan-benchmark.json | 480x480 | 49 | 24 | 2.04s | 20 | 5.0 | 42 | ~940s | Q3_K_M (8.0 GB) + UMT5 (6.3 GB) + CLIP Vision (1.2 GB). ~4 GB headroom. Extremely slow offloading | outputs/wan-test-001.mp4 (0.2 MB) | 3 | 2 | 3 | 2 | Successful but too slow for production. 16 min for 2s clip |
| 004 | 2026-06-17 | 000-first-clip | first-render-001.png | WAN 2.1 I2V 14B 480p Q3_K_M | wan-benchmark.json | 768x512 | 121 | 24 | 5.0s | 30 | 5.0 | 42 | ~17700s (4.9h timeout) | Full benchmark timed out after 4.9h. Q3_K_M (8.0 GB) + UMT5 + CLIP Vision = excessive offloading | — | — | — | — | — | Rejected — not viable on 12GB VRAM |

## Status Legend

- **Baseline** — Reference entry for comparison
- **Completed** — Benchmark finished and QA passed
- **Retry needed** — Render failed, will retry with different settings
- **Rejected** — Model not suitable

## Policy

1. Every benchmark uses the same input image (first-render-001.png)
2. All settings recorded for fair comparison
3. Render time measured from queue to completion
4. Quality scores assigned manually via RENDER_QA (1-5 scale)
5. Update entries when re-running with different parameters
