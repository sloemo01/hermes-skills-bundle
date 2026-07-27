# Search URL Templates — Job Search Automation

## LinkedIn (US Remote, $200K+)
```
# Agentic AI Architect
https://www.linkedin.com/jobs/search/?keywords=agentic%20AI%20architect%20remote&location=Remote&f_WT=2&f_SB2=200000

# Agentic AI Engineer
https://www.linkedin.com/jobs/search/?keywords=agentic%20AI%20engineer%20remote&location=Remote&f_WT=2&f_SB2=200000

# Principal AI Architect
https://www.linkedin.com/jobs/search/?keywords=principal%20AI%20architect%20remote&location=Remote&f_WT=2&f_SB2=200000

# LLM Agent Architect
https://www.linkedin.com/jobs/search/?keywords=LLM%20agent%20architect%20remote&location=Remote&f_WT=2&f_SB2=200000

# AI Orchestration Engineer
https://www.linkedin.com/jobs/search/?keywords=AI%20orchestration%20engineer%20remote&location=Remote&f_WT=2&f_SB2=200000
```

## Indeed (US Remote, Last 7 Days)
```
# Agentic AI Architect
https://www.indeed.com/jobs?q=agentic+AI+architect+remote&l=Remote&fromage=7

# Agentic AI Engineer
https://www.indeed.com/jobs?q=agentic+AI+engineer+remote&l=Remote&fromage=7

# Sr AI Architect
https://www.indeed.com/jobs?q=senior+AI+architect+remote&l=Remote&fromage=7

# AI Platform Architect
https://www.indeed.com/jobs?q=AI+platform+architect+remote&l=Remote&fromage=7
```

## Dice (US Remote)
```
# Agentic AI Engineer
https://www.dice.com/jobs?q=agentic%20AI%20engineer%20remote&location=Remote

# Agentic AI Architect
https://www.dice.com/jobs?q=agentic%20AI%20architect%20remote&location=Remote

# LLM Engineer Remote
https://www.dice.com/jobs?q=LLM%20engineer%20remote&location=Remote
```

## Glassdoor (US Remote — use .com domain)
```
# Agentic AI Engineer
https://www.glassdoor.com/Job/remote-agentic-ai-engineer-jobs-SRCH_IL.0,6_IK7,26.htm

# AI Architect
https://www.glassdoor.com/Job/remote-ai-architect-jobs-SRCH_IL.0,6_IK7,17.htm

# Principal AI Engineer
https://www.glassdoor.com/Job/remote-principal-ai-engineer-jobs-SRCH_IL.0,6_IK7,23.htm
```

## Search Parameter Reference

### LinkedIn
| Param | Meaning | Example |
|-------|---------|---------|
| `keywords` | Search query | `agentic%20AI%20architect` |
| `location` | Location | `Remote`, `United%20States` |
| `f_WT` | Work type | `2` = Remote, `1` = On-site, `3` = Hybrid |
| `f_SB2` | Salary min (base) | `200000` = $200K+ |
| `f_E` | Experience level | `4` = Director, `5` = Executive, `6` = Intern |
| `f_JT` | Job type | `F` = Full-time, `C` = Contract |
| `start` | Pagination offset | `0`, `25`, `50` |

### Indeed
| Param | Meaning | Example |
|-------|---------|---------|
| `q` | Query | `agentic+AI+architect+remote` |
| `l` | Location | `Remote`, `United+States` |
| `fromage` | Days since posted | `1`, `3`, `7`, `14` |
| `start` | Pagination | `0`, `10`, `20` |
| `salary` | Salary filter | `$200,000` (limited support) |

### Dice
| Param | Meaning | Example |
|-------|---------|---------|
| `q` | Query | `agentic%20AI%20engineer%20remote` |
| `location` | Location | `Remote`, `United%20States` |
| `radius` | Distance | `30`, `50` (miles) |
| `page` | Page number | `1`, `2`, `3` |
| `sort` | Sort order | `relevance`, `date` |