# Deep Research Workflows with Kimi WebBridge

## Multi-Tab OSINT Research Pattern

### Session Initialization

**macOS / Linux:**
```bash
# 1. Ensure daemon is running
~/.kimi-webbridge/bin/kimi-webbridge start

# 2. Create session with descriptive group title
curl -X POST http://127.0.0.1:10086/command \
  -H "Content-Type: application/json" \
  -d '{"action":"navigate","args":{"url":"https://www.google.com","newTab":true,"group_title":"Research - [Target Name]"},"session":"[target-slug]-research"}'
```

**Windows (PowerShell):**
```powershell
# 1. Ensure daemon is running
& "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe" start

# 2. Create session with descriptive group title
curl.exe -X POST http://127.0.0.1:10086/command \
  -H "Content-Type: application/json" \
  --data-binary @$env:TEMP\kimi-nav.json
```

**Cross-platform (any shell):**
```bash
# 1. Ensure daemon is running
${HOME:-$USERPROFILE}/.kimi-webbridge/bin/kimi-webbridge${EXE:-} start

# 2. Create session (same curl command works everywhere)
curl -X POST http://127.0.0.1:10086/command \
  -H "Content-Type: application/json" \
  -d '{"action":"navigate","args":{"url":"https://www.google.com","newTab":true,"group_title":"Research - [Target Name]"},"session":"[target-slug]-research"}'
```

### Phase 1: Seed Search & Handle Discovery
```bash
# Fill search box via evaluate (more reliable than fill)
curl -X POST ... -d '{"action":"evaluate","args":{"code":"document.querySelector(\"textarea[name=\'q\']\").value = \"[Target Name]\""},"session":"[target-slug]-research"}'

# Submit with send_keys (human-like)
curl -X POST ... -d '{"action":"send_keys","args":{"keys":"Enter"},"session":"[target-slug]-research"}'

# Wait for results
sleep 3

# Snapshot to extract result URLs
curl -X POST ... -d '{"action":"snapshot","args":{},"session":"[target-slug]-research"}'
```

### Phase 2: Parallel Profile Tab Opening (10+ tabs)
```bash
# Fire all navigations rapidly (same session = single tab group)
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.linkedin.com/in/[handle]/","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.instagram.com/[handle]/","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.youtube.com/@[handle]","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.facebook.com/[handle]","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.google.com/search?q=\"[Name]\"+LinkedIn","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.google.com/search?q=\"[Name]\"+Instagram","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.google.com/search?q=\"[Name]\"+YouTube","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.google.com/search?q=[Name]+content+creator","newTab":true},"session":"[target-slug]-research"}'
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.google.com/search?q=\"[Name]\"+interview","newTab":true},"session":"[target-slug]-research"}'
# Add direct content URLs (Shorts, Reels, Posts)
curl -X POST ... -d '{"action":"navigate","args":{"url":"https://www.youtube.com/shorts/[id]","newTab":true},"session":"[target-slug]-research"}'
```

### Phase 3: Batch Extraction (with anti-detection delays)
```bash
# Wait for all tabs to load
sleep 5

# Iterate through each tab URL from list_tabs
curl -X POST ... -d '{"action":"list_tabs","args":{},"session":"[target-slug]-research"}'

# For each tab:
curl -X POST ... -d '{"action":"find_tab","args":{"url":"[exact-tab-url]"},"session":"[target-slug]-research"}'
sleep 2  # Anti-detection delay
curl -X POST ... -d '{"action":"snapshot","args":{},"session":"[target-slug]-research"}'

# Optional: screenshot for visual verification
curl -X POST ... -d '{"action":"screenshot","args":{"format":"png"},"session":"[target-slug]-research"}'
```

### Phase 4: Deep Content Extraction (per platform)
```bash
# Instagram: scroll feed for more posts
curl -X POST ... -d '{"action":"evaluate","args":{"code":"window.scrollBy(0, 2000)"},"session":"[target-slug]-research"}'
sleep 1
curl -X POST ... -d '{"action":"snapshot","args":{},"session":"[target-slug]-research"}'

# YouTube: click tabs (Shorts, Videos, etc.)
curl -X POST ... -d '{"action":"click","args":{"selector":"@e[tab-ref]"},"session":"[target-slug]-research"}'
sleep 2
curl -X POST ... -d '{"action":"snapshot","args":{},"session":"[target-slug]-research"}'
```

---

## Anti-Detection Best Practices (User-Validated)

