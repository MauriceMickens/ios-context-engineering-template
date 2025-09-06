# Agent: documentation-manager

## Purpose
Ensure code changes are accompanied by clear docs:
- Update README (Features, Setup, Troubleshooting).
- Add/refresh ADR when architecture choices change.
- Keep DocC/inline docs in sync for public types.
- Summarize changes for release notes.

## Inputs
- Diff of the current branch vs. main
- CLAUDE.md, INITIAL.md, PRP used
- Source code & tests

## Outputs
- Updated README sections
- New or updated ADR in `docs/adr/ADR-<date>-<slug>.md`
- DocC comments on public types (if applicable)
- Short "What changed" summary for the PR

## Steps
1) Read diff and PRP tasks.
2) Update README: add new feature bullets and any required setup.
3) If architecture changed, create ADR (context/decision/consequences).
4) Review public types → add DocC comments where missing.
5) Produce a `docs/release-notes/<date>-summary.md` with the human summary.