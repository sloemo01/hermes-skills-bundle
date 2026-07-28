---
name: deep-web-research
description: Deep web research with 10+ tabs via Kimi WebBridge.
metadata:
  version: "1.0.0"
---

# Deep Web Research with Kimi WebBridge

## When to Use
- User asks for "deep research", "comprehensive research", "investigate thoroughly"
- Multi-source investigation needed (GitHub, X/Twitter, Google, docs sites)
- Need 10+ tabs organized in named tab groups
- User says "retry" to re-do with same approach

## Core Methodology

### 1. Session & Tab Group Setup
```bash
# First navigate: create session + tab group with human-readable label
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"navigate","args":{"url":"<first_url>","newTab":true,"group_title":"<descriptive label>"},"session":"<task-name>"}'
```

**Rules:**
- One task = one session = one tab group
- Session name = task identifier (e.g., `vsouthvpawv-research`, `web-search`)
- `group_title` = user-language label shown in browser tab group
- Never switch session names mid-task

### 2. Opening Additional Sources
```bash
# Subsequent navigates: same session, newTab:true, no group_title needed
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"navigate","args":{"url":"<url>","newTab":true},"session":"<task-name>"}'
```

### 3. Reading Page Content
```bash
# Snapshot returns accessibility tree with @e refs
curl -s -X POST http://127.0.0.1:10086/command \
  -H 'Content-Type: application/json' \
  -d '{"action":"snapshot","args":{},"session":"<task-name>"}'
```

### 4. Following Links / Interacting
- Use `@e` refs from snapshot for click/fill
- Prefer snapshot over CSS selectors
- For navigation, use `navigate` with same session

## Proper Use of @e References

**Important**: The `@e` references (e.g., `@e58`, `@e100`) returned by the `snapshot` tool are special identifiers that work ONLY as direct values for the `selector` parameter in tools like `click`, `fill`, etc.

### Common Mistake
Attempting to use `@e` references in `evaluate()` with DOM query methods will FAIL:
```javascript
// ❌ WRONG - This will throw "Failed to execute 'querySelector' on 'Document': '@e58' is not a valid selector"
document.querySelector("@e58").href
```

### Correct Usage
Always pass `@e` references directly as the `selector` value. The Kimi WebBridge resolves `@e` references server-side before browser execution, making them valid in WebBridge commands but NOT in raw browser JS.

```bash
# ✅ CORRECT - Use @e reference directly as selector
curl -s -X POST http://127.0.0.1:10086/command \
  -d '{"action":"click","args":{"selector":"@e58"},"session":"my-session"}'

# ✅ CORRECT - For getting attributes, use the get_attribute action
curl -s -X POST http://127.0.0.1:10086/command \
  -d '{"action":"get_attribute","args":{"selector":"@e58","attribute":"href"},"session":"my-session"}'
```

### When You Need Attributes
If you need to extract attributes like `href`, `textContent`, etc. from an element identified by `@e` reference:
1. Use the `get_attribute` action with the `@e` reference
2. Or, if you need to use `evaluate`, use a standard CSS selector (not an `@e` reference)

Example using a proper CSS selector in evaluate:
```bash
curl -s -X POST http://127.0.0.1:10086/command \
  -d '{"action":"evaluate","args":{"code":"const el = document.querySelector(\"a.target-link\"); return el ? el.href : null;"},"session":"my-session"}'
```

### Workflow Recommendation
1. Use `snapshot` to get the accessibility tree with `@e` references
2. Identify the target element by its `@e` reference and role/name
3. For actions (click, fill): Pass the `@e` reference directly as `selector`
4. For attribute extraction: Use `get_attribute` with the `@e` reference
5. Never try to manipulate `@e` references as strings or use them in CSS selectors outside of the tool parameters

### 5. Closing
Only call `close_session` when user explicitly asks ("close those tabs").

## Research Patterns

### Parallel Source Investigation
Open multiple tabs simultaneously for different source types:
- GitHub repos/orgs
- X/Twitter profiles
- Google searches (quoted, site:, filetype:)
- Documentation sites
- Blog posts / Medium / Substack

### Identity Resolution
When researching a handle/person:
1. Search handle + keywords
2. Check GitHub profile → pinned repos → org membership
3. Check X/Twitter → bio → followers/following → interactions
4. Cross-reference usernames across platforms
5. Look for "verified" markers, org affiliations

### Technical Project Analysis
For GitHub projects:
1. Main repo → README → topics → stars/forks
2. Owner profile → other repos → contribution graph
3. Related repos (forks, dependencies, forks of forks)
4. Issues/PRs for active development signals
5. Contributors list for team/community size

## Key Commands Reference

| Action | Purpose |
|--------|---------|
| `navigate` (newTab:true, group_title) | Open first tab, create tab group |
| `navigate` (newTab:true) | Open additional tabs in same group |
| `snapshot` | Read page content (accessibility tree) |
| `click` / `fill` | Interact using @e refs |
| `find_tab` | Switch to earlier tab in session |
| `list_tabs` | Inspect open tabs |
| `close_session` | Close entire tab group (user-initiated only) |

## Daemon Management

**macOS / Linux:**
```bash
~/.kimi-webbridge/bin/kimi-webbridge start
```

**Windows (PowerShell):**
```powershell
& "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe" start
```

**Cross-platform (any shell with HOME/USERPROFILE):**
```bash
# Using $HOME (Linux/macOS) or %USERPROFILE% (Windows)
${HOME:-$USERPROFILE}/.kimi-webbridge/bin/kimi-webbridge${EXE:-} start
```

The daemon runs on `http://127.0.0.1:10086` regardless of platform.

## Pitfalls to Avoid
- ❌ Switching session names mid-task → fragments tab groups
- ❌ Using Chrome CDP / built-in browser tools instead of Kimi WebBridge
- ❌ Not using `newTab:true` for parallel pages
- ❌ Using bare domains in `find_tab` (use exact URL)
- ❌ Calling `close_session` without user request
- ❌ CSS/JS selectors when @e refs available

## Example: Multi-Source Person Investigation
```bash
# Session: "alice-research"
# 1. Google search
navigate("https://google.com/search?q=%22alice%22+github", newTab:true, group_title:"alice deep research", session:"alice-research")
# 2. GitHub profile
navigate("https://github.com/alice", newTab:true, session:"alice-research")
# 3. X/Twitter
navigate("https://x.com/alice", newTab:true, session:"alice-research")
# 4. Company site
navigate("https://company.com/team/alice", newTab:true, session:"alice-research")
# ... repeat for 10+ sources
# Snapshot each, cross-reference, synthesize
```

## References

- [E-Reference Guide](file:///e:/hermes-skills-bundle/deep-web-research/references/e-reference-guide.md)
- [Search Engine Preference](file:///e:/hermes-skills-bundle/deep-web-research/references/search-engine-preference.md)