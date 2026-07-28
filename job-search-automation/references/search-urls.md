# Search URL Templates — Job Search Automation

## Template Format

Replace `[KEYWORDS]`, `[LOCATION]`, and other placeholders with user-provided values.

## LinkedIn

```bash
# Generic template
https://www.linkedin.com/jobs/search/?keywords=[KEYWORDS]&location=[LOCATION]&f_WT=[REMOTE_FILTER]&f_SB2=[SALARY_MIN]

# Examples (user fills in):
# https://www.linkedin.com/jobs/search/?keywords=python%20developer%20remote&location=Remote&f_WT=2&f_SB2=150000
# https://www.linkedin.com/jobs/search/?keywords=ml%20engineer%20remote&location=United%20States&f_WT=2
```

**Parameters:**
| Param | Meaning | Example Values |
|-------|---------|----------------|
| `keywords` | Search terms | `python developer`, `ml engineer`, `devops engineer` |
| `location` | Geographic location | `Remote`, `United States`, `India`, `London` |
| `f_WT=2` | Remote filter | `2` = Remote |
| `f_SB2=X` | Minimum base salary (USD) | `150000`, `200000`, `250000` |
| `f_TPR=r604800` | Posted within 7 days | `r604800` = last week |

## Indeed

```bash
# Generic template
https://www.indeed.com/jobs?q=[KEYWORDS]&l=[LOCATION]&fromage=[DAYS]

# Examples:
# https://www.indeed.com/jobs?q=python+developer+remote&l=Remote&fromage=7
# https://in.indeed.com/jobs?q=ml+engineer+remote&l=Remote&fromage=7
```

**Parameters:**
| Param | Meaning | Example |
|-------|---------|---------|
| `q` | Search query | `python developer remote` |
| `l` | Location | `Remote`, `United States`, `India` |
| `fromage` | Days back | `1` (24h), `7` (week), `14`, `30` |
| `radius` | Distance from location | `50`, `100` |

## Dice

```bash
# Generic template
https://www.dice.com/jobs?q=[KEYWORDS]&location=[LOCATION]

# Examples:
# https://www.dice.com/jobs?q=python+developer+remote&location=Remote
# https://www.dice.com/jobs?q=devops+engineer&location=Remote
```

## Glassdoor

```bash
# Use .co.in for India-based searches (includes remote)
# Generic template
https://www.glassdoor.co.in/Job/[ROLE]-jobs-SRCH_KO0,17.htm?clickSource=searchBox

# Examples:
# https://www.glassdoor.co.in/Job/python-developer-jobs-SRCH_KO0,17.htm
# https://www.glassdoor.co.in/Job/ml-engineer-jobs-SRCH_KO0,17.htm
```

## Naukri (India-Focused)

```bash
# Generic template
https://www.naukri.com/[ROLE]-jobs-in-india?k=[KEYWORDS]&experience=[EXP_RANGE]&location=remote

# Examples:
# https://www.naukri.com/python-developer-jobs-in-india?k=python%20developer&experience=0-5&location=remote
# https://www.naukri.com/ml-engineer-jobs-in-india?k=ml%20engineer&experience=2-7&location=remote
```

**Parameters:**
| Param | Meaning | Example |
|-------|---------|---------|
| `k` | Keywords | `python developer`, `ml engineer` |
| `experience` | Years range | `0-3`, `3-7`, `7-10` |
| `location` | Location | `remote`, `bangalore`, `mumbai` |

## Wellfound (AngelList) — Manual Only

```bash
# Cannot automate (DataDome CAPTCHA)
https://wellfound.com/jobs?q=[KEYWORDS]&remote=true

# Example:
# https://wellfound.com/jobs?q=python+developer&remote=true
```

## Lever / Greenhouse — Generally Broken

- `jobs.lever.co/search?q=` → 404
- `boards.greenhouse.io/search/jobs?q=` → 404
- Use company-specific career pages instead

---

## Search Strategy (Agent Should Generate)

When user says "Find jobs for [ROLE]":

1. **Clarify** (if needed):
   - "What specific keywords? (e.g., 'python developer', 'ml engineer', 'devops')"
   - "Location preference? (Remote, US, India, EU, etc.)"
   - "Salary minimum? (e.g., $150K, ₹30L)"
   - "Experience level? (0-3, 3-7, 7+ years)"
   - "Recency? (last 24h, 7 days, 30 days)"

2. **Build URLs** using templates above with user's keywords

3. **Open 8-10 tabs** in single tab group via Kimi WebBridge

4. **Extract & synthesize** results across platforms