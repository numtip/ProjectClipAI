# Phase 4A — Multi-Shot Foundation Report

> Generated: 2026-06-18
> Status: COMPLETE

---

## Summary

Successfully generated 4 video shots using the existing LTX Video 2B v0.9.1 pipeline. All shots use `mjuhight1.jpg` (1706×960) as the Image-to-Video source input.

---

## Shot Inventory

| Shot | Filename | Size | Duration | Resolution | FPS | Frames | Codec | Render Time |
|------|----------|------|----------|------------|-----|--------|-------|-------------|
| 01 | `Shot01.mp4` | 1,860 KB | 5.04s | 768×512 | 24 | 121 | H.264 | 120.3s |
| 02 | `Shot02.mp4` | 1,680 KB | 5.04s | 768×512 | 24 | 121 | H.264 | 105.2s |
| 03 | `Shot03.mp4` | 1,817 KB | 5.04s | 768×512 | 24 | 121 | H.264 | 105.2s |
| 04 | `Shot04.mp4` | 1,580 KB | 5.04s | 768×512 | 24 | 121 | H.264 | 105.2s |

**Total output size:** 6.9 MB
**Total render time:** 435.9s (~7.3 min)
**Average per shot:** 109.0s

---

## Parameters

All shots used the validated `first-video-002.json` workflow with per-shot variations:

| Shot | Seed | Prompt Theme |
|------|------|--------------|
| 01 | 101 | Drone aerial — cinematic forward movement, swaying trees, mountains backdrop |
| 02 | 202 | Descent — smooth downward movement toward rice terraces, mist, morning light |
| 03 | 303 | Smart agriculture — monitoring station, sensor equipment, camera orbit |
| 04 | 404 | Hero ending — golden hour wide shot, sunset, crane rise, warm color |

### Shared Parameters

| Parameter | Value |
|-----------|-------|
| Model | LTX Video 2B v0.9.1 |
| Text Encoder | T5XXL fp8 |
| Resolution | 768×512 |
| Frames | 121 |
| FPS | 24 |
| Steps | 30 |
| CFG Scale | 4.0 |
| Sampler | Euler |
| Scheduler | Normal |
| Codec | H.264 |

---

## Validation

All outputs validated with `ffprobe`:

- **Codec:** H.264 (all pass)
- **Resolution:** 768×512 (all pass)
- **Duration:** 5.04s (±0.0s tolerance, all pass)
- **File integrity:** Opens without errors (all pass)
- **No workflow errors:** No API errors during render (all pass)

---

## Source Image

| Property | Value |
|----------|-------|
| File | `mjuhight1.jpg` |
| Path | `F:\ProjectClipsAI\projects\mjuhight1.jpg` |
| Resolution | 1706×960 |
| Size | 403 KB |
| Aspect ratio | 16:9 |

Placed in ComfyUI `input/` as `first-render-001.png` for workflow compatibility.

---

## Pipeline

```
mjuhight1.jpg
   ↓
ComfyUI/input/first-render-001.png
   ↓
LTX Video 2B v0.9.1 + T5XXL fp8
   ↓
Shot01.mp4, Shot02.mp4, Shot03.mp4, Shot04.mp4
   ↓
projects/phase3-first-multishot/outputs/
```

---

## Files Created

```
projects/phase3-first-multishot/outputs/
├── Shot01.mp4
├── Shot02.mp4
├── Shot03.mp4
└── Shot04.mp4
```

---

## Observations

1. **Shot 01 (Drone Aerial)** was the longest render (120.3s) — likely due to initial model warm-up
2. **Subsequent shots** consistently rendered in ~105s each, showing stable pipeline performance
3. All 4 shots used the same source image with different prompts and seeds, producing distinct motion results
4. The LTX pipeline handles single-source multi-shot generation reliably at ~2 min per clip
5. No custom nodes or modifications required — all nodes are built-in to ComfyUI 0.25.0

---

## Next Steps

- **Phase 4B:** FFmpeg assembly — concatenate shots with transitions
- **Phase 5:** Production pipeline automation — SDXL keyframe → LTX video → FFmpeg export
