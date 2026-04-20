#!/bin/bash
# claude-coacher SessionStart hook — inject the collaborator frame.
set -euo pipefail
cat > /dev/null  # drain stdin (SessionStart sends a payload)

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
FRAME_FILE="$PLUGIN_ROOT/frame.md"

if [ ! -f "$FRAME_FILE" ]; then
  exit 0
fi

python3 - "$FRAME_FILE" <<'PY'
import json, sys
with open(sys.argv[1]) as f:
    frame = f.read()
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": frame,
    },
    "systemMessage": "claude-coacher: collaborator frame loaded (use /coach to re-anchor or translate a rant)",
}))
PY
