#!/bin/bash
# Silent checkpoint for tutor sessions.
# Runs as a Stop hook — captures the last teaching response
# so state survives Ctrl+C.

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty' 2>/dev/null)
[ -z "$CWD" ] && exit 0

# Only during active sessions
[ ! -f "$CWD/.tutor-session-active" ] && exit 0

MESSAGE=$(echo "$INPUT" | jq -r '.last_assistant_message // empty' 2>/dev/null)
[ -z "$MESSAGE" ] && exit 0

CURRICULUM=$(cat "$CWD/.tutor-active-curriculum" 2>/dev/null || echo "unknown")
LESSON=$(sed -n "/### $CURRICULUM/,/^### \|^## /{/\*\*Lesson\*\*/p}" "$CWD/student/index.md" 2>/dev/null | grep -oP '(?<=\*\*Lesson\*\*: ).*' || echo "unknown")
PHASE=$(sed -n "/### $CURRICULUM/,/^### \|^## /{/\*\*Phase\*\*/p}" "$CWD/student/index.md" 2>/dev/null | grep -oP '(?<=\*\*Phase\*\*: ).*' || echo "unknown")
TIMESTAMP=$(date -Iseconds)

cat > "$CWD/.tutor-state" << EOF
curriculum: $CURRICULUM
lesson: $LESSON
phase: $PHASE
timestamp: $TIMESTAMP
last_response: |
$(echo "$MESSAGE" | sed 's/^/  /')
EOF

exit 0
