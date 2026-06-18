# First Render Workflow

**Date:** 2026-06-17
**Purpose:** First image generation test for ProjectClipsAI

## Overview

Minimal SDXL image generation workflow:

```
Checkpoint Loader → CLIP Text Encode (positive) → KSampler → VAE Decode → Save Image
                  → CLIP Text Encode (negative) ──┘
```

## Required Nodes

All nodes are ComfyUI built-in — no custom nodes required.

## Model

- **Model:** SDXL base 1.0
- **Path:** `F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors`

## Settings

- **Resolution:** 1024x1024 (SDXL default)
- **Sampler:** euler
- **Scheduler:** normal
- **Steps:** 20
- **CFG:** 7.0
- **Seed:** 42

## Test Result

Generated image saved to `projects/000-first-clip/assets/first-render-001.png`
