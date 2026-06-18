# Video Workflow Review

**Purpose:** Evaluate a video generation workflow before running it.

## Checklist

- [ ] Input images/keyframes exist in project assets
- [ ] Model is loaded and available (check MODEL_REGISTRY)
- [ ] VRAM is sufficient for the selected resolution and frame count
- [ ] Output path points to project outputs folder
- [ ] Frame count matches shot duration × fps

## Parameter Review

- Resolution: 720p minimum, 1080p if VRAM allows
- Frame count: 24-30fps × shot duration
- Denoising strength: 0.7-0.9 typical range
- Seed: recorded for reproducibility

## After Render

- [ ] Output plays without corruption
- [ ] Duration matches expected length
- [ ] No visible artifacts or flickering
- [ ] render-notes.md updated
