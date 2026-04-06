# Socrates

An AI agent that teaches through the Socratic method — asking questions, not giving answers. Built on the [llm-wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), it can ingest any source material and turn it into a structured teaching curriculum.

## How it works

The tutor maintains two wikis:

- **`knowledge/`** — the teaching brain. Concepts, lessons, common mistakes, and cross-references compiled from source material.
- **`student/`** — your learning history. Mastery levels, session logs, observed patterns. Persists across sessions so the tutor remembers where you left off.

Source material lives in `sources/` and is never modified by the agent.

All session-specific content (knowledge pages, student data, sources) is gitignored — the repo ships as a clean framework that generates content fresh per user.

## Getting started

### Prerequisites

- [Claude Code](https://claude.ai/claude-code) CLI

### 1. Clone and start

```bash
git clone <repo-url>
cd socrates
```

The `/socrates` command is available automatically via `.claude/commands/socrates.md` — no manual setup needed.

### 2. Start learning

> `/socrates`

The tutor asks what you want to learn. Then it:

1. **Assesses your level** — a short Socratic conversation (3-5 questions) to gauge where you are
2. **Asks for sources** — you can paste URLs to learn from, or let the tutor find material for you (or both)
3. **Searches for material** (if needed) — spawns parallel agents to find tutorials, papers, and courses matched to your level
4. **Ingests into the knowledge wiki** — parallel agents process each source into `knowledge/` (concepts, lessons, mistakes, cross-references)
5. **Builds a curriculum** — orders lessons by difficulty, starting at your level
6. **Starts teaching** — begins the first lesson in Socratic mode

If you're returning, the tutor reads your history and asks if you want to continue or learn something new.

### Adding your own sources (optional)

You can also manually add material to `sources/` and ask the tutor to ingest it:
- `sources/urls.md` — links to online tutorials, courses, documentation
- `sources/notebooks/` — Jupyter notebooks
- `sources/textbooks/` — textbook excerpts, chapter notes
- `sources/papers/` — relevant papers

## Sessions

A session is a single conversation with the tutor agent. The tutor uses the `student/` wiki to maintain continuity across sessions.

### Starting a session

Run `/socrates`. The tutor will:

1. Read `student/index.md` for your current status
2. Read your most recent session log in `student/sessions/`
3. Read relevant mastery and pattern pages
4. Ask: *"Want to pick up where we left off, or learn something new?"*

If you're brand new, it asks what you want to learn and runs the full assess → search → ingest → teach flow.

### During a session

The tutor follows a loop: **ask → wait → evaluate → respond**. It tracks your phase within each lesson and only advances when you demonstrate understanding — not when you ask to skip ahead.

You can:
- Answer with text explanations, math, pseudocode, or code
- Say "I'm stuck" to get a hint (max 2 hints before it explains)
- Say "let's experiment" to jump to trying things once your understanding is solid
- Ask "why?" about anything — the tutor loves that

### Ending a session

Say goodbye, or just stop. The tutor will:

1. Write a session page to `student/sessions/YYYY-MM-DD.md`
2. Update `student/index.md` with where you are and what to do next
3. Update mastery pages for any concepts whose status changed
4. Log any new learning patterns it noticed

If you close Claude without saying goodbye, a **Stop hook** detects the active session and blocks exit until the session is saved — so your progress is never lost.

### Continuing next time

Start a new conversation. The tutor reads the wiki and picks up exactly where you left off. You don't need to re-explain anything.

## Project structure

```
.claude/
  commands/socrates.md    # /socrates slash command
  settings.json           # Stop hook for session auto-save

knowledge/                # Teaching brain — agent maintained (gitignored)
  index.md                # Master catalog (template committed)
  log.md                  # Ingest/lint history
  curricula/              # One page per tutorial curriculum
  concepts/               # One page per teachable concept
  lessons/                # One page per lesson — teaching strategy
  mistakes/               # Common mistake patterns
  connections/            # Cross-cutting synthesis

student/                  # Student memory — agent maintained (gitignored)
  index.md                # Current status snapshot (template committed)
  log.md                  # Session history
  profile.md              # Learning style and strengths
  mastery/                # One page per encountered concept
  sessions/               # One page per session
  patterns/               # Recurring observations

sources/                  # Immutable — human curated (gitignored)
  notebooks/              # Tutorial notebooks
  textbooks/              # Excerpts, chapter notes
  papers/                 # Relevant papers
  urls.md                 # Index of online sources

AGENTS.md                 # Wiki schema — governs agent behavior
```
