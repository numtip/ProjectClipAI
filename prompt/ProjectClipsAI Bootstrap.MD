# ProjectClipsAI Bootstrap

Workspace:
F:\ProjectClipsAI

Role:
You are the implementation worker. GPT is the architecture advisor. User is building a Local-First AI Video Lab focused on AI Clips production using Open Source tools and local GPU rendering.

Goal:
Create a maintainable AI Video Factory foundation that supports repeatable clip production, model management, workflow tracking, token-efficient agent operations, and future automation.

## Mandatory Governance

Follow these principles:

1. Reuse before create
2. Search before generate
3. Diff before rewrite
4. Audit before build
5. Minimal output first
6. Append instead of rewrite
7. Avoid duplicate files
8. Avoid unnecessary documentation
9. Token efficiency is mandatory
10. Registry and Context Packs are Source of Truth

Never perform broad workspace scans unless required.

Always read:

1. context/*
2. registry/*
3. relevant project folder

before scanning additional files.

## Safety Rules

Do NOT:

* Download models
* Download LoRA
* Download checkpoints
* Download node packs
* Initialize Git
* Install software
* Modify other projects

unless explicitly requested.

This task creates foundation only.

## Create Structure

F:\ProjectClipsAI

├── README.md
├── PROJECT_CONSTITUTION.md
├── .gitignore

├── context
│   ├── PROJECT_CONTEXT.md
│   ├── TOOLCHAIN_CONTEXT.md
│   └── WORKFLOW_CONTEXT.md

├── registry
│   ├── MODEL_REGISTRY.md
│   ├── WORKFLOW_REGISTRY.md
│   ├── ASSET_REGISTRY.md
│   └── PROJECT_REGISTRY.md

├── docs
│   ├── AI_VIDEO_LAB_BLUEPRINT.md
│   ├── LOCAL_TOOLCHAIN.md
│   ├── MODEL_LIBRARY_POLICY.md
│   ├── COMFYUI_WORKFLOW_POLICY.md
│   ├── CLIP_PRODUCTION_PIPELINE.md
│   ├── PROMPTING_GUIDE.md
│   ├── FIRST_CLIP_SPRINT.md
│   ├── TROUBLESHOOTING.md
│   └── skills
│       ├── TOKEN_SAVIOR_WORKFLOW.md
│       ├── VIDEO_WORKFLOW_REVIEW.md
│       ├── COMFYUI_WORKFLOW_REVIEW.md
│       ├── MODEL_LIBRARY_AUDIT.md
│       ├── RENDER_QA.md
│       └── EXPORT_QA.md

├── workflows
│   ├── comfyui
│   │   └── README.md
│   ├── prompts
│   │   ├── storyboard-template.md
│   │   ├── image-prompt-template.md
│   │   └── video-motion-prompt-template.md
│   └── ffmpeg
│       └── README.md

├── projects
│   └── 000-first-clip
│       ├── brief.md
│       ├── storyboard.md
│       ├── prompts.md
│       ├── render-notes.md
│       ├── assets
│       ├── outputs
│       └── exports\

├── assets
│   ├── references
│   ├── images
│   ├── audio
│   └── fonts\

├── models
│   └── README.md

├── exports\

├── scripts
│   ├── check-env.ps1
│   ├── ffmpeg-check.ps1
│   └── make-project.ps1

└── .cursor
└── rules
└── projectclipsai.mdc

## Required Content

README.md

Explain:

Topic
→ Script
→ Storyboard
→ Key Images
→ Image-to-Video
→ FFmpeg
→ Final Clip

Preferred stack:

* Stability Matrix
* ComfyUI
* WAN
* LTX
* FFmpeg

Cloud AI may be used for:

* Script writing
* Storyboards
* Prompt engineering

Local GPU is used for rendering.

## Constitution

Include:

* First milestone = one 10–15 second MP4
* Image-to-video before text-to-video
* Broken experiments are valuable
* Every render must be documented
* Every project lives under projects/

## Context Packs

Keep each file concise.

Maximum:
200 lines

Purpose:
Allow future agents to avoid scanning the whole workspace.

## Registry

Registry files act as Source of Truth.

Agents should consult registry first.

## Skills

Create concise reusable operational skills.

Keep skills practical.

Avoid theory.

## Toolchain Document

Document only.

Do not install.

Recommended stack:

* Stability Matrix
* ComfyUI
* FFmpeg
* Git
* Optional Pinokio
* Optional Subtitle Edit
* Optional CapCut

## Model Policy

* Shared model library
* No duplicate models
* Models outside Git
* Never commit checkpoints

## Workflow Policy

* Start with one working workflow
* Store workflow JSONs
* Track required nodes
* No random node installs

## Prompt Guide

Standard prompt structure:

* Scene
* Subject
* Style
* Camera
* Lighting
* Motion
* Negative Prompt
* Duration
* Aspect Ratio

## First Clip Sprint

Goal:

Produce first local AI video.

Constraints:

* 3 shots maximum
* 5 seconds per shot
* 720p acceptable
* MP4 final output

## Troubleshooting

Cover:

* CUDA issues
* VRAM errors
* Missing models
* Missing FFmpeg
* Slow rendering
* Flickering
* Character inconsistency

## Scripts

check-env.ps1

Check:

* Windows version
* GPU via nvidia-smi
* VRAM
* FFmpeg
* Git
* Python
* Node

Must not fail hard.

ffmpeg-check.ps1

Check FFmpeg availability.

make-project.ps1

Create numbered project folders with standard structure.

## Cursor Rules

Create projectclipsai.mdc

Rules:

* Local AI Video Lab
* Token efficient
* No large downloads
* No duplicate assets
* Update render-notes.md
* Use registry first
* Use context packs first
* Keep outputs outside Git
* Ask GPT advisor for architecture changes

## Git Ignore

Include:

models/*
exports/*
projects/*/outputs/*
projects/*/exports/*
*.mp4
*.mov
*.webm
*.safetensors
*.ckpt
*.pt
*.pth
*.onnx
**pycache**
.venv
node_modules

## Validation

After creation:

1. Verify folder structure
2. Run scripts/check-env.ps1
3. Verify registry files
4. Verify context packs
5. Perform Runtime QA

Build success alone is insufficient.

## Final Report

Return only:

* Files created
* Scripts created
* Validation result
* Next recommended action
* Anything intentionally not done