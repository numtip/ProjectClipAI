# Toolchain Context

## Overview

All tools are documented — not installed. This file helps agents understand what tools exist in the ecosystem.

## Recommended Stack

| Tool | Purpose | Install Source |
|------|---------|----------------|
| Stability Matrix | Environment manager for ComfyUI and models | GitHub release |
| ComfyUI | Node-based workflow for image/video generation | Via Stability Matrix |
| FFmpeg | Video/audio processing, assembly, export | chocolatey or FFmpeg.org |
| Git | Version control | git-scm.com |
| Pinokio (optional) | Alternative tool manager | pinokio.computer |
| Subtitle Edit (optional) | Subtitle creation | GitHub release |
| CapCut (optional) | Quick cuts, overlays, text | ByteDance |

## Environment Checks

Run `scripts/check-env.ps1` to verify prerequisites:
- Windows version
- GPU (nvidia-smi)
- VRAM
- FFmpeg
- Git
- Python
- Node

Run `scripts/ffmpeg-check.ps1` for FFmpeg-specific checks.

## ComfyUI

- Managed through Stability Matrix
- Custom nodes tracked per workflow
- Workflow JSONs stored in `workflows/comfyui/`
- Required nodes documented in workflow registry

## Model Management

- Shared model library path (no duplicates)
- Models stored outside Git
- Never commit safetensors, ckpt, pt, pth, or onnx files
- See `docs/MODEL_LIBRARY_POLICY.md` for full policy

## FFmpeg

- Used for: concatenation, trimming, transitions, overlay, audio sync
- Scripts in `workflows/ffmpeg/`
- Expect ffmpeg.exe in PATH
