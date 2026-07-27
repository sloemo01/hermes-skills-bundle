---
name: research-automation-bundle
description: "Use when you need 8 research/automation skills bundled."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [kimi-webbridge, deep-web-research, job-search, linkedin, mcp-trading, osint, polymarket, social-media-hiring]
    related_skills: [kimi-webbridge, deep-web-research, job-search-automation, linkedin-automation, mcp-trading-research, osint-person-search, polymarket, social-media-hiring-research]
---

# Research Automation Bundle

## Overview

This skill bundles 8 research and automation skills for comprehensive web research, job hunting, OSINT, and market analysis workflows.

## Included Skills

| Skill | Category | Purpose |
|-------|----------|---------|
| **kimi-webbridge** | automation | Browser automation via Kimi WebBridge daemon |
| **deep-web-research** | research | 10+ tab deep research with tab groups |
| **job-search-automation** | automation | Remote AI job board searching |
| **linkedin-automation** | automation | LinkedIn people search & filtering |
| **mcp-trading-research** | research | Free MCP servers for trading data |
| **osint-person-search** | research | Cross-platform person profile verification |
| **polymarket** | research | Prediction market queries (markets, prices, orderbooks) |
| **social-media-hiring-research** | research | AI/ML hiring posts on X/Twitter, LinkedIn |

## When to Use

- Comprehensive job search + company research workflows
- OSINT investigations combining person search + social media + trading data
- Market research combining Polymarket + MCP trading + deep web research
- Hiring landscape analysis across LinkedIn, X/Twitter, job boards

## Usage Pattern

```python
# Load all skills in sequence for a research workflow
skill_view(name="kimi-webbridge")
skill_view(name="deep-web-research")
skill_view(name="job-search-automation")
skill_view(name="linkedin-automation")
skill_view(name="mcp-trading-research")
skill_view(name="osint-person-search")
skill_view(name="polymarket")
skill_view(name="social-media-hiring-research")
```

## Workflow Examples

### Job Hunt + Company Research
1. `job-search-automation` — Find remote AI roles
2. `linkedin-automation` — Research company employees & hiring managers
3. `deep-web-research` — Deep dive on target companies
4. `social-media-hiring-research` — Check X/Twitter for hiring signals

### OSINT Investigation
1. `osint-person-search` — Cross-platform person verification
2. `kimi-webbridge` — Browser automation for evidence collection
3. `deep-web-research` — Multi-tab organized research
4. `polymarket` + `mcp-trading-research` — Market sentiment data

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
# Using $HOME (Linux/macOS) or %USERPROFILE% (Windows)
${HOME:-$USERPROFILE}/.kimi-webbridge/bin/kimi-webbridge${EXE:-} start
```

The daemon runs on `http://127.0.0.1:10086` regardless of platform.

## Regeneration

This bundle references existing skills. To update, modify the `related_skills` list in frontmatter.