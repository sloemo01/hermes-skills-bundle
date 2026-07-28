---
name: osint-person-search
description: Find and verify person profiles across platforms via OSINT.
category: research
tags:
  - osint
  - person-search
  - profile-discovery
  - social-media
  - linkedin
  - twitter
  - instagram
  - behance
  - dribbble
  - background-check
---

# OSINT Person Search

A class-level skill for discovering and verifying person profiles, professional presence, and digital footprints across multiple platforms using open-source intelligence techniques.

## When to Use

- User needs to find all public profiles for a person (name, email, handle, company)
- Background research on candidates, speakers, competitors, collaborators
- Due diligence, journalism, recruiting, sales prospecting
- Building comprehensive dossiers from fragmented online presence

## Core Principles

1. **Start broad, then narrow** — Begin with name + location/role combinations, iterate with discovered handles
2. **Cross-reference handles** — Same username often reused across platforms (johndoe, john_doe, johndoe.com)
3. **Verify with multiple sources** — LinkedIn claim "Senior Designer at Example Corp" confirmed by Behance case study + personal site + XING = high confidence
4. **Document negative results** — "No Facebook profile found for @johndoe" is as valuable as positive findings
5. **Respect platform ToS** — Use search engines, aggregators, public profiles; avoid scraping behind auth walls

## Search Strategy Framework

### Phase 1: Seed Queries (Name Variants)
```
"Full Name"                    → "John Doe"
"First Last" + role            → "John Doe product designer"
"First Last" + location        → "John Doe Berlin"
"First Last" + company         → "John Doe Example Corp"
"First M. Last"                → "J. Doe designer"
Handle variations              → johndoe, john_doe, john-doe
```

### Phase 2: Platform-Specific Tactics

| Platform | Best Entry Points | Verification Signals |
|----------|-------------------|---------------------|
| **LinkedIn** | `site:linkedin.com/in "Name"`, `/pub/dir/First/Last` | Connections, endorsements, company pages, license IDs |
| **X/Twitter** | `@handle`, `site:twitter.com "Name"`, `site:x.com "Name"` | Verified badge, follower/following ratio, tweet history |
| **Instagram** | `@handle`, `site:instagram.com "Name"` | Post consistency, tagged photos, bio links |
| **Facebook** | `site:facebook.com "Name"`, public profile directory | Friends list visibility, groups, pages managed |
| **GitHub** | `@handle`, `site:github.com "Name"` | Repo ownership, contributions, org membership |
| **Behance** | `behance.net/handle`, `site:behance.net "Name"` | Project case studies, appreciations, Adobe certs |
| **Dribbble** | `dribbble.com/handle`, `site:dribbble.com "Name"` | Shots, likes, teams, hiring status |
| **XING** (DACH) | `xing.com/profile/First_Last`, `site:xing.com "Name"` | Skills tags, employment timeline, languages |
| **Personal Site** | `firstname-lastname.com`, `handle.com`, `about.me/handle` | Domain ownership, portfolio, blog, contact |
| **Academic** | `scholar.google.com "Name"`, `orcid.org`, `researchgate.net` | Publications, citations, affiliations |

### Phase 3: Aggregator & Search Engine Leverage
- **DuckDuckGo** `site:platform.com "Name"` — no personalization, good for public profiles
- **Google** `intext:"Name" inurl:linkedin` — broader index, may hit auth walls
- **Bing** — often surfaces different results than Google
- **Namechk / KnowEm** — username availability checker (reverse: find where taken)
- **Social Analyzer** — CLI/API for multi-platform username enumeration

### Phase 4: Enrichment & Correlation
- **Email permutation** → `hunter.io`, `voilanorbert`, `findthat.email` (from domain)
- **Phone/address** → Whitepages, TruePeopleSearch (US), local equivalents
- **Domain WHOIS** → `whois johndoe.com` → registrant name/email
- **Image reverse search** → Google Lens, Yandex, TinEye (profile photos across platforms)
- **Certificate Transparency** → `crt.sh` for subdomains (portfolio.NAME.com)

