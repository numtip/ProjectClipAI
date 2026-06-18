# Prompt Optimization Guide

> Analysis of Phase 4A prompts with optimization patterns for future LTX renders.
> Based on: LTX Video 2B v0.9.1 at 768×512, 121 frames, CFG 4.0, 30 steps.
> Last updated: 2026-06-18

---

## Background

Phase 4A generated 4 shots using the same source image (`mjuhight1.jpg`, 1706×960) with different prompts and seeds. All shots passed technical QA. Visual QA requires playback review, but based on LTX model behaviour patterns, this guide identifies known prompt failure modes and proven optimization strategies.

---

## LTX-Specific Prompt Rules

LTX Video 2B differs from standard Stable Diffusion in important ways:

| Rule | Reason |
|------|--------|
| Keep prompts concise (50–80 tokens optimal) | LTX's T5XXL encoder handles long context but rewards focused prompts |
| Front-load camera motion | LTX reads early tokens first; motion description early = better adherence |
| Avoid proper nouns for specific buildings | Model has no campus-specific training |
| Use physics-based motion language | "swaying", "drifting", "rising" > "moving" |
| Avoid abstract or emotional descriptors | "peaceful", "hopeful" contribute little to motion |
| Avoid character/human references | LTX tends to hallucinate humans if prompted near faces |
| Repeat the core subject | Mentioning the landscape twice reinforces content stability |

---

## Phase 4A Prompt Analysis

### Shot 01 — Drone Aerial (Seed 101)

**Original:**
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

**Assessment:** Well-structured. Camera motion specified early. Good balance.

**Optimization:**
```
slow cinematic drone push forward over green agricultural fields,
camera at low altitude revealing trees and landscape,
tree canopy gently swaying in breeze,
distant mountain ridgeline visible through morning haze,
documentary aerial cinematography,
photorealistic,
natural daylight
```

**Changes:** Removed "campus" (no training), added "low altitude", specified "tree canopy", replaced "subtle fog" with "morning haze" (more physically specific).

---

### Shot 02 — Descent (Seed 202)

**Original:**
```
smooth drone descent toward lush green rice terraces,
agricultural research plots,
rows of crops gently swaying,
morning sunlight breaking through mist,
documentary cinematography style,
natural colors,
gentle downward camera movement
```

**Assessment:** Good direction. Downward motion specified at both start and end (good reinforcement). "Mist" is appropriate.

**Optimization:**
```
slow vertical descent of camera toward green terraced rice fields,
rows of crops becoming larger as camera descends,
morning light filtering through ground mist,
documentary drone cinematography,
natural muted green and gold tones,
photorealistic
```

**Changes:** "Vertical descent" more specific than "descent", "becoming larger" reinforces motion directionality, removed redundant "agricultural research plots".

---

### Shot 03 — Smart Agriculture (Seed 303)

**Original:**
```
close-up shot of smart agriculture monitoring station in rice field,
sensor equipment among green plants,
IoT antennas against blue sky,
educational documentary aesthetic,
clean crisp lighting,
slight camera orbit around the station
```

**Assessment:** Risk of hallucinated tech artifacts. "IoT antennas" is abstract to the model.

**Optimization:**
```
close-up camera orbit around a metal monitoring post in a green rice field,
scientific equipment surrounded by tall green plants,
clear blue sky visible between plants,
steady circular camera movement,
documentary style,
sharp clean lighting,
photorealistic
```

**Changes:** "Metal monitoring post" is more visually concrete, removed "IoT antennas", "circular camera movement" is more precise than "slight orbit", removed brand-specific tech language.

---

### Shot 04 — Hero Ending (Seed 404)

**Original:**
```
golden hour wide shot of agricultural campus,
warm sunset light over terraced fields,
mountains in background with soft haze,
peaceful countryside atmosphere,
slow cinematic crane rise,
photorealistic,
warm color grading
```

**Assessment:** Strong composition. "Crane rise" is understood by LTX. "Warm color grading" is redundant with "golden hour". "Peaceful countryside" is abstract.

**Optimization:**
```
slow cinematic upward camera rise revealing wide landscape at golden hour,
terraced green fields bathed in orange sunset light,
mountain silhouette against warm sky,
long shadows stretching across farmland,
documentary final scene,
photorealistic,
rich golden warm tones
```

**Changes:** Front-loaded camera motion ("upward camera rise"), replaced "peaceful countryside" with concrete visual detail ("long shadows"), "mountain silhouette" is more rendered-consistently than "mountains in background".

---

## Common LTX Failure Modes and Fixes

| Issue | Symptom | Fix |
|-------|---------|-----|
| Architecture morphing | Buildings/trees change shape | Add "stable architecture", "consistent geometry" |
| Flicker | Rapid brightness oscillation | Reduce CFG (try 3.5), reduce steps slightly |
| Over-motion | Too much camera shake | Add "steady camera", reduce seed range, try fewer steps |
| Under-motion | Clip looks like a still image | Increase CFG to 4.5, add explicit motion verbs |
| Horizon tilt | Camera tilts unexpectedly | Add "level horizon", "horizontal camera" |
| Human hallucination | Unwanted figures appear | Strengthen negative: "human figure, person, silhouette, shadow of person" |
| Tech artifact hallucination | Random digital overlays | Remove tech-specific words; use physical descriptions |
| Color inconsistency | Unnatural color shifts mid-clip | Specify lighting time of day twice ("morning light... daylight") |
| Generic landscape | Output ignores key prompt elements | Move key element to first 5 tokens |

---

## Improved Negative Prompt Baseline

The Phase 4A universal negative was effective but can be extended:

**Phase 4A (baseline):**
```
blurry, low quality, distorted, ugly, deformed, fast motion,
jittery, flickering, bad anatomy, character, person, human,
face, warping, morphing, artifacts, noise
```

**Phase 5C (extended):**
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

**Additions:** `strobing`, `hands`, `geometric distortion`, `dissolving`, `compression blocks`, `text/watermark/logo`, `overexposed/underexposed/flat lighting`, `camera shake/handheld wobble/unstable horizon`, `duplicate objects/extra limbs/double exposure`.

---

## Parameter Optimization Reference

| Parameter | Phase 4A | Optimization Range | Notes |
|-----------|----------|-------------------|-------|
| CFG | 4.0 | 3.5–5.0 | Lower = less flicker; higher = more prompt adherence |
| Steps | 30 | 25–40 | 30 is balanced; 25 for speed, 40 for quality |
| Seed | Sequential (101, 202) | Varied | Keep seeds > 100 apart for distinct results |
| Resolution | 768×512 | Fixed | Do not change; validated on RTX 3060 |
| Frames | 121 | 97–121 | 97 for faster render (~86s), 121 for full 5s |
| Sampler | Euler | Euler (keep) | Euler is stable for LTX |
| Scheduler | Normal | Normal (keep) | Do not change scheduler for LTX |

---

## Seed Strategy

| Goal | Strategy |
|------|---------|
| Reproduce same motion | Use identical seed |
| Slight variation | Seed ±1–5 |
| Different motion style | Seed ±100+ |
| Fresh render | Random (use Date+Shot: `20260618_01` → 202606180) |

---

## Shot Continuity Tips

For 4-shot sequences that flow as one clip:

1. **Maintain color temperature across shots** — all prompts should share lighting state (all "morning", all "golden hour")
2. **Use consistent scene scale** — don't jump from aerial to extreme close-up without a transition shot
3. **Repeat environment anchor words** — mention "rice fields" or "agricultural landscape" in every prompt to ground the model
4. **Use opposite seeds for visual variety** — if Shot01=101, Shot03=3030 (avoids accidental similarity)
