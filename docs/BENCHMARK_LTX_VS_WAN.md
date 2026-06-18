# Benchmark: LTX Video vs WAN 2.1 I2V

> Date: 2026-06-17
> Hardware: RTX 3060 12GB
> Input: `projects/000-first-clip/assets/first-render-001.png`
> Purpose: Determine the best baseline video model for ProjectClipsAI

---

## Models Tested

| Model | Format | Size | VRAM Usage |
|-------|--------|------|------------|
| **LTX Video 2B v0.9.1** | safetensors (fp16) | 5.3 GB | Fits comfortably in 12GB |
| **WAN 2.1 I2V 14B 480p Q4_K_M** | GGUF (Q4) | 10.6 GB | Overflowed 12GB — never completed |
| **WAN 2.1 I2V 14B 480p Q3_K_M** | GGUF (Q3) | 8.0 GB | Barely fits with --lowvram offloading |

---

## Comparison Table

| Metric | LTX | WAN (Q3_K_M, test) | Winner |
|--------|-----|---------------------|--------|
| **Render time (2s clip)** | ~37s (48f, 768x512) | ~940s (49f, 480x480) | **LTX** (25x faster) |
| **Render time (5s clip)** | ~116s (121f, 768x512) | ~3600s est (121f, 768x512) | **LTX** (31x faster) |
| **VRAM suitability** | Fits with headroom | Requires --lowvram offloading | **LTX** |
| **Setup complexity** | Built-in nodes, no extras | Requires ComfyUI-GGUF custom node | **LTX** |
| **Model dependencies** | 1 model + T5XXL encoder | 1 model + UMT5 + VAE + CLIP Vision | **LTX** |
| **Resolution achieved** | 768x512 | 480x480 (test) | **LTX** |
| **Realism (1-5)** | 3 | 3 | Tie |
| **Motion stability (1-5)** | 3 | 2 | **LTX** |
| **Flicker (1-5, higher=better)** | 4 | 3 | **LTX** |
| **Camera smoothness (1-5)** | 3 | 2 | **LTX** |
| **Future potential** | Limited by 2B size | 14B arch, faster GPUs unlock quality | **WAN** |
| **Overall practicality** | Production-ready | Not practical on 12GB | **LTX** |

---

## Recommendations

### Production Baseline Model
**LTX Video 2B v0.9.1** — Use for all ProjectClipsAI renders on RTX 3060 12GB.

- ~2 min per 5s clip at 768x512
- No custom nodes needed
- Reliable, predictable performance

### Fast Preview Model
**LTX Video 2B v0.9.1** (same model, lower frames/steps)
- 49 frames, 15 steps: ~30s for quick previews

### Rejected Models
**WAN 2.1 I2V 14B (any quantization)** — Not suitable for RTX 3060 12GB.

- Q4_K_M: 10.6 GB model + 6.3 GB UMT5 + 1.2 GB CLIP Vision → constant VRAM overflow
- Q3_K_M: 8.0 GB model + 6.3 GB UMT5 + 1.2 GB CLIP Vision → 16 min for 2s clip at 480x480
- Even with --lowvram, the 14B parameter count makes this model impractical
- WAN would benefit from a T2V 1.3B variant which requires ~8-15 GB (untested)
- Future consideration if GPU is upgraded to 24GB+ VRAM

---

## Key Insights

1. **Model size matters more than architecture quality** for 12GB VRAM. WAN's 14B architecture produces comparable or slightly better quality per step, but the VRAM overhead makes renders 25-30x slower.

2. **GGUF offloading cost is prohibitive** for models this large. Each denoising step requires loading ~8 GB of weights from system RAM, which adds 20-60s per step.

3. **LTX's 2B parameter count is the sweet spot** for 12GB VRAM. The model loads entirely in VRAM with room for T5XXL encoder + VAE.

4. **If GPU were upgraded to 24GB+ VRAM**, WAN would likely become the superior model. The 14B architecture has more headroom for photorealism and motion coherence.

---

## What Was NOT Tested

- WAN T2V 1.3B (8-15 GB VRAM, might fit with Q4). Deferred — text-to-video not needed for I2V pipeline.
- WAN with native fp8 safetensors (no GGUF). Requires ~17 GB for 480p model — too large.
- Multi-shot WAN clips. Not applicable per benchmark constraints.
- LoRA-enhanced WAN. Not applicable — benchmark is pure I2V baseline.
