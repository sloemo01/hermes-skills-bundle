---
name: social-media-hiring-research
description: "Research hiring posts on social media (X/Twitter, LinkedIn) for AI/ML/agentic roles. Covers search patterns, query strategies, and authentication requirements."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos]
prerequisites:
  commands: [xurl, browser]
metadata:
  hermes:
    tags: [research, hiring, social-media, x, twitter, linkedin, ai-jobs]
    homepage: ""
---

# Social Media Hiring Research

This skill covers finding job postings and hiring announcements on social media platforms, particularly X (Twitter) and LinkedIn, for AI/ML/agentic engineering roles.

## When to Use

- User asks "who's hiring for X role on Twitter"
- User wants to find companies hiring agentic AI engineers
- User needs market intelligence on hiring trends
- User wants to track specific recruiters/companies

## Key Platforms

### X (Twitter) - Primary for Real-Time Hiring Posts

**Search URL Pattern**: `https://x.com/search?q=QUERY&src=typed_query&f=live`
- `f=live` = "Latest" tab (chronological, not algorithmic)
- Always use "Latest" for hiring posts - "Top" shows viral/old content

**Effective Query Patterns** (tested July 2026):

| Query | Use Case |
|-------|----------|
| `"agentic AI engineer" hiring` | Exact phrase, high precision |
| `hiring agentic AI engineer` | Broader, catches variations |
| `hiring agentic AI` | Broadest, includes ML/AI roles |
| `"AI agent engineer" hiring` | Alternative terminology |
| `autonomous agents hiring` | Broader agent-related roles |

**Date Filtering**: Add `since:YYYY-MM-DD` to query for last N days
- Example: `hiring agentic AI engineer since:2026-06-25` (last 30 days)

### LinkedIn - Better for Structured Job Listings

**Search URL**: `https://www.linkedin.com/search/results/content/?keywords=QUERY`
- Or use Google: `site:linkedin.com "AI agent engineer" hiring`

## Active Recruiters to Follow (July 2026)

| Handle | Name | Company/Role | Notes |
|--------|------|--------------|-------|
| @mange_manali | Manali Mango | ClanX.ai | Posts Senior Agentic AI roles, Bengaluru |
| @Shreyas_Pandeyy | Shreyas Pandey | Recruiter | 15+ Agentic AI positions, 6+ yrs exp |
| @AnanyainTech | Ananya | Accolite | 1-3 yrs, multiple India locations |
| @Narayani07 | Narayani Gurunathan | Big 4 GCC | Azure AI/ML/Agentic, walk-ins |
| @Ebiowei_C | Calabar | Automation Eng | Senior, $147-234k, remote |
| @suraj_sharma14 | Suraj Sharma | Market analyst | Posts hiring trend reports |
| @jhanviparmar239 | Jhanvi Parmar | AI Overlords | Remote, 0-2 yrs, immediate |

## Companies Actively Hiring (from posts)

| Company | Roles | Locations | Source |
|---------|-------|-----------|--------|
| ClanX.ai | AI Agent Architect, AI Engineer, Voice AI Engineer | Bengaluru | @mange_manali |
| Accolite | Agentic AI Engineer | Hyderabad/Chennai/Bangalore/Gurgaon | @AnanyainTech |
| Big 4 GCC | Azure AI/ML/Agentic AI Engineer | Bangalore | @Narayani07 |
| AI Overlords | Agentic AI Engineer | Remote | @jhanviparmar239 |
| Lamatic.ai | Agentic System roles | Early stage | Wellfound |

## xurl CLI Usage (Requires Auth)

**Setup (one-time, user must do)**:
```bash
# 1. Create app at https://developer.x.com/en/portal/dashboard
#    Redirect URI: http://localhost:8080/callback
#    App type: "Web app, automated app or bot"

# 2. Register app locally
xurl auth apps add my-app --client-id YOUR_CLIENT_ID --client-secret YOUR_CLIENT_SECRET

# 3. Authenticate (opens browser)
xurl auth oauth2 --app my-app YOUR_USERNAME

# 4. Set as default
xurl auth default my-app
```

**Search Commands**:
```bash
# Basic searches
xurl search '"agentic AI engineer" hiring' -n 20
xurl search 'hiring agentic AI engineer' -n 30
xurl search 'hiring agentic AI engineer since:2026-06-25' -n 30

# Specific users
xurl search 'from:mange_manali hiring' -n 10
xurl search 'from:Shreyas_Pandeyy agentic' -n 10

# Check auth status
xurl auth status
xurl whoami
```

**Critical**: Without OAuth 2.0 auth, all searches fail with `Error: Auth Error: NoAuthMethod`

## Browser Automation Alternative

When xurl auth isn't available, use browser navigation:

```python
# Navigate to search URL
await browser_navigate("https://x.com/search?q=hiring%20agentic%20AI%20engineer&src=typed_query&f=live")

# Wait for load, then snapshot
await browser_snapshot(full=True)

# Scroll for more results
await browser_scroll(direction="down")
await browser_snapshot(full=True)
```

**Limitations**: X.com heavily rate-limits unauthenticated scraping. Browser automation may hit login walls or 404s.

## Google Search Fallback

When X search fails, use Google with site restriction:
- Query: `"agentic AI engineer" hiring site:x.com OR site:twitter.com`
- Add `&tbs=qdr:m` for past month
- Also search LinkedIn: `site:linkedin.com "AI agent engineer" hiring`

## Output Format for Findings

Return structured data:
```json
{
  "query": "search query used",
  "platform": "x.com",
  "date_searched": "2026-07-25",
  "results": [
    {
      "username": "@handle",
      "name": "Display Name",
      "company": "Company Name",
      "role": "Job Title",
      "location": "City, Country / Remote",
      "experience": "X+ years",
      "salary": "$X - $Y (if mentioned)",
      "skills": ["skill1", "skill2"],
      "apply_link": "URL or 'DM' or 'See comments'",
      "post_date": "Jul 2 / 19 hours ago",
      "post_url": "https://x.com/handle/status/...",
      "engagement": {"replies": 3, "reposts": 1, "likes": 24}
    }
  ]
}
```

## Pitfalls & Gotchas

1. **X.com requires login for deep scrolling** - First ~20 posts visible, then login wall
2. **"Top" vs "Latest" tab** - Default is "Top" (algorithmic). Must use `&f=live` or click "Latest"
3. **Rate limits** - Unauthenticated: ~20 searches/15min. Authenticated: higher but still limited
4. **Date parsing** - X shows relative times ("19h", "Jul 2"). Convert to absolute dates carefully
5. **Deleted/expired posts** - Job posts often deleted after filled. Snapshot quickly
6. **xurl auth pitfall** - Token saved to `default` app (no client-id) instead of named app. Fix: `xurl auth oauth2 --app my-app` then `xurl auth default my-app`

## References

- `references/hiring-search-patterns.md` - Detailed search patterns and real post examples from July 2026
- `references/xurl-auth-guide.md` - Complete xurl authentication walkthrough