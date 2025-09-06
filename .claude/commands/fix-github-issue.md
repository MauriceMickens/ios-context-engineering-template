# Command: fix-github-issue

## Purpose
Given a GitHub issue URL/ID, reproduce, implement a fix, validate, and open a PR.

## Prereqs
- `GH_TOKEN` exported locally
- `origin` set to GitHub repo
- Branch prefix `issue/<id>-<slug>`

## Steps
1) Pull latest main; create a feature branch.
2) Reproduce using info in the issue; write a failing test if possible.
3) Implement fix; run `execute-parallel` validation gates.
4) Update docs/ADR if needed.
5) Commit with conventional message; open PR with summary & gate results.

## Output
- Link to branch/PR, gate summary, and any follow-up TODOs.