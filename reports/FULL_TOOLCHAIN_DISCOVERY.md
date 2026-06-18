# Full Toolchain Discovery Report

> Date: 2026-06-18
> Method: Direct filesystem scan + registry context
> Scope: F:\ProjectClipsAI, F:\AIModels, C:\Users\prinya\AppData\Local\StabilityMatrix, F:\AI

---

## 1. Runtime Inventory

| Runtime | Found | Version | Path |
|---------|-------|---------|------|
| Stability Matrix | **YES** | 2.16.1+d97f6ccb9634a7ccfa7513be083aa70653112147 | `C:\Users\prinya\AppData\Local\StabilityMatrix\StabilityMatrix.exe` |
| ComfyUI | **YES** (managed) | 0.25.0 | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\` |
| Python | **YES** | 3.12.10 | `C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe` |
| Git | **YES** | 2.53.0.windows.2 | `C:\Program Files\Git\cmd\git.exe` |
| FFmpeg | **YES** | 8.0.1-full_build | `C:\Users\prinya\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-8.0.1-full_build\bin\ffmpeg.exe` |
| Node.js | **YES** | v24.14.0 | `C:\Program Files\nodejs\node.exe` |
| npx / npm | **YES** | npm 11.9.0 | via Node.js |
| Pinokio | **NO** | N/A | Not installed |
| pnpm | **YES** | 10.33.0 | (in PATH) |
| NVIDIA GPU | **YES** | RTX 3060 12GB | Driver 610.62, CUDA 13.3 |

---

## 2. Model Inventory

### 2.1 Shared Library (`F:\AIModels`)

| Model | Found | Size | Path | Status |
|-------|-------|------|------|--------|
| SDXL Base 1.0 | **YES** | 6.94 GB | `F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors` | READY |
| LTX Video 2B v0.9.1 | **YES** | 5.72 GB | `F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors` | READY |

### 2.2 Managed ComfyUI Models (`StabilityMatrix\Data\Packages\ComfyUI\models\`)

| Model | Found | Size | Path | Status |
|-------|-------|------|------|--------|
| T5XXL fp8 Text Encoder | **YES** | 4.56 GB | `...\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors` | READY |

### 2.3 Model Library Structure (`F:\AIModels\`)

| Directory | Files | Content |
|-----------|-------|---------|
| `checkpoints\` | 2 files | `sd_xl_base_1.0.safetensors`, `ltx-video-2b-v0.9.1.safetensors` (plus `.gitignore`, `.metadata` files) |
| `video\` | 0 | Empty |
| `vae\` | 0 | Empty |
| `controlnet\` | 0 | Empty |
| `embeddings\` | 0 | Empty |
| `lora\` | 0 | Empty |
| `upscale\` | 0 | Empty |
| `ipadapter\` | 0 | Empty |
| `archive\` | 0 | Empty |

### 2.4 HuggingFace Cache (`F:\AI\models\hub\`)

| Cached Model | Type |
|-------------|------|
| `models--city96--Wan2.1-I2V-14B-480P-gguf` | WAN 2.1 I2V 14B GGUF (remnants) |
| `models--Comfy-Org--Wan_2.1_ComfyUI_repackaged` | WAN 2.1 ComfyUI repackaged (remnants) |

> Note: WAN models were previously removed from ComfyUI model directories per WAN_CLEANUP_AUDIT.md. HuggingFace cache remnants remain but are NOT symlinked into any active ComfyUI model path.

---

## 3. ComfyUI Inventory

| Property | Value |
|----------|-------|
| Location | Managed by Stability Matrix |
| Root path | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\` |
| Version | 0.25.0 |
| main.py | Present |
| Custom nodes count | **2** (ComfyUI-GGUF, \_\_pycache\_\_) |
| Workflow count (internal) | 0 (workflows stored in project repo) |
| Model dir mapping | Hybrid: internal `models\` folder + external `F:\AIModels\` via `extra_model_paths.yaml` |

### ComfyUI Model Directories (Internal)

| Directory | Content |
|-----------|---------|
| `models\checkpoints\` | Empty (placeholder file only) |
| `models\unet\` | Empty (placeholder file only) |
| `models\text_encoders\` | **t5xxl_fp8_e4m3fn.safetensors** (4.56 GB) |
| `models\vae\` | Empty (placeholder file only) |
| `models\clip_vision\` | Empty (placeholder file only) |

### External Model Path Mapping (`extra_model_paths.yaml`)

```
checkpoints → F:\AIModels\checkpoints\
loras       → F:\AIModels\lora\
vae         → F:\AIModels\vae\
controlnet  → F:\AIModels\controlnet\
embeddings  → F:\AIModels\embeddings\
```

> Note: `text_encoders` is NOT mapped to external library. The T5XXL lives inside the managed ComfyUI `models\text_encoders\` directory instead.

---

## 4. Stability Matrix Inventory

| Property | Value |
|----------|-------|
| Installation root | `C:\Users\prinya\AppData\Local\StabilityMatrix\` |
| Executable | `StabilityMatrix.exe` (360 MB) |
| Version | 2.16.1 |
| Data directory | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\` |
| Managed packages | 1: **ComfyUI** v0.25.0 |
| Package type | Git-based (has `.git`, `main.py`, full source tree) |
| Model directories (managed) | 38 model subdirectories (StableDiffusion, VAE, Lora, ControlNet, TextEncoders, etc.) — **all empty** |
| Shared model library | Not configured (no `Data/SharedModels`) |
| External model mapping | Configured via ComfyUI `extra_model_paths.yaml` |

### Stability Matrix Model Directory Categories (All Empty)

| Directory | Purpose |
|-----------|---------|
| `Data\Models\StableDiffusion\` | SD checkpoints (placeholder for SM inference) |
| `Data\Models\VAE\` | VAE models |
| `Data\Models\Lora\` | LoRA adapters |
| `Data\Models\ControlNet\` | ControlNet models |
| `Data\Models\TextEncoders\` | Text encoders |
| ... 33 more empty directories | Various model types |

> Key insight: Stability Matrix's own model directories are empty. Models live either in `F:\AIModels\` (for SDXL/LTX) or in the managed ComfyUI `models\text_encoders\` (for T5XXL).

---

## 5. Workflow Inventory

| Workflow | Path | Purpose | Valid JSON |
|----------|------|---------|------------|
| SDXL First Render | `workflows/comfyui/first-render/first-render.json` | Generate initial key image (1024×1024) using SDXL Base 1.0 | YES |
| LTX Video (v1) | `workflows/comfyui/first-video/first-video.json` | I2V generation: image → 97-frame video (768×512, ~4s @ 24fps) | YES |
| LTX Video (v2) | `workflows/comfyui/first-video/first-video-002.json` | I2V generation: image → 121-frame video (768×512, ~5s @ 24fps, 30 steps) | YES |
| WAN Benchmark | `workflows/comfyui/wan-benchmark/wan-benchmark.json` | Benchmark workflow using WAN 2.1 I2V 14B GGUF (retired) | YES |
| Test Workflow | `workflows/comfyui/test/test-workflow.json` | Minimal test/validation workflow | YES |

### Workflow Analysis

**SDXL First Render** (`first-render.json`):
- References: `sd_xl_base_1.0.safetensors` → FOUND @ F:\AIModels\checkpoints\
- Class types: KSampler, CheckpointLoaderSimple, CLIPTextEncode, VAEDecode, SaveImage
- Custom nodes required: **None** (all built-in)

**LTX Video v1** (`first-video.json`):
- References: `ltx-video-2b-v0.9.1.safetensors` → FOUND @ F:\AIModels\checkpoints\
- References: `t5xxl_fp8_e4m3fn.safetensors` → FOUND @ managed ComfyUI text_encoders
- References: `first-render-001.png` → **MISSING** (needs to be generated first)
- Class types: LTXVImgToVideo, CLIPLoader (ltxv type) → requires ComfyUI v0.25.0+
- Custom nodes required: **None** (LTX nodes are built-in since ComfyUI 0.25.0)

**LTX Video v2** (`first-video-002.json`):
- Same as v1 but: 30 steps, 121 frames, different prompt/seed

**WAN Benchmark** (retired):
- References: `wan2.1-i2v-14b-480p-Q3_K_M.gguf` → REMOVED (per WAN audit)
- Requires: `UnetLoaderGGUF` (ComfyUI-GGUF custom node) → INSTALLED
- Requires: Additional WAN-specific models (removed)

---

## 6. Project Asset Inventory

| Asset | Found | Path |
|-------|-------|------|
| Projects directory | **YES** | `F:\ProjectClipsAI\projects\` |
| Project 000-first-clip | **YES** | `F:\ProjectClipsAI\projects\000-first-clip\` |
| Project phase3-first-multishot | **YES** | `F:\ProjectClipsAI\projects\phase3-first-multishot\` |
| Exports directory (root) | **YES** | `F:\ProjectClipsAI\exports\` |
| Exports directory (project) | **YES** | `F:\ProjectClipsAI\projects\000-first-clip\exports\` |
| Assets folders | **NO** | No `assets\` directories found |
| Workflows directory | **YES** | `F:\ProjectClipsAI\workflows\comfyui\`, `F:\ProjectClipsAI\workflows\ffmpeg\` |
| Registry directory | **YES** | `F:\ProjectClipsAI\registry\` (10 files) |
| Docs directory | **YES** | `F:\ProjectClipsAI\docs\` (13 files) |
| Scripts directory | **YES** | `F:\ProjectClipsAI\scripts\` (8 files) |
| `mjuhight1.jpg` | **YES** | `F:\ProjectClipsAI\projects\mjuhight1.jpg` (403 KB, 1706×960, 16:9) |

### Previous Renders & Outputs

| Asset | Size | Path |
|-------|------|------|
| `first-video-001.mp4` | 420 KB | `F:\ProjectClipsAI\projects\000-first-clip\outputs\` |
| `first-video-002.mp4` | 698 KB | `F:\ProjectClipsAI\projects\000-first-clip\outputs\` |
| `wan-test-001.mp4` | 196 KB | `F:\ProjectClipsAI\projects\000-first-clip\outputs\` |
| `render-notes.md` | 4.5 KB | `F:\ProjectClipsAI\projects\000-first-clip\` |

### Project 000-first-clip Assets

| File | Purpose |
|------|---------|
| `brief.md` | Project brief |
| `prompts.md` | Generation prompts |
| `storyboard.md` | Shot storyboard |
| `render-notes.md` | Render documentation |

### Project phase3-first-multishot Assets

| File | Purpose |
|------|---------|
| `README.md` | Overview |
| `scripts/concat_shots.bat` | FFmpeg concatenation script |
| `prompts/shot01_i2v_mju_drone.md` | Shot 1: drone approach |
| `prompts/shot02_descent.md` | Shot 2: descent |
| `prompts/shot03_smart_agri_data.md` | Shot 3: smart agriculture overlay |
| `prompts/shot04_hero_ending.md` | Shot 4: hero ending |
| `reports/PHASE3_FIRST_MULTISHOT_PLAN.md` | Production plan |

---

## 7. Toolchain Architecture Map

```
┌────────────────────────────────────────────────────────────────┐
│                     RUNTIME LAYER                                │
│                                                                  │
│  Stability Matrix v2.16.1                                        │
│  └── C:\Users\prinya\AppData\Local\StabilityMatrix\              │
│       └── Data\Packages\ComfyUI v0.25.0                          │
│           └── main.py                                            │
│           └── custom_nodes\ComfyUI-GGUF                          │
│           └── models\text_encoders\t5xxl_fp8_e4m3fn.safetensors  │
│                                                                  │
│  Python 3.12.10 ── Git 2.53 ── FFmpeg 8.0.1 ── Node v24.14.0    │
│  NVIDIA RTX 3060 12GB (CUDA 13.3, Driver 610.62)                 │
└────────────────────────┬───────────────────────────────────────┘
                         │
                         ▼
