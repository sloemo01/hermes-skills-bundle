# Hermes Research Automation Skill Bundle

> **9 cross-platform skills** for deep web research, OSINT, MCP server discovery, hiring analysis, and general investigation — all powered by **Kimi WebBridge** (your real browser, your login sessions) and **NVIDIA Nemotron 3 Ultra** (via NVIDIA NIM API).

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🔑 Required: NVIDIA NIM API Key

This bundle uses **NVIDIA Nemotron 3 Ultra** (the model behind all of this) via NVIDIA NIM. You need an API key before using the skills.

### Get Your API Key

1. Go to **https://build.nvidia.com/nvidia/nemotron-3-ultra-550b-a55b**
2. Click **"Get API Key"** (requires NVIDIA account — free to create)
3. Copy the key (starts with `nvapi-...`)

### Add to Hermes

**Option A: Hermes Desktop App (Recommended)**
1. Open Hermes → Settings (gear icon) → **Models / Providers**
2. Find **NVIDIA** provider → Paste your API key
3. Select **nvidia/nemotron-3-ultra-550b-a55b** as the model

**Option B: Environment Variable (All Platforms)**
```bash
# macOS / Linux
echo 'export NVIDIA_API_KEY="nvapi-...here"' >> ~/.zshrc
source ~/.zshrc

# Windows (PowerShell)
[Environment]::SetEnvironmentVariable("NVIDIA_API_KEY", "nvapi-your-key-here", "User")
```

**Option C: Hermes Config File**
```yaml
# ~/.hermes/config.yaml
providers:
  nvidia:
    api_key: "nvapi-your-key-here"
models:
  default: "nvidia/nemotron-3-ultra-550b-a55b"
```

> **Test it:** `curl -H "Authorization: Bearer ***" https://integrate.api.nvidia.com/v1/models` — should return model list.

---

## 🚀 Quick Install (Skills)

### Option 1: Automated (Recommended)

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/sloemo01/hermes-skills-bundle/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/sloemo01/hermes-skills-bundle/main/install.ps1 | iex
```

### Option 2: Manual Clone

**macOS / Linux:**
```bash
git clone https://github.com/sloemo01/hermes-skills-bundle ~/.hermes/skills/hermes-skills-bundle
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/sloemo01/hermes-skills-bundle "$env:USERPROFILE\.hermes\skills\hermes-skills-bundle"
```

### After Install (All Platforms)
1. Restart Hermes
2. In chat: `"Set up my memory"`  # 5 questions → saved forever
3. Use naturally: `"Research AI agent frameworks"` → auto-loads skills
4. `"retry"` → re-runs last approach

---

## 🎯 First Time? Run This Once

**In Hermes chat, say:**
> **"Set up my memory"**

I'll ask 5 quick questions (multiple choice, one at a time):
1. Browser automation? → **Kimi WebBridge** (your real Chrome, your sessions)
2. Research style? → **10+ tabs in named groups**
3. Repeat command? → **"retry"**
4. Privacy? → **No public pastes, local-only**
5. UI patterns? → **Preview pane for docs/social/localhost**

Answers save to `~/.hermes/memories/memory.md` — every future session knows your preferences.

---

## 🤖 Skills Included (9 Total)

| Skill | Category | Purpose |
|-------|----------|---------|
| `kimi-webbridge` | automation | Browser engine — your real Chrome with your logins |
| `deep-web-research` | research | 10+ tab methodology with tab groups |
| `job-search-automation` | automation | Search **any role** across 5 platforms (LinkedIn, Indeed, Glassdoor, Naukri, Dice) |
| `linkedin-automation` | automation | People search, connection filters, pagination |
| `mcp-server-research` | research | Find free MCP servers for **any topic** — data, APIs, dev tools, automation |
| `osint-person-search` | research | Cross-platform person verification (12+ platforms) |
| `interactive-prompt-analyzer` | utility | Vague prompt → structured options + custom escape hatch |
| `research-automation-bundle` | meta | Loads all 7 research skills as coordinated workflow |
| `memory-setup` | onboarding | Guided 5-question memory configuration |

---

## 🔧 Prerequisites

### Kimi WebBridge (Required for Browser Skills)

**All browser automation skills require Kimi WebBridge** — a local daemon + browser extension that lets the AI control **your real browser with your logged-in sessions**.

#### 1. Install the Daemon

**macOS / Linux:**
```bash
curl -fsSL https://cdn.kimi.com/webbridge/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://cdn.kimi.com/webbridge/install.ps1 | iex
```

#### 2. Install Browser Extension

| Browser | Method |
|---------|--------|
| **Chrome / Edge / Brave / Arc** | [Chrome Web Store → Kimi WebBridge](https://chromewebstore.google.com/detail/kimi-webbridge/fldmhceldgbpfpkbgopacenieobmligc?pli=1) → Add to Chrome |
| **Firefox** | ❌ **NOT SUPPORTED** — Kimi WebBridge only works on Chromium-based browsers |
| **Manual** | Download `.crx` from kimi.com → drag to `chrome://extensions` |

