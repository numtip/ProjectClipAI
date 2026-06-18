# Phase 3 — First Multi-shot Clip

**Project:** phase3-first-multishot
**Status:** planned (prompts ready)
**Shots:** 4
**Target Duration:** ~20s (5s per shot)
**Pipeline:** WAN Image-to-Video → FFmpeg assembly
**Reference Image:** `..\mjuhight1.jpg`

## Shot Overview

| # | Name | Type | Duration | Key Visual |
|---|------|------|----------|------------|
| 01 | MJU Drone Aerial | I2V (from mjuhight1.jpg) | ~5s | Cinematic drone flyover of Maejo University campus |
| 02 | Descent to Fields | T2V / I2V | ~5s | Camera descends from overview into farm plots |
| 03 | Smart Agriculture Data | T2V / I2V | ~5s | Animated data overlays on crop fields |
| 04 | Hero Ending | T2V / I2V | ~5s | Golden-hour wide shot, sustainable future |

## Folder Structure

```
phase3-first-multishot/
├── README.md
├── prompts/
│   ├── shot01_i2v_mju_drone.md
│   ├── shot02_descent.md
│   ├── shot03_smart_agri_data.md
│   └── shot04_hero_ending.md
├── scripts/
│   └── concat_shots.bat
├── reports/
│   └── PHASE3_FIRST_MULTISHOT_PLAN.md
├── inputs/          (place source clips here after rendering)
├── outputs/         (final assembled clip)
└── work/            (intermediate files)
```

## How to Use

1. Generate each shot in Wan2GP / Pinokio (see individual prompt files for exact WAN settings).
2. Place the output `.mp4` files in `inputs/` named `Shot01.mp4` through `Shot04.mp4`.
3. Run `scripts/concat_shots.bat` to produce `outputs/first_multishot_clip.mp4`.

## Dependencies

- WAN 2.1 I2V 14B 480p (for Shot 01 image-to-video)
- WAN 2.1 T2V 14B 480p (for Shots 02–04, or I2V if keyframes are generated)
- FFmpeg (for concatenation)

> **Note:** WAN was retired in Phase 2C due to high inference time on RTX 3060 12GB. These prompts serve as the creative blueprint. If hardware constraints persist, consider substituting LTX Video for Shots 02–04 where T2V is sufficient.
