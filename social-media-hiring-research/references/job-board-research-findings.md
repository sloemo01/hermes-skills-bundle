# Job Board Research Findings - July 2026 Session

## Session Summary
Researched agentic AI engineer job postings across major job boards and company career pages.

---

## Wellfound (AngelList)

**URL**: `https://wellfound.com/jobs` and `https://wellfound.com/role/r/ai-engineer`

**Findings**:
- **1,964+ AI Engineer roles** across 52 pages
- **Search requires login** - keyword filtering (e.g., "agentic AI engineer", "AI agent engineer") returns 0 results without authentication
- **Lamatic.ai** explicitly markets "All in one stack to build reliable Agentic System" - hiring Applied AI Engineers (India/Remote)
- **LaunchDarkly** has "Technical and Agentic Enablement Lead" ($129k–$210k)
- **Stuut** hiring "Member of Technical Staff — Audio and Voice AI" ($250k–$320k, NYC)
- **Modern Treasury** has "AI Search and Discovery Lead" (Remote SF, $120k–$160k)

**Key Companies with Agentic-Relevant Roles**:
| Company | Role | Location | Salary |
|---------|------|----------|--------|
| Lamatic.ai | Applied AI Engineer / Intern | India / Remote Europe | $6k–$40k |
| LaunchDarkly | Technical and Agentic Enablement Lead | Remote | $129k–$210k |
| Stuut | MTS — Audio and Voice AI | NYC (In office) | $250k–$320k |
| Modern Treasury | AI Search and Discovery Lead | Remote (SF) | $120k–$160k |
| Chronicle | Senior AI Engineer | LA / Remote | $220k–$300k |
| Twin Health | Senior AI Apps / Staff AI Engineer | Remote | $195k–$265k |
| Fieldguide | Senior/Staff AI Engineer | Remote (SF) | $190k–$310k |
| PlutusAI | AI Engineer | Remote | $175k–$200k |

---

## Y Combinator Jobs

**URL**: `https://www.ycombinator.com/jobs`

**Findings**:
- **Search endpoint broken** - `/jobs/search?query=` returns 404
- Main page shows ~15 recent YC startup jobs
- **Relevant AI/agentic companies**:
  - **CoLoop (S21)** - "AI Copilot for insights & strategy" → Product Engineer (London, £70K–£120K)
  - **Soraban (W21)** - "AI tax workflow platform" → AI-first Fullstack Engineer (Chandler AZ, $120K–$180K)
  - **Per Diem (W21)** - "AI operating system for restaurants" → React Native Dev (Remote, $60K)
  - **Rownd (W22)** - "Fully autonomous defense solutions" → Edge Computer Vision Engineer (Milwaukee/Durham, $90K–$150K)
  - **Turing Labs (W20)** - "AI for R&D of consumer brands" → Senior SWE Full Stack (Palo Alto, $150K–$200K)

---

## Greenhouse Job Boards

**Working URL Pattern**: `https://job-boards.greenhouse.io/embed/job_board?for=<company-slug>`

**Anthropic** (`for=anthropic`): ✅ **418 roles**
- Searchable via embedded search box
- **"agent" search returns 40 roles**:
  - Research Engineer, Agents (Remote-Friendly, Travel-Required)
  - Engineering Manager, Agent Runtime Platform
  - Research Engineer, Computer Use
  - Research Engineer, Code RL / Cybersecurity RL / Model Evaluations
  - Multiple RL/Reinforcement Learning roles

**Failed/404 Company Slugs Tested**:
- openai, perplexity, cohere, adept, runwayml, huggingface, character-ai, midjourney, stability-ai, elevenlabs, replit

**Note**: Many AI companies don't use Greenhouse, or use different slug names.

---

## Lever Job Boards

**URL Pattern**: `https://jobs.lever.co/<company-slug>`

**All Tested Returned 404**:
- openai, anthropic, perplexity, cohere, adept, langchain, llamaindex, crewai, character-ai, runwayml, huggingface

**Conclusion**: Most major AI companies don't use Lever, or use custom career pages.

---

## Company Career Pages

| Company | Career Page | Status |
|---------|-------------|--------|
| Character.ai | `https://character.ai/careers` | ✅ Loads, has "View Open Roles" button |
| Anthropic | `https://www.anthropic.com/careers` | Redirects to Greenhouse |
| OpenAI | `https://openai.com/careers` | Custom page (not tested) |

---

## Search Strategy Recommendations

### For Wellfound
1. **Browse AI Engineer category** → filter manually for agentic keywords
2. **Check company descriptions** for "agentic", "autonomous agents", "LLM agents"
3. **Login required** for keyword search - consider authenticated scraping

### For Y Combinator
1. **Browse main page** - no search available
2. **Filter by "Science" category** or scan all Software Engineer roles
3. **Check company descriptions** for AI/agent keywords

### For Greenhouse
1. **Guess company slugs** or find via company career page redirect
2. **Use embedded search** once on company board
3. **Anthropic is the best source** for explicit "agent" roles

### For Company Pages
1. **Check `/careers` subpath** first
2. **Look for "View Open Roles" → ATS redirect** (Greenhouse, Lever, Ashby, etc.)
3. **Search company name + "careers" on Google** to find correct ATS

---

## Raw Data Points for Future Reference

### Wellfound AI Engineer Role Page (sample)
```
URL: https://wellfound.com/role/r/ai-engineer
Total: 1964 results, 52 pages
Notable: Lamatic.ai description explicitly mentions "Agentic System"
```

### Anthropic Greenhouse Search Results for "agent"
```
Research Engineer, Agents - Remote-Friendly (Travel-Required) | SF | Seattle | NYC
Engineering Manager, Agent Runtime Platform - SF | NYC
Research Engineer, Computer Use - SF | NYC | Seattle
Research Engineer, Code RL - SF | NYC
Research Engineer, Cybersecurity RL - SF | NYC
Research Engineer, Machine Learning (RL Velocity) - Remote-Friendly | London
Research Engineer, Model Evaluations - Remote-Friendly | SF | NYC
Research Engineer, Performance RL - SF
Research Engineer, Pretraining - London / SF
Research Engineer, Production Model Post-Training - SF | NYC | Seattle | Zürich
Research Engineer / Scientist, Pre-training - Zürich / Remote-Friendly
Research Engineer / Scientist, Tokens - NYC | Seattle | SF
Research Engineer, RL Scaling Science - London
Research Engineer / Scientist, Alignment - SF
```

### YC Jobs Page Structure
```
Software Engineer roles grouped by company
Each entry: Company (Batch) • Description • Role Title • Full-time • Category • Stack • Salary • Location • Apply link
"See more jobs ›" button at bottom
```

---

## Next Session Action Items

1. **Try authenticated Wellfound scraping** with browser automation + login
2. **Test Greenhouse slugs** for more AI companies (try: databricks, scale, weigh, etc.)
3. **Check Ashby boards** - many startups use Ashby (e.g., `https://boards.ashbyhq.com/<company>`)
4. **Set up xurl auth** for X/Twitter hiring posts
5. **Monitor specific recruiter accounts** on X for real-time postings