# Workflow Context

## Pipeline Stages

### 1. Topic → Script
- Cloud AI used for script generation
- Output stored in project's `brief.md`

### 2. Script → Storyboard
- Breakdown into shots
- Each shot described: scene, subject, style, camera, lighting
- Stored in project's `storyboard.md`

### 3. Storyboard → Key Images
- Generate reference images using ComfyUI
- Prompt templates in `workflows/prompts/`
- Images stored in project's `assets/`

### 4. Image-to-Video
- Feed key images into video generation (WAN/LTX)
- ComfyUI workflows in `workflows/comfyui/`
- Raw outputs in project's `outputs/`

### 5. FFmpeg Assembly
- Concatenate shots, add transitions, sync audio
- Scripts in `workflows/ffmpeg/`
- Final assembly in project's `exports/`

## Prompt Structures

Standard prompt fields: Scene, Subject, Style, Camera, Lighting, Motion, Negative Prompt, Duration, Aspect Ratio.

## ComfyUI Workflow Policy

- Start with one working workflow
- Store workflow JSONs in `workflows/comfyui/`
- Track required custom nodes
- No random node installs

## Rendering Policy

- Every render must be documented in `render-notes.md`
- Include: parameters, model used, output path, observations, issues
- 720p acceptable for early clips
- 3 shots maximum, 5 seconds per shot

## Skill-First Requirement

Skill-first workflow is mandatory. Agents must read `docs/skills/README.md` and task-specific skills before making changes.
