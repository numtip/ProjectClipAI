# ComfyUI Workflow Review

**Purpose:** Review a ComfyUI workflow JSON before adding to the registry.

## Checklist

- [ ] Workflow loads in ComfyUI without errors
- [ ] All required custom nodes are documented in WORKFLOW_REGISTRY
- [ ] Model paths use relative or configurable references
- [ ] Output path is configurable
- [ ] Workflow saved as JSON export (not image embed)

## Documentation Requirements

- Purpose of the workflow
- Required custom nodes
- Expected input types (image, text, seed, etc.)
- Recommended settings (resolution, steps, CFG scale)
- Notes on performance (VRAM usage, render time)
