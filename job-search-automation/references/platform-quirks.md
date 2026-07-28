# Platform Quirks Reference — Job Search Automation

## LinkedIn
- **Salary filter**: `f_SB2=200000` for $200K+ base
- **Remote filter**: `f_WT=2`
- **Keywords**: User-provided role terms + tech stack
- **Login wall**: Job cards visible without auth; detail pages require login
- **Easy Apply filter**: Shows only jobs you can apply to without leaving LinkedIn
- **Pagination**: Page parameter `start=` (0, 25, 50...)

## Indeed
- **Recency filter**: `fromage=7` (7 days), `fromage=1` (24h)
- **Remote**: `l=Remote` or `l=United+States` + remote checkbox
- **Salary estimates**: Often shown in listing cards as "Estimated: $X–$Y"
- **Pagination**: `start=` parameter (0, 10, 20...)
- **Sponsored jobs**: Mixed in; check for "Sponsored" label
- **Use `in.indeed.com` for India market** — better for India-based remote roles

## Dice
- **Cookie consent**: Must click "Allow all" (`@e2` in snapshot) before content loads
- **Contract rates**: Shown as "$70-75/hr" — multiply by 2080 for annualized
- **Location**: `location=Remote` works; also `location=United+States`
- **Tech stack tags**: Visible in listing cards (Python, AWS, Kubernetes, etc.)

## Glassdoor
- **Geo-redirect**: From India IP → `glassdoor.co.in` (shows India + remote jobs) — works well!
- **Search URLs**: Direct job listing pages work better than search URLs
- **Filters in snapshot**: "Remote only" button `@e24`, "Easy Apply only" button `@e23`
- **Salary estimates**: "Glassdoor Est." ranges in listings
- **Company reviews**: Integrated; useful for culture signals

## Naukri (India-Focused)
- **Explicit filters**: `experience=0-3&location=remote` works well
- **Volume**: Large numbers for tech roles
- **Filters**: Experience range, location, salary range
- **Best for**: India-based remote roles, 0-7 years experience

## Wellfound (AngelList)
- **Blocked**: DataDome CAPTCHA — cannot automate via WebBridge
- **Manual only**: User must search at `wellfound.com/jobs`
- **Strength**: Startup equity data, early-stage roles

## Lever / Greenhouse
- **Search URLs broken**: `jobs.lever.co/search?q=` and `boards.greenhouse.io/search/jobs?q=` return 404
- **Use company career pages** instead

---

## Quick Reference: Working vs Blocked

| Platform | Automation | Notes |
|----------|------------|-------|
| LinkedIn | ✅ Excellent | Salary/remote filters, login for details |
| Indeed | ✅ Excellent | Pagination, recency filter |
| Glassdoor | ✅ Good | Direct listing URLs, .co.in for India |
| Naukri | ✅ Good | Explicit exp/location filters |
| Dice | ✅ Good | Cookie consent first |
| Wellfound | ❌ Blocked | DataDome CAPTCHA |
| Lever | ❌ Broken | Search 404s |
| Greenhouse | ❌ Broken | Search 404s |

---

## Anti-Detection Notes

- **LinkedIn**: Blocks `event.isTrusted` — manual interaction needed for CAPTCHAs/login walls
- **All platforms**: Add random delays (2-5s) between actions
- **Use `evaluate` for form fills** instead of `fill` (avoids extension bugs)
- **Single session name** = single tab group in Chrome
- **Human navigation order**: Search → Results → Profiles