# Token Savior Workflow

> Minimize token consumption when working in AI Clips Factory.

---

## Reading Strategy

1. **Read only required files** — Before scanning, check if the answer exists in:
   - `PROJECT_STATE.md` (project state)
   - `kb/DECISION_LOG.md` (decisions)
   - `kb/CURRENT_TOOLCHAIN.md` (tool versions/paths)
   - `kb/PHASE_STATUS.md` (current phase)
   - Registry files in `registry/`

2. **Search before reading entire folders** — Use `Grep` or targeted reads instead of broad directory listings.

3. **Context packs first** — Always read `context/*` and `kb/*` before scanning the workspace.

4. **Reuse existing reports** — Check `reports/` before generating new analysis. The full toolchain discovery (`FULL_TOOLCHAIN_DISCOVERY.md`) is the authoritative source.

---

## Editing Strategy

1. **Prefer patch over rewrite** — Append to files instead of rewriting full documents when possible.

2. **Keep files concise** — Context packs max 200 lines. Registry files max 200 lines. Skills as short as possible.

3. **Create small KB files** — New knowledge base entries should be under 5 KB unless comprehensive coverage is required.

---

## Model Management

1. **Avoid duplicate model downloads** — Always check `registry/MODEL_REGISTRY.md` and `kb/CURRENT_TOOLCHAIN.md` before downloading anything.

2. **Avoid duplicate scans** — The full toolchain has already been discovered. Reuse `reports/FULL_TOOLCHAIN_DISCOVERY.md`.

3. **Reuse existing workflows** — Check `workflows/comfyui/` and `kb/CURRENT_TOOLCHAIN.md` before creating new workflow JSONs.

4. **Preserve previous decisions** — `kb/DECISION_LOG.md` contains all architectural decisions. Do not propose reverting without adding a new superseding decision.

---

## Workflow Rules

1. **Never reinstall existing tools** — All runtimes are already installed (see `kb/CURRENT_TOOLCHAIN.md`).

2. **Never propose WAN for production** — WAN 2.1 I2V 14B is retired. LTX Video 2B is the production baseline.

3. **No rendering before readiness validation** — Check `kb/PHASE_STATUS.md` for unresolved blockers.

4. **No large assets in Git** — Model files, renders, and exports stay outside version control.

5. **Always verify actual paths** — Don't assume paths from memory. Read `kb/CURRENT_TOOLCHAIN.md`.

---

## Reporting

1. **Create concise reports** — Focus on findings, not process.

2. **Reference authoritative sources** — Cite `PROJECT_STATE.md`, `kb/DECISION_LOG.md`, and `reports/` where applicable.

3. **Use diff-style updates** — When updating registries, append rather than rewrite.

4. **Preserve discovery evidence** — Don't delete or overwrite existing reports.
