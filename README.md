# ⚡ Hermes Skills Bundle

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OS: Windows | macOS | Linux](https://img.shields.io/badge/OS-Windows%20%7C%20macOS%20%7C%20Linux-blue)](#)

> **9 cross-platform skills** for deep web research, OSINT, MCP server discovery, hiring analysis, and general investigation. 
> 
> Powered by **Kimi WebBridge** (controlling your *real browser* and *login sessions*) and **NVIDIA Nemotron 3 Ultra** (via NVIDIA NIM).

---

## 🚀 Getting Started

The installer handles everything automatically: downloading the daemon, cloning the skills, and verifying the setup.

### 1. Install

**Windows (PowerShell):**
```powershell
iex (irm https://raw.githubusercontent.com/sloemo01/hermes-skills-bundle/main/install.ps1 | Out-String)
```

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/sloemo01/hermes-skills-bundle/main/install.sh | bash
```

### 2. Follow the Prompts
The installer will pause and ask you to:
1. **Add your NVIDIA NIM API Key:** Go to [NVIDIA API Settings](https://build.nvidia.com/settings/api-keys), generate a key (it will start with `nvapi-`), and add it to Hermes (`Settings → Models/Providers → NVIDIA`).
2. **Install the Chrome Extension:** Add the [Kimi WebBridge Extension](https://chromewebstore.google.com/detail/kimi-webbridge/fldmhceldgbpfpkbgopacenieobmligc) and sign in.

### 3. Restart & Run
1. **Restart Hermes** (Close the app and reopen it).
2. Type: `"Set up my memory"` to configure your research preferences.
3. You're done! Start asking Hermes to do real work on the web.

---

## 🤖 What's Included? (9 Skills)

| Skill | Category | Description |
|-------|----------|-------------|
| 🌐 `kimi-webbridge` | **Core** | The engine. Lets Hermes control your real Chrome browser using your logins. |
| 🔍 `deep-web-research` | **Research** | Advanced 10+ tab methodology for deep dives on complex topics. |
| 💼 `job-search-automation` | **Automation** | Scours LinkedIn, Indeed, Glassdoor, etc., to find and extract job roles. |
| 🤝 `linkedin-automation` | **Automation** | People search, connection filters, and pagination for LinkedIn networking. |
| 🔌 `mcp-server-research` | **Research** | Finds free MCP servers for *any topic* (data, APIs, dev tools, automation). |
| 🕵️ `osint-person-search` | **OSINT** | Cross-platform person verification (scans 12+ social/public platforms). |
| 🧠 `interactive-prompt-analyzer` | **Utility** | Turns vague prompts into structured options with custom escape hatches. |
| 🏗️ `research-automation-bundle` | **Meta** | Loads all 6 research skills together as a coordinated workflow. |
| ⚙️ `memory-setup` | **Onboarding** | A guided 5-question setup to tailor Hermes to your workflow. |

---

## 💡 What can it do? (Examples)

Simply type these into Hermes to trigger autonomous browser workflows:

* 🏢 **"Find remote ML engineer roles posted today and research the top companies."**
* 🔎 **"Investigate John Doe — find all their profiles and verify their identity."**
* 🌍 **"Research renewable energy policy in the EU, open 10 tabs, and synthesize a report."**
* 🛠️ **"Find free MCP servers for crypto data and set up monitoring."**

*(Because it uses Kimi WebBridge, it bypasses CAPTCHAs and login walls by using your actual browser sessions—meaning LinkedIn, X/Twitter, and GitHub just work).*

---

## 🛠️ Manual Configuration & Troubleshooting

If you prefer to install things manually, or if you run into issues, here is the manual setup:

### Kimi WebBridge Manual Install
```bash
# macOS / Linux
curl -fsSL https://cdn.kimi.com/webbridge/install.sh | bash
~/.kimi-webbridge/bin/kimi-webbridge start

# Windows (PowerShell)
iex (irm https://cdn.kimi.com/webbridge/install.ps1 | Out-String)
& "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe" start
```

### Common Issues

| Issue | Fix |
|-------|-----|
| **"Connection refused"** | The Kimi daemon isn't running. Run the `start` command above. |
| **Buttons won't click** | Some banking/captcha sites block synthetic clicks. Manual interaction is required. |
| **Skills not loading** | Make sure you cloned the repo to `~/.hermes/skills/` and **restarted Hermes**. |

---

## 🤝 Contributing
1. Fork the repo and create a new skill folder with a `SKILL.md`.
2. Follow existing patterns (YAML frontmatter, `@e` ref usage).
3. Test on Linux, macOS, and Windows.
4. Submit a PR!

## 📄 License
This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

## 🙏 Credits
* **Kimi WebBridge** — Moonshot AI (daemon + browser extension)
* **Hermes Agent** — Nous Research (desktop app, skill system)