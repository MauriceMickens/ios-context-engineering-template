# iOS Context Engineering Template

A production-ready SwiftUI iOS template implementing **context engineering** principles for building maintainable, testable, and scalable mobile applications.

## 🎯 What is Context Engineering?

Context engineering is a methodology that uses Product Requirements Prompts (PRPs), validation loops, and context-driven scaffolding to deliver consistent, high-quality software features. This template provides a complete iOS implementation with modern SwiftUI patterns, MVVM architecture, and comprehensive validation gates.

## ✨ Features

### 🏗️ Architecture
- **MVVM Pattern** with protocol-based ViewModels
- **@Observable** modern SwiftUI state management
- **Structured Concurrency** with proper Task cancellation
- **Dependency Injection** via initializers
- **Protocol Seams** for comprehensive testing

### 🛠️ Development Workflow
- **Context Engineering Commands**: `generate-prp`, `execute-prp`, `primer`
- **Parallel Execution**: Advanced task coordination with `execute-parallel`
- **Validation Gates**: Build, test, lint, accessibility, performance, privacy
- **GitHub Integration**: Automated issue fixing with `fix-github-issue`

### 🧪 Quality Assurance
- **SwiftLint** strict configuration with zero warnings policy
- **Comprehensive Testing** patterns (Unit + UI + Integration)
- **Accessibility** validation with VoiceOver support
- **Performance** monitoring with 70%+ code coverage target
- **Privacy/Security** scanning and validation

### 🚀 DevOps & CI/CD
- **GitHub Actions** CI pipeline
- **Fastlane** automation lanes
- **Validation Scripts** for accessibility, performance, privacy
- **Modern Tooling**: Swift Package Manager, DocC documentation

## 🚀 Quick Start

### Prerequisites
- **Xcode 15+** with iOS 16+ deployment target
- **Swift 5.9+**
- **SwiftLint**: `brew install swiftlint`

### Setup
1. **Clone the template:**
   ```bash
   git clone https://github.com/MauriceMickens/ios-context-engineering-template.git
   cd ios-context-engineering-template
   ```

2. **Open in Xcode:**
   ```bash
   open context-eng-template.xcodeproj
   ```

3. **Install dependencies:**
   ```bash
   # Install SwiftLint if not already installed
   brew install swiftlint
   
   # Verify setup
   swiftlint --version
   ```

4. **Run validation:**
   ```bash
   # Run all validation gates
   fastlane validate
   
   # Or individual gates
   ./scripts/a11y_check.sh
   ./scripts/perf_smoke.sh
   ./scripts/privacy_scan.sh
   ```

## 📱 Context Engineering Workflow

### 1. **Author Your Feature**
Edit `INITIAL.md` with your feature requirements:
```markdown
## Problem
Users need to view a list of trending movies

## Goals
- Display movies in a scrollable list
- Show movie ratings and posters
- Handle loading and error states
```

### 2. **Generate PRP**
Transform requirements into a structured Product Requirements Prompt:
```bash
# Use the generate-prp command in Claude Code
# This creates PRPs/<feature>.md with full implementation plan
```

### 3. **Execute Implementation**
Run the structured implementation with validation:
```bash
# Use execute-prp command for guided implementation
# Includes: PLAN → IMPLEMENT → VALIDATE → DOCUMENT
```

### 4. **Validate & Deploy**
All validation gates must pass:
- ✅ **Build**: Clean compilation
- ✅ **Tests**: Unit + UI tests passing
- ✅ **Lint**: Zero SwiftLint warnings
- ✅ **Accessibility**: Labels and VoiceOver support
- ✅ **Performance**: Smooth scrolling, memory usage
- ✅ **Privacy**: No PII logging, proper permissions

## 🏛️ Project Structure

```
ios-context-engineering-template/
├── 📁 .claude/                          # Context engineering commands & agents
│   ├── agents/                          # Documentation & validation agents
│   ├── commands/                        # PRP workflow commands
│   └── hooks/                           # Automation hooks
├── 📁 .github/workflows/                # CI/CD pipeline
├── 📁 PRPs/                            # Product Requirements Prompts
├── 📁 examples/                        # Code patterns & examples
├── 📁 scripts/                         # Validation scripts
├── 📁 context-eng-template/            # Main iOS app
├── 📁 context-eng-templateTests/       # Unit tests
├── 📁 context-eng-templateUITests/     # UI tests
├── 📄 CLAUDE.md                        # Project operating system
├── 📄 INITIAL.md                       # Feature request template
└── 📄 .swiftlint.yml                   # Strict linting rules
```