┌────────────────────────────────────────────────────────────────┐
│                    MODEL LAYER                                   │
│                                                                  │
│  External Library (F:\AIModels)    Managed Models                 │
│  ├─ checkpoints/                   ├─ text_encoders/              │
│  │  ├─ sd_xl_base_1.0              │  └─ t5xxl_fp8_e4m3fn        │
│  │  └─ ltx-video-2b-v0.9.1        └─ (empty dirs for rest)      │
│  ├─ lora/ (empty)               │                                │
│  ├─ vae/ (empty)               ◄── extra_model_paths.yaml        │
│  ├─ controlnet/ (empty)        │   maps F:\AIModels → ComfyUI    │
│  ├─ embeddings/ (empty)          │                                │
│  └─ video/ (empty)               │                                │
│                                                                  │
│  HuggingFace Cache (F:\AI\models\hub)                            │
│  └─ WAN 2.1 remnants (not symlinked, inactive)                   │
│                                                                  │
│  Total model storage: ~17.2 GB (11.79 external + 4.56 managed    │
│                          + ~1.0 huggingface cache)               │
└────────────────────────┬───────────────────────────────────────┘
                         │
                         ▼
┌────────────────────────────────────────────────────────────────┐
│                    WORKFLOW LAYER                                │
│                                                                  │
│  F:\ProjectClipsAI\workflows\comfyui\                            │
│  ├─ first-render\first-render.json   (SDXL I2I, 1024×1024)      │
│  ├─ first-video\first-video.json      (LTX I2V, 768×512, 4s)    │
│  ├─ first-video\first-video-002.json  (LTX I2V, 768×512, 5s)    │
│  ├─ test\test-workflow.json           (minimal validation)       │
│  └─ wan-benchmark\wan-benchmark.json  (retired WAN benchmark)    │
│                                                                  │
│  F:\ProjectClipsAI\workflows\ffmpeg\                             │
│  └─ README.md (concatenation scripts)                            │
│                                                                  │
│  F:\ProjectClipsAI\workflows\prompts\                             │
│  ├─ storyboard-template.md                                       │
│  ├─ image-prompt-template.md                                     │
│  └─ video-motion-prompt-template.md                              │
└────────────────────────┬───────────────────────────────────────┘
                         │
                         ▼
