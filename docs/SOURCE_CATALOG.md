# Source Catalog

> Official approved source registry for ProjectClipsAI.
> Governance document only. No installations.

---

## Tier 1 — Core Approved Sources

These sources are mandatory for the production pipeline. All downloads must come from these URLs. No mirrors or forks unless verified.

### Stability Matrix

| Field | Value |
|-------|-------|
| URL | https://github.com/LykosAI/StabilityMatrix |
| Category | Environment Launcher |
| Purpose | Manage ComfyUI instances, model paths, and environment configurations |
| Why Approved | Simplifies ComfyUI setup and model management. Handles Python venv, custom nodes, and version control automatically |
| Local Usage Notes | Configure model library path to an external drive. Do not store models inside the repository |

### ComfyUI

| Field | Value |
|-------|-------|
| URL | https://github.com/comfyanonymous/ComfyUI |
| Category | Workflow Engine |
| Purpose | Node-based image and video generation pipeline |
| Why Approved | Industry-standard open-source workflow engine. Supports WAN, LTX, all major models. Active development |
| Local Usage Notes | Install via Stability Matrix for easier management. Store workflow JSONs in `workflows/comfyui/` |

### FFmpeg

| Field | Value |
|-------|-------|
| URL | https://ffmpeg.org |
| Category | Video Assembly |
| Purpose | Concatenate clips, add transitions, sync audio, final export |
| Why Approved | Industry-standard video processing. Zero-cost, battle-tested, scriptable |
| Local Usage Notes | Verify with `scripts/ffmpeg-check.ps1`. Ensure ffmpeg.exe is in PATH |

### Agency Agents

| Field | Value |
|-------|-------|
| URL | https://github.com/msitarzewski/agency-agents |
| Category | Agent Framework |
| Purpose | Reference for agent-based workflow orchestration (future use) |
| Why Approved | Open-source agent framework aligned with ProjectClipsAI's automation goals |
| Local Usage Notes | Not yet integrated. Tracked for future automation phases |

---

## Tier 2 — Approved Video Models

These models are approved for use in the production pipeline. Documented here; not yet downloaded.

### WAN Video

| Field | Value |
|-------|-------|
| Purpose | Primary image-to-video generation model |
| Hardware Suitability | Requires 8GB+ VRAM. 12GB recommended |
| RTX 3060 Suitability | Suitable at 720p resolution. Expect 5–15 min per clip depending on frame count and steps |
| Recommended Use Case | First choice for all image-to-video clips. Best quality-to-speed ratio |

### LTX Video

| Field | Value |
|-------|-------|
| Purpose | Alternative / experimental image-to-video generation model |
| Hardware Suitability | Lighter than WAN. Runs on 6GB+ VRAM |
| RTX 3060 Suitability | Well suited. Faster than WAN on 12GB VRAM at the cost of some quality |
| Recommended Use Case | Faster iteration / prototyping. Fallback if WAN is too slow or VRAM-constrained |

---

## Tier 3 — Optional Sandbox Sources

### Pinokio

| Field | Value |
|-------|-------|
| URL | https://pinokio.computer |
| Purpose | Testing and experimentation |
| Status | Not part of production workflow |
| Local Usage Notes | Use for evaluating new models or tools in isolation. Do not rely on Pinokio for production renders |

> Pinokio is a sandbox-only tool. It is not part of the approved production toolchain.
