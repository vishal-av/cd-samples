#!/usr/bin/env bash
set -euo pipefail

# --- check for yq v4+ ---
if ! command -v yq &>/dev/null; then
  echo "ERROR: yq not found in PATH" >&2
  exit 1
fi

# --- run the deep-merge ---
# all args are YAML files in the order you want to merge
# e.g. ./deep_merge.sh base.yaml override1.yaml override2.yaml
yq eval-all 'reduce .[] as $item ({}; . *+ $item)' "$@"
