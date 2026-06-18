# Shot 03 — Smart Agriculture Data

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
| Motion Strength | 0.25 – 0.35 |

## Positive Prompt

```
close-up view of smart agriculture monitoring station in a rice field,
digital tablet displaying crop health data graphs,
sensor equipment among green plants,
IoT antennas against blue sky,
scientist or student checking soil readings,
educational documentary aesthetic,
clean crisp lighting,
slight camera orbit around the station
```

## Negative Prompt

```
text, watermark, cartoon, anime, warped architecture,
extra buildings, camera shake, low quality, blurry,
dark underexposed, heavy grain
```

## Notes

- This shot introduces the "smart agriculture" narrative element.
- Lower Motion Strength (0.25–0.35) works well here — the data-reading moment benefits from a steady gaze.
- For an I2V approach, generate an SDXL image of a monitoring station in a field first.
- If T2V produces odd sensor/hand artifacts, simplify the prompt or mask the subject region.
