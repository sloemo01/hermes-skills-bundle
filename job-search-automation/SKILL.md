---
name: job-search-automation
description: Search job boards via Kimi WebBridge for ANY role/keywords. Covers search patterns, query strategies, and authentication requirements across multiple platforms.
version: 1.2.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [automation, job-search, hiring, linkedin, indeed, naukri, glassdoor, dice, webbridge]
    homepage: ""
---

# Job Search Automation with Kimi WebBridge

This skill helps you search for **any job role** across multiple platforms using browser automation with Kimi WebBridge.

## When to Use

- User asks "find jobs for [ROLE]"
- User wants to search multiple job boards in parallel
- User needs market intelligence on hiring for [SKILL/DOMAIN]
- User wants to track specific companies hiring for [ROLE]

## Key Principle: User-Defined Search

**Always ask the user what role/keywords they want to search for.** The skill provides the methodology and platform patterns; the user provides the topic.

---

## Platform Compatibility Matrix

| Platform | Works Well | Blockers | Best For |
|----------|------------|----------|----------|
| **LinkedIn** | ✅ Excellent | Login wall for details | Salary-filtered searches (`f_SB2=200000`), remote filter (`f_WT=2`), structured extraction |
| **Indeed** (in.indeed.com) | ✅ Excellent | Pagination handling | **Best for India-market remote roles**. High-yield for specific tech stacks |
| **Glassdoor** (.co.in) | ✅ Good | Must use direct job-listing URLs | Direct search result pages, "Remote only" filter, "Easy Apply" filter |
| **Naukri** | ✅ Good | Pagination | India-focused, explicit experience/location filters (`experience=0-3&location=remote`) |
| **Dice** | ✅ Good | Cookie consent dialog | Tech-focused, shows salary ranges, contract rates |
| **Wellfound** | ❌ Blocked | DataDome CAPTCHA | Manual only |
| **Lever** | ❌ Broken | Search URL 404s | — |
| **Greenhouse** | ❌ Broken | Search URL 404s | — |

---

## Effective Search Patterns (Template-Based)

### LinkedIn (Best for High-Salary Remote)
```
https://www.linkedin.com/jobs/search/?keywords=[KEYWORDS]&location=[LOCATION]&f_WT=2&f_SB2=[SALARY]
```
- `f_WT=2` = Remote
- `f_SB2=200000` = $200K+ base salary filter
- Keywords: User-provided role terms

### Indeed (Best for India-Market Remote)
```
https://in.indeed.com/jobs?q=[KEYWORDS]&location=Remote
```
- Use `in.indeed.com` for India market
- `fromage=7` = last 7 days filter
- Keywords: User-provided role + tech stack terms

### Dice
```
https://www.dice.com/jobs?q=[KEYWORDS]&location=Remote
```
- Shows contract rates and full-time salaries

### Glassdoor (Use Direct Job URLs)
```
https://www.glassdoor.co.in/Job/[ROLE]-jobs-SRCH_KO0,17.htm?clickSource=searchBox
```
- Filter: "Remote only" button (`@e24` in snapshot)

### Naukri (India-Focused)
```
https://www.naukri.com/[ROLE]-jobs-in-india?k=[KEYWORDS]&experience=[0-3]&location=remote
```
- `experience=0-3` = 0-3 years filter
- `location=remote` = remote filter

### Wellfound (Manual Only - CAPTCHA Blocked)
```
https://wellfound.com/jobs?q=[KEYWORDS]&remote=true
```
- User must search manually

---

## Tab Group Workflow (Kimi WebBridge)

### macOS / Linux
```bash
# All tabs use same session name for grouping
session="[USER_DEFINED_SESSION]"
group_title="Job Search - [USER_DEFINED_ROLE]"

# Open N tabs with newTab:true (single group)
SEARCH_URLS=(
  "https://in.indeed.com/jobs?q=[KEYWORDS1]&location=Remote"
  "https://in.indeed.com/jobs?q=[KEYWORDS2]&location=Remote"
  "https://www.linkedin.com/jobs/search/?keywords=[KEYWORDS3]&location=India&f_WT=2"
  "https://www.naukri.com/[ROLE]-jobs-in-india?k=[KEYWORDS4]&experience=0-3&location=remote"
  # Add more as needed
)

for url in "${SEARCH_URLS[@]}"; do
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"navigate\",\"args\":{\"url\":\"$url\",\"newTab\":true,\"group_title\":\"$group_title\"},\"session\":\"$session\"}"
done
```

### Windows (PowerShell)
```powershell
$urls = @(
  "https://in.indeed.com/jobs?q=[KEYWORDS1]&location=Remote"
  "https://in.indeed.com/jobs?q=[KEYWORDS2]&location=Remote"
  "https://www.linkedin.com/jobs/search/?keywords=[KEYWORDS3]&location=India&f_WT=2"
  "https://www.naukri.com/[ROLE]-jobs-in-india?k=[KEYWORDS4]&experience=0-3&location=remote"
)

$session = "[USER_DEFINED_SESSION]"
$group_title = "Job Search - [USER_DEFINED_ROLE]"

foreach ($url in $urls) {
  $body = "{\"action\":\"navigate\",\"args\":{\"url\":\"$url\",\"newTab\":true,\"group_title\":\"$group_title\"},\"session\":\"$session\"}"
  $body | Set-Content -Path "$env:TEMP\kimi-nav.json" -Encoding UTF8
  curl.exe -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" --data-binary @"$env:TEMP\kimi-nav.json"
}
```

