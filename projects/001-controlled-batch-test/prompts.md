# Per-Shot Prompts & Parameters

## Shared Parameters

| Parameter | Value |
|-----------|-------|
| Model | LTX Video 2B v0.9.1 |
| Text Encoder | T5XXL fp8 |
| Resolution | 768×512 |
| Frames | 121 |
| FPS | 24 |
| Steps | 30 |
| CFG | 4.0 |
| Sampler | Euler |
| Scheduler | Normal |
| Codec | H.264 |

## Extended Negative Prompt (Phase 5C)

```
blurry, low quality, distorted, ugly, deformed,
fast motion, jittery, flickering, strobing,
bad anatomy, character, person, human, face, hands,
warping, morphing, geometric distortion, dissolving,
artifacts, noise, grain, compression blocks,
text, watermark, logo, subtitle, caption,
overexposed, underexposed, flat lighting,
camera shake, handheld wobble, unstable horizon,
duplicate objects, extra limbs, double exposure
```

## Shot 01 — Drone Aerial Push

| Parameter | Value |
|-----------|-------|
| Seed | 101 |
| Prompt | slow cinematic drone push forward over green agricultural fields, camera at low altitude revealing trees and landscape, tree canopy gently swaying in breeze, distant mountain ridgeline visible through morning haze, documentary aerial cinematography, photorealistic, natural daylight |
| Negative | Extended negative (Phase 5C) |

## Shot 02 — Vertical Descent

| Parameter | Value |
|-----------|-------|
| Seed | 202 |
| Prompt | slow vertical descent of camera toward green terraced rice fields, rows of crops becoming larger as camera descends, morning light filtering through ground mist, documentary drone cinematography, natural muted green and gold tones, photorealistic |
| Negative | Extended negative (Phase 5C) |

## Shot 03 — Monitoring Station Orbit

| Parameter | Value |
|-----------|-------|
| Seed | 303 |
| Prompt | close-up camera orbit around a metal monitoring post in a green rice field, scientific equipment surrounded by tall green plants, clear blue sky visible between plants, steady circular camera movement, documentary style, sharp clean lighting, photorealistic |
| Negative | Extended negative (Phase 5C) |

## Shot 04 — Golden Hour Reveal

| Parameter | Value |
|-----------|-------|
| Seed | 404 |
| Prompt | slow cinematic upward camera rise revealing wide landscape at golden hour, terraced green fields bathed in orange sunset light, mountain silhouette against warm sky, long shadows stretching across farmland, documentary final scene, photorealistic, rich golden warm tones |
| Negative | Extended negative (Phase 5C) |
