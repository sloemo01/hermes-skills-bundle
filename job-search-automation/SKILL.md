---
name: job-search-automation
description: Search job boards via Kimi WebBridge for remote AI roles.
metadata:
  version: "1.1.0"
---

# Job Search Automation with Kimi WebBridge

Use this skill when the user wants to search for jobs across multiple platforms using browser automation, especially for high-salary remote roles in AI/ML/agentic engineering.

## Platform Compatibility Matrix

| Platform | Works Well | Blockers | Notes |
|----------|------------|----------|-------|
| **LinkedIn** | ✅ Excellent | Login wall for details | Best for salary-filtered searches (`f_SB2=200000`), remote filter (`f_WT=2`), structured data extraction via snapshot. Keywords: `agentic ai engineer python remote`, `ai agent engineer python tool calling remote` |
| **Indeed (in.indeed.com)** | ✅ Excellent | Pagination handling | **Best for India-market remote roles**. High-yield searches: `agentic ai engineer remote python tool calling` (400), `ai agent engineer python function calling remote` (400), `ai workflow orchestration engineer remote python` (600), `n8n ai automation engineer remote python` (18) |
| **Glassdoor (.co.in)** | ✅ Good | Must use direct job-listing URLs | Search result pages work: `/Job/agentic-ai-engineer-jobs-SRCH_KO0,17.htm`. Filter "Remote only" (`@e24`) + "Easy Apply only" (`@e23`). 6,478 AI agent engineer jobs, 700 agentic AI jobs |
| **Naukri** | ✅ Good | Pagination | India-focused, explicit experience/location filters: `experience=0-3&location=remote`. 9,363 agentic AI, 736 automation engineer jobs |
| **Dice** | ✅ Good | Cookie consent dialog | Tech-focused, shows salary ranges, contract rates |
| **Wellfound (AngelList)** | ❌ Blocked | DataDome CAPTCHA | Cannot automate; manual search only at `wellfound.com/jobs?q=agentic+ai+engineer&remote=true` |
| **Lever** | ❌ Broken | Search URL 404s | `jobs.lever.co/search?q=` doesn't work |
| **Greenhouse** | ❌ Broken | Search URL 404s | `boards.greenhouse.io/search/jobs?q=` doesn't work |

## Effective Search Patterns for Agentic AI Roles

### LinkedIn (Best for High-Salary Remote)
```
https://www.linkedin.com/jobs/search/?keywords=agentic%20AI%20architect%20remote&location=Remote&f_WT=2&f_SB2=200000
```
- `f_WT=2` = Remote
- `f_SB2=200000` = $200K+ base salary filter
- Keywords: `agentic AI architect`, `agentic AI engineer`, `principal AI architect`, `LLM agent architect`

### Indeed (Best for India-Based Remote Roles)
```
https://in.indeed.com/jobs?q=agentic+AI+engineer+remote+python+tool+calling&location=Remote
```
- Use `in.indeed.com` for India market
- **High-yield keyword combos for agentic profiles:**
  - `agentic ai engineer remote python tool calling` (400 results)
  - `ai agent engineer python function calling remote` (400 results)
  - `n8n ai automation engineer remote python` (18 results - niche but high match)
  - `ai workflow orchestration engineer remote python` (600 results)
  - `llm integration engineer remote python rag` (varies)
- `fromage=7` = last 7 days filter

### Dice
```
https://www.dice.com/jobs?q=agentic%20AI%20engineer%20remote&location=Remote
```
- Shows contract rates ($70-75/hr) and full-time salaries

### Glassdoor (Use Direct Job URLs)
```
https://www.glassdoor.co.in/Job/agentic-ai-engineer-jobs-SRCH_KO0,17.htm?clickSource=searchBox
https://www.glassdoor.co.in/Job/ai-agent-engineer-jobs-SRCH_KO0,17.htm?clickSource=searchBox
```
- Direct search result pages work better than search URLs
- Filter: "Remote only" button (`@e24` in snapshot)

### Naukri (India-Focused)
```
https://www.naukri.com/agentic-ai-engineer-jobs-in-india?k=agentic%20ai%20engineer&experience=0-3&location=remote
https://www.naukri.com/ai-automation-engineer-jobs-in-india?k=ai%20automation%20engineer&experience=0-3&location=remote
```
- `experience=0-3` = 0-3 years filter
- `location=remote` = remote filter
- 9,363 agentic AI engineer jobs, 736 automation engineer jobs

### Wellfound (Manual Only - CAPTCHA Blocked)
- Cannot automate via WebBridge
- User must search manually at `https://wellfound.com/jobs?q=agentic+ai+engineer&remote=true`

## Data Extraction Patterns (Kimi WebBridge)

