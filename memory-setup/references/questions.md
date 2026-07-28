# Memory Setup Questions Reference

## Question Bank

| # | Category | Question | Options | Maps To |
|---|----------|----------|---------|---------|
| 1 | Browser Automation | What browser automation do you prefer? | 1. Kimi WebBridge (real Chrome, your logins)<br>2. Chrome CDP / Playwright (headless)<br>3. No preference | `browser_choice` |
| 2 | Research Style | How do you like deep research done? | 1. Many tabs (10+) in named groups<br>2. One focused search at a time<br>3. Just give me the answer/summary | `research_style` |
| 3 | Repeat Command | What word means "do it again the same way"? | 1. retry<br>2. rerun<br>3. again<br>4. Other (specify) | `repeat_word` |
| 4 | Privacy | Any privacy/data things to avoid? | 1. No public pastes (dpaste, GitHub Gists)<br>2. Local-only tools, no cloud APIs<br>3. Delete temp files after<br>4. No strong preferences | `privacy_choice` |
| 5 | UI Patterns | Any UI patterns you use repeatedly? | 1. Preview pane for docs/social/localhost<br>2. Terminal split for logs + editor<br>3. Dev server on fixed port (e.g., :3000)<br>4. No strong patterns | `ui_patterns` |

## Memory Output Templates

### Entry 1 (Browser)
```
User prefers {browser_choice} for all browser automation — standing preference for all future sessions.
```

### Entry 2 (Research + Repeat)
```
User prefers {research_style} research workflows. Uses "{repeat_word}" to request re-doing a task with the same approach.
```

### Entry 3 (Repeat Command)
```
User uses "{repeat_word}" as a command to re-do a task with the same approach (deep research, multiple tabs, Kimi WebBridge).
```

### Entry 4 (Privacy)
```
User is privacy-conscious: {privacy_choice}. Avoids public pastes/external uploads.
```

### Entry 5 (UI Patterns)
```
Preview pane workflows: use open_preview(url, label) to embed web content, files, or screenshots. Patterns: {ui_patterns}.
```

## Confirmation Message Template

```
✅ Done! Saved to ~/.hermes/memories/memory.md. From now on I'll:
- Use {browser_choice} for all browser tasks
- Open 10+ tabs in named groups for research
- "{repeat_word}" = re-run same methodology
- Never use dpaste/public uploads
- Open preview pane for docs/localhost/social links
```