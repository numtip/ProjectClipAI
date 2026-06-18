# Prompt Library

> Curated prompt categories for AI Clips Factory LTX Video pipeline.
> Proven prompts from Phase 4A renders.
> Last updated: 2026-06-18

---

## Category Index

1. [Drone Aerial](#drone-aerial)
2. [Campus Flyover](#campus-flyover)
3. [Agriculture](#agriculture)
4. [Smart Agriculture](#smart-agriculture)
5. [Research Center](#research-center)
6. [Data Overlay](#data-overlay)
7. [Hero Ending](#hero-ending)
8. [Golden Hour](#golden-hour)
9. [Documentary Motion](#documentary-motion)

---

## Drone Aerial

**Camera:** Cinematic drone flight, gentle forward movement
**Proven Seed:** 101 (Phase 4A Shot01)

```
cinematic drone flight above agricultural campus,
gentle forward movement,
trees swaying naturally,
subtle fog,
mountains in background,
realistic aerial documentary footage,
photorealistic,
natural lighting
```

---

## Campus Flyover

**Camera:** Wide aerial, slow orbit
**Reference:** Drone Aerial variant

```
wide aerial flyover of university campus with
agricultural fields and research facilities,
slow orbiting movement,
green landscapes stretching to horizon,
soft cloud shadows drifting across fields,
documentary style,
natural color palette
```

---

## Agriculture

**Camera:** Descent, smooth downward movement
**Proven Seed:** 202 (Phase 4A Shot02)

```
smooth drone descent toward lush green rice terraces,
agricultural research plots,
rows of crops gently swaying,
morning sunlight breaking through mist,
documentary cinematography style,
natural colors,
gentle downward camera movement
```

---

## Smart Agriculture

**Camera:** Close-up, slight camera orbit
**Proven Seed:** 303 (Phase 4A Shot03)

```
close-up shot of smart agriculture monitoring station in rice field,
sensor equipment among green plants,
IoT antennas against blue sky,
educational documentary aesthetic,
clean crisp lighting,
slight camera orbit around the station
```

---

## Research Center

**Camera:** Establishing shot, slow push-in

```
exterior view of agricultural research center,
modern glass buildings surrounded by experimental plots,
scientists walking between greenhouses,
clean modern architecture,
educational documentary style,
soft afternoon lighting,
steady camera
```

---

## Data Overlay

**Camera:** Static or gentle drift

```
close-up of digital tablet displaying crop health data,
sensor readout screens in agricultural setting,
scientific monitoring equipment,
clean organized composition,
educational documentary aesthetic,
steady camera,
clear lighting
```

---

## Hero Ending

**Camera:** Slow cinematic crane rise, wide shot
**Proven Seed:** 404 (Phase 4A Shot04)

```
golden hour wide shot of agricultural campus,
warm sunset light over terraced fields,
mountains in background with soft haze,
peaceful countryside atmosphere,
slow cinematic crane rise,
photorealistic,
warm color grading
```

---

## Golden Hour

**Camera:** Wide or medium, gentle motion

```
warm golden hour landscape,
sunset light streaming through trees,
long shadows across green fields,
tranquil rural atmosphere,
cinematic photography style,
soft warm tones,
slow gentle camera movement
```

---

## Documentary Motion

**Camera:** Various, slow controlled moves

```
steady documentary tracking shot,
smooth gimbal movement,
natural environmental details,
professional cinematography,
clean composition,
realistic textures,
natural lighting
```

---

## Negative Prompt (Universal)

Use this negative prompt for all LTX shots:

```
blurry, low quality, distorted, ugly, deformed, fast motion,
jittery, flickering, bad anatomy, character, person, human,
face, warping, morphing, artifacts, noise
```

## Negative Prompt (Extended — Phase 5C Baseline)

More robust negative prompt for improved stability:

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

---

## Recommended Parameters

| Parameter | Value |
|-----------|-------|
| Model | LTX Video 2B v0.9.1 |
| Resolution | 768×512 |
| Frames | 121 |
| FPS | 24 |
| Steps | 30 |
| CFG | 4.0 |
| Sampler | Euler |
| Scheduler | Normal |

---

## Usage Guide

1. Select prompt category matching your shot description
2. Adapt tense/mood to match storyboard direction
3. Set unique seed per shot (sequential recommended: 101, 202, 303, 404)
4. Keep negative prompt identical across all shots
5. Document new proven prompts as new projects complete

---

---

## LTX-Specific Prompt Rules

1. **Front-load camera motion** — describe the camera move in the first 10 tokens
2. **Use physics-based motion language** — "swaying", "drifting", "rising" instead of "moving"
3. **Avoid proper nouns** — use descriptive words, not building or campus names
4. **Repeat the environment** — mention landscape type twice for stability
5. **Keep total length 50–80 tokens** — concise prompts yield more predictable results
6. **Avoid abstract adjectives** — "peaceful", "hopeful" contribute nothing to motion
7. **Avoid tech-brand terms** — "IoT", "sensor" → use "metal post", "equipment"
8. **Use time-of-day anchors** — "morning light", "golden hour", "midday sun"

---

## Phase 5C Optimized Variants

### Drone Aerial (Optimized)

**Seed:** 101 | **Phase 5C improved**

```
slow cinematic drone push forward over green agricultural fields,
camera at low altitude revealing trees and landscape,
tree canopy gently swaying in breeze,
distant mountain ridgeline visible through morning haze,
documentary aerial cinematography,
photorealistic,
natural daylight
```

### Agriculture Descent (Optimized)

**Seed:** 202 | **Phase 5C improved**

```
slow vertical descent of camera toward green terraced rice fields,
rows of crops becoming larger as camera descends,
morning light filtering through ground mist,
documentary drone cinematography,
natural muted green and gold tones,
photorealistic
```

### Smart Agriculture Station (Optimized)

**Seed:** 303 | **Phase 5C improved**

```
close-up camera orbit around a metal monitoring post in a green rice field,
scientific equipment surrounded by tall green plants,
clear blue sky visible between plants,
steady circular camera movement,
documentary style,
sharp clean lighting,
photorealistic
```

### Hero Ending (Optimized)

**Seed:** 404 | **Phase 5C improved**

```
slow cinematic upward camera rise revealing wide landscape at golden hour,
terraced green fields bathed in orange sunset light,
mountain silhouette against warm sky,
long shadows stretching across farmland,
documentary final scene,
photorealistic,
rich golden warm tones
```

---

## Future Categories (Unseeded)

- Time-lapse transition
- Night scene / moonlit
- Indoor laboratory
- Close-up flora
- Weather event (rain, fog, mist)
- Aerial river/waterway
