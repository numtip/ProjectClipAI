# GitHub Release Audit — AI Clips Factory v1.1

> Generated: 2026-06-18
> Status: READY FOR RELEASE

---

## .gitignore Audit

| Pattern | Status | Protects |
|---------|--------|----------|
| `AIModels/` | ✅ Added | External model library root |
| `checkpoints/` | ✅ Added | Checkpoint directories |
| `models/*` | ✅ Existing | Model file directories |
| `projects/*/outputs/` | ✅ Updated | Project render outputs |
| `projects/*/exports/` | ✅ Updated | Project master exports |
| `renders/` | ✅ Added | Render output directories |
| `videos/` | ✅ Added | Video directories |
| `*.mp4`, `*.mov`, `*.webm` | ✅ Existing | Video files anywhere |
| `*.safetensors`, `*.ckpt`, `*.pt`, `*.pth`, `*.onnx` | ✅ Existing | Model weight files |
| `*.bin`, `*.gguf`, `*.weight` | ✅ Added | Additional weight formats |
| `cache/`, `temp/` | ✅ Added | Cache and temp directories |
| `__pycache__/` | ✅ Existing | Python bytecode cache |
| `node_modules/` | ✅ Existing | Node dependencies |
| `.env` | ✅ Existing | Environment secrets |

## Excluded from Release (by policy)

| Category | Reason |
|----------|--------|
| Model weight files (safetensors, ckpt, pt, pth, onnx) | Too large, external library |
| Video outputs (mp4, mov, webm) | Generated media |
| Render exports (master-hardcuts.mp4, master-fades.mp4) | Generated media |
| ComfyUI runtime | Managed by Stability Matrix |
| Stability Matrix runtime | Separate installation |
| WAN HuggingFace cache remnants | Not project data |
| FFmpeg / Python / Node / Git runtimes | System-level dependencies |

## Included in Release

| Category | Details |
|----------|---------|
| Documentation | `docs/`, `CONTEXT_PACK.md`, `HANDOFF.md`, `START_NEW_SESSION.md` |
| Knowledge Base | `kb/` (8 files) |
| Scripts | `scripts/` (PowerShell + Batch) |
| Workflows | `workflows/comfyui/` (JSON exports) |
| Templates | `templates/` (project template) |
| Library | `library/` (prompts, metrics) |
| Reports | `reports/` (phase reports) |
| Registries | `registry/` (model, workflow, asset registries) |
| Context | `context/` (project, toolchain, workflow context) |
| Rules | `.cursor/rules/` (governance rules) |
| Project files | `.gitignore`, `PROJECT_STATE.md`, `PROJECT_CONSTITUTION.md` |

## Verdict

**READY FOR RELEASE** — All model files, renders, and external runtimes are excluded. Repository contains only documentation, scripts, workflows, and governance files.
