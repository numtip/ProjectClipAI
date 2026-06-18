# Current Toolchain

> Discovered: 2026-06-18
> Source: `reports/FULL_TOOLCHAIN_DISCOVERY.md`

---

| Layer | Component | Version | Path | Status |
|-------|-----------|---------|------|--------|
| Environment Manager | Stability Matrix | 2.16.1 | `C:\Users\prinya\AppData\Local\StabilityMatrix\StabilityMatrix.exe` | READY |
| Workflow Engine | ComfyUI | 0.25.0 | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\` | READY |
| Runtime | Python | 3.12.10 | `C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe` | READY |
| Video Processing | FFmpeg | 8.0.1 | `C:\Users\prinya\...\Gyan.FFmpeg...\bin\ffmpeg.exe` | READY |
| Version Control | Git | 2.53.0 | `C:\Program Files\Git\cmd\git.exe` | READY |
| JS Runtime | Node.js | v24.14.0 | `C:\Program Files\nodejs\node.exe` | READY |
| GPU | NVIDIA RTX 3060 | 12GB (CUDA 13.3) | Driver 610.62 | READY |
| Image Model | SDXL Base 1.0 | 1.0 | `F:\AIModels\checkpoints\sd_xl_base_1.0.safetensors` (6.94 GB) | READY |
| Video Model | LTX Video 2B | v0.9.1 | `F:\AIModels\checkpoints\ltx-video-2b-v0.9.1.safetensors` (5.72 GB) | READY |
| Text Encoder | T5XXL fp8 | — | `...\ComfyUI\models\text_encoders\t5xxl_fp8_e4m3fn.safetensors` (4.56 GB) | READY |
| Retired Video | WAN 2.1 I2V 14B | Q3/Q4_K_M | REMOVED from ComfyUI; HF cache remnants only | RETIRED |
| External Model Map | extra_model_paths.yaml | — | `...\ComfyUI\extra_model_paths.yaml` | READY |
| Custom Nodes | ComfyUI-GGUF | — | `...\ComfyUI\custom_nodes\ComfyUI-GGUF\` | PRESENT |

---

## Model Storage Summary

| Location | Size | Details |
|----------|------|---------|
| `F:\AIModels\checkpoints\` | 11.79 GB | SDXL + LTX |
| ComfyUI `models\text_encoders\` | 4.56 GB | T5XXL fp8 |
| `F:\AI\models\hub\` (WAN remnants) | ~1 GB | Not active |
| **Total** | **~17.2 GB** | |

---

## Key Paths

| Purpose | Path |
|---------|------|
| Model library root | `F:\AIModels\` |
| Project workspace | `F:\ProjectClipsAI\` |
| ComfyUI managed root | `C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\` |
| Stability Matrix root | `C:\Users\prinya\AppData\Local\StabilityMatrix\` |
| Python executable | `C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe` |
| FFmpeg executable | `C:\Users\prinya\...\Gyan.FFmpeg...\bin\ffmpeg.exe` |
| Git executable | `C:\Program Files\Git\cmd\git.exe` |
| Node executable | `C:\Program Files\nodejs\node.exe` |

---

## Workflow Summary

| Workflow | Path | Uses |
|----------|------|------|
| SDXL First Render | `workflows/comfyui/first-render/first-render.json` | SDXL Base 1.0 |
| LTX Video v1 | `workflows/comfyui/first-video/first-video.json` | LTX 2B + T5XXL, 97 frames |
| LTX Video v2 | `workflows/comfyui/first-video/first-video-002.json` | LTX 2B + T5XXL, 121 frames |
| Test | `workflows/comfyui/test/test-workflow.json` | Validation |
| WAN Benchmark (retired) | `workflows/comfyui/wan-benchmark/wan-benchmark.json` | RETIRED |
