# Student Schema

The student directory tracks per-student state across sessions. It is not a knowledge base — it is a state machine that records where the student is, what they've mastered, and how they learn.

## Directory layout

```
student/
  index.md        # Current status snapshot (lesson, phase, next action)
  log.md          # Append-only session record
  profile.md      # Learning style, strengths, weaknesses
  SCHEMA.md       # This file
  mastery/        # One page per concept the student has encountered
  sessions/       # One page per session
  patterns/       # Synthesized observations across sessions
```

## index.md

```markdown
# Student: <name>

## Current Status
- **Curriculum**: <which curriculum they're following>
- **Lesson**: <current lesson id>
- **Phase**: <understanding | application | synthesis>
- **Last session**: <date>
- **Next action**: <what to do when session resumes>

## Quick Profile
<2-3 sentences: learning style, strengths, current struggles>
```

Update at the end of every session and at every phase/lesson transition.

## sessions/YYYY-MM-DD.md

```markdown
---
date: <YYYY-MM-DD>
lesson: <lesson id>
phases_covered: [<phase>, ...]
duration_approx: <short | medium | long>
---

## Where we started
<State at session begin — lesson, phase, open questions from last time>

## What happened
<Narrative of the session — key moments, breakthroughs, struggles>

## Where we stopped
<Exact point — what question was open, what state was reached>

## Observations
<Anything notable about how the student learns — update profile.md if significant>
```

## mastery/\<concept\>.md

```markdown
---
concept: <name>
introduced: <lesson id>, session <date>
status: <not_seen | introduced | shaky | solid | deep>
---

<Evidence-based narrative. What happened when this concept was introduced.
How many hints needed. Any regressions. When to revisit.>
```

### Status levels

- **not_seen**: concept exists in knowledge wiki but student hasn't encountered it
- **introduced**: student has seen it but hasn't demonstrated understanding
- **shaky**: got it once but evidence of fragility (e.g., forgot it later, or needed hints)
- **solid**: demonstrated correctly in multiple contexts without hints
- **deep**: can explain why, predict edge cases, or teach it back

## patterns/\<name\>.md

```markdown
---
pattern: <name>
evidence: [<session date>, ...]
---

<What you've noticed across sessions. This is synthesis, not raw data.
Example: "Tends to jump to code before understanding the concept — has caused confusion in lessons 1, 3, and 5.
Likely a rush-to-results habit rather than a conceptual gap.">
```

Only create pattern pages when you see the same thing happen 2+ times across sessions.

## Workflows

### Session start

1. Read `student/index.md` for current status
2. Read the most recent `student/sessions/*.md` for pickup context
3. Read relevant `student/mastery/*.md` pages for the current lesson's concepts
4. Read relevant `student/patterns/*.md` if they might affect this session
5. Greet the student with a brief recap

### Session end

1. Write `student/sessions/YYYY-MM-DD.md`
2. Update `student/index.md` with current status and next action
3. Update any `student/mastery/*.md` pages where status changed
4. If you noticed a recurring pattern, create or update `student/patterns/<name>.md`
5. If profile.md needs updating (new insight about learning style), update it
6. Append to `student/log.md`: date, lesson, phases covered, summary line
