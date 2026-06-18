# Phase 3 — First Multi-shot Clip Plan

**Date:** 2026-06-18
**Author:** ProjectClipsAI Agent (Token-Savior mode)
**Reference Image:** `projects\mjuhight1.jpg`

---

## Files Created

| # | File | Purpose |
|---|------|---------|
| 1 | `README.md` | Project overview, folder structure, usage instructions |
| 2 | `prompts/shot01_i2v_mju_drone.md` | I2V prompt for drone aerial shot from mjuhight1.jpg |
| 3 | `prompts/shot02_descent.md` | Descent from aerial to field-level view |
| 4 | `prompts/shot03_smart_agri_data.md` | Smart agriculture monitoring station close-up |
| 5 | `prompts/shot04_hero_ending.md` | Golden-hour wide shot finale |
| 6 | `scripts/concat_shots.bat` | FFmpeg concat script (Shot01–04 → first_multishot_clip.mp4) |
| 7 | `reports/PHASE3_FIRST_MULTISHOT_PLAN.md` | This report |

## Project Structure

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
├── inputs/          ← place rendered clips here
├── outputs/         ← final assembled clip lands here
└── work/            ← scratch directory
```

## Exact WAN Settings (All Shots)

| Parameter | Shot 01 | Shot 02 | Shot 03 | Shot 04 |
|-----------|---------|---------|---------|---------|
| Model | WAN I2V 14B 480p | WAN 14B (T2V/I2V) | WAN 14B (T2V/I2V) | WAN 14B (T2V/I2V) |
| Resolution | 832×480 | 832×480 | 832×480 | 832×480 |
| Frames | 81 | 81 | 81 | 81 |
| FPS | 16 | 16 | 16 | 16 |
| Steps | 20 | 20 | 20 | 20 |
| CFG | 5 | 5 | 5 | 5 |
| Motion Strength | 0.35–0.45 | 0.30–0.40 | 0.25–0.35 | 0.35–0.45 |
| Input | mjuhight1.jpg | (keyframe or T2V) | (keyframe or T2V) | (keyframe or T2V) |

## Manual Steps for User (Wan2GP / Pinokio)

### Step 1 — Generate Shot 01 (I2V)
1. Open Wan2GP or Pinokio WAN I2V 14B 480p workflow.
2. Load `mjuhight1.jpg` as input image.
3. Set parameters as specified in `prompts/shot01_i2v_mju_drone.md`.
4. Run generation.
5. Save output as `inputs\Shot01.mp4`.

### Step 2 — Generate Shots 02–04
For each remaining shot:
1. (Optional) Generate a keyframe image in SDXL or use T2V mode directly.
2. Set parameters from the respective prompt file.
3. Run generation.
4. Save outputs as `inputs\Shot02.mp4`, `inputs\Shot03.mp4`, `inputs\Shot04.mp4`.

### Step 3 — Concatenate
1. Ensure all four `.mp4` files are present in `inputs\`.
2. Run `scripts\concat_shots.bat`.
3. The final clip appears at `outputs\first_multishot_clip.mp4`.

### If FFmpeg Is Not in PATH
Replace the `ffmpeg` call in `concat_shots.bat` with the full path to `ffmpeg.exe`, e.g.:
```
"C:\Program Files\ffmpeg\bin\ffmpeg.exe" -f concat -safe 0 -i "%FILELIST%" -c copy "%OUTPUT_DIR%\first_multishot_clip.mp4"
```

## Success Criteria

- [x] Project folder created at `projects/phase3-first-multishot/`
- [x] Prompt files ready for all 4 shots
- [x] FFmpeg concat script ready
- [x] No large files copied
- [x] No model downloads or installations
- [x] Token-savior workflow followed
- [ ] Shot 01 rendered from `mjuhight1.jpg` via WAN I2V
- [ ] Shots 02–04 rendered
- [ ] All 4 clips concatenated into `first_multishot_clip.mp4`
- [ ] Final clip plays correctly (~20s)

## Known Constraints

- **WAN performance:** WAN 2.1 I2V 14B 480p was retired in Phase 2C (~16+ min per 2s clip on RTX 3060 12GB). The 5s clips in this phase may take 40+ minutes each.
- **AI tool version:** All models/workflows reference the ComfyUI + Stability Matrix stack locked in Phase 2C.
- **Fallback:** If WAN render times are prohibitive, substitute LTX Video for Shots 02–04 (T2V-capable, much faster). Shot 01 (I2V) would need a different approach if WAN I2V is unavailable.

## Next: Phase 4 Recommendation

**Phase 4 — Production Clip Assembly & QA**

Recommended tasks:
1. **Render Shot 01** — Generate the I2V clip from `mjuhight1.jpg` in Wan2GP/Pinokio.
2. **Generate keyframes** for Shots 02–04 using SDXL (ComfyUI `first-render.json` workflow).
3. **Render Shots 02–04** via LTX Video I2V (faster fallback) or WAN I2V.
4. **Assemble** with `concat_shots.bat`.
5. **Run RENDER_QA** — review each shot for artifacts, continuity, and timing.
6. **Run EXPORT_QA** — verify final MP4 encoding, resolution, and playback.
7. **Update** `PROJECT_REGISTRY.md` with Phase 3 completion.
8. **Optionally retry** WAN after any ComfyUI/WAN pipeline optimizations.

## Skills Used

- Token Savior Workflow (`docs/skills/TOKEN_SAVIOR_WORKFLOW.md`)
- ProjectClipsAI governance rules (`.cursor/rules/projectclipsai.mdc`)
