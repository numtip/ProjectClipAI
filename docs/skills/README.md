# Skill Index

> ProjectClipsAI is a **skill-first** workspace. Every agent must read and apply the relevant skills before making changes.

## Skill-First Rule

No major task may close without skill usage. The appropriate skill chain must be read and followed for the task type.

## Skill Chains by Task Type

### A. Any Task (always first)

1. **TOKEN_SAVIOR_WORKFLOW** — Always read this skill first. Minimizes token consumption via context-pack-first reads, targeted file access, and append-over-rewrite patterns.

### B. New Video Workflow

1. TOKEN_SAVIOR_WORKFLOW
2. **COMFYUI_WORKFLOW_REVIEW** — Review workflow JSON before adding to registry. Checks node completeness, model paths, and documentation.
3. **VIDEO_WORKFLOW_REVIEW** — Evaluate video generation parameters before rendering. Verifies inputs, VRAM, frame count, and output path.

### C. Model or Model Path Task

1. TOKEN_SAVIOR_WORKFLOW
2. **MODEL_LIBRARY_AUDIT** — Audit external model library for duplicates and registry compliance. Compare files on disk against registry entries.

### D. Render Experiment

1. TOKEN_SAVIOR_WORKFLOW
2. VIDEO_WORKFLOW_REVIEW
3. **RENDER_QA** — Quality assurance for rendered clips. Checks visual and technical quality, flags artifacts.

### E. Final Export

1. TOKEN_SAVIOR_WORKFLOW
2. **EXPORT_QA** — Quality assurance for final MP4 exports. Verifies pre-export conditions, output integrity, and archive completeness.

### F. Sprint Closeout

1. TOKEN_SAVIOR_WORKFLOW
2. VIDEO_WORKFLOW_REVIEW
3. RENDER_QA
4. EXPORT_QA

## Skills Overview

| Skill | File | When to Use |
|-------|------|-------------|
| Token Savior Workflow | `TOKEN_SAVIOR_WORKFLOW.md` | Every task — read first |
| Video Workflow Review | `VIDEO_WORKFLOW_REVIEW.md` | Before/after any video render |
| ComfyUI Workflow Review | `COMFYUI_WORKFLOW_REVIEW.md` | When adding or modifying a workflow JSON |
| Model Library Audit | `MODEL_LIBRARY_AUDIT.md` | Model queries, downloads, or path changes |
| Render QA | `RENDER_QA.md` | After each render experiment |
| Export QA | `EXPORT_QA.md` | Before finalizing a clip export |

## Reporting Skill Usage

Every agent's final report must declare:
- Which skills were read
- Which skills were applied
- Validation performed per the skill checklist
- Whether the task was completed, blocked, or deferred
