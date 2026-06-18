# Workflow Backup Policy

> Policy for versioning, storing, and recovering ComfyUI workflows.

---

## Storage Location

All workflow files live in `workflows/comfyui/`.

## Required Files per Workflow

Every approved workflow must include these four files in its directory or as part of its entry:

| Artifact | Description |
|----------|-------------|
| **JSON export** | ComfyUI workflow JSON. Named in versioning format below |
| **README** | Brief description, purpose, input/output expectations |
| **Required nodes list** | All custom nodes needed, with install sources |
| **Tested model list** | Models verified to work with this workflow |
| **Last validation date** | Date the workflow was last tested end-to-end |

## Versioning Format

`YYYY-MM-DD-purpose.json`

### Examples

```
2026-06-17-img2vid-wan-basic.json
2026-06-18-img2vid-ltx-experiment.json
```

Versioning by date enables rollback and chronological tracking.

### README companion format

```
workflows/comfyui/2026-06-17-img2vid-wan-basic/
├── 2026-06-17-img2vid-wan-basic.json
├── README.md
├── required-nodes.txt
├── tested-models.txt
└── validation-log.txt
```

---

## Rollback Procedure

If a workflow update breaks a production render:

1. Identify the last working JSON via the date stamp in the filename.
2. Load the working JSON in ComfyUI.
3. Confirm it loads without errors (`COMFYUI_WORKFLOW_REVIEW` skill).
4. Note the rollback in the workflow's `validation-log.txt`.
5. Archive the broken workflow with a `-broken` suffix for post-mortem.

---

## Policy

1. Every new workflow or significant modification gets a new dated file. Never overwrite an existing working workflow.
2. The `workflows/comfyui/README.md` must list all active workflows and their purpose.
3. Register each workflow in `registry/WORKFLOW_REGISTRY.md` upon approval.
4. Remove a workflow from active use only after confirming no project references it.
