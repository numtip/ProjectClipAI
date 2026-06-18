# Project Governance

> Rules for maintaining the project memory system.

---

## Context Preservation System (Phase 5E)

The following files form the **Context Preservation System**. They enable any future AI (ChatGPT, Cursor, Claude, DeepSeek, Grok) to resume the project accurately without relying on conversation history:

| File | Purpose | Update Frequency |
|------|---------|-----------------|
| `CONTEXT_PACK.md` | Executive summary — project identity, stack, milestones, key decisions | On any project change |
| `HANDOFF.md` | Single-page status handoff — current phase, blockers, next actions | End of every session |
| `START_NEW_SESSION.md` | Startup instructions for any future AI | When governance rules or read order changes |

These files exist at the project root (`F:\ProjectClipsAI\`) for immediate discoverability.

---

## Phase Close Procedure

Before closing any major phase, the agent MUST execute the following checklist in order:

### Step 0 — Update Context Preservation System
- Update `CONTEXT_PACK.md` — current phase, objective, blockers, next action, milestone table
- Update `HANDOFF.md` — current phase, completed, state, risks, blockers, next action, last updated
- Ensure `START_NEW_SESSION.md` reflects current governance rules and read order

### Step 1 — Update PROJECT_STATE.md
- Update phase history table with new phase
- Update "Current Phase" marker
- Update "Next Phase" marker
- Add new known gaps if discovered
- Mark date and new current phase at top

### Step 2 — Update PHASE_STATUS.md
- Mark completed phase as ✅ Complete
- Update "YOU ARE HERE" marker to new current phase
- Update production readiness status if changed
- Update blocker list if resolved or new blockers found
- Update next actions

### Step 3 — Update DECISION_LOG.md
- Append new DECISION-XXX records for any new architectural decisions
- Never delete or modify existing decision records
- Superseded decisions retain full original text with status change

### Step 4 — Update CURRENT_TOOLCHAIN.md
- Update if any runtime version changed
- Update if any model was added, removed, or changed status
- Update if any workflow was added or retired

### Step 5 — Append SESSION_LOG.md
- Create a new `## YYYY-MM-DD` entry at the top
- List completed items as bullet points
- List decisions made during the session (reference DECISION-XXX)
- List next actions

### Step 6 — Create Handoff Report
- Create `reports/<PHASE_NAME>_HANDOFF.md` (or equivalent phase report)
- Include: files modified, decisions made, blockers, next actions
- Brief format (under 3 KB unless comprehensive coverage needed)

### Step 7 — Update Context Preservation Files
- Update `CONTEXT_PACK.md` with latest phase status and milestone table
- Update `HANDOFF.md` with current state and next recommended action
- These two files together must be sufficient for a new AI to recover project state

---

## Knowledge Base Integrity Rules

1. **PROJECT_STATE.md** is the single source of truth. All other files derive from it.
2. **DECISION_LOG.md** is append-only. Existing decisions are never edited — only superseded.
3. **SESSION_LOG.md** is append-only. New entries go at the top (newest first).
4. **PHASE_STATUS.md** always reflects the exact current state. Update it immediately after phase changes.
5. **CURRENT_TOOLCHAIN.md** must match reality. Verify paths if uncertain.
6. **AGENT_START_HERE.md** is the onboarding contract. Every agent follows it.

---

## File Ownership

| File | Owner | Update Frequency |
|------|-------|-----------------|
| `CONTEXT_PACK.md` | All agents | On any project change |
| `HANDOFF.md` | All agents | End of every session |
| `START_NEW_SESSION.md` | Governance | When onboarding rules change |
| `PROJECT_STATE.md` | All agents | On any project change |
| `kb/DECISION_LOG.md` | All agents | On new decisions |
| `kb/CURRENT_TOOLCHAIN.md` | Discoverers | When toolchain changes |
| `kb/PHASE_STATUS.md` | All agents | On phase transitions |
| `kb/SESSION_LOG.md` | All agents | End of every session |
| `kb/AGENT_START_HERE.md` | Governance | When onboarding rules change |
| `kb/TOKEN_SAVIOR_WORKFLOW.md` | All agents | As token efficiency evolves |
| `kb/PROJECT_GOVERNANCE.md` | Governance | When governance rules change |
| `kb/PHASE_CHECKLIST.md` | All agents | When phases are added/completed |
| `reports/*` | Per-phase agents | At phase boundaries |

---

## Conflict Resolution

1. If KB file contents contradict scanned reality, **reality wins**. Update the KB.
2. If two KB files contradict, **PROJECT_STATE.md is authoritative**.
3. If a decision is revisited, append a new superseding DECISION-XXX to DECISION_LOG.md.