#### 3. Start the Daemon

```bash
# macOS / Linux
~/.kimi-webbridge/bin/kimi-webbridge start

# Windows (PowerShell)
& "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe" start

# Cross-platform (any shell)
${HOME:-$USERPROFILE}/.kimi-webbridge/bin/kimi-webbridge${EXE:-} start
```

#### 4. Verify

```bash
curl http://127.0.0.1:10086/status
# Should return: {"running":true,"version":"...","extension_connected":true,...}
```

#### 5. Sign In (Extension)

Click the Kimi icon in your toolbar → **Sign in with your Kimi account** (required for extension ↔ daemon connection).

> **Why Kimi WebBridge?** No headless browsers, no CAPTCHAs, no login walls. Uses **your actual Chrome** with **your sessions** — LinkedIn, X/Twitter, GitHub, Gmail all just work.

---

## 💡 Usage Examples

### Research Any Topic
```text
You: "Research AI agent frameworks"
Agent: 
  1. Loads kimi-webbridge + deep-web-research
  2. Creates tab group "AI Agent Frameworks Research"
  3. Opens 10+ tabs: GitHub (LangGraph, AutoGen, CrewAI), docs, X/Twitter, blogs, YouTube
  4. Extracts, cross-references, synthesizes
  5. Opens preview pane with structured report
```

### Find Roles for Any Position
```text
You: "Find remote ML engineer roles"
Agent:
  1. Loads job-search-automation
  2. Opens 10 tabs across Indeed, LinkedIn, Glassdoor, Naukri, Dice with search queries for "ML engineer remote"
  3. Extracts listings, companies, apply links
  4. If you want: deep-web-research on top companies
```

### Research MCP Servers for Any Topic
```text
You: "Find free MCP servers for GitHub automation"
Agent:
  1. Loads mcp-server-research (works for ANY topic)
  2. Searches mcpservers.org, GitHub, awesomeclaude.ai
  3. Returns structured list with install commands, configs, free tier limits
```

### OSINT Person Verification
```text
You: "Investigate this person — find all profiles, verify identity"
Agent:
  1. Loads osint-person-search
  2. Runs 4-phase methodology across 12+ platforms
  3. Outputs standardized dossier with confidence scoring
```

### Generic Research Workflow
```text
You: "Research renewable energy policy in EU"
Agent:
  1. deep-web-research — 10+ tab methodology on EU energy policy
  2. mcp-server-research — Find MCP servers for energy data APIs
  3. job-search-automation — Find roles in renewable energy sector
  4. linkedin-automation — Find experts/companies in space
```

---

## 🔄 Common Workflows

### Topic Research + Company Analysis
```text
You: "Find remote AI roles and research the top companies"
Agent:
  1. job-search-automation → 10 tabs across Indeed/LinkedIn/Naukri
  2. Extract company names from listings
  3. deep-web-research → 10+ tabs per company (GitHub, X, Glassdoor, blogs)
  4. linkedin-automation → Find hiring managers, 1st-degree connections
  5. Synthesize → Structured report with apply links, company intel, contacts
```

