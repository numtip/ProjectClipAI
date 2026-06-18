# Shot 01 — MJU Drone Aerial (I2V)

**Type:** Image-to-Video
**Model:** WAN 2.1 I2V 14B 480p
**Reference Image:** `..\mjuhight1.jpg`
**Target Duration:** ~5s

## WAN Settings

| Setting | Value |
|---------|-------|
| Resolution | 832 × 480 |
| Frames | 81 |
| FPS | 16 |
| Steps | 20 |
| CFG Scale | 5 |
| Motion Strength | 0.35 – 0.45 |

## Positive Prompt

```
cinematic drone flight above Maejo University agricultural campus,
gentle forward movement,
trees swaying naturally,
subtle fog,
mountains in background,
realistic aerial documentary footage,
photorealistic,
natural lighting
```

## Negative Prompt

```
text, watermark, cartoon, anime, warped architecture,
extra buildings, camera shake, low quality, blurry
```

## Notes

- Use the provided `mjuhight1.jpg` as the I2V input image.
- Motion Strength at 0.35 may produce smoother, more stable output. Start there and increase toward 0.45 if the clip lacks movement.
- The 832×480 resolution is a balanced crop for WAN 480p pipelines.
- If the result appears too static, try reducing CFG to 4 or increasing Motion Strength to 0.5.
