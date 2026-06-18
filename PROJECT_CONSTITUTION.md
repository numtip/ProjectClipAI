# ProjectClipsAI Constitution

## Mission

Build a maintainable, local-first AI Video Factory for repeatable clip production using open-source tools and local GPU rendering.

## First Milestone

Produce one 10–15 second MP4 clip.

## Core Principles

1. **Image-to-video first** — Prioritize image-to-video pipelines over text-to-video until the workflow is stable.
2. **Document every render** — Every output, failure, and observation goes into `render-notes.md` for the project.
3. **Every project under `projects/`** — No orphan files. Each clip gets a numbered project folder.
4. **Broken experiments are valuable** — Failed renders are learning data. Document what broke and why.
5. **Models outside Git** — Checkpoints, LoRAs, and safetensors live outside the repository. Never commit them.
6. **Token efficiency** — Operations should minimize token consumption. Use context packs and registries before scanning the workspace.
7. **Reuse before create** — Check existing workflows, prompts, and assets before generating new ones.
8. **Registry is source of truth** — Consult registry files first. Keep them updated.

## Governance Rules

- Agents must read `context/*` and `registry/*` before scanning the workspace.
- Never download models, LoRAs, checkpoints, or node packs without explicit instruction.
- Start with one working ComfyUI workflow. No random node installs.
- Shared model library — no duplicate models anywhere on disk.

## Quality Standards

- 720p is acceptable for early clips
- 3 shots maximum per early project
- 5 seconds per shot as starting constraint
- MP4 as final delivery format
- Every project includes: brief, storyboard, prompts, render notes

## Skill-First Requirement

This workspace enforces a skill-first workflow. Every agent must use the project skills before making changes.

Rules:

- No major task may close without skill usage.
- Every task must start with TOKEN_SAVIOR_WORKFLOW.
- Video workflow changes require COMFYUI_WORKFLOW_REVIEW and VIDEO_WORKFLOW_REVIEW.
- Model tasks require MODEL_LIBRARY_AUDIT.
- Render tasks require RENDER_QA.
- Export tasks require EXPORT_QA.
- Final reports must list skills used.
