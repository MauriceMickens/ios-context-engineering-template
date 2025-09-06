#!/bin/bash
set -e

echo "🔒 Running privacy and security scan..."

# Check for hardcoded secrets or API keys
echo "Scanning for hardcoded secrets..."
if grep -r -i "api_key\|apikey\|secret\|token\|password" context-eng-template/ --include="*.swift" | grep -v "// TODO\|// MARK\|struct.*Token" > /dev/null; then
    echo "❌ Potential hardcoded secrets found"
    grep -r -i "api_key\|apikey\|secret\|token\|password" context-eng-template/ --include="*.swift" | grep -v "// TODO\|// MARK\|struct.*Token"
    exit 1
else
    echo "✅ No hardcoded secrets detected"
fi

# Check for PII in logs
echo "Checking for potential PII in logs..."
if grep -r "print(\|NSLog\|os_log" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "⚠️  Warning: Found logging statements - verify no PII is logged"
    grep -r "print(\|NSLog\|os_log" context-eng-template/ --include="*.swift"
fi

# Check for proper keychain usage
if grep -r "Keychain\|kSecClass" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "✅ Found keychain usage for secure storage"
fi

# Check for network security
if grep -r "http://\|HTTP://" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "❌ Found insecure HTTP URLs - use HTTPS only"
    exit 1
else
    echo "✅ No insecure HTTP URLs found"
fi

# Check for location permission patterns
if grep -r "CLLocationManager\|requestWhenInUseAuthorization" context-eng-template/ --include="*.swift" > /dev/null; then
    echo "ℹ️  Found location services - ensure proper permission handling"
fi

echo "✅ Privacy and security scan complete"