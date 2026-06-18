# AI Video Lab Blueprint

## Architecture

```
┌─────────────────────────────────────────────┐
│              Cloud AI Layer                  │
│  Script Writing  │  Storyboarding  │  Prompts │
└──────────┬──────────────────────────────────┘
           │ text
           ▼
┌─────────────────────────────────────────────┐
│            ComfyUI (Local GPU)               │
│  ┌─────────┐  ┌──────────┐  ┌───────────┐  │
│  │ Image   │→│ Video   │→│ Upscale  │  │
│  │ Gen     │  │ Gen     │  │ /Refine  │  │
│  └─────────┘  └──────────┘  └───────────┘  │
└──────────────────┬──────────────────────────┘
                   │ rendered clips
                   ▼
┌─────────────────────────────────────────────┐
│              FFmpeg Assembly                │
│  Concatenate │ Transitions │ Audio │ Export │
└──────────────────┬──────────────────────────┘
                   │ final MP4
                   ▼
            Projects/<id>/exports/
```

## Key Design Decisions

1. **Local-First** — All GPU rendering happens locally. Cloud is only for creative text tasks.
2. **Image-to-Video Priority** — Generate key frames first, then animate. More control than text-to-video.
3. **No Git for Large Files** — Models, outputs, and exports stay outside version control.
4. **Numbered Projects** — Sequential project IDs prevent naming conflicts and enable easy reference.
5. **Registry-Driven** — All artifacts (models, workflows, assets, projects) cataloged in registries.

## Data Flow

1. Topic → Script (cloud)
2. Script → Storyboard (cloud)
3. Storyboard → Image Prompts → ComfyUI Image Gen (local GPU)
4. Key Images → ComfyUI Video Gen (local GPU)
5. Raw Clips → FFmpeg Assembly → Final MP4 (local)
6. Final MP4 → Project Exports (local, outside Git)
