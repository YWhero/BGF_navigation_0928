#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
# Starting a second controller for the same physical motors is not valid.
if docker ps --format '{{.Names}}' | grep -qx ai_worker; then
  echo 'The existing ai_worker container is running. Stop its robot bringup before using this standalone deployment.' >&2
  echo 'For Mission Canvas integration, use the existing-container procedure in README.md.' >&2
  exit 1
fi
exec docker compose -f deployment/compose.yaml up --build