### LinkedIn Job Cards (snapshot + evaluate)
```javascript
// In evaluate() after snapshot shows [data-job-id] elements
var jobs = document.querySelectorAll("[data-job-id]");
Array.from(jobs).slice(0, 10).map(el => ({
  title: el.querySelector("[data-job-title]")?.textContent?.trim() || "",
  company: el.querySelector("[data-company-name]")?.textContent?.trim() || "",
  location: el.querySelector("[data-job-location]")?.textContent?.trim() || "",
  link: el.querySelector("a[href*='/jobs/view/']")?.href || "",
  salary: el.querySelector("[data-salary]")?.textContent?.trim() || ""
}))
```

### Indeed Job Cards (in.indeed.com)
- Use snapshot to find `@e` refs for job cards
- Extract via `heading` (title), `StaticText` (company, location), `link` (apply URL)
- **High-yield listings seen:** "AI Automation Engineer (LLM, n8n & Workflow Automation)" @ MIS Technologies (From ₹40K/mo, Remote), "AI Agent Engineer" @ Freshers JobSolution (₹15K-30K/mo, Remote), "Applied AI Engineer (Automation)" @ Fusemachines (Remote)

### Glassdoor Job Cards (glassdoor.co.in)
- Use snapshot to find job cards in list
- Elements: `heading` (title), company logo/name, location, salary range, "Easy Apply" badge
- **Key listings:** "Agentic AI Engineer" @ Commerce Pundit (Remote, "At least one real demonstrable agentic/LLM project you can show and walk through (link required)"), "AI Agent Engineer" @ Freshers JobSolution (Remote, ₹15K-30K/mo, "Tool & Function Integration")

### Naukri Job Cards
- Snapshot shows: job title link, company, location, salary, experience, skills tags
- Filter URL params: `experience=0-3&location=remote` works well
- **Volume:** 9,363 agentic AI engineer, 736 AI automation engineer, 11,183 LLM engineer jobs

## High-Yield Search Tabs Strategy (10 Tabs, Single Group)

When doing multi-platform job searches for agentic AI roles, open 10 tabs in a single Chrome tab group using the same session name:

| Tab | Platform | Search URL | Est. Results | Target |
|-----|----------|------------|--------------|--------|
| 1 | Indeed (India) | `in.indeed.com/jobs?q=agentic+ai+engineer+remote+python+tool+calling&location=Remote` | 400 | MIS Technologies, GenifyLeads |
| 2 | Indeed (Function Calling) | `in.indeed.com/jobs?q=ai+agent+engineer+python+function+calling+remote&location=Remote` | 400 | Freshers JobSolution, QuantumLoopAI |
| 3 | Indeed (n8n/Automation) | `in.indeed.com/jobs?q=n8n+ai+automation+engineer+remote+python&location=Remote` | 18 | MIS Technologies, n8n specialist roles |
| 4 | Indeed (Workflow Orchestration) | `in.indeed.com/jobs?q=ai+workflow+orchestration+engineer+remote+python&location=Remote` | 600 | AHL Saaf AI, Fusemachines |
| 5 | LinkedIn India | `linkedin.com/jobs/search/?keywords=agentic%20ai%20engineer%20python%20remote&location=India&f_WT=2` | 17 | Filter: Remote only |
| 6 | LinkedIn Function Calling | `linkedin.com/jobs/search/?keywords=ai%20agent%20engineer%20python%20tool%20calling%20remote&location=India&f_WT=2` | 17 | Filter: Remote only |
| 7 | Naukri Agentic | `naukri.com/agentic-ai-engineer-jobs-in-india?k=agentic%20ai%20engineer&experience=0-3&location=remote` | 9,363 | 0-3 yrs, Remote |
| 8 | Naukri Automation | `naukri.com/ai-automation-engineer-jobs-in-india?k=ai%20automation%20engineer&experience=0-3&location=remote` | 736 | 0-3 yrs, Remote |
| 9 | Naukri LLM | `naukri.com/llm-engineer-jobs-in-india?k=llm%20engineer&experience=0-3&location=remote` | 11,183 | 0-3 yrs, Remote |
| 10 | Wellfound | `wellfound.com/jobs?q=agentic+ai+engineer&remote=true` | Manual only | CAPTCHA blocked |

### Tab Group Workflow (Kimi WebBridge)

**Prerequisite: Start the Kimi WebBridge daemon**

**macOS / Linux:**
```bash
~/.kimi-webbridge/bin/kimi-webbridge start
```

**Windows (PowerShell):**
```powershell
& "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe" start
```

**Cross-platform (any shell):**
```bash
${HOME:-$USERPROFILE}/.kimi-webbridge/bin/kimi-webbridge${EXE:-} start
```

