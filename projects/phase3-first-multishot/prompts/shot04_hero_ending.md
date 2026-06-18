# Shot 04 — Hero Ending

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
| Motion Strength | 0.35 – 0.45 |

## Positive Prompt

```
golden hour wide shot of Maejo University agricultural campus,
warm sunset light over terraced fields and research greenhouses,
mountains in far background with soft purple haze,
peaceful countryside atmosphere,
sustainable farming landscape,
trees silhouetted against orange sky,
slow cinematic crane rise,
documentary final scene,
photorealistic,
warm color grading
```

## Negative Prompt

```
text, watermark, cartoon, anime, warped architecture,
extra buildings, camera shake, low quality, blurry,
cold blue tint, flat lighting
```

## Notes

- This is the emotional anchor of the clip. Golden-hour warmth signals "hopeful future."
- Motion Strength at 0.40 is ideal — enough for a gentle crane rise without breaking the serene mood.
- If the sunset sky looks unnatural, try reducing CFG to 4.5.
- For best quality, generate a golden-hour keyframe via SDXL first, then run I2V.
