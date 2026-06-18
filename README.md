# ProjectClipsAI

A Local-First AI Video Lab for producing AI-generated clips using open-source tools and local GPU rendering.

## Pipeline

```
Topic → Script → Storyboard → Key Images → Image-to-Video → FFmpeg → Final Clip
```

## Preferred Stack

| Tool | Role |
|------|------|
| Stability Matrix | Environment manager for AI tools |
| ComfyUI | Node-based workflow for image/video generation |
| WAN | Video generation model |
| LTX | Video generation model |
| FFmpeg | Video assembly and export |

Cloud AI may be used for script writing, storyboards, and prompt engineering. All rendering runs on local GPU.

## Repository Structure

```
├── context/      - Agent context packs for workspace awareness
├── registry/     - Source-of-truth registries (models, workflows, assets, projects)
├── docs/         - Documentation, policies, and operational skills
├── workflows/    - ComfyUI workflows, prompt templates, FFmpeg scripts
├── projects/     - Individual clip projects (numbered)
├── assets/       - Shared reference assets (images, audio, fonts)
├── models/       - Model library references (models stored outside Git)
├── exports/      - Final rendered exports
├── scripts/      - Utility scripts (environment checks, project scaffolding)
└── .cursor/      - Cursor IDE rules and configurations
```

## Getting Started

1. Ensure your local GPU environment is ready (see [LOCAL_TOOLCHAIN.md](docs/LOCAL_TOOLCHAIN.md))
2. Run `scripts/check-env.ps1` to verify prerequisites
3. Review [FIRST_CLIP_SPRINT.md](docs/FIRST_CLIP_SPRINT.md) for the initial milestone
4. Create a new project: `scripts/make-project.ps1`

## Principles

- Image-to-video before text-to-video
- Every render must be documented
- Every project lives under `projects/`
- Broken experiments are valuable
- Models and large assets stay outside Git
