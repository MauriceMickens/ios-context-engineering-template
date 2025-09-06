# Command: prep-parallel

## Goal
Turn a PRP into an executable task graph with dependencies and parallelism hints.

## Steps
1) Read PRP + CLAUDE.md; extract modules, files, tests, and gates.
2) Propose a DAG of tasks:
   - Scaffold (folders/files/SPM)
   - Domain models
   - ViewModels / Views
   - Integration points (Repository/DataSources)
   - Unit tests, then UI tests
   - Lint/Config updates
   - Validation gates
   - Docs/ADR
3) Mark tasks as:
   - [P] parallel-safe
   - [S] sequential (blocked)
4) Output a checklist with IDs, dependencies, and expected artifacts.