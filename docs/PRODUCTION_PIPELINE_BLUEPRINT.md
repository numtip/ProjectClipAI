# Production Pipeline Blueprint

> Validated pipeline for AI Clips Factory
> Generated: 2026-06-18
> Status: PRODUCTION READY

---

## Pipeline Overview

```
IDEA
  │
  ▼
BRIEF ──────────────── project-template/brief.md
  │
  ▼
STORYBOARD ─────────── project-template/storyboard.md
  │
  ▼
PROMPT DESIGN ──────── library/PROMPT_LIBRARY.md
  │
  ▼
SDXL KEYFRAME ──────── workflows/comfyui/first-render/first-render.json
  │                    1024×1024, 1 image
  │
  ▼
LTX RENDER ─────────── workflows/comfyui/first-video/first-video-002.json
  │                    768×512, 121 frames, 30 steps, ~115s per clip
  │
  ▼
FFMPEG ASSEMBLY ────── Hard cuts (concat) + Fade transitions (xfade 0.4s)
  │
  ▼
EXPORT ─────────────── projects/<id>/exports/
  │                    master-hardcuts.mp4 | master-fades.mp4
  │
  ▼
QA ─────────────────── ffprobe validation
  │                    Duration, resolution, frames, codec, playback
  │
  ▼
ARCHIVE ────────────── projects/<id>/ (all assets preserved)
```

---

## Stage 1 — Idea & Brief

**Input:** Creative concept
**Output:** `brief.md`

- Define project ID, concept, audience, tone
- Document key message and visual references
- Choose shot count (standard: 4 shots)

---

## Stage 2 — Storyboard

**Input:** `brief.md`
**Output:** `storyboard.md`

- 4 shots minimum recommended
- Each shot: type (I2V), camera movement, description, duration (~5s)
- Reference example: Phase 4A (Drone Aerial, Descent, Smart Agriculture, Hero Ending)

---

## Stage 3 — Prompt Design

**Input:** `storyboard.md`
**Output:** Prompt entries per shot

- Use `library/PROMPT_LIBRARY.md` for proven categories
- Adapt prompt language to shot description
- Maintain consistent negative prompt across all shots:

```
blurry, low quality, distorted, ugly, deformed, fast motion, jittery,
flickering, bad anatomy, character, person, human, face, warping,
morphing, artifacts, noise
```

---

## Stage 4 — SDXL Keyframe

**Input:** Brief + storyboard direction
**Output:** Key image(s) for I2V pipeline

| Setting | Value |
|---------|-------|
| Workflow | `workflows/comfyui/first-render/first-render.json` |
| Model | `sd_xl_base_1.0.safetensors` |
| Resolution | 1024×1024 |
| Output naming | `<project>-key-<shot>.png` |
| Location | `ComfyUI/input/` |

**Procedure:**
1. Place key image in `ComfyUI/input/` as `first-render-001.png`
2. Adjust positive prompt in SDXL workflow for desired composition
3. Queue via ComfyUI API or Stability Matrix GUI
4. Copy output to `projects/<id>/assets/`

---

## Stage 5 — LTX Render

**Input:** Key image in `ComfyUI/input/`
**Output:** 4× MP4 clips in `ComfyUI/output/`

| Setting | Value |
|---------|-------|
| Workflow | `workflows/comfyui/first-video/first-video-002.json` |
| Model | `ltx-video-2b-v0.9.1.safetensors` |
| Encoder | `t5xxl_fp8_e4m3fn.safetensors` |
| Resolution | 768×512 |
| Frames | 121 |
| FPS | 24 |
| Steps | 30 |
| CFG | 4.0 |
| Sampler | Euler |
| Render time | ~105–120s per clip (RTX 3060 12GB) |

**Per-shot variation:**
- Change `seed` for different motion results
- Change positive `prompt` for different scene themes
- Keep negative prompt and all other parameters identical

**API Execution:**
```
POST http://127.0.0.1:8188/prompt
Body: { "prompt": <workflow JSON with modified prompt/seed> }
```

---

## Stage 6 — FFmpeg Assembly

**Input:** Shot01.mp4, Shot02.mp4, Shot03.mp4, Shot04.mp4
**Output:** 2 master exports

### Version A — Hard Cuts (concat demuxer)

```powershell
file 'Shot01.mp4'
file 'Shot02.mp4'
file 'Shot03.mp4'
file 'Shot04.mp4'

ffmpeg -y -f concat -safe 0 -i concat_list.txt -c copy -movflags +faststart master-hardcuts.mp4
```

- Stream copy, no re-encode
- Total duration: 4 × 5.04s = 20.17s
- Lossless quality

### Version B — Fade Transitions (xfade filter)

```powershell
ffmpeg -y -i Shot01.mp4 -i Shot02.mp4 -i Shot03.mp4 -i Shot04.mp4
  -filter_complex "[0][1]xfade=transition=fade:duration=0.4:offset=4.642[x1];
                    [x1][2]xfade=transition=fade:duration=0.4:offset=9.283[x2];
                    [x2][3]xfade=transition=fade:duration=0.4:offset=13.925"
  -c:v libx264 -crf 18 -preset fast -pix_fmt yuv420p -movflags +faststart master-fades.mp4
```

- Re-encode required for xfade
- Each transition: 0.4s crossfade
- Total duration: 4 × 5.04s − 3 × 0.4s = 18.97s

---

## Stage 7 — Export

**Output location:** `projects/<id>/exports/`

| File | Description |
|------|-------------|
| `master-hardcuts.mp4` | Hard cuts, lossless concat |
| `master-fades.mp4` | 0.4s fade transitions |

---

## Stage 8 — QA

Validate with ffprobe:

```powershell
ffprobe -v error -show_entries format=duration,size,bit_rate:
  stream=codec_name,width,height,r_frame_rate,nb_frames
  -of default=noprint_wrappers=1 <file>
```

**Checklist:**
- [ ] Codec: H.264
- [ ] Resolution: 768×512
- [ ] FPS: 24
- [ ] Duration: ~20.2s (hard cuts) / ~19.0s (fades)
- [ ] Frame count: ~484 (hard cuts) / ~456 (fades)
- [ ] Playback: No errors
- [ ] Visual: No glitches, corrupt frames, or freezing

---

## Stage 9 — Archive

- All source images stay in `projects/<id>/assets/`
- All render outputs stay in `projects/<id>/outputs/`
- Final exports in `projects/<id>/exports/`
- Reports in `projects/<id>/reports/`
- Project brief, storyboard, and prompts committed to Git (no large files)

---

## Performance Reference (RTX 3060 12GB)

| Metric | Value |
|--------|-------|
| Single clip render | ~115s |
| Per-shot (4-shot batch) | ~109s avg |
| 4-shot total render | ~7.3 min |
| FFmpeg assembly | < 3s |
| Total pipeline | ~8 min (4 shots) |
