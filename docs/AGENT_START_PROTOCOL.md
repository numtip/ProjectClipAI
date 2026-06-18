# Agent Start Protocol

Every agent operating in ProjectClipsAI must follow this startup sequence.

## Mandatory Reading Order

Before making any changes, read these files in order:

1. **`context/PROJECT_CONTEXT.md`** — Project identity, stack, constraints, agent rules
2. **`context/TOOLCHAIN_CONTEXT.md`** — Tool ecosystem, environment checks, management policies
3. **`context/WORKFLOW_CONTEXT.md`** — Pipeline stages, prompt structures, rendering policy
4. **`registry/` (task-relevant)** — Consult `PROJECT_REGISTRY.md`, `MODEL_REGISTRY.md`, `WORKFLOW_REGISTRY.md`, or `ASSET_REGISTRY.md` depending on the task
5. **`docs/skills/README.md`** — Skill index to determine required skill chain for the task
6. **Task-specific skills** — Read the skills identified by the skill index

## After Reading

- Apply TOKEN_SAVIOR_WORKFLOW behaviors throughout the session
- Read and follow each skill in the chain for the task type
- Use targeted reads — never broad workspace scans when context packs suffice

## Final Report Requirements

Every agent must include in the final report:

| Item | Description |
|------|-------------|
| **Context files read** | List which context packs were consulted |
| **Registry files consulted** | List which registries were referenced |
| **Skills used** | List each skill read and how it was applied |
| **Files changed** | List every file created, modified, or deleted |
| **Validation performed** | Describe checks run (scripts, QA reviews, audits) |
| **Intentionally not done** | Explain any task items that were skipped and why |
