# CLAUDE.md — Project Rules & Operating System (iOS)

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Mission
Deliver production-quality iOS features via **context engineering**: PRPs (Product Requirements Prompts), validation loops, and context-driven scaffolding.

## Tech
- Swift 5.9+, SwiftUI, async/await
- iOS 16+ minimum
- Swift Package Manager only

## Architecture
- MVVM per feature (View + ViewModel + Domain + Data)
- Dependency injection via init
- Protocol seams for testing
- Extensions in `Type+Feature.swift`

## Code Style
- SwiftLint strict, zero warnings
- Structs preferred, immutability first
- `@MainActor` on UI code
- No singletons

## Async
- Structured concurrency, `Task` cancellation
- Async boundaries in UseCases
- Never block main thread

## Networking
- URLSession + Codable + typed requests
- Retries/backoff
- Caching policy per feature
- Secrets in build settings, never in repo

## Testing
- Unit + UI + snapshot (if needed)
- Coverage target 70%+
- Deterministic, no flaky async

## Accessibility
- Labels on all controls
- Dynamic Type
- VoiceOver tested

## Performance
- Cold start unchanged
- Smooth scroll ≥55 FPS
- Instruments to validate regressions

## Privacy/Security
- No PII logs
- JIT permissions
- Keychain for secrets
- Document threat model

## CI/CD
- GitHub Actions: build, lint, test
- Fastlane lanes optional

## Definition of Done
- All validation gates pass: build ✅, tests ✅, lint ✅, a11y ✅, perf ✅, privacy ✅
- Docs + ADR updated

## Build Commands

- **Build**: `xcodebuild -project context-eng-template.xcodeproj -scheme context-eng-template -configuration Debug build`
- **Test**: `xcodebuild test -project context-eng-template.xcodeproj -scheme context-eng-template -destination 'platform=iOS Simulator,name=iPhone 15'`
- **Lint**: `swiftlint`
- **Format**: `swift-format -r .`

## Project Structure

```
context-eng-template/
├── .claude/                           # Claude commands
├── PRPs/                              # Product Requirements Prompts
├── examples/                          # Code examples and patterns
├── scripts/                           # Build and validation scripts
├── context-eng-template/              # Main app target
├── context-eng-templateTests/         # Unit tests
├── context-eng-templateUITests/       # UI tests
└── context-eng-template.xcodeproj/    # Xcode project file
```

## Context Engineering Workflow

1. **Author**: Edit `INITIAL.md` with your feature request
2. **Generate**: Run `generate-prp` command to create structured PRP
3. **Execute**: Run `execute-prp` command to implement with validation
4. **Validate**: All gates must pass before completion