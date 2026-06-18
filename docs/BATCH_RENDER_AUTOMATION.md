# Batch Render Automation

> Repeatable batch render system for the validated AI Clips Factory pipeline.
> Last updated: 2026-06-18

---

## Overview

The batch automation system provides three scripts that automate the validated 4-shot LTX workflow:

```
validate-batch-inputs.bat  →  Check project readiness
render-batch-ltx.bat       →  Render 4 shots via ComfyUI API
assemble-batch.bat         →  Concatenate shots into master exports
```

All scripts support `--dry-run` mode for validation without side effects.

---

## Scripts

### 1. validate-batch-inputs.bat

Checks that a project directory is ready for batch rendering.

```batch
validate-batch-inputs.bat <project-dir>
```

**Checks performed:**
- Project folder exists
- Source image exists (project `assets/` or global ComfyUI `input/`)
- Workflow JSON exists
- ComfyUI `main.py` exists
- FFmpeg is in PATH
- Project output/export folders exist
- Shot manifest exists (optional)
- Existing shot count (if re-rendering)

**Exit codes:**
- `0`: READY — all critical checks pass
- `1`: BLOCKED — fix failures before rendering

**Example:**
```batch
validate-batch-inputs.bat F:\ProjectClipsAI\projects\project-001
```

---

### 2. render-batch-ltx.bat

Renders up to 4 shots using the LTX Video 2B workflow via the ComfyUI API.

```batch
render-batch-ltx.bat <project-dir> [--dry-run]
```

**What it does:**
1. Validates ComfyUI API is reachable (or starts it)
2. Validates input image exists in `ComfyUI/input/first-render-001.png`
3. For each shot:
   - Loads workflow JSON
   - Injects shot-specific prompt and seed
   - Submits via POST to `http://127.0.0.1:8188/prompt`
   - Polls until completion (~120s per shot)
   - Copies output to project `outputs/ShotNN.mp4`
   - Logs render time and file size to `reports/render-log.md`

**Dry run:**
```batch
render-batch-ltx.bat F:\ProjectClipsAI\projects\project-001 --dry-run
```
Prints what would be rendered without submitting any jobs.

---

### 3. assemble-batch.bat

Assembles rendered shots into two master export versions.

```batch
assemble-batch.bat <project-dir> [--dry-run]
```

**What it does:**
1. Verifies all 4 shot files exist in `outputs/`
2. **Version A (Hard Cuts):** `concat` demuxer, stream copy (lossless)
3. **Version B (Fade Transitions):** `xfade` filter chain, 0.4s crossfades, CRF 18
4. Validates both exports with `ffprobe`

**Outputs:**
- `exports/master-hardcuts.mp4` — ~20.2s, 6.9 MB, lossless
- `exports/master-fades.mp4` — ~19.0s, 9.8 MB, polished

---

## Shot Manifest

The `shot-manifest.json` defines per-shot parameters. Place it in the project root.

**Location:** `projects/<project-id>/shot-manifest.json`

**Schema:**

```json
{
  "project_id": "001-example",
  "source_image": "assets/source.png",
  "workflow": "workflows/comfyui/first-video/first-video-002.json",
  "comfyui": {
    "url": "http://127.0.0.1:8188",
    "input_image": "first-render-001.png"
  },
  "output_dir": "outputs",
  "export_dir": "exports",
  "render_settings": {
    "resolution": "768x512",
    "fps": 24,
    "frames": 121,
    "steps": 30,
    "cfg": 4.0,
    "sampler": "euler"
  },
  "assembly": {
    "hard_cuts": { "enabled": true },
    "fade_transitions": { "enabled": true, "duration": 0.4 }
  },
  "shots": [
    {
      "id": "Shot01",
      "prompt_category": "Drone Aerial",
      "prompt": "...",
      "negative_prompt": "...",
      "seed": 101,
      "duration_seconds": 5,
      "resolution": "768x512",
      "fps": 24,
      "frames": 121
    }
  ]
}
```

See `templates/project-template/shot-manifest.json` for a complete example with 4 shots from Phase 4A.

---

## Required Project Structure

```
projects/<project-id>/
├── shot-manifest.json       # Shot definitions (optional; provides defaults)
├── assets/
│   └── source.png           # Source image for I2V (copy to ComfyUI/input/)
├── outputs/                 # Generated: shot MP4s
├── exports/                 # Generated: master MP4s
├── reports/
│   └── render-log.md        # Generated: per-shot render log
└── brief.md / storyboard.md / prompts.md  # Project docs
```

The global ComfyUI input image must be at:
```
C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\input\first-render-001.png
```

---

## Full Pipeline Command

```batch
:: 1. Validate
validate-batch-inputs.bat F:\ProjectClipsAI\projects\project-001

:: 2. Render (DRY RUN first)
render-batch-ltx.bat F:\ProjectClipsAI\projects\project-001 --dry-run
render-batch-ltx.bat F:\ProjectClipsAI\projects\project-001

:: 3. Assemble
assemble-batch.bat F:\ProjectClipsAI\projects\project-001 --dry-run
assemble-batch.bat F:\ProjectClipsAI\projects\project-001
```

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Project folders | `project-<NNN>` | `project-001` |
| Shot files | `Shot<NN>.mp4` | `Shot01.mp4` |
| Hard cuts export | `master-hardcuts.mp4` | (fixed) |
| Fades export | `master-fades.mp4` | (fixed) |
| Render log | `reports/render-log.md` | (fixed) |
| Shot manifest | `shot-manifest.json` | (fixed) |
| ComfyUI prefix | `<shot-id>_` | `Shot01_00001_.mp4` |

---

## Recovery: If ComfyUI Exits Mid-Batch

1. Check render-log.md to see which shots completed
2. Restart ComfyUI:
   ```batch
   cmd /c "cd /d C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI && C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe main.py --listen 127.0.0.1 --port 8188"
   ```
3. Re-run render-batch-ltx.bat — already-completed shots must be skipped manually (shots in `outputs/` are detected)

---

## RTX 3060 Timing Reference

| Stage | Duration |
|-------|----------|
| ComfyUI startup | ~15s |
| Single shot render (121 frames) | ~105-120s |
| 4-shot batch render | ~7.3 min |
| FFmpeg hard cuts assembly | < 1s |
| FFmpeg fades assembly | ~3s |
| **Total pipeline** | **~8 min** |

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| ComfyUI "Connection refused" | Server not running | Launch ComfyUI first |
| "Port 8188 in use" | Previous instance hung | `netstat -ano \| findstr :8188`, kill PID |
| Workflow not found | Bad path in manifest | Verify workflow path in shot-manifest.json |
| Shot file size is 0 B | Render failed silently | Check ComfyUI for model errors |
| xfade "Invalid argument" | Option ordering in FFmpeg 8 | Use `transition=fade:duration=X:offset=Y` |
| Missing input image | Image not in ComfyUI/input/ | Copy source image to `first-render-001.png` |
