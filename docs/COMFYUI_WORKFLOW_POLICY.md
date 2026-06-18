# ComfyUI Workflow Policy

## Principles

1. **Start small** — Begin with one working workflow. Only expand when stable.
2. **Version control** — Export workflow JSONs to `workflows/comfyui/`.
3. **Document nodes** — Track all required custom nodes in `registry/WORKFLOW_REGISTRY.md`.
4. **No random installs** — Do not install custom nodes without documenting them first.

## Workflow Structure

Each workflow in `workflows/comfyui/` should include:
- Workflow JSON export (the file ComfyUI loads)
- Annotated notes at the top of the JSON or in a companion `.md` file
- List of required custom nodes
- Recommended model settings

## Standard Nodes vs Custom Nodes

Prefer ComfyUI built-in nodes. Only use custom nodes when the built-in set cannot achieve the required output.

When adding a custom node:
1. Verify it's needed (can built-in nodes do this?)
2. Check `registry/WORKFLOW_REGISTRY.md` for existing installations
3. Install via ComfyUI Manager or Stability Matrix
4. Document the node, its purpose, and its source
5. Update `registry/WORKFLOW_REGISTRY.md`

## Workflow Lifecycle

1. **Draft** — Initial version, untested
2. **Active** — Successfully rendered at least one output
3. **Stable** — Used across multiple projects with consistent results
4. **Archived** — Replaced by a better workflow, kept for reference
