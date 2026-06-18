# First Clip Sprint

## Goal

Produce the first local AI video — a 10–15 second MP4 clip.

## Constraints

| Constraint | Value |
|------------|-------|
| Max shots | 3 |
| Max per shot | 5 seconds |
| Total duration | 10–15 seconds |
| Resolution | 720p acceptable |
| Format | MP4 |

## Sprint Plan

### Step 1: Setup & Validation
- Run `scripts/check-env.ps1` to verify toolchain
- Confirm ComfyUI is accessible via Stability Matrix
- Confirm FFmpeg is available

### Step 2: Choose Your Topic
Pick something simple:
- A character in a scenic environment
- A product showcase
- A short atmospheric scene

### Step 3: Script & Storyboard
- Write a 3-shot script
- 5 seconds per shot
- Each shot transitions naturally to the next

### Step 4: Generate Key Images
- Create image prompts from storyboard
- Generate with ComfyUI
- Iterate until each shot has a satisfying key frame

### Step 5: Generate Video Clips
- Use image-to-video workflow (WAN or LTX)
- Generate each shot individually
- Document parameters in render-notes.md

### Step 6: Assemble with FFmpeg
- Concatenate clips
- Add minimal transitions if needed
- Export as MP4

### Step 7: Archive
- Document everything in render-notes.md
- Update registry/PROJECT_REGISTRY.md
- Celebrate the first clip 🎉

## Success Criteria

- [ ] MP4 file plays correctly
- [ ] Total duration 10–15 seconds
- [ ] Smooth transitions between shots
- [ ] Acceptable visual quality (720p+)
- [ ] Render-notes.md documents the process
- [ ] Project registry updated
