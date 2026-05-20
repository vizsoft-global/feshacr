#!/usr/bin/env bash
# Removes stale web build outputs that can trigger:
#   FileSystemException: readInto failed ... fa-regular-400 2.ttf (errno 60)
# when Flutter hashes assets (duplicate " *.ttf" copies under build/web).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
rm -rf "$ROOT/build/web" "$ROOT/.dart_tool/flutter_build"
flutter pub get
echo "Web build cache cleared. Retry: flutter run -d chrome --release"
