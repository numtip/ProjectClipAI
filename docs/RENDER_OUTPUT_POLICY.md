# Render Output Policy

> Standards for organizing raw renders and final exports.

---

## Directory Structure

```
projects/{project-id}/
├── outputs/          # Raw renders, test clips, iterations
└── exports/          # Final deliverables only
```

Never mix outputs and exports.

---

## Outputs

**Path:** `projects/{project-id}/outputs/`

### Contents

- Raw clips from ComfyUI (image-to-video renders)
- Test renders and iterations
- Experimental outputs

### Naming Convention

```
{shot-number}-{purpose}-{attempt}.mp4
```

Examples:

```
shot1-img2vid-wan-001.mp4
shot2-img2vid-ltx-001.mp4
test-upscale-001.mp4
```

### Rules

1. Every render attempt gets a unique filename.
2. Do not overwrite previous attempts. If you want to re-render, increment the attempt number.
3. Reference render attempt numbers in `render-notes.md` for traceability.

---

## Exports

**Path:** `projects/{project-id}/exports/`

### Contents

- Final assembled MP4 clips (ready for delivery)
- Only version that passes EXPORT_QA

### Naming Convention

```
{project-id}-final-{version}.mp4
```

Examples:

```
000-first-clip-final-v1.mp4
000-first-clip-final-v2.mp4
```

### Rules

1. Only files that pass `docs/skills/EXPORT_QA.md` move to `exports/`.
2. Increment version number for each iteration.
3. Final exports are read-only. Do not modify exports in place.

---

## Retention Policy

| Scope | Retention | Action |
|-------|-----------|--------|
| All outputs | Until project is marked **archived** | Keep for traceability |
| Exports (final) | Indefinite | Archive permanently |
| Failed renders | Until project closeout | Review for lessons, then may delete |
| Intermediate test clips | After final export passes QA | May be deleted |

---

## Git Exclusion

Both `outputs/` and `exports/` are already excluded from Git via `.gitignore`. All video files stay outside version control.
