#!/usr/bin/env bash
# guard-destructive-ops.sh — PreToolUse safety hook for platform-services
#
# Prompts the operator before executing operations that are hard to reverse:
# force-push, hard-reset, rm -rf, --no-verify bypass, or branch/tag deletion.
# AGT-008: this file satisfies the PreToolUse safety hook requirement.

set -euo pipefail

TOOL_INPUT="${TOOL_INPUT:-}"
TOOL_NAME="${TOOL_NAME:-}"

# Patterns that warrant a confirmation prompt
DESTRUCTIVE_PATTERNS=(
  "force"
  "hard"
  "rm -rf"
  "--no-verify"
  "branch.*-[Dd]"
  "tag.*-[Dd]"
)

payload="${TOOL_INPUT} ${TOOL_NAME}"

for pattern in "${DESTRUCTIVE_PATTERNS[@]}"; do
  if echo "${payload}" | grep -qE "(^|[^a-zA-Z])${pattern}"; then
    echo "⚠  SAFETY HOOK: This operation matches a destructive pattern (${pattern})."
    echo "   Repository: platform-services"
    echo "   Tool input: ${TOOL_INPUT}"
    echo ""
    read -r -p "   Proceed? (yes/no): " answer
    if [[ "${answer}" != "yes" ]]; then
      echo "   Aborted by safety hook."
      exit 1
    fi
  fi
done

exit 0