**All platforms (same curl commands):**
```bash
# All tabs use same session name for grouping
session="agentic-jobs-search"
group_title="Job Search - Agentic AI Engineer"

# Open all 10 tabs with newTab:true (single group)
SEARCH_URLS=(
  "https://in.indeed.com/jobs?q=agentic+ai+engineer+remote+python+tool+calling&location=Remote"
  "https://in.indeed.com/jobs?q=ai+agent+engineer+python+function+calling+remote&location=Remote"
  "https://in.indeed.com/jobs?q=n8n+ai+automation+engineer+remote+python&location=Remote"
  "https://in.indeed.com/jobs?q=ai+workflow+orchestration+engineer+remote+python&location=Remote"
  "https://www.linkedin.com/jobs/search/?keywords=agentic%20ai%20engineer%20python%20remote&location=India&f_WT=2"
  "https://www.linkedin.com/jobs/search/?keywords=ai%20agent%20engineer%20python%20tool%20calling%20remote&location=India&f_WT=2"
  "https://www.naukri.com/agentic-ai-engineer-jobs-in-india?k=agentic%20ai%20engineer&experience=0-3&location=remote"
  "https://www.naukri.com/ai-automation-engineer-jobs-in-india?k=ai%20automation%20engineer&experience=0-3&location=remote"
  "https://www.naukri.com/llm-engineer-jobs-in-india?k=llm%20engineer&experience=0-3&location=remote"
  "https://wellfound.com/jobs?q=agentic+ai+engineer&remote=true"
)

for url in "${SEARCH_URLS[@]}"; do
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"navigate\",\"args\":{\"url\":\"$url\",\"newTab\":true,\"group_title\":\"$group_title\"},\"session\":\"$session\"}"
done
```

**Windows (PowerShell):**
```powershell
# Open all 10 tabs - create temp JSON for each
$urls = @(
  "https://in.indeed.com/jobs?q=agentic+ai+engineer+remote+python+tool+calling&location=Remote"
  "https://in.indeed.com/jobs?q=ai+agent+engineer+python+function+calling+remote&location=Remote"
  "https://in.indeed.com/jobs?q=n8n+ai+automation+engineer+remote+python&location=Remote"
  "https://in.indeed.com/jobs?q=ai+workflow+orchestration+engineer+remote+python&location=Remote"
  "https://www.linkedin.com/jobs/search/?keywords=agentic%20ai%20engineer%20python%20remote&location=India&f_WT=2"
  "https://www.linkedin.com/jobs/search/?keywords=ai%20agent%20engineer%20python%20tool%20calling%20remote&location=India&f_WT=2"
  "https://www.naukri.com/agentic-ai-engineer-jobs-in-india?k=agentic%20ai%20engineer&experience=0-3&location=remote"
  "https://www.naukri.com/ai-automation-engineer-jobs-in-india?k=ai%20automation%20engineer&experience=0-3&location=remote"
  "https://www.naukri.com/llm-engineer-jobs-in-india?k=llm%20engineer&experience=0-3&location=remote"
  "https://wellfound.com/jobs?q=agentic+ai+engineer&remote=true"
)

$session = "agentic-jobs-search"
$group_title = "Job Search - Agentic AI Engineer"

foreach ($url in $urls) {
  $body = "{\"action\":\"navigate\",\"args\":{\"url\":\"$url\",\"newTab\":true,\"group_title\":\"$group_title\"},\"session\":\"$session\"}"
  $body | Set-Content -Path "$env:TEMP\kimi-nav.json" -Encoding UTF8
  curl.exe -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" --data-binary @"$env:TEMP\kimi-nav.json"
}
```

**Extract from each tab (all platforms):**
```bash
for i in {0..9}; do
  # Find the tab by exact URL
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"find_tab\",\"args\":{\"url\":\"${SEARCH_URLS[i]}\"},\"session\":\"$session\"}"
  
  # Get full accessibility tree
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"snapshot\",\"args\":{\"full\":true},\"session\":\"$session\"}"
  
  # Run platform-specific extraction script via evaluate
  # (see references/extraction-scripts.md for JS)
done

# Cleanup: close entire tab group
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d "{\"action\":\"close_session\",\"args\":{},\"session\":\"$session\"}"
```

## High-Value Target Companies (from searches)
- **Twilio** – Sr AI Architect Conversational AI ($275K–$405K)
- **Benchling** – Agentic AI Engineer ($176K–$265K)
- **Oracle** – Principal AI/LLM Agent Architect
- **Capital One** – Senior Director AI Engineering (Agentic Platform)
- **American Express** – Senior AI Engineer Agentic AI
- **Navitus Health** – Architect Enterprise AI
- **SailPoint** – AI Workflow Architect
- **Change.org** – AI Architect

## Salary Negotiation Context (India-based, Remote US)
- Target $200K–$400K base + equity
- "Principal/Staff/Architect" titles command highest comp
- "Agentic AI" keyword still emerging – also search "LLM agent", "AI orchestration", "multi-agent systems"
- Contract roles ($70-100/hr) as bridge option