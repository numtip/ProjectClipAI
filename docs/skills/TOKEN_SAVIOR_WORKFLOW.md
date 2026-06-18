# Token Savior Workflow

**Purpose:** Minimize token consumption when working in ProjectClipsAI.

## Behaviors

1. Always read `context/*` and `registry/*` before scanning the workspace.
2. Use `Grep` and targeted file reads instead of broad directory scans.
3. Append to files instead of rewriting full documents.
4. Before generating new content, check registries for existing resources.
5. Prefer diff-style updates over full file regenerations.

## When to Skip Scanning

If the question can be answered from context packs or registry entries alone, do not scan the workspace.

## File Size Limits

Keep files concise:
- Context packs: max 200 lines
- Registry files: max 200 lines
- Skills: as short as possible while remaining usable
