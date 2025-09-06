#!/bin/bash
set -e

echo "🔍 Running accessibility checks..."

# Check for accessibility labels in SwiftUI views
echo "Checking for accessibility labels..."
if ! grep -r "accessibilityLabel\|accessibilityHint\|accessibilityValue" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "⚠️  Warning: No accessibility labels found in SwiftUI views"
fi

# Check for VoiceOver support indicators
if grep -r "accessibilityElement\|accessibilityTraits" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "✅ Found accessibility elements configuration"
else
    echo "⚠️  Warning: Consider adding accessibility traits for complex views"
fi

# Check for Dynamic Type support
if grep -r "\.font(\|Font\." context-eng-template/ --include="*.swift" > /dev/null; then
    echo "✅ Found font configurations (verify Dynamic Type support)"
else
    echo "ℹ️  Info: No custom fonts detected"
fi

echo "✅ Accessibility check complete"