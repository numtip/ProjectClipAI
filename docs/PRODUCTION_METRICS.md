# Production Metrics

> Performance benchmarks for AI Clips Factory pipeline.
> Last updated: 2026-06-18
> Hardware: RTX 3060 12GB, CUDA 13.3, Driver 610.62

---

## LTX Video 2B v0.9.1

### Single Shot

| Metric | Value |
|--------|-------|
| Resolution | 768×512 |
| Frames | 121 |
| FPS | 24 |
| Duration | 5.04s |
| Steps | 30 |
| CFG | 4.0 |
| Sampler | Euler |
| Render time | 115.3s (Phase 3C) |
| Output size | 698 KB |
| Bitrate | ~2.9 Mbps |
| Codec | H.264 |

### Multi-Shot (4-shot batch)

| Metric | Value |
|--------|-------|
| Shots | 4 |
| Total video duration | 20.17s |
| Total render time | 435.9s (~7.3 min) |
| Average per shot | 109.0s |
| First shot warm-up | 120.3s |
| Subsequent shots avg | 105.2s |
| Total output size | 6.9 MB (4 files) |

### Per-Shot Breakdown (Phase 4A)

| Shot | Seed | Prompt Theme | Render Time | File Size |
|------|------|-------------|-------------|-----------|
| 01 | 101 | Drone Aerial | 120.3s | 1.86 MB |
| 02 | 202 | Descent | 105.2s | 1.68 MB |
| 03 | 303 | Smart Agriculture | 105.2s | 1.82 MB |
| 04 | 404 | Hero Ending | 105.2s | 1.58 MB |

---

## FFmpeg Assembly

| Version | Method | Duration | Size | Bitrate | Time |
|---------|--------|----------|------|---------|------|
| Hard Cuts | Concat (stream copy) | 20.17s | 6.9 MB | 2.7 Mbps | < 1s |
| Fade Transitions | xfade (re-encode CRF 18) | 19.00s | 9.8 MB | 4.1 Mbps | ~3s |

---

## Known Constraints

| Factor | Limit |
|--------|-------|
| Max VRAM | 12 GB |
| Max LTX resolution | 768×512 (validated) |
| Max clips per batch | 4 (validated) |
| Total pipeline time (4 shots) | ~8 min |
| WAN 2.1 (retired) | Not viable at any quantization |

---

## Metric Collection Log

| Date | Test | Metric | Value | Phase |
|------|------|--------|-------|-------|
| 2026-06-18 | First LTX single render | Render time | 115.3s | 3C |
| 2026-06-18 | First LTX single render | File size | 698 KB | 3C |
| 2026-06-18 | 4-shot batch render | Avg render time | 109.0s | 4A |
| 2026-06-18 | 4-shot batch render | Total render time | 435.9s | 4A |
| 2026-06-18 | FFmpeg hard cuts | Assembly time | < 1s | 4B |
| 2026-06-18 | FFmpeg fade transitions | Assembly time | ~3s | 4B |

---

---

## Estimated Production Time (RTX 3060 12GB)

| Target Output | Shot Count | Est. Render Time | Est. Assembly | Est. Total |
|---------------|------------|-----------------|---------------|------------|
| 20s clip | 4 shots | ~7.3 min | < 5s | ~7.5 min |
| 30s clip | 6 shots | ~11 min | < 5s | ~11.5 min |
| 60s clip | 12 shots | ~22 min | < 10s | ~23 min |
| 90s clip | 18 shots | ~33 min | ~15s | ~33.5 min |

> Based on avg 109s/shot batch rate (Phase 4A). First shot ~120s (warm-up).

---

## Per-Shot File Size Reference

| Shot | Bitrate | Size | Notes |
|------|---------|------|-------|
| Shot01 | 2.95 Mbps | 1.86 MB | High-motion aerial |
| Shot02 | 2.67 Mbps | 1.68 MB | Descent, some motion |
| Shot03 | 2.88 Mbps | 1.82 MB | Orbit, moderate motion |
| Shot04 | 2.51 Mbps | 1.58 MB | Rise, gentle motion |

> Lower bitrate may indicate less content motion (more static frames).

---

## Master Export Comparison

| Version | Duration | Frames | Size | Bitrate | Quality |
|---------|----------|--------|------|---------|---------|
| Hard Cuts | 20.17s | 484 | 6.93 MB | 2.75 Mbps | Lossless (stream copy) |
| Fade Transitions | 19.00s | 456 | 9.77 MB | 4.11 Mbps | Re-encode CRF 18 |

---

## Future Metric Entries

| Date | Test | Metric | Value | Notes |
|------|------|--------|-------|-------|
| -- | -- | -- | -- | -- |