┌────────────────────────────────────────────────────────────────┐
│                    PROJECT LAYER (RENDERS + ASSETS)              │
│                                                                  │
│  F:\ProjectClipsAI\projects\                                     │
│  ├─ mjuhight1.jpg (403 KB, 1706×960, 16:9, I2V source candidate)│
│  ├─ 000-first-clip\                                              │
│  │  ├─ outputs\first-video-001.mp4 (420 KB, previous render)     │
│  │  ├─ outputs\first-video-002.mp4 (698 KB, previous render)     │
│  │  ├─ outputs\wan-test-001.mp4  (196 KB, WAN benchmark)         │
│  │  ├─ exports\ (empty, ready for assembly)                      │
│  │  ├─ brief.md, prompts.md, storyboard.md, render-notes.md      │
│  └─ phase3-first-multishot\                                      │
│     ├─ scripts\concat_shots.bat                                   │
│     ├─ prompts\ (4 shot descriptions)                             │
│     └─ reports\PHASE3_FIRST_MULTISHOT_PLAN.md                     │
│                                                                  │
│  ┌─────────────────── GIT REPO ───────────────────────┐          │
│  │  F:\ProjectClipsAI\ (no large files)               │          │
│  │  ├─ context\ │ registry\ │ docs\ │ scripts\       │          │
│  │  ├─ workflows\ │ projects\ (metadata only)        │          │
│  │  └─ reports\ (audit artifacts)                    │          │
│  └────────────────────────────────────────────────────┘          │
└────────────────────────────────────────────────────────────────┘
```

---

## 8. Findings

### Critical Corrections from Previous Audit (reports/MODEL_AUDIT_REPORT.md)

| Previous Claim | Actual | Impact |
|---------------|--------|--------|
| ComfyUI not installed | **ComfyUI IS installed** — managed by Stability Matrix (`Data\Packages\ComfyUI\`) | Changes BLOCKED → READY status |
| T5XXL missing | **T5XXL IS present** — inside managed ComfyUI `models\text_encoders\` (4.56 GB) | LTX conditioning is possible |

### Positive Findings

1. **Complete toolchain is installed** — Stability Matrix v2.16.1 → ComfyUI v0.25.0 with all core models
2. **All 3 core models present**: SDXL Base 1.0 (6.94 GB), LTX Video 2B (5.72 GB), T5XXL encoder (4.56 GB)
3. **External library mapping configured** — `extra_model_paths.yaml` maps `F:\AIModels\` into ComfyUI
4. **Previous renders exist** — LTX pipeline has been successfully run before (first-video-001.mp4, first-video-002.mp4)
5. **GPU confirmed** — RTX 3060 12GB with CUDA 13.3
6. **All runtimes present** — Python 3.12, Git 2.53, FFmpeg 8.0.1, Node v24.14

### Gaps / Warnings

1. **Input image `first-render-001.png` missing** — Both LTX workflows reference this file. Candidate `mjuhight1.jpg` (1706×960, 16:9) exists but must be renamed/copied to match workflow expectation.
2. **No VAE/ControlNet/LoRA models** — All secondary model directories are empty. SDXL uses baked-in VAE. LTX uses internal VAE. Not blockers for baseline.
3. **Empty managed model directories** — Stability Matrix's own `Data\Models\*` directories are all empty. Relies entirely on external mapping + T5XXL in ComfyUI.
4. **Only 1 custom node** — ComfyUI-GGUF is installed (for WAN GGUF), which is no longer needed. No LTX-specific custom nodes needed (built into 0.25.0).
5. **WAN cache remnants** — ~1 GB of WAN HuggingFace cache remains at `F:\AI\models\hub\`. Not referenced by any active workflow.
6. **LTX checkpoint location** — Stored in `checkpoints\` not `video\` per naming convention. Works but is non-standard.
7. **SDXL naming** — Uses underscores (`sd_xl_base_1.0`) instead of standard hyphens (`stabilityai-sdxl-base-1.0`).

---

## 9. False Positives from Previous Audit

| Issue in Phase 3A/3B Report | Actual Status | Explanation |
|------------------------------|---------------|-------------|
| ❌ ComfyUI: FAIL (not installed) | ✅ ComfyUI IS installed | Managed by Stability Matrix at `...\StabilityMatrix\Data\Packages\ComfyUI\` |
| ❌ T5XXL: MISSING | ✅ T5XXL IS present (4.56 GB) | Located at `...\StabilityMatrix\Data\Packages\ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors` |
| ❌ Workflows not loadable (no ComfyUI) | ✅ Workflows are loadable | ComfyUI 0.25.0 with LTX built-in nodes supports all workflows |
| ❌ BLOCKED for first LTX render | ✅ PARTIAL (1 remaining issue) | Only missing `first-render-001.png` input image |

---

## 10. Production Readiness Status

```
╔══════════════════════════════════════════════════╗
║           STATUS: PARTIAL                         ║
║                                                   ║
║  Pipeline infrastructure: ✅ ALL RUNNINGS READY    ║
║  Model library:            ✅ 3/3 CORE MODELS     ║
║  ComfyUI installation:     ✅ V0.25.0 READY        ║
║  Workflows:                ✅ 5 JSONs LOADABLE     ║
║  GPU:                      ✅ RTX 3060 12GB       ║
║                                                   ║
║  REMAINING ISSUE:                                  ║
║  Input image first-render-001.png missing          ║
║  (candidate mjuhight1.jpg available at 1706×960)  ║
║                                                   ║
║  To reach READY:                                   ║
║  1. Copy/rename mjuhight1.jpg → first-render-001.png║
║  2. OR run SDXL first-render workflow first         ║
║  3. OR update workflow to point at existing image   ║
╚══════════════════════════════════════════════════╝
```

### Readiness Checklist

| Requirement | Status | Notes |
|-------------|--------|-------|
| Stability Matrix | ✅ READY | v2.16.1 installed |
| ComfyUI | ✅ READY | v0.25.0 managed via SM |
| SDXL Base 1.0 | ✅ READY | 6.94 GB @ F:\AIModels\ |
| LTX Video 2B v0.9.1 | ✅ READY | 5.72 GB @ F:\AIModels\ |
| T5XXL fp8 | ✅ READY | 4.56 GB @ ComfyUI text_encoders |
| External model mapping | ✅ READY | extra_model_paths.yaml configured |
| Custom nodes (LTX) | ✅ READY | Built into ComfyUI 0.25.0 |
| GPU | ✅ READY | RTX 3060 12GB |
| Workflow JSONs | ✅ READY | All 5 valid, 3 active |
| Previous render evidence | ✅ YES | 3 MP4s in project outputs |
| Input image for I2V | ❌ MISSING | first-render-001.png not found; mjuhight1.jpg available as candidate |
| Exports directory | ✅ READY | Ready at projects\000-first-clip\exports\ |

---

*End of Full Toolchain Discovery Report*
