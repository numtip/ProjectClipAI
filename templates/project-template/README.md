# AI Clips Factory — Project Template

> Copy this folder to create a new project.
> `copy project-template project-<id>`

## Project Structure

```
project-<id>/
├── brief.md          # Creative brief and goals
├── storyboard.md     # Shot-by-shot storyboard
├── prompts.md        # Per-shot LTX prompts and parameters
├── assets/           # Source images and reference files
│   └── key-image.png # I2V source image (SDXL-generated or provided)
├── outputs/          # Raw LTX render outputs
│   ├── Shot01.mp4
│   ├── Shot02.mp4
│   └── ...
├── exports/          # Final assembled exports
│   ├── master-hardcuts.mp4
│   └── master-fades.mp4
└── reports/          # Phase reports
    └── PROJECT_REPORT.md
```

## Pipeline

```
Idea → Brief → Storyboard → Prompts → SDXL Keyframe → LTX Renders → FFmpeg Assembly → Export
```

## Production Baseline

| Setting | Value |
|---------|-------|
| Image Model | SDXL Base 1.0 |
| Video Model | LTX Video 2B v0.9.1 |
| Text Encoder | T5XXL fp8 |
| Workflow | `workflows/comfyui/first-video/first-video-002.json` |
| Resolution | 768×512 |
| Frames | 121 |
| FPS | 24 |
| Steps | 30 |
| CFG | 4.0 |
| Sampler | Euler |
| Render Time | ~115s per clip (RTX 3060 12GB) |

## Reference

- Model library: `F:\AIModels\`
- Prompt library: `library/PROMPT_LIBRARY.md`
- Pipeline blueprint: `docs/PRODUCTION_PIPELINE_BLUEPRINT.md`
- New project workflow: `docs/NEW_PROJECT_WORKFLOW.md`
