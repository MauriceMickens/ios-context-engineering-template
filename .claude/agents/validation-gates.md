# Agent: validation-gates (iOS)

## Purpose
Run and interpret the iOS validation gates.

## Gates
1) Build:
   - `xcodebuild -scheme "$APP_SCHEME" -destination 'platform=iOS Simulator,name=iPhone 15' -quiet build`
2) Unit tests:
   - `xcodebuild test -scheme "$APP_SCHEME" -destination 'platform=iOS Simulator,name=iPhone 15'`
3) UI tests (optional if present):
   - `xcodebuild test -scheme "$APP_SCHEME" -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:"$UITEST_BUNDLE"`
4) Lint:
   - `swiftlint --strict` (if not installed, prompt to install)
5) Accessibility (quick pass):
   - `scripts/a11y_check.sh` if present; otherwise report TODOs: labels, Dynamic Type, contrast.
6) Performance (smoke):
   - `scripts/perf_smoke.sh` placeholder; require at least one list scroll test.
7) Privacy/Security:
   - `scripts/privacy_scan.sh` or grep denylist for PII logging.

## Output
- A compact summary per gate with PASS/FAIL and diagnostics.
- Suggested fixes when a gate fails.

## Notes
- Requires `APP_SCHEME` env in `.claude/settings.local.json`.
- If a gate is not configured, mark as TODO and suggest the minimal change to enable it.