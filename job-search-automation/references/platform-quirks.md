# Platform Quirks Reference — Job Search Automation

## LinkedIn
- **Salary filter**: `f_SB2=200000` for $200K+ base
- **Remote filter**: `f_WT=2`
- **Keywords that work**: `agentic AI architect`, `agentic AI engineer`, `principal AI architect`, `LLM agent architect`, `AI orchestration engineer`
- **Login wall**: Job cards visible without auth; detail pages require login
- **Easy Apply filter**: Shows only jobs you can apply to without leaving LinkedIn
- **Pagination**: Page parameter `start=` (0, 25, 50...)

## Indeed
- **Recency filter**: `fromage=7` (7 days), `fromage=1` (24h)
- **Remote**: `l=Remote` or `l=United+States` + remote checkbox
- **Salary estimates**: Often shown in listing cards as "Estimated: $X–$Y"
- **Pagination**: `start=` parameter (0, 10, 20...)
- **Sponsored jobs**: Mixed in; check for "Sponsored" label

## Dice
- **Cookie consent**: Must click "Allow all" (`@e2` in snapshot) before content loads
- **Contract rates**: Shown as "$70-75/hr" — multiply by 2080 for annualized
- **Location**: `location=Remote` works; also `location=United+States`
- **Tech stack tags**: Visible in listing cards (Python, AWS, Kubernetes, etc.)

## Glassdoor (.co.in works well for India-based remote)
- **Geo-redirect**: From India IP → `glassdoor.co.in` (shows India + remote jobs) — **works well!**
- **Search URLs that work**: 
  - `https://www.glassdoor.co.in/Job/agentic-ai-engineer-jobs-SRCH_KO0,17.htm?clickSource=searchBox`
  - `https://www.glassdoor.co.in/Job/ai-agent-engineer-jobs-SRCH_KO0,17.htm?clickSource=searchBox`
- **Filters in snapshot**: "Remote only" button `@e24`, "Easy Apply only" `@e23`
- **Volume**: 6,478 AI agent engineer jobs, ~700 agentic AI jobs
- **Key listing**: Commerce Pundit — "At least one real, demonstrable agentic/LLM project you can show and walk through (link required)"
- **Salary estimates**: "Glassdoor Est." ranges in listings
- **Company reviews**: Integrated; useful for culture signals

## Wellfound (AngelList)
- **Blocked**: DataDome CAPTCHA on all automated access
- **Manual only**: User must search in browser
- **Strength**: Startup equity data, early-stage roles

## Lever / Greenhouse
- **Search URLs broken**: `jobs.lever.co/search?q=` and `boards.greenhouse.io/search/jobs?q=` return 404
- **Workaround**: Search company career pages directly or use Wellfound/Indeed aggregation

## Session Management (Kimi WebBridge)
- **Tab grouping**: Use same `session` name + `newTab:true` for all tabs in a search
- **Group title**: Set on first `navigate` — appears as Chrome tab group label
- **Cleanup**: `close_session` with session name closes all tabs in group
- **Tab listing**: `list_tabs` shows all tabs in session with `tabId`, `url`, `title`