| Technique | Why It Works | Implementation |
|-----------|--------------|----------------|
| **Random delays (2-5s)** | Mimics human reading time | `sleep $((RANDOM % 4 + 2))` between actions |
| **`evaluate` for form fills** | Avoids `fill()` extension bugs; sets value directly | `document.querySelector('selector').value = 'text'` |
| **`send_keys` for Enter** | Human-like key event vs synthetic click | `{"action":"send_keys","args":{"keys":"Enter"}}` |
| **Single session name** | All tabs grouped in one browser tab group | Use same `session` value across all commands |
| **Human navigation order** | Search → Results → Profiles (not direct deep links) | Always start from Google/search engine |
| **Snapshot after state changes** | Verifies content loaded; captures accessibility tree | Call `snapshot` after every navigation/wait |
| **Reuse logged-in browser** | Leverages user's existing sessions (no auth walls) | Kimi WebBridge uses real Chrome profile |

---

## Common Pitfalls & Fixes

| Issue | Root Cause | Fix |
|-------|------------|-----|
| `fill: value is required` | Wrong parameter name | Use `evaluate` instead |
| `fill: Uncaught` | Extension bug on complex inputs | Use `evaluate` with direct DOM manipulation |
| `click: selector is required` | `@e` ref not passed correctly | Use `selector: "@e12"` format |
| Tab not found in `find_tab` | URL mismatch (params, trailing slash) | Use exact URL from `list_tabs` output |
| 404 on LinkedIn profile | Profile private/deleted | Fall back to Google cache / search snippets |
| Large snapshot truncation | Accessibility tree > 15K chars | Use `evaluate` for targeted extraction |

---

## Command Templates (Cross-Platform)

### Create temp JSON files (avoids shell escaping issues)

**macOS / Linux:**
```bash
cat > /tmp/kimi-nav.json << 'EOF'
{"action":"navigate","args":{"url":"https://example.com","newTab":true},"session":"my-research"}
EOF
curl -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" -d @/tmp/kimi-nav.json
```

**Windows (PowerShell):**
```powershell
@'
{"action":"navigate","args":{"url":"https://example.com","newTab":true},"session":"my-research"}
'@ | Set-Content -Path "$env:TEMP\kimi-nav.json" -Encoding UTF8
curl.exe -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" --data-binary @"$env:TEMP\kimi-nav.json"
```

### Evaluate with proper escaping

**macOS / Linux:**
```bash
cat > /tmp/kimi-eval.json << 'EOF'
{"action":"evaluate","args":{"code":"document.querySelector(\"textarea[name='q']\").value = 'Target Name'"},"session":"my-research"}
EOF
curl -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" -d @/tmp/kimi-eval.json
```

**Windows (PowerShell):**
```powershell
@'
{"action":"evaluate","args":{"code":"document.querySelector(\"textarea[name='q']\").value = 'Target Name'"},"session":"my-research"}
'@ | Set-Content -Path "$env:TEMP\kimi-eval.json" -Encoding UTF8
curl.exe -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" --data-binary @"$env:TEMP\kimi-eval.json"
```

### Send keys

**macOS / Linux:**
```bash
cat > /tmp/kimi-keys.json << 'EOF'
{"action":"send_keys","args":{"keys":"Enter"},"session":"my-research"}
EOF
curl -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" -d @/tmp/kimi-keys.json
```

**Windows (PowerShell):**
```powershell
@'
{"action":"send_keys","args":{"keys":"Enter"},"session":"my-research"}
'@ | Set-Content -Path "$env:TEMP\kimi-keys.json" -Encoding UTF8
curl.exe -s -X POST http://127.0.0.1:10086/command -H "Content-Type: application/json" --data-binary @"$env:TEMP\kimi-keys.json"
```

---

## Integration with osint-person-search Skill

This workflow is the **browser automation layer** for the `osint-person-search` methodology. When that skill's Phase 2 (Platform-Specific Tactics) calls for "Google search" or "LinkedIn profile" or "Instagram profile", use this Kimi WebBridge workflow to:

1. **Automate the search** — human-like, anti-detection
2. **Open 10+ tabs in parallel** — single tab group for organization
3. **Extract full accessibility trees** — structured data via `snapshot`
4. **Cross-reference handles** — same session, easy tab switching
5. **Document everything** — raw snapshots + extracted findings

The `osint-person-search` skill references this workflow in its **Tools Quick Reference** section.