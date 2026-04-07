# Tutor Schema

The tutor directory contains two things: **knowledge** (the LLM-wiki that stores structured teaching material) and **sources** (immutable reference material provided by the student or found via search).

## Directory layout

```
tutor/
  SCHEMA.md                     # This file
  knowledge/                    # LLM-wiki — agent maintained
    index.md                    # Master catalog of all knowledge pages
    log.md                      # Append-only record of ingests and lint passes
    curricula/                  # One page per tutorial/curriculum
    concepts/                   # One page per teachable concept
    lessons/                    # One page per lesson — teaching strategy
    mistakes/                   # Common mistakes, detection, hints
    connections/                # Cross-cutting synthesis pages
  sources/                      # IMMUTABLE — human curated
    notebooks/                  # Tutorial notebooks
    textbooks/                  # Excerpts, chapter notes
    papers/                     # Relevant papers
    urls.md                     # Index of online sources with descriptions
```

## concepts/\<name\>.md

```markdown
---
concept: <name>
domain: <subject area>
introduced_in: <lesson id>
prerequisites: [<concept>, ...]
leads_to: [<concept>, ...]
---

## What it is
<Plain language explanation, as you'd say it to a student>

## Why it matters
<Motivation — why this concept is important in context>

## Common misunderstandings
- <misconception>: <why students think this, and what to ask to shake it loose>

## Key questions to ask
- Phase understanding: "<question>"
- Phase application: "<question>"
- Phase synthesis: "<question>"

## Connections
- <Link to related concept page and why they connect>
```

## curricula/\<name\>.md

```markdown
---
curriculum: <name>
author: <author>
url: <url if online>
total_lessons: <N>
topics_covered: [<topic>, ...]
---

## Overview
<What this curriculum teaches, who it's for, how it's structured>

## Lesson map
| # | Title | Concepts | Maps to lessons/ page |
|---|-------|----------|-----------------------|

## Unique strengths
<What this curriculum does that others don't>

## Gaps
<What this curriculum doesn't cover that other sources fill>
```

## lessons/\<id\>.md

```markdown
---
lesson: <id>                # e.g., "python_basics_01", "calc_03"
title: <name>
source_curriculum: <curriculum name>
new_concepts: [<concept>, ...]
builds_on: [<concept>, ...]
equivalent_lessons: [<lesson id>, ...]  # same topic in other curricula
---

## Teaching strategy
<How to guide a student through this lesson — ordering, pacing, what to emphasize>

## Phase transitions
- understanding -> application: <what the student must demonstrate>
- application -> synthesis: <what the student must demonstrate>
- synthesis -> done: <what the student must demonstrate>

## Tricky spots
<Where students typically get stuck and how to unstick them>

## Reference solution
<If applicable — never show to student unprompted>

## Verification criteria
<How to confirm the student has truly grasped this lesson>
```

## mistakes/\<name\>.md

```markdown
---
mistake: <short name>
appears_in: [<lesson id>, ...]
severity: <conceptual | mechanical | subtle>
---

## What it looks like
<How to detect it in student work or explanation>

## Why students make it
<Root cause — not just the symptom>

## Socratic response
<Questions to ask, NOT the answer. Max 3 escalating hints.>
1. "<gentle nudge>"
2. "<more specific hint>"
3. "<targeted explanation — use only after hints 1-2 fail>"

## Related mistakes
- <Link to related mistake page>
```

## connections/\<name\>.md

```markdown
---
connection: <name>
links: [<concept>, <concept>, ...]
---

<Synthesis — how these concepts relate, when to bring up the connection,
what question reveals the link to a student>
```

## Ingest workflow

When a new source is added to `tutor/sources/`:

1. Read the source completely
2. Identify concepts, techniques, common mistakes, and cross-references
3. For each concept: create or update `tutor/knowledge/concepts/<name>.md`
4. For each lesson: create or update `tutor/knowledge/lessons/<curriculum>_<NN>.md` and `tutor/knowledge/curricula/<name>.md`
5. For each mistake pattern: create or update `tutor/knowledge/mistakes/<name>.md`
6. If two or more concepts connect non-obviously: create `tutor/knowledge/connections/<name>.md`
7. Update `tutor/knowledge/index.md` with new/changed pages
8. Append to `tutor/knowledge/log.md`: date, source, pages created/updated

## Lint workflow

Run periodically or when asked:

1. Check every concept page: are prerequisites and leads_to links still valid?
2. Check every lesson page: do new_concepts and builds_on match the concept pages?
3. Check for orphan concepts (not referenced by any lesson)
4. Check for missing connections (concepts that co-occur in mistakes but have no connection page)
5. Report findings, then fix them