## 💡 Example: Movie List Feature

### ViewModel Pattern
```swift
@Observable
class RealMovieListViewModel: MovieListViewModel {
    private(set) var movies: [Movie] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    func send(_ action: Action) {
        switch action {
        case .onAppear:
            send(.loadData)
        case .loadData:
            Task { await loadMovies() }
        }
    }
}
```

### SwiftUI View
```swift
struct MovieListView: View {
    @State var viewModel: MovieListViewModel

    var body: some View {
        NavigationStack {
            // State-driven UI with proper accessibility
        }
        .task { viewModel.send(.onAppear) }
    }
}
```

## 🧪 Testing Strategy

### Unit Tests
- **ViewModels**: Test all actions and state transitions
- **Use Cases**: Test business logic in isolation
- **Repositories**: Test data layer with mock services

### UI Tests
- **User Journeys**: Critical path automation
- **Accessibility**: VoiceOver navigation
- **Error Handling**: Network failures and edge cases

### Integration Tests
- **End-to-End**: Real network calls with test data
- **Performance**: Memory usage and scroll performance

## 🛡️ Validation Gates

### Build Gate
```bash
xcodebuild -scheme context-eng-template -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### Test Gate
```bash
xcodebuild test -scheme context-eng-template -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Lint Gate
```bash
swiftlint --strict  # Zero warnings policy
```

### Accessibility Gate
```bash
./scripts/a11y_check.sh  # Validates labels, Dynamic Type, VoiceOver
```

### Performance Gate
```bash
./scripts/perf_smoke.sh  # Checks for blocking calls, retain cycles
```

### Privacy Gate
```bash
./scripts/privacy_scan.sh  # Scans for PII logging, hardcoded secrets
```

## 🎨 Code Style Guide

### Swift Conventions
- **Structs preferred** over classes for data types
- **@MainActor** on all UI-related code
- **Protocol seams** for testability
- **Extensions** organized by feature: `Type+Feature.swift`

### Architecture Principles
- **No singletons** - use dependency injection
- **Immutability first** - minimize mutable state  
- **Async boundaries** in Use Cases, not ViewModels
- **Error handling** with typed Result types

### SwiftUI Patterns
- **@State** for ViewModel storage (not @StateObject)
- **Action-based** interactions via `send(Action)`
- **Comprehensive accessibility** labels and hints
- **Modern APIs**: NavigationStack, refreshable, task

## 🤝 Contributing

1. **Fork the repository**
2. **Create feature branch**: `git checkout -b feature/amazing-feature`
3. **Follow the context engineering workflow**:
   - Edit `INITIAL.md`
   - Run `generate-prp`
   - Run `execute-prp`
4. **Ensure all validation gates pass**
5. **Submit Pull Request**

## 📚 Resources

### Context Engineering
- **Original Concept**: [Context Engineering Introduction](https://github.com/coleam00/context-engineering-intro) by Cole Medin
- **Methodology**: Product Requirements Prompts (PRPs) and validation-driven development

### iOS Development
- **Apple Documentation**: [SwiftUI](https://developer.apple.com/swiftui/), [Swift Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- **Testing**: [XCTest](https://developer.apple.com/documentation/xctest), [UI Testing](https://developer.apple.com/documentation/xctest/user_interface_tests)
- **Accessibility**: [iOS Accessibility](https://developer.apple.com/accessibility/ios/)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

This iOS template is adapted from the excellent [Context Engineering Introduction](https://github.com/coleam00/context-engineering-intro) by [@coleam00](https://github.com/coleam00). The original work provides the foundational concepts and methodology that this iOS-specific implementation builds upon.

**Key adaptations for iOS:**
- SwiftUI + MVVM architecture patterns
- iOS-specific validation gates (accessibility, performance)
- Xcode project structure and build systems
- Swift Package Manager integration
- iOS CI/CD pipeline with GitHub Actions

---

**Built with ❤️ using Context Engineering principles**