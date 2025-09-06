#!/bin/bash
set -e

echo "⚡ Running performance smoke tests..."

# Check for performance anti-patterns
echo "Checking for performance anti-patterns..."

# Look for potential main thread blocking
if grep -r "Thread\.sleep\|usleep\|sleep(" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "❌ Found potential thread blocking calls"
    exit 1
fi

# Check for retain cycles in closures
if grep -r "\[weak self\]\|\[unowned self\]" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "✅ Found weak self usage in closures"
else
    echo "⚠️  Warning: Consider using [weak self] in closures to avoid retain cycles"
fi

# Check for @MainActor usage on UI code
if grep -r "@MainActor" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "✅ Found @MainActor annotations"
else
    echo "⚠️  Warning: Consider adding @MainActor to ViewModels and UI classes"
fi

# Check for task cancellation
if grep -r "task\.cancel\|Task {" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "✅ Found Task usage (verify proper cancellation)"
fi

echo "✅ Performance smoke test complete"