#!/usr/bin/env bash
set -euo pipefail

TS="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
echo "$TS $*" >> .claude/usage.log