---
name: linkedin-automation
description: LinkedIn people search via Kimi WebBridge — URLs, filters.
metadata:
  version: "1.0.0"
---

# LinkedIn Automation with Kimi WebBridge

Patterns for finding people on LinkedIn via browser automation. Use when you need to search for profiles, filter by connection degree, paginate results, or search by education/employment.

## Quick Reference: Search URL Patterns

| Goal | URL Pattern |
|------|-------------|
| Basic name search | `https://www.linkedin.com/search/results/people/?keywords=NAME` |
| 1st-degree connections only | `...&origin=FACETED_SEARCH&network=%5B%22F%22%5D` |
| 2nd-degree connections only | `...&origin=FACETED_SEARCH&network=%5B%22S%22%5D` |
| 3rd+ connections only | `...&origin=FACETED_SEARCH&network=%5B%22O%22%5D` |
| Specific person's connections | `https://www.linkedin.com/in/USERNAME/connections/` |
| Search within connections | `https://www.linkedin.com/search/results/people/?keywords=TERM&origin=MEMBER_PROFILE_CANNED_SEARCH` |
| Education/school search | `https://www.linkedin.com/search/results/people/?keywords=SCHOOL_NAME` |
| Name + school combo | `https://www.linkedin.com/search/results/people/?keywords=NAME+SCHOOL` |
| Pagination | Add `&page=N` to any search URL |

## Workflow

1. **Navigate** to search URL with `newTab:true` and a descriptive `group_title`
2. **Snapshot** the page (`full:true` for complete tree, `full:false` for interactive elements)
3. **Extract** profile links from `@e` refs in the snapshot (look for `role: "link"` with profile names)
4. **Click** a profile link to open it, then snapshot for details
5. **Paginate** by clicking page number buttons (`@e` refs for "Page 1", "Page 2", etc.) or navigating to `&page=N`

## Connection Degree Filters

| Network Value | Meaning |
|---------------|---------|
| `%5B%22F%22%5D` | 1st connections (encoded `["F"]`) |
| `%5B%22S%22%5D` | 2nd connections (encoded `["S"]`) |
| `%5B%22O%22%5D` | 3rd+ connections (encoded `["O"]`) |

Use with `origin=FACETED_SEARCH` parameter.

## Profile URL Pattern

Individual profiles follow: `https://www.linkedin.com/in/USERNAME/`

From search results, click the profile name link (`@e` ref) to navigate, then read the URL from the snapshot's `url` field.

## Education Search Tips

- Search school name alone: `keywords=Amrita%20Vidyalayam`
- Combine with name: `keywords=Arjun%20Kannan%20Amrita%20Vidyalayam`
- Filter by 1st/2nd connections to find alumni in your network
- If no results, try variations: "Amritha Vidyalayam", "Amrita Vidyalaya", "Amrita Vidhyalayam"

## Pitfalls

- **LinkedIn blocks automation** — some actions may fail with "event.isTrusted" errors. Manual interaction needed for captchas, login walls.
- **Search results are truncated** in snapshots — use `full:true` and parse the tree, or click through pages.
- **Profile URLs change** — usernames may differ from display names. Always capture the actual URL after clicking.
- **Rate limiting** — LinkedIn may throttle rapid requests. Add delays between actions.
- **Dynamic content** — `@e` refs change on each snapshot. Re-snapshot after navigation before clicking.

## Example Session Flow

```bash
# 1. Open search tab
curl -X POST http://127.0.0.1:10086/command \
  -d '{"action":"navigate","args":{"url":"https://www.linkedin.com/search/results/people/?keywords=Arjun%20Kannan","newTab":true,"group_title":"Arjun Kannan search"},"session":"linkedin"}'

# 2. Get full page tree
curl -X POST http://127.0.0.1:10086/command \
  -d '{"action":"snapshot","args":{"full":true},"session":"linkedin"}'

# 3. Click a profile (use @e ref from snapshot)
curl -X POST http://127.0.0.1:10086/command \
  -d '{"action":"click","args":{"selector":"@e33"},"session":"linkedin"}'

# 4. Get profile details
curl -X POST http://127.0.0.1:10086/command \
  -d '{"action":"snapshot","args":{"full":true},"session":"linkedin"}'

# 5. Filter to 1st connections only
curl -X POST http://127.0.0.1:10086/command \
  -d '{"action":"navigate","args":{"url":"https://www.linkedin.com/search/results/people/?keywords=Arjun%20Kannan&origin=FACETED_SEARCH&network=%5B%22F%22%5D","newTab":true},"session":"linkedin"}'
```

## Related Skills

- `kimi-webbridge` — underlying browser automation tool
- `computer-use` — alternative desktop automation approach