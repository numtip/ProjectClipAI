# Toolchain Registry

> Source of truth for tool status in ProjectClipsAI.

## Status Definitions

| Status | Meaning |
|--------|---------|
| **Production Baseline** | Core part of the production pipeline. Locked and validated |
| **Approved** | Part of the production pipeline. Documented, tested, and ready |
| **Experimental** | Evaluated but not yet production-ready. Use for testing |
| **Deferred** | Identified but not yet installed or integrated |
| **Retired** | Removed from active use. Knowledge preserved in registry |

---

## Approved

| Tool | Version (installed) | Source | Why Approved |
|------|---------------------|--------|--------------|
| Stability Matrix | 2.16.1 | GitHub | Required for ComfyUI instance management, model paths, environment isolation. Installed at `%LOCALAPPDATA%\StabilityMatrix\`. Launches successfully |
| ComfyUI | ca3dbe20 (latest) | GitHub (via git clone) | Core workflow engine. Installed via Stability Matrix data dir at `%LOCALAPPDATA%\StabilityMatrix\Data\Packages\ComfyUI\`. Web UI verified at http://127.0.0.1:8188 |
| FFmpeg | 8.0.1 | ffmpeg.org | Verified working. Required for clip assembly and export |
| LTX Video 2B v0.9.1 | 0.9.1 | Hugging Face (Lightricks/LTX-Video) | Production Baseline — Validated through benchmark testing on RTX 3060 12GB. ~2 min per 5s clip at 768x512. No custom nodes required |
| ComfyUI-GGUF | Latest (city96) | GitHub | Approved for GGUF support. Installed during Phase 2B benchmark. Kept for future GGUF-use if needed |

## Experimental

| Tool | Version (target) | Source | Why Experimental |
|------|------------------|--------|------------------|
| — | — | — | No experimental tools currently |

## Deferred

| Tool | Version (target) | Source | Why Deferred |
|------|------------------|--------|--------------|
| Pinokio | Latest | pinokio.computer | Alternative launcher. Not needed while Stability Matrix covers requirements. Sandbox use only |
| Subtitle Edit | Latest | GitHub | Not required for first clip sprint |
| CapCut | Latest | ByteDance | Not required for first clip sprint |
| Agency Agents | Latest | GitHub | Future automation phase. Not yet integrated |

## Retired

| Tool | Version (installed) | Source | Why Retired |
|------|---------------------|--------|-------------|
| WAN 2.1 I2V 14B 480p (GGUF) | Q3_K_M (8.0 GB) / Q4_K_M (10.6 GB) | HuggingFace (city96) / Comfy-Org | Retired after Phase 2B benchmark. Not production-viable on RTX 3060 12GB. 16 min for 2s clip. Revisit with GPU upgrade to 24GB+ VRAM |
| Subtitle Edit | Latest | GitHub | Not required for first clip sprint |
| CapCut | Latest | ByteDance | Not required for first clip sprint |
| Agency Agents | Latest | GitHub | Future automation phase. Not yet integrated |

## Policy

1. **Promotion path**: Experimental → Approved requires successful render QA on a real clip project.
2. **No unregistered tools**: Every tool used in a production render must be registered here first.
3. **Status changes**: Update this registry when a tool moves between statuses.
4. **Version tracking**: Target versions are guidelines. Actual installed version is verified by scripts/check-env.ps1.