### OSINT Investigation
```text
You: "Investigate 'John Doe' — find all profiles, verify identity"
Agent:
  1. osint-person-search → Phase 1-4 methodology across 12 platforms
  2. kimi-webbridge → 11-tab deep research session (anti-detection)
  3. Cross-reference handles, document negative results
  4. Output: Standardized dossier with confidence scoring
```

### MCP Server Discovery + Domain Research
```text
You: "Find MCP servers for crypto data and set up monitoring"
Agent:
  1. mcp-server-research → Find TraderWAI, Alpaca, CCXT, Yahoo Finance MCP servers
  2. Configure alerts: "Alert me if BTC breaks $65K"
  3. deep-web-research → Market sentiment, regulatory news, docs
```

---

## 🛠 Troubleshooting

| Issue | Fix |
|-------|-----|
| Tool call fails: "connection refused" | Daemon not running → `~/.kimi-webbridge/bin/kimi-webbridge start` (idempotent) |
| `fill`/`click` ignored on banking/captcha sites | Site checks `event.isTrusted` → manual interaction needed |
| `@e` ref fails in `evaluate` with `querySelector` | `@e` refs are NOT CSS selectors — use directly in `click`/`fill`, or in `evaluate`: `document.querySelector("@e123")` |
| LinkedIn automation hits `event.isTrusted` error | Manual interaction needed for that step — snapshot after |
| X/Twitter rate limits / login wall | Use `f=live` for Latest tab, add delays, or use Google fallback |
| `find_tab` errors "no tab matching" | Use exact URL from `list_tabs` or prior `navigate` result |
| Skills not appearing in `hermes skills list` | Restart Hermes after cloning to `~/.hermes/skills/` |

---

## 📁 Repository Structure

```
hermes-skills-bundle/
├── README.md                           # This file
├── LICENSE                             # MIT License
├── install.sh                          # macOS/Linux installer
├── install.ps1                         # Windows installer
├── deep-web-research/
│   ├── SKILL.md
│   └── references/
│       ├── e-reference-guide.md
│       └── search-engine-preference.md
├── interactive-prompt-analyzer/
│   └── SKILL.md
├── job-search-automation/
│   ├── SKILL.md
│   └── references/
│       ├── extraction-scripts.md
│       ├── platform-quirks.md
│       └── search-urls.md
├── kimi-webbridge/
│   ├── SKILL.md
│   └── references/
│       └── operations.md
├── linkedin-automation/
│   └── SKILL.md
├── mcp-server-research/
│   └── SKILL.md
├── memory-setup/
│   ├── SKILL.md
│   └── references/
│       └── questions.md
├── osint-person-search/
│   ├── SKILL.md
│   └── references/
│       ├── anonymized-case-study-1.md
│       ├── anonymized-case-study-2.md
│       ├── anonymized-case-study-3.md
│       └── kimi-webbridge-deep-research.md
├── research-automation-bundle/
│   └── SKILL.md
```

---

## 📄 License

**MIT License** — see [LICENSE](LICENSE) for full text.

---

## 🤝 Contributing

1. Fork → create skill folder with `SKILL.md` + `references/`/`scripts/`
2. Follow existing patterns: frontmatter, cross-platform commands, `@e` ref usage
3. Test on Linux/macOS/Windows (daemon startup, paths)
4. PR with description of new skill / improvement

---

## 🙏 Credits

- **Kimi WebBridge** — Moonshot AI (daemon + browser extension)
- **Hermes Agent** — Nous Research (desktop app, skill system)
- **Case study data** — Public profiles only ([anonymized Berlin designer], [anonymized 1.6M IG creator + student dual identity])
- **Job search patterns** — Live searches (Indeed, LinkedIn, Naukri, Glassdoor, Dice)

---

## 📞 Support

- **Issues:** GitHub Issues on this repo
- **Kimi WebBridge help:** https://www.kimi.com/features/webbridge (EN) / https://www.kimi.com/zh-cn/features/webbridge (中文)
- **Hermes Agent:** https://hermes-agent.nousresearch.com/docs

---

**Built for researchers, OSINT analysts, job seekers, and investigators who want their AI to use the web like a human — with their browser, their sessions, their context.**