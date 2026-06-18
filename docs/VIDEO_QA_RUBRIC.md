# Video QA Rubric

> Standard evaluation rubric for AI Clips Factory outputs.
> Applies to: individual shots, master exports, and any future production clips.
> Last updated: 2026-06-18

---

## How to Use

1. Play each clip in a media player (VLC, Windows Media Player, browser)
2. Score each rubric category 1–5
3. Tally the score and assign a production status

---

## Scoring Scale

| Score | Label | Meaning |
|-------|-------|---------|
| 5 | Excellent | Broadcast-quality, no flaws |
| 4 | Good | Minor imperfections, not distracting |
| 3 | Acceptable | Noticeable flaws but usable for internal/demo use |
| 2 | Marginal | Flaws degrade usability; borderline acceptable |
| 1 | Poor | Significant flaws that make the clip unusable |

---

## Rubric Categories

### 1. Motion Smoothness

**What to look for:**
- Camera movement feels fluid and intentional
- No jitter, sudden jumps, or stutter
- Motion acceleration/deceleration is natural

| Score | Criteria |
|-------|---------|
| 5 | Perfectly smooth, cinematic movement |
| 4 | Mostly smooth with minor micro-jitter |
| 3 | Some jitter or inconsistency, but watchable |
| 2 | Visible stutter or erratic motion |
| 1 | Extreme jitter, shake, or teleporting |

---

### 2. Architecture Stability

**What to look for:**
- Buildings, trees, and structures stay coherent throughout
- No morphing or dissolving geometry
- Edges and shapes hold their form

| Score | Criteria |
|-------|---------|
| 5 | All elements stable and consistent |
| 4 | Minor edge shimmer, overall stable |
| 3 | Some geometry wobble but recognizable |
| 2 | Notable warping or morphing of structures |
| 1 | Severe morphing; environment unrecognizable |

---

### 3. Flicker Level

**What to look for:**
- No rapid brightness oscillation
- Consistent luminance throughout
- No strobing or unnatural light pulses

| Score | Criteria |
|-------|---------|
| 5 | Completely stable, zero flicker |
| 4 | Subtle variation, not distracting |
| 3 | Occasional flicker, noticeable on close watch |
| 2 | Regular flicker that draws attention |
| 1 | Severe strobing; unwatchable |

---

### 4. Prompt Adherence

**What to look for:**
- Clip content matches the intended prompt description
- Camera movement type matches (drone, descent, orbit, crane)
- Scene elements match prompt intent

| Score | Criteria |
|-------|---------|
| 5 | Clip precisely matches prompt description |
| 4 | Strong adherence with minor deviations |
| 3 | General theme present; some elements missing |
| 2 | Loose connection to prompt |
| 1 | Content unrelated to prompt |

---

### 5. Composition

**What to look for:**
- Framing follows rule of thirds or intentional composition
- Main subject is clearly positioned
- No accidental clipping or awkward empty space

| Score | Criteria |
|-------|---------|
| 5 | Excellent cinematic framing |
| 4 | Clean framing with minor imperfections |
| 3 | Acceptable framing, slightly awkward in places |
| 2 | Poor framing that distracts |
| 1 | Subject cut off or completely unframed |

---

### 6. Natural Lighting

**What to look for:**
- Light behavior is consistent with stated time of day
- No unnatural color shifts or impossible shadows
- Consistent light direction across frames

| Score | Criteria |
|-------|---------|
| 5 | Photorealistic, consistent natural lighting |
| 4 | Mostly natural with minor inconsistencies |
| 3 | Acceptable but with some unnatural moments |
| 2 | Noticeably artificial or inconsistent lighting |
| 1 | Extreme or impossible lighting artifacts |

---

### 7. Story Continuity

**What to look for:**
- When viewed as a sequence, clips feel like they belong together
- Visual language (color palette, motion style) is consistent
- Transitions between clips don't feel jarring

| Score | Criteria |
|-------|---------|
| 5 | Seamless narrative flow across all shots |
| 4 | Strong continuity with minor tonal shifts |
| 3 | Clips relate but feel somewhat disconnected |
| 2 | Significant tonal or visual discontinuity |
| 1 | Clips appear unrelated |

---

### 8. Transition Quality

**Applies to master export only. Rate N/A for individual shots.**

**What to look for:**
- Hard cuts feel deliberate, not abrupt
- Fade transitions are smooth and appropriately timed
- No black frames or sudden audio jumps at transitions

| Score | Criteria |
|-------|---------|
| 5 | Transitions invisible and perfectly timed |
| 4 | Smooth with minor timing imperfections |
| 3 | Noticeable but acceptable transitions |
| 2 | Transitions feel awkward or mistimed |
| 1 | Jarring transitions that break immersion |
| N/A | Not applicable (individual shot) |

---

### 9. Usability for Production

**Overall production readiness.**

| Score | Criteria |
|-------|---------|
| 5 | Ready for client or public delivery |
| 4 | Ready for internal review, minor polishing needed |
| 3 | Demo/draft quality; acceptable for early-stage review |
| 2 | Requires rerender or heavy post-processing |
| 1 | Reject; cannot represent the project |

---

## Production Status Levels

### Scoring → Status

| Total Score (out of 45) | Status |
|------------------------|--------|
| 40–45 | **PASS** |
| 30–39 | **USABLE** |
| 20–29 | **NEEDS RERENDER** |
| < 20 | **REJECT** |

### Status Definitions

| Status | Meaning | Action |
|--------|---------|--------|
| **PASS** | Production-ready | Proceed to delivery |
| **USABLE** | Acceptable for demo/internal | Minor prompt tweaks on next render |
| **NEEDS RERENDER** | Significant issues | Adjust prompt, seed, or CFG before next batch |
| **REJECT** | Unusable | Full re-render with revised parameters |

---

## QA Scorecard Template

```
Shot: ___________________
Date: ___________________
Reviewer: _______________

| Category | Score (1-5) | Notes |
|----------|-------------|-------|
| Motion Smoothness | | |
| Architecture Stability | | |
| Flicker Level | | |
| Prompt Adherence | | |
| Composition | | |
| Natural Lighting | | |
| Story Continuity | | |
| Transition Quality | N/A (shot) | |
| Usability | | |
| TOTAL | / 40 | |

Status: [ ] PASS  [ ] USABLE  [ ] NEEDS RERENDER  [ ] REJECT
Notes:
```
