# Model Library Standard

> Naming and organization standard for the external model library.

---

## Model Categories

### Checkpoints

| Field | Value |
|-------|-------|
| Purpose | Base model for image generation (Stable Diffusion / Flux checkpoints) |
| Folder | `F:\AIModels\checkpoints\` |
| Naming | `publisher-model-version.safetensors` |

### LoRA

| Field | Value |
|-------|-------|
| Purpose | Lightweight adapters for style, character, or concept conditioning |
| Folder | `F:\AIModels\lora\` |
| Naming | `publisher-concept-version.safetensors` |

### VAE

| Field | Value |
|-------|-------|
| Purpose | Variational Autoencoder for latent space encoding/decoding |
| Folder | `F:\AIModels\vae\` |
| Naming | `publisher-model-version.safetensors` |

### ControlNet

| Field | Value |
|-------|-------|
| Purpose | Conditional control for generation (canny, depth, pose, etc.) |
| Folder | `F:\AIModels\controlnet\` |
| Naming | `publisher-type-version.safetensors` |

### Embeddings

| Field | Value |
|-------|-------|
| Purpose | Textual inversion / CLIP embeddings for prompt conditioning |
| Folder | `F:\AIModels\embeddings\` |
| Naming | `name-version.pt` or `name-version.safetensors` |

### Video Models

| Field | Value |
|-------|-------|
| Purpose | Image-to-video and text-to-video generation (WAN, LTX, etc.) |
| Folder | `F:\AIModels\video\` |
| Naming | `publisher-model-version.safetensors` |

### Upscalers

| Field | Value |
|-------|-------|
| Purpose | Image/video upscaling models |
| Folder | `F:\AIModels\upscale\` |
| Naming | `publisher-model-scale-version.pth` |

---

## Naming Convention

**Format:** `publisher-modelname-version.safetensors`

### Good examples

```
stabilityai-sdxl-base-1.0.safetensors
black-forest-flux-1-dev.safetensors
wan-t2v-14b-1.3.safetensors
ltx-video-0.9.safetensors
```

### Avoid

```
final-v2-fixed-new.safetensors
working-copy.safetensors
test.safetensors
my-model.safetensors
```

### Rules

1. Use lowercase only.
2. Separate words with hyphens.
3. Include publisher and version.
4. No spaces.
5. No date strings or "final" / "new" / "working" qualifiers.
6. Registry entries in `registry/MODEL_REGISTRY.md` must match filenames exactly.

---

## Archive Policy

1. Deprecated models move to `F:\AIModels\archive\`.
2. Before archiving, verify no active workflow references the model.
3. Update `registry/MODEL_REGISTRY.md` status to `Deprecated`.
4. Archive entries retain the original filename and a deprecation note.
5. A model is deleted only after confirming it is unreferenced by any project or workflow.
