# Command: generate-prp

## Goal
Transform `INITIAL.md` into a concrete PRP for iOS.

## Steps
1. Parse problem/goals/non-goals, devices, KPIs
2. Extract user stories, UX states, data contracts, telemetry
3. Define validation gates (build/test/lint/a11y/perf/privacy)
4. Emit PRP at `PRPs/<feature>.md` using `PRPs/templates/prp_base.md`