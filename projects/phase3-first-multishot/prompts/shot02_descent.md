# Shot 02 — Descent to Fields

**Type:** Text-to-Video (or Image-to-Video if a keyframe is generated first)
**Model:** WAN 2.1 14B
**Target Duration:** ~5s

## WAN Settings

| Setting | Value |
|---------|-------|
| Resolution | 832 × 480 |
| Frames | 81 |
| FPS | 16 |
| Steps | 20 |
| CFG Scale | 5 |
| Motion Strength | 0.30 – 0.40 |

## Positive Prompt

```
smooth drone descent from aerial view toward lush green rice terraces,
agricultural research plots at Maejo University,
rows of crops gently swaying,
morning sunlight breaking through mist,
farmers walking between plots,
documentary cinematography style,
natural colors,
gentle downward camera movement
```

## Negative Prompt

```
text, watermark, cartoon, anime, warped architecture,
extra buildings, camera shake, low quality, blurry,
oversaturated, lens flare
```

## Notes

- If generating T2V, the scene should feel like a natural continuation from Shot 01's aerial view.
- For best continuity, generate a keyframe image first (SDXL) showing the descent perspective, then use I2V.
- Start Motion Strength at 0.30 — the descent needs to feel smooth, not rushed.
