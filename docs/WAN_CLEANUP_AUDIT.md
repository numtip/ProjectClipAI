# WAN Cleanup Audit

> Date: 2026-06-17
> Purpose: Identify, classify, and remove WAN-only assets after Phase 2B benchmark
> Conclusion: WAN 2.1 I2V 14B not viable on RTX 3060 12GB

---

## Assets

| # | Path | Size | Decision | Reason |
|---|------|------|----------|--------|
| 1 | ComfyUI\models\unet\wan2.1-i2v-14b-480p-Q4_K_M.gguf | 10.6 GB | REMOVE | Q4_K_M overflowed 12GB VRAM. Never completed render. Benchmark concluded |
| 2 | ComfyUI\models\unet\wan2.1-i2v-14b-480p-Q3_K_M.gguf | 8.0 GB | REMOVE | Q3_K_M took 16 min for 2s clip. Full benchmark ran 4.9h without completing. Not production-viable |
| 3 | ComfyUI\models\text_encoders\umt5_xxl_fp8_e4m3fn_scaled.safetensors | 6.3 GB | REMOVE | WAN-only text encoder. Not needed for LTX pipeline |
| 4 | ComfyUI\models\vae\wan_2.1_vae.safetensors | 0.2 GB | REMOVE | WAN-only VAE. Not needed for LTX pipeline |
| 5 | ComfyUI\models\clip_vision\clip_vision_h.safetensors | 1.2 GB | REMOVE | WAN-only for I2V conditioning. Not needed for LTX pipeline |
| 6 | ComfyUI\custom_nodes\ComfyUI-GGUF | ~50 MB (code) | KEEP | Approved tool. May be useful for other GGUF models in future. Zero maintenance burden as a git repo |
| 7 | Workflows\comfyui\wan-benchmark\* | ~15 KB | ARCHIVE (keep) | Benchmark workflow documented for knowledge preservation |
| 8 | Projects\000-first-clip\outputs\wan-test-001.mp4 | 0.2 MB | KEEP | Benchmark output preserved as project knowledge |
| 9 | Docs\BENCHMARK_LTX_VS_WAN.md | 3 KB | KEEP | Comparison document. Essential knowledge asset |
| 10 | Registry\BENCHMARK_REGISTRY.md | 3 KB | KEEP | Benchmark data. Essential knowledge asset |

**Total to remove: 26.2 GB**
**Total to keep: 0.2 GB + documents**

---

## Decision Rationale

All WAN model files and supporting components are marked REMOVE because:

1. WAN 2.1 I2V 14B is not production-viable on RTX 3060 12GB at any quantization
2. No future WAN renders are planned on current hardware
3. All benchmark data is preserved in registry and comparison docs
4. Full benchmark was run (4.9h timeout) confirming the conclusion
5. Knowledge is fully captured — re-downloading models is trivial if hardware is upgraded

ComfyUI-GGUF custom node is KEPT because:
- It is a small git repo (~50 MB code, no model weights)
- Zero maintenance burden (updates via git pull)
- May be useful for other GGUF models in the future

WAN workflow JSONs are ARCHIVED (kept) because:
- They document the exact benchmark configuration
- Useful reference if WAN is revisited with upgraded hardware
- Minimal storage cost (~15 KB)
