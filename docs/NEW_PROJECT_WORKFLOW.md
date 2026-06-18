# New Project Workflow

> How to create a new project from scratch using the project template.
> Applies to project 001, 002, 003, and beyond.

---

## Overview

Each new project follows a standard 9-stage pipeline:

```
Copy Template → Fill Brief → Storyboard → Design Prompts
→ Generate Key Image → Render Shots → Assemble → QA → Archive
```

---

## Step-by-Step

### Step 1: Create Project Folder

```powershell
# Copy template
Copy-Item -Recurse "F:\ProjectClipsAI\templates\project-template"
  "F:\ProjectClipsAI\projects\project-<id>"

# Verify
Get-ChildItem "F:\ProjectClipsAI\projects\project-<id>"
```

### Step 2: Fill Brief

Edit `projects/project-<id>/brief.md`:

- Set project ID
- Write 1-2 sentence concept
- Define target audience and key message
- Note tone/mood (documentary, cinematic, etc.)

### Step 3: Fill Storyboard

Edit `projects/project-<id>/storyboard.md`:

- 4 shots minimum
- Each shot: camera movement, description, duration
- Reference: `library/PROMPT_LIBRARY.md` categories

### Step 4: Design Prompts

Edit `projects/project-<id>/prompts.md`:

- Select prompt categories from `library/PROMPT_LIBRARY.md`
- Adapt to shot descriptions
- Assign unique seeds (101, 202, 303, 404 pattern)
- Keep negative prompt universal

### Step 5: Generate Key Image

**Option A — Use existing image:**
Place image in `ComfyUI/input/` as `first-render-001.png`

**Option B — Generate via SDXL:**
Use workflow `workflows/comfyui/first-render/first-render.json`

1. Update positive prompt for desired composition
2. Queue via ComfyUI API or Stability Matrix GUI
3. Copy output to `projects/project-<id>/assets/key-image.png`

### Step 6: Render Shots

Launch ComfyUI:
```powershell
cmd /c "cd /d C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI
  && C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe
  main.py --listen 127.0.0.1 --port 8188"
```

Queue each shot via API (modify prompt and seed in workflow JSON):
```powershell
$wf = Get-Content "workflows/comfyui/first-video/first-video-002.json" -Raw | ConvertFrom-Json
$wf."4".inputs.text = "<shot prompt>"
$wf."7".inputs.seed = <shot seed>
$wf."10".inputs.filename_prefix = "shot<NN>"
$body = @{prompt = $wf} | ConvertTo-Json -Depth 10
Invoke-RestMethod -Uri "http://127.0.0.1:8188/prompt" -Method POST -Body $body -ContentType "application/json"
```

Copy outputs:
```powershell
Copy-Item "ComfyUI/output/shot<NN>_00001_.mp4"
  "projects/project-<id>/outputs/Shot<NN>.mp4"
```

### Step 7: Assemble

Create both export versions:

**Hard cuts:**
```powershell
ffmpeg -y -f concat -safe 0 -i concat_list.txt -c copy -movflags +faststart
  "projects/project-<id>/exports/master-hardcuts.mp4"
```

**Fade transitions:**
```powershell
ffmpeg -y -i Shot01.mp4 -i Shot02.mp4 -i Shot03.mp4 -i Shot04.mp4
  -filter_complex "[0][1]xfade=transition=fade:duration=0.4:offset=4.642[x1];
  [x1][2]xfade=transition=fade:duration=0.4:offset=9.283[x2];
  [x2][3]xfade=transition=fade:duration=0.4:offset=13.925"
  -c:v libx264 -crf 18 -preset fast -pix_fmt yuv420p -movflags +faststart
  "projects/project-<id>/exports/master-fades.mp4"
```

### Step 8: QA

Validate with ffprobe:
```powershell
ffprobe -v error -show_entries format=duration,size:
  stream=codec_name,width,height,r_frame_rate,nb_frames
  -of default=noprint_wrappers=1 <file>
```

**Checklist:**
- [ ] All shots: H.264, 768×512, 24fps
- [ ] All shots: ~5.04s, ~121 frames
- [ ] Hard cuts: ~20.2s, ~484 frames
- [ ] Fades: ~19.0s, ~456 frames
- [ ] Playback: No errors
- [ ] Visual: No glitches

### Step 9: Archive

- Keep all outputs in `projects/project-<id>/`
- Commit brief, storyboard, prompts to Git
- Large files (MP4, PNG) stay outside Git (per DECISION-011)

---

## Project ID Convention

| Project | ID | Description |
|---------|----|-------------|
| 001 | `project-001` | First render (Phase 3C) |
| 002 | `project-002` | Next project |
| 003 | `project-003` | Future project |

---

## Quick Reference

| Action | Command/Path |
|--------|-------------|
| Template | `templates\project-template\` |
| Key image location | `ComfyUI\input\first-render-001.png` |
| Render workflow | `workflows\comfyui\first-video\first-video-002.json` |
| ComfyUI root | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\` |
| Python | `C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe` |
| Prompt library | `library\PROMPT_LIBRARY.md` |
| Metrics | `docs\PRODUCTION_METRICS.md` |
