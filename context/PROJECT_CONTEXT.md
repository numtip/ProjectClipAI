# Project Context

## Identity

- **Name:** ProjectClipsAI
- **Type:** Local-First AI Video Lab
- **Goal:** Produce AI-generated clips using open-source tools and local GPU

## Stack

- Stability Matrix (environment manager)
- ComfyUI (workflow engine)
- WAN / LTX (video models)
- FFmpeg (video assembly)
- Cloud AI for script/storyboard/prompt engineering only

## Pipeline

```
Topic → Script → Storyboard → Key Images → Image-to-Video → FFmpeg → Final Clip
```

## Key Constraints

- First milestone: one 10–15s MP4
- Image-to-video before text-to-video
- Every render documented in render-notes.md
- Models and assets outside Git
- 720p acceptable
- 3 shots max, 5s per shot

## Important Paths

| Path | Purpose |
|------|---------|
| `context/` | Agent context packs — read these first |
| `registry/` | Source-of-truth registries |
| `projects/*/` | Individual clip projects |
| `workflows/` | ComfyUI, prompt templates, FFmpeg |
| `scripts/` | Utility PowerShell scripts |
| `docs/skills/` | Operational skills for agents |

## Rules for Agents

1. Read context/* and registry/* before scanning workspace
2. Never download models, LoRAs, or checkpoints
3. Reuse existing workflows/prompts before creating new ones
4. Update registries when adding models/workflows/assets
5. Token efficiency is mandatory