### Extract from Each Tab
```bash
for url in "${SEARCH_URLS[@]}"; do
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"find_tab\",\"args\":{\"url\":\"$url\"},\"session\":\"$session\"}"
  
  curl -s -X POST http://127.0.0.1:10086/command \
    -H 'Content-Type: application/json' \
    -d "{\"action\":\"snapshot\",\"args\":{\"full\":true},\"session\":\"$session\"}"
  
  # Run platform-specific extraction via evaluate
done

# Cleanup
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d "{\"action\":\"close_session\",\"args\":{},\"session\":\"$session\"}"
```

---

## Platform-Specific Extraction (via `evaluate`)

### LinkedIn Job Cards
```javascript
var jobs = document.querySelectorAll("[data-job-id]");
Array.from(jobs).slice(0, 20).map(el => ({
  title: el.querySelector("[data-job-title]")?.textContent?.trim() || "",
  company: el.querySelector("[data-company-name]")?.textContent?.trim() || "",
  location: el.querySelector("[data-job-location]")?.textContent?.trim() || "",
  link: el.querySelector("a[href*='/jobs/view/']")?.href || "",
  salary: el.querySelector("[data-salary]")?.textContent?.trim() || ""
}))
```

### Indeed Job Cards (in.indeed.com)
```javascript
// Use snapshot @e refs for job cards
// Extract: heading (title), StaticText (company, location), link (apply URL)
```

### Glassdoor Job Cards
```javascript
// Elements: heading (title), company logo/name, location, salary range, "Easy Apply" badge
```

### Naukri Job Cards
```javascript
// Snapshot shows: job title link, company, location, salary, experience, skills tags
// Filter URL params: experience=0-3&location=remote works well
```

---

## Keyword Strategy

### User Provides Role → Agent Generates Keywords

| User Input | Agent Should Search |
|------------|---------------------|
| "Python developer" | `python developer remote`, `python engineer remote`, `django developer remote`, `fastapi developer remote` |
| "ML engineer" | `machine learning engineer remote`, `ml engineer python remote`, `AI engineer remote`, `deep learning engineer remote` |
| "DevOps" | `devops engineer remote`, `site reliability engineer remote`, `platform engineer remote`, `kubernetes engineer remote` |
| "Data scientist" | `data scientist remote`, `data science python remote`, `analytics engineer remote`, `MLOps engineer remote` |

**Best Practice**: Combine role + tech stack + remote
- `[ROLE] remote [TECH_STACK]`
- `[ROLE] [TECH_STACK] remote python`
- `remote [ROLE] [KEY_SKILL]`

---

## Data Extraction Output Format

```json
{
  "query": "[search query used]",
  "platform": "[platform name]",
  "date_searched": "2026-07-25",
  "results": [
    {
      "title": "Job Title",
      "company": "Company Name",
      "location": "City, Country / Remote",
      "experience": "X+ years",
      "salary": "$X - $Y (if mentioned)",
      "skills": ["skill1", "skill2"],
      "apply_link": "URL or 'DM' or 'See comments'",
      "post_date": "Jul 2 / 19 hours ago",
      "job_id": "[platform-specific ID]"
    }
  ]
}
```

---

## Pitfalls & Gotchas

1. **LinkedIn blocks automation** — `event.isTrusted` errors. Manual interaction needed for CAPTCHAs/login walls. Add delays between requests.
2. **Indeed pagination** — Handle `start=10`, `start=20` etc.
3. **Glassdoor login wall** — Deep scroll triggers login. Capture first page only.
4. **Naukri rate limits** — Add delays, respect robots.txt
5. **Wellfound CAPTCHA** — Cannot automate. Manual only.
6. **Dice cookie consent** — Handle dialog before extraction.

---

## References

- `job-search-automation/references/search-urls.md` — Search URL templates
- `job-search-automation/references/extraction-scripts.md` — Platform-specific JS
- `job-search-automation/references/platform-quirks.md` — Platform-specific handling

---

## Quick Start for Agent

When user says "Find jobs for [ROLE]":

1. **Clarify** (if needed):
   - "What specific role/keywords should I search?"
   - "Any specific tech stack? (e.g., Python, React, AWS)"
   - "Location preference? (Remote, India, US, EU, etc.)"
   - "Salary minimum?"
   - "Experience level?"

2. **Build search URLs** using templates above with user's keywords

3. **Open 8-10 tabs** in single tab group via Kimi WebBridge

4. **Extract & synthesize** results across platforms

5. **Output** structured data + apply links + company names for follow-up research