## Verification Checklist (Confidence Scoring)

| Signal | Weight |
|--------|--------|
| Same handle across 3+ platforms | High |
| Personal site links to LinkedIn/Behance/GitHub | High |
| Company page lists person in role | High |
| Mutual connections on LinkedIn | Medium |
| Consistent bio/headline/location | Medium |
| Cross-platform project references (ProjectX on LinkedIn + Behance + personal site) | High |
| Single platform only, no cross-links | Low |
| Common name, no disambiguators | Very Low |

## Output Format (Standardized Dossier)

```markdown
# Person Dossier: [Name]

## Summary
- **Primary Role**: [Title at Company]
- **Location**: [City, Country]
- **Confidence**: [High/Medium/Low] — [rationale]

## Verified Profiles
| Platform | URL | Handle | Status | Key Signals |
|----------|-----|--------|--------|-------------|
| LinkedIn | https://... | johndoe | ✅ Verified | 2K followers, Example Corp, 10+ certs |
| X/Twitter | https://... | @JohnDoe | ✅ Verified | 1.6K posts, Berlin|NYC, joined 2010 |
| Behance | https://... | johndoe | ✅ Verified | 10+ yrs exp, ProjectX/ProjectY case studies |
| Personal Site | https://johndoe.com | — | ✅ Verified | Portfolio, blog, resume, contact |

## Unverified / Partial
| Platform | URL | Notes |
|----------|-----|-------|
| Instagram | @john_doe | 0 posts, 60 followers — likely inactive/reserved |
| XING | John_Doe | Profile visible but gated behind login |
| F6S | johndoe | Bot detection blocked access |

## Not Found
- Facebook (no public profile matching name + role + location)
- YouTube (@johndoe → 404)
- GitHub (no public repos under handle)
```
|| Tab | Target | Purpose ||
||-----|--------|---------||
|| 1 | Google Search | Seed query + result URLs ||
|| 2 | LinkedIn Profile | Professional identity, role, company ||
|| 3 | Facebook | Personal/social presence ||
|| 4 | Instagram | Visual content, bio links, highlights ||
|| 5 | YouTube Channel | Video content, subscriber count ||
|| 6 | Google "Name LinkedIn" | LinkedIn-specific results ||
|| 7 | Google "Name Instagram" | Instagram-specific results ||
|| 8 | Google "Name YouTube" | YouTube-specific results ||
|| 9 | Google "Name creator/influencer" | Content creator signals ||
|| 10 | Google "Name interview podcast" | Media appearances ||
|| 11+ | Direct content URLs (Shorts, Reels, Posts) | Deep content analysis ||

### Anti-Detection Best Practices (from user preference)
- **Add random delays** (2-5s) between tab navigation and extraction
- **Use `evaluate` for form fills** instead of `fill` (more reliable)
- **Use `send_keys` for Enter/submit** instead of clicking buttons
- **Reuse single session name** across all tabs → single tab group in browser
- **Group title in user's language** (e.g., "Self Research - Target Name")
- **Snapshot after each state change** to verify content loaded

## Kimi WebBridge Deep Research Workflow

For deep, multi-tab OSINT research using the user's real browser (with their login sessions):

### Session-Based Tab Group Management

**macOS / Linux:**
```bash
# 1. Start daemon if needed
~/.kimi-webbridge/bin/kimi-webbridge start

# 2. Create session with group title (first tab)
curl -X POST http://127.0.0.1:10086/command \
  -H "Content-Type: application/json" \
  -d '{"action":"navigate","args":{"url":"https://www.google.com","newTab":true,"group_title":"Self Research - [Target Name]"},"session":"[target-name]-research"}'

# 3. Search and open results in new tabs (same session = same group)
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.linkedin.com/in/[handle]/","newTab":true},"session":"[target-name]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.instagram.com/[handle]/","newTab":true},"session":"[target-name]-research"}'
# ... repeat for 10+ tabs across platforms
```

**Windows (PowerShell):**
```powershell
# 1. Start daemon if needed
& "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe" start

# 2. Create session with group title
$body = '{"action":"navigate","args":{"url":"https://www.google.com","newTab":true,"group_title":"Self Research - [Target Name]"},"session":"[target-name]-research"}'
$body | Set-Content -Path "$env:TEMP\kimi-nav.json" -Encoding UTF8
curl.exe -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" --data-binary @"$env:TEMP\kimi-nav.json"
```

**Cross-platform (any shell):**
```bash
# 1. Start daemon if needed
${HOME:-$USERPROFILE}/.kimi-webbridge/bin/kimi-webbridge${EXE:-} start

# 2. Create session (same curl command works everywhere)
curl -X POST http://127.0.0.1:10086/command \
  -H "Content-Type: application/json" \
  -d '{"action":"navigate","args":{"url":"https://www.google.com","newTab":true,"group_title":"Self Research - [Target Name]"},"session":"[target-name]-research"}'
```

### Human-Like Interaction Pattern

```bash
# Fill search boxes via evaluate (avoids fill() issues)
curl ... -d '{"action":"evaluate","args":{"code":"document.querySelector(\"textarea[name='q']\").value = \"Target Name\""},"session":"..."}'

# Submit with send_keys (human-like)
curl ... -d '{"action":"send_keys","args":{"keys":"Enter"},"session":"..."}'

# Wait between actions (anti-detection)
sleep 3

# Switch tabs and extract content
curl ... -d '{"action":"find_tab","args":{"url":"https://..."},"session":"..."}'
curl ... -d '{"action":"snapshot","args":{},"session":"..."}'
```

### Multi-Platform Coverage Checklist (10+ tabs)
| Tab | Target | Purpose |
|-----|--------|---------|
| 1 | Google Search | Seed query + result URLs |
| 2 | LinkedIn Profile | Professional identity, role, company |
| 3 | Facebook | Personal/social presence |
| 4 | Instagram | Visual content, bio links, highlights |
| 5 | YouTube Channel | Video content, subscriber count |
| 6 | Google "Name LinkedIn" | LinkedIn-specific results |
| 7 | Google "Name Instagram" | Instagram-specific results |
| 8 | Google "Name YouTube" | YouTube-specific results |
| 9 | Google "Name creator/influencer" | Content creator signals |
| 10 | Google "Name interview podcast" | Media appearances |
| 11+ | Direct content URLs (Shorts, Reels, Posts) | Deep content analysis |

### Anti-Detection Best Practices (from user preference)
- **Add random delays** (2-5s) between tab navigation and extraction
- **Use `evaluate` for form fills** instead of `fill` (more reliable)
- **Use `send_keys` for Enter/submit** instead of clicking buttons
- **Reuse single session name** across all tabs → single tab group in browser
- **Group title in user's language** (e.g., "Self Research - Target Name")
- **Snapshot after each state change** to verify content loaded

## Pitfalls to Avoid

- ❌ Assuming same name = same person (disambiguate with role/location/company)
- ❌ Trusting single-source claims without cross-reference
- ❌ Scraping behind login walls (ToS violation, unreliable)
- ❌ Ignoring "no result" — document what you checked
- ❌ Using stale cached data — re-verify live profiles for time-sensitive work
- ❌ Conflating personal vs. brand accounts (e.g., @john___inc ≠ @johndoe)

## Skill Evolution Notes

- **2025-07-27**: Created from deep search sessions — validated multi-platform methodology across 12+ platforms, documented handle correlation patterns, and standardized dossier output format.
- **2025-07-27**: Applied methodology to search for connections between individuals — demonstrated how to document negative results when no public linkage exists between individuals.
- **2025-07-27**: Applied methodology to resolve dual identities (creator persona vs. academic/professional persona) — validated human-like browsing patterns with anti-detection techniques: random delays, `evaluate` for form fills, `send_keys` for submit, single session across 11 tabs. Documented full extraction methodology and cross-platform correlation matrix.

## Related Skills

- `social-media-data-extraction` — for bulk data collection from platforms
- `computer-use` — for GUI automation when browser tools hit auth walls