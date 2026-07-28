---
name: research-automation-bundle
description: "Use when you need comprehensive research skills bundled for any topic — web research, OSINT, MCP servers, social media hiring, LinkedIn, job search."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [kimi-webbridge, deep-web-research, job-search, linkedin, mcp-servers, osint, research]
    related_skills: [kimi-webbridge, deep-web-research, job-search-automation, linkedin-automation, mcp-server-research, osint-person-search]
---

# Research Automation Bundle

## Overview

This skill bundles research and automation skills for comprehensive web research, OSINT, and domain-specific analysis workflows — for **any topic the user wants to research**.

## Included Skills

| Skill | Category | Purpose |
|-------|----------|---------|
| **kimi-webbridge** | automation | Browser automation via Kimi WebBridge daemon |
| **deep-web-research** | research | 10+ tab deep research with tab groups |
| **job-search-automation** | automation | Search any role across 5 platforms (LinkedIn, Indeed, Glassdoor, Naukri, Dice) |
| **linkedin-automation** | automation | LinkedIn people search & filtering |
| **mcp-server-research** | research | Find free MCP servers for **any topic** — data, APIs, dev tools, automation |
| **osint-person-search** | research | Cross-platform person profile verification (12+ platforms) |

## When to Use

- User wants to research **any topic** comprehensively
- Job search + company research workflows
- OSINT investigations combining person search + social media + domain data
- Market research combining deep web + MCP servers + social signals
- Hiring landscape analysis across LinkedIn, X/Twitter, job boards

## Usage Pattern

```python
# Load all skills in sequence for a research workflow
skill_view(name="kimi-webbridge")
skill_view(name="deep-web-research")
skill_view(name="job-search-automation")
skill_view(name="linkedin-automation")
skill_view(name="mcp-server-research")
skill_view(name="osint-person-search")
```

## Workflow Examples

### Job Hunt + Company Research
1. `job-search-automation` — Find remote roles for [USER'S TOPIC]
2. `linkedin-automation` — Research company employees & hiring managers
3. `deep-web-research` — Deep dive on target companies

### OSINT Investigation
1. `osint-person-search` — Cross-platform person verification
2. `kimi-webbridge` — Browser automation for evidence collection
3. `deep-web-research` — Multi-tab organized research

### MCP Server Discovery + Domain Research
1. `mcp-server-research` — Find MCP servers for [USER'S TOPIC]
2. `deep-web-research` — Market sentiment, regulatory news, docs

### Generic Research
```
You: "Research renewable energy policy in EU"
Agent:
  1. deep-web-research — 10+ tab methodology on EU energy policy
  2. mcp-server-research — Find MCP servers for energy data APIs
  3. job-search-automation — Find roles in renewable energy sector
  4. linkedin-automation — Find experts/companies in space
```

## Kimi WebBridge Daemon

All browser automation requires the Kimi WebBridge daemon running at `http://127.0.0.1:10086`.

**macOS / Linux:**
```bash
~/.kimi-webbridge/bin/kimi-webbridge start
```

**Windows (PowerShell):**
```powershell
& "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe" start
```

**Cross-platform (any shell with HOME/USERPROFILE):**
```bash
${HOME:-$USERPROFILE}/.kimi-webbridge/bin/kimi-webbridge${EXE:-} start
```

The daemon runs on `http://127.0.0.1:10086` regardless of platform.

---

## Key Principle: User-Defined Topics

**Every skill in this bundle accepts user-specified topics.** The agent should always ask or infer:

> "What do you want to research / search for?"

Then pass that topic to each skill's methodology. No hardcoded topics.