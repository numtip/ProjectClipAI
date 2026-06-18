# Retired Components

> Source of truth for components retired from ProjectClipsAI.

## Retirement Entries

| Date | Component | Version | Reason | Space Recovered | Notes |
|------|-----------|---------|--------|-----------------|-------|
| 2026-06-17 | WAN 2.1 I2V 14B 480p Q4_K_M GGUF | 10.6 GB | Not suitable for RTX 3060 12GB. Overflowed VRAM, render never completed | 10.6 GB | Benchmark ID 002 in BENCHMARK_REGISTRY.md |
| 2026-06-17 | WAN 2.1 I2V 14B 480p Q3_K_M GGUF | 8.0 GB | Not suitable for RTX 3060 12GB. 16 min for 2s test clip at 480x480 | 8.0 GB | Benchmark ID 003 in BENCHMARK_REGISTRY.md. Full benchmark (ID 004) ran 4.9h without completing |
| 2026-06-17 | UMT5 XXL fp8 (text encoder) | 6.3 GB | Required only for WAN. Retired with WAN pipeline | 6.3 GB | Loaded via CLIPLoader(type="wan") |
| 2026-06-17 | WAN 2.1 VAE | 0.2 GB | Required only for WAN. Retired with WAN pipeline | 0.2 GB | Separate VAE file (not embedded in model) |
| 2026-06-17 | CLIP Vision H | 1.2 GB | Required only for WAN I2V. Retired with WAN pipeline | 1.2 GB | Not needed for LTX I2V (LTX uses T5XXL only) |

**Total space recovered: 26.2 GB** (confirmed 2026-06-17 after file deletion)

## Policy

1. Retirement preserves knowledge. All benchmark docs remain.
2. Retired components may be restored if hardware is upgraded (e.g., 24GB+ GPU).
3. Space recovered is recorded at time of removal.
4. Registry entries remain visible (status = rejected) for audit trail.
