# First Real LTX Render Report

> Phase 3C
> Date: 2026-06-18
> Workflow: first-video-002.json
> Status: SUCCESS

---

## Render Summary

| Metric | Value |
|--------|-------|
| Workflow | `workflows/comfyui/first-video/first-video-002.json` |
| LTX model | `ltx-video-2b-v0.9.1.safetensors` (5.72 GB) |
| Text Encoder | `t5xxl_fp8_e4m3fn.safetensors` (4.56 GB) |
| Source image | `first-render-001.png` (1.6 MB, 1024x1024) |
| ComfyUI version | 0.25.0 |
| Platform | Stability Matrix v2.16.1 |
| Start time | 22:06:21 ICT |
| End time | 22:08:29 ICT |
| Render duration | 115.3 seconds (~2 min) |

---

## Output Details

| Property | Value |
|----------|-------|
| Filename | `first-video_00003_.mp4` |
| Output path | `ComfyUI\output\first-video_00003_.mp4` |
| Project copy | `projects\000-first-clip\outputs\first-video-003.mp4` |
| File size | 714,706 bytes (698 KB) |
| Duration | 5.04 seconds |
| Resolution | 768 x 512 |
| Frame rate | 24 fps |
| Codec | H.264 |
| Bitrate | 1134 kbps |
| VRAM usage | ~2600 MiB idle after render (peak ~10 GB during) |
| GPU utilization | ~10% idle after render |

---

## Parameters Used

| Parameter | Value |
|-----------|-------|
| Steps | 30 |
| CFG | 4.0 |
| Frames | 121 |
| Seed | 12345 |
| Sampler | euler |
| Scheduler | normal |
| Denoise | 1.0 |
| Output format | MP4 (H.264) |

---

## Quality Notes

- **Duration**: 5.04s -- exactly matches expected 121 frames @ 24fps
- **Resolution**: 768x512 -- matches workflow specification
- **File size**: 698 KB -- comparable to previous render first-video_00002_.mp4 (698 KB)
- **Render time**: 115.3 seconds -- consistent with prior benchmarks (~116s for 5s clip on RTX 3060 12GB)
- **No workflow errors**: Pipeline completed without warnings or failures

---

## Issues

| Issue | Severity | Resolution |
|-------|----------|------------|
| None | -- | First production render completed without issues |

---

## Previous Render Comparison

| Render | Date | Workflow | Frames | Steps | Size | Duration |
|--------|------|----------|--------|-------|------|----------|
| first-video_00001_.mp4 | 2026-06-17 | v1 (97f, 25s) | 97 | 25 | 420 KB | ~4s |
| first-video_00002_.mp4 | 2026-06-17 | v2 (121f, 30s) | 121 | 30 | 698 KB | ~5s |
| **first-video_00003_.mp4** | **2026-06-18** | **v2 (121f, 30s)** | **121** | **30** | **698 KB** | **~5s** |

Current render matches previous successful parameters exactly. Output quality consistent with benchmark.

---

## Conclusion

**Phase 3C complete. Pipeline is production-verified.**
