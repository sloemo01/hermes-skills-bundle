---
name: interactive-prompt-analyzer
description: "Use when user gives a prompt — analyzes intent, suggests structured options, and always includes a custom 'add your own' option."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [prompt-analysis, interactive, decision-support, clarification]
    related_skills: []

---

# Interactive Prompt Analyzer

## Overview

This skill provides a structured way to analyze user prompts, identify ambiguity, and present clear options with an always-available "add your own" escape hatch. It turns vague requests into actionable choices.

## When to Use

- User gives a vague or multi-interpretable prompt
- User asks "what should I do?" or "help me decide"
- Task has multiple valid approaches with trade-offs
- You need user buy-in before executing a complex workflow
- User might not know all available options

## Core Pattern

### 1. Analyze the Prompt

Extract:
- **Explicit goals** (what they said)
- **Implicit needs** (what they likely need but didn't say)
- **Constraints** (budget, time, tools, platform)
- **Ambiguities** (what could mean multiple things)

### 2. Generate Options

Create 3-4 structured options covering:
- **Recommended** (best practice / most common)
- **Alternative** (different approach, different trade-off)
- **Minimal** (quickest / least effort)
- **Comprehensive** (most thorough / highest effort)

### 3. Always Include "Add Your Own"

```markdown
**Option 5: Custom** — Describe your own approach or combine elements above
```

## Implementation

### Using the `clarify` Tool (Recommended)

```python
# Single choice with custom option
clarify(
    question="How should we approach this research task?",
    choices=[
        "Deep research (10+ tabs, multiple sources, 30+ min)",
        "Quick scan (3-5 tabs, key sources only, 10 min)",
        "Targeted search (specific question, 1-2 sources, 5 min)",
    ]
)
# User can pick 1-4 or type their own
```

### For Complex Multi-Decision Workflows

```python
# Step 1: Scope
clarify(
    question="What's the scope of this research?",
    choices=[
        "Single person/company",
        "Market/industry landscape",
        "Technical comparison (tools, frameworks)",
        "Hiring/competitive intelligence",
    ]
)

# Step 2: Depth
clarify(
    question="How deep should we go?",
    choices=[
        "Surface (public profiles, 1-2 sources)",
        "Standard (cross-reference 3-5 sources)",
        "Deep (10+ tabs, OSINT methodology, case studies)",
    ]
)

# Step 3: Output format
clarify(
    question="What output format do you need?",
    choices=[
        "Structured dossier (markdown/JSON)",
        "Executive summary (bullet points)",
        "Raw data dump (all snapshots + links)",
        "Actionable recommendations (next steps)",
    ]
)
```

## Decision Framework

### When to Offer Options vs. Just Do It

| Situation | Approach |
|-----------|----------|
| Clear, unambiguous, low-risk | Just execute |
| Multiple valid approaches | Offer options |
| High stakes / irreversible | Offer options + confirm |
| User learning / exploring | Offer options + explain trade-offs |
| Time-critical | Recommend one + "or tell me otherwise" |

### Option Quality Checklist

- [ ] Each option is **mutually exclusive** (pick one)
- [ ] Options cover **meaningfully different** approaches
- [ ] Trade-offs are **explicit** (time vs. depth, cost vs. quality)
- [ ] **Recommended** option is labeled and explained
- [ ] "Custom" option is **always last** and clearly labeled
- [ ] No more than **4 structured options** + custom

## Example: Research Request

**User**: "Research AI agent frameworks"

**Analysis**:
- Ambiguous: "research" could mean survey, comparison, deep dive, code review
- Ambiguous: "frameworks" — LangGraph, AutoGen, CrewAI, custom, orchestration?
- No scope: one framework vs. all? Production vs. prototype?

**Options Presented**:

```
I can approach this several ways:

**Option 1: Framework Comparison Matrix** (Recommended)
- Compare LangGraph, AutoGen, CrewAI, OpenAI Swarm on: architecture, state mgmt, tooling, deployment, learning curve
- Output: Markdown table + recommendation for your use case
- Time: ~15 min via deep-web-research

**Option 2: Production Readiness Deep Dive**
- Pick ONE framework, go deep: scaling patterns, observability, error handling, team adoption
- Output: Technical dossier with code patterns
- Time: ~30 min

**Option 3: Quick Landscape Survey**
- 20 frameworks categorized: orchestration, multi-agent, RAG, code-gen, no-code
- Output: Categorized list with GitHub stars, last commit, community size
- Time: ~10 min

**Option 4: Hands-On Spike**
- Build a minimal "hello world" agent in 2-3 frameworks
- Output: Working code + friction notes
- Time: ~45 min (requires code execution)

**Option 5: Custom** — Tell me your specific angle (e.g., "compare only for RAG pipelines" or "focus on Python async frameworks")
```

## Anti-Patterns to Avoid

- ❌ **False choices** — options that lead to same outcome
- ❌ **Too many options** — decision paralysis (max 4 + custom)
- ❌ **Jargon-heavy options** — user can't evaluate trade-offs
- ❌ **Missing "obvious" option** — always include the standard approach
- ❌ **No recommendation** — user wants guidance, not a menu
- ❌ **Forgetting custom** — users often have hybrid needs

## Integration with Other Skills

This skill pairs well with:
- `deep-web-research` — for option 1/2 execution
- `job-search-automation` — when user says "find me a job"
- `plan` — when user wants a multi-step plan after choosing
- `research-automation-bundle` — for complex multi-skill workflows

## Quick Reference

```bash
# Minimal usage pattern
clarify(
    question="[One clear question]",
    choices=["Option A", "Option B", "Option C"]
)
# User sees: 1) Option A  2) Option B  3) Option C  4) Other (type your answer)
```

The `clarify` tool automatically adds "Other (type your answer)" — no extra code needed.