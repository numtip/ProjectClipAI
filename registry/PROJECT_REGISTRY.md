# Project Registry

> Source of truth for all clip projects.
> Each project lives under `projects/` with a numbered prefix.

## Projects

| # | Name | Status | Brief | Output | Notes |
|---|------|--------|-------|--------|-------|
| 000 | first-clip | in-progress | — | first-render-001.png, first-video-001.mp4, first-video-002.mp4, wan-test-001.mp4 | Initial bootstrap project. Phase 1C: first SDXL render complete. Phase 2A: first LTX video render complete. Phase 2B: WAN benchmark test complete |

## Status Legend

- **planned** — Brief written, not yet started
- **in-progress** — Active production
- **rendering** — ComfyUI jobs running
- **completed** — Final export delivered
- **archived** — Reference only, no active work

## Phase 0 — Skill Enforcement

| Phase | Name | Status | Purpose | Key Files |
|-------|------|--------|---------|-----------|
| 0 | Skill Enforcement | completed | enforce skill-first workflow | docs/skills/README.md, docs/AGENT_START_PROTOCOL.md, PROJECT_CONSTITUTION.md, .cursor/rules/projectclipsai.mdc |

## Phase 0.5 — Source Catalog & Tool Selection Audit

| Phase | Name | Status | Purpose | Key Files |
|-------|------|--------|---------|-----------|
| 0.5 | Source Catalog & Tool Selection Audit | completed | identify, classify, and document approved tools and sources | SOURCE_CATALOG.md, TOOL_SELECTION_MATRIX.md, TOOLCHAIN_REGISTRY.md |

## Phase 1A — Installation Foundation & Asset Governance

| Phase | Name | Status | Purpose | Key Files |
|-------|------|--------|---------|-----------|
| 1A | Installation Foundation & Asset Governance | completed | storage architecture, model standard, backup policy, output policy, asset governance, registry templates | STORAGE_ARCHITECTURE.md, MODEL_LIBRARY_STANDARD.md, WORKFLOW_BACKUP_POLICY.md, RENDER_OUTPUT_POLICY.md, ASSET_GOVERNANCE.md, PHASE1B_READINESS.md |

## Phase 1B — Installation Foundation

| Phase | Name | Status | Purpose | Key Outputs |
|-------|------|--------|---------|-------------|
| 1B | Installation Foundation | completed | install Stability Matrix, ComfyUI, shared library, workflow test | Stability Matrix 2.16.1, ComfyUI (latest), Shared Library at F:\AIModels, Workflow Import/Export verified |

## Phase 1C — First Render Foundation

| Phase | Name | Status | Purpose | Key Outputs |
|-------|------|--------|---------|-------------|
| 1C | First Render Foundation | completed | first image generation workflow and render | first-render.json, first-render-001.png (1024x1024), SDXL base 1.0 registered |

## Phase 2A — First Video Generation (LTX I2V)

| Phase | Name | Status | Purpose | Key Outputs |
|-------|------|--------|---------|-------------|
| 2A | First Video Generation (LTX I2V) | completed | generate first AI video clip from existing image | first-video.json, first-video-001.mp4 (768x512, 4s, 24fps), first-video-002.mp4 (768x512, 5s, 24fps, motion-first prompt), LTX Video model registered, T5XXL text encoder installed |

## Phase 2B — WAN Benchmark

| Phase | Name | Status | Purpose | Key Outputs |
|-------|------|--------|---------|-------------|
| 2B | WAN Benchmark | completed with constraints | benchmark WAN I2V vs LTX baseline on RTX 3060 12GB | wan-benchmark workflow, wan-test-001.mp4 (480x480, 2s, moved to 000-first-clip/outputs/), BENCHMARK_LTX_VS_WAN.md, BENCHMARK_REGISTRY.md, WAN models registered (Q4_K_M rejected, Q3_K_M tested) |

## Phase 2C — Production Baseline Lock

| Phase | Name | Status | Purpose | Key Outputs |
|-------|------|--------|---------|-------------|
| 2C | Production Baseline Lock | completed | lock production stack based on benchmark results; retire WAN; reclaim disk space | TOOLCHAIN_REGISTRY.md (LTX=Production Baseline, WAN=Retired), MODEL_REGISTRY.md (LTX=production_baseline, WAN=rejected), RETIRED_COMPONENTS.md, WAN_CLEANUP_AUDIT.md, 26.2 GB recovered |

### Production Stack

| Layer | Tool | Status |
|-------|------|--------|
| Environment | Stability Matrix 2.16.1 | Approved |
| Workflow Engine | ComfyUI | Approved |
| Image Model | SDXL Base 1.0 | Active |
| Video Model | LTX Video 2B v0.9.1 | Production Baseline |
| Assembly | FFmpeg 8.0.1 | Approved |

### Retired

| Component | Reason | Space Recovered |
|-----------|--------|-----------------|
| WAN 2.1 I2V 14B 480p (all quantizations) | Not viable on RTX 3060 12GB. 16+ min for 2s clip | 26.2 GB |
| UMT5 XXL fp8 text encoder | WAN-only dependency | included above |
| WAN 2.1 VAE | WAN-only dependency | included above |
| CLIP Vision H | WAN-only I2V dependency | included above |

## Policy

1. Every clip project gets a sequential number (001, 002, ...)
2. Each project folder contains: brief, storyboard, prompts, render notes
3. Outputs and exports stay in their respective subfolders
4. Update this registry when starting or completing a project
