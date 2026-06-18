# Release Inventory — AI Clips Factory v1.1

> Generated: 2026-06-18
> Total items committed: ~100+ files across 10+ directories

---

## Included Directories & File Counts

| Directory | Files | Description |
|-----------|-------|-------------|
| `docs/` | ~10 | Guides, rubrics, optimization guide, pipeline blueprint |
| `docs/skills/` | 7 | Operational skills for agents |
| `kb/` | 8 | Knowledge base (session log, phase status, decisions, etc.) |
| `templates/` | 5 | Project template (brief, storyboard, prompts, manifest) |
| `library/` | 2 | Prompt library, production metrics |
| `scripts/` | ~10 | Batch render, validation, assembly, env check |
| `reports/` | ~16 | Phase reports (3C through 5E) |
| `workflows/` | ~12 | ComfyUI JSON workflows + FFmpeg docs |
| `registry/` | ~8 | Model, workflow, asset registries |
| `context/` | 3 | Project, toolchain, workflow context packs |
| `.cursor/rules/` | 1 | Project governance rules |
| Root | 6 | `.gitignore`, `PROJECT_STATE.md`, `CONTEXT_PACK.md`, `HANDOFF.md`, `START_NEW_SESSION.md`, `AGENT_START_HERE.md` |

## Excluded from Release

| Item | Reason |
|------|--------|
| `F:\AIModels\` (SDXL, LTX, models) | External model library — not in repo |
| `projects/*/outputs/` | Generated MP4 renders |
| `projects/*/exports/` | Generated master exports |
| `*.safetensors`, `*.ckpt`, `*.pt`, `*.pth` | Model weight files |
| `*.mp4`, `*.mov`, `*.webm` | Video files |
| `ComfyUI/` | Managed by Stability Matrix |
| `StabilityMatrix/` | Separate installation |
| `node_modules/` | Not applicable |
| `__pycache__/` | Python bytecode |
| `.venv/`, `venv/` | Python virtual environments |

## Inventory Size Estimate

| Metric | Value |
|--------|-------|
| Total files committed | ~100+ |
| Estimated size | ~1-2 MB (text files, JSON, scripts) |
| Excluded model + media size | ~17.2 GB (models) + ~50 MB (renders) |
