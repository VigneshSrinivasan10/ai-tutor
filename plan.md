# Socrates — Project Plan

## One-liner

An AI agent that teaches any subject through the Socratic method — asking questions, not giving answers — using an llm-wiki knowledge architecture.

---

## Motivation

Most tutorials are cookbooks: read this, copy that, move on. Learners finish with surface exposure but no deep understanding. The Socratic method flips this — the agent guides the student to *discover* concepts themselves. Any well-structured source material can be ingested and turned into a Socratic curriculum.

Secondary motivation: demonstrate that AI agents can *teach*, not just *answer*.

---

## Scope

### In scope
- Ingest any source material (tutorials, textbooks, notebooks, papers) into a structured knowledge wiki
- Socratic teaching agent that asks questions, gives hints, and tracks mastery
- Student state tracking (concepts mastered, current phase, mistakes)
- Cross-curriculum connections and gap analysis
- Session continuity via persistent student wiki

### Out of scope (for now)
- Multi-user / classroom mode
- Grading or certification
- Real-time collaboration
- Voice or multimedia interaction

---

## Agent Architecture

### Core Loop

```
┌─────────────────────────────────────┐
│           SOCRATIC LOOP             │
│                                     │
│  ASK → WAIT → EVALUATE → RESPOND   │
│   │                         │       │
│   │    ┌──────────────┐     │       │
│   └────│ Student State │─────┘       │
│        └──────────────┘             │
└─────────────────────────────────────┘
```

1. **ASK** — Pose a question calibrated to current phase and mastery level
2. **WAIT** — Student responds (text explanation, code, diagram, or "I'm stuck")
3. **EVALUATE** — Agent reads response, checks understanding
4. **RESPOND** — One of:
   - Correct → affirm + ask "why does this work?" or advance to next concept
   - Partially correct → acknowledge what's right, nudge toward the gap
   - Wrong → give a hint (max 2 hints, then a targeted explanation)
   - Stuck → reduce scope ("let's just think about this one part first")

### Phase Transitions

Phases advance based on demonstrated understanding, NOT student request:

- **understanding → application**: Student can explain the concept in their own words
- **application → synthesis**: Student can apply the concept correctly to a problem
- **synthesis → done**: Student can connect this concept to others and explain *why* it works, not just *how*

---

## Milestones

### M1: Core wiki architecture
- [ ] Knowledge wiki schema and page formats
- [ ] Student wiki schema and page formats
- [ ] Ingest workflow for source material
- [ ] Lint workflow for knowledge consistency

### M2: First curriculum
- [ ] Ingest one complete source into the knowledge wiki
- [ ] Full Socratic lesson flow for first curriculum
- [ ] Session start/end workflows
- [ ] Student state tracking across sessions

### M3: Multi-curriculum support
- [ ] Cross-curriculum concept mapping
- [ ] Equivalent lesson detection
- [ ] Gap analysis between curricula
- [ ] Student can switch or combine curricula

### M4: Polish and release
- [ ] Clean repo with README
- [ ] Sample dialogues as markdown
- [ ] Documentation for adding new subjects

---

## Open Questions

1. **How strict is the Socratic mode?** — Pure Socratic (never tell) is frustrating for some learners. Need an escape hatch?
2. **State persistence** — Current design uses file-based wikis. Scale considerations for many sessions?
3. **Evaluation** — How do we know the tutor actually works better than reading the source material directly?
4. **Domain adaptation** — Some subjects (math, programming) have verifiable answers. Others (literature, philosophy) are more subjective. How should the tutor adapt?
