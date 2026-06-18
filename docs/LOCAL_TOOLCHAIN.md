# Local Toolchain Guide

> Reference document only. Do not install software through this guide without explicit instruction.

## Prerequisites

| Tool | Required | Minimum Version |
|------|----------|-----------------|
| Windows 10/11 | Yes | 22H2 |
| NVIDIA GPU | Yes | 8GB+ VRAM |
| CUDA | Yes | 12.x |
| FFmpeg | Yes | Latest |
| Git | Yes | Latest |
| Python | Yes | 3.10+ |
| Node.js | Optional | 18+ |

## Recommended Setup Order

1. **NVIDIA Drivers + CUDA** — Install latest Game Ready or Studio Driver
2. **Stability Matrix** — Download from GitHub, install, configure model paths
3. **ComfyUI** — Install via Stability Matrix
4. **FFmpeg** — Install via chocolatey or download from ffmpeg.org
5. **Git** — Install from git-scm.com
6. **Models** — Download to shared library path (outside repository)

## Verification

Run `scripts/check-env.ps1` from the repository root to verify all prerequisites.

## Path Configuration

- **Model Library**: Configure Stability Matrix to store models in a shared location outside this repository
- **FFmpeg**: Ensure ffmpeg.exe is in system PATH or available in ComfyUI
- **Git**: Ensure git is in PATH

## Notes

- Pinokio is an alternative to Stability Matrix for managing AI tools
- Subtitle Edit and CapCut are optional post-processing tools
- This toolchain is documented but no software is installed through this project
