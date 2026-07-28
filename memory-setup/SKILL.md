---
name: memory-setup
description: "Use when user says 'Set up my memory' — runs 5-question interactive setup and saves to persistent memory."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [memory, setup, preferences, onboarding]
    related_skills: []
---

# Memory Setup Skill

## Overview

This skill provides a guided first-time setup for new users. When triggered, it runs a 5-question interactive flow using the `clarify` tool and saves the answers to the user's persistent memory (`~/.hermes/memories/memory.md`).

## Trigger Conditions

Load this skill when the user says:
- "Set up my memory"

## Workflow

### Step 1: Announce the Setup
```
I'll ask 5 quick questions to learn your preferences. This runs once and saves forever.
```

### Step 2: Run Questions Sequentially (using `clarify` tool)

**Question 1 — Browser Automation:**
```python
clarify(
    question="What browser automation do you prefer?",
    choices=[
        "Kimi WebBridge (uses your real Chrome with your logins)",
        "Chrome CDP / Playwright (headless, no login persistence)",
        "No preference — whatever works"
    ]
)
```

**Question 2 — Research Style:**
```python
clarify(
    question="How do you like deep research done?",
    choices=[
        "Many tabs (10+) organized in named groups",
        "One focused search at a time",
        "Just give me the answer/summary"
    ]
)
```

**Question 3 — Repeat Command:**
```python
clarify(
    question="What word do you use to mean 'do it again the same way'?",
    choices=[
        "retry",
        "rerun",
        "again",
        "Other (I'll specify)"
    ]
)
```

**Question 4 — Privacy Concerns:**
```python
clarify(
    question="Any privacy/data things I should avoid?",
    choices=[
        "No public pastes (dpaste, GitHub Gists)",
        "Local-only tools, no cloud APIs",
        "Delete temp files after",
        "No strong preferences"
    ]
)
```

**Question 5 — UI Patterns:**
```python
clarify(
    question="Any UI patterns you use repeatedly?",
    choices=[
        "Preview pane for docs/social/localhost",
        "Terminal split for logs + editor",
        "Dev server on fixed port (e.g., :3000)",
        "No strong patterns"
    ]
)
```

### Step 3: Save to Memory

After all 5 answers collected, call `memory` tool with operations array:

```python
memory(
    target="memory",
    operations=[
        {"action": "add", "content": f"User prefers {browser_choice} for all browser automation — standing preference for all future sessions."},
        {"action": "add", "content": f"User prefers {research_style} research workflows. Uses \"{repeat_word}\" to request re-doing a task with the same approach."},
        {"action": "add", "content": f"User uses \"{repeat_word}\" as a command to re-do a task with the same approach (deep research, multiple tabs, Kimi WebBridge)."},
        {"action": "add", "content": f"User is privacy-conscious: {privacy_choice}. Avoids public pastes/external uploads."},
        {"action": "add", "content": f"Preview pane workflows: use open_preview(url, label) to embed web content, files, or screenshots. Patterns: {ui_patterns}."}
    ]
)
```

### Step 4: Confirm Completion

```
✅ Done! Saved to ~/.hermes/memories/memory.md. From now on I'll:
- Use [browser_choice] for all browser tasks
- Open 10+ tabs in named groups for research
- "[repeat_word]" = re-run same methodology
- Never use dpaste/public uploads
- Open preview pane for docs/localhost/social links
```

## Implementation Notes

- Each `clarify` call renders as clickable buttons in Hermes — user just clicks or types
- Questions run sequentially (one at a time) to avoid overwhelm
- Memory entries use the `§` delimiter format for proper parsing
- The `memory` tool batch operation ensures atomic save

## Testing

To test without saving, use a test profile or mock the memory tool.

## Related Skills

None — this is a standalone onboarding skill.