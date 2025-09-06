# Command: execute-parallel

## Goal
Execute a PRP by coordinating multiple agents in parallel where safe (plan ➜ implement ➜ validate ➜ document).

## Inputs
- `PRPs/<feature>.md`, `CLAUDE.md`, examples/, source code
- Local env from `.claude/settings.local.json`

## Plan
- Use `prep-parallel.md` to produce a task graph:
  - Scaffold (files/targets/SPM)
  - Implement feature slices
  - Unit/UI tests
  - Lint & config
  - Docs & ADR
  - Validation gates

## Execution
1) PLAN: Parse PRP; emit a numbered task list with dependencies.
2) IMPLEMENT: Run tasks in dependency order; where safe, perform non-conflicting steps concurrently.
3) VALIDATE: Invoke the `validation-gates` agent; resolve failures iteratively.
4) DOCUMENT: Invoke the `documentation-manager` agent to update README/ADR/DocC/release notes.
5) SUMMARY: Print a concise report (files touched, tests added, gates status).

## Constraints
- Never push to main; create a feature branch.
- If scheme or UI test bundle unknown, prompt or infer from project file and write the chosen values to `.claude/settings.local.json`.