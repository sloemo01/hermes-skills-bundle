---
name: mcp-server-research
description: Find free MCP servers for any research topic — data APIs, developer tools, automation, finance, science, or any domain. Covers search patterns, evaluation criteria, and quick-start configs.
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [research, mcp, mcp-servers, tools, api, automation, data]
    homepage: ""
---

# MCP Server Research

This skill helps you find free MCP (Model Context Protocol) servers for **any research topic** — data APIs, developer tools, automation, financial data, scientific data, cloud infrastructure, or any domain.

## When to Use

- User asks "find MCP servers for [TOPIC]"
- User needs natural-language access to data sources or APIs
- User wants to monitor websites, APIs, or services via AI
- User needs automated execution or data retrieval via MCP

## How It Works

1. **User specifies the research topic** (e.g., "GitHub automation", "weather data", "crypto prices", "Kubernetes monitoring", "scientific papers")
2. **Agent searches** across directories and GitHub for relevant MCP servers
3. **Agent evaluates** based on free tier, capabilities, maintenance
4. **Agent provides** quick-start configs and evaluation

---

## Research Methodology (via Kimi WebBridge)

### Search Strategy
1. **Directories**: mcpservers.org, awesomeclaude.ai/mcp/, github.com/topics/mcp-server
2. **GitHub Search**: `topic:mcp-server [TOPIC]` or `mcp server [TOPIC]`
3. **Vendor Sites**: Check official docs for MCP integrations
4. **Google**: `free MCP server [TOPIC]`, `MCP server [TOPIC] open source`

### Evaluation Criteria
- **Free tier limits**: requests/day, concurrent connections, data retention
- **Data sources**: official APIs, public data, proprietary
- **Capabilities**: read-only vs read-write, local vs remote
- **Maintenance**: stars, recent commits, issue response time
- **Security**: keys stay local (local servers) vs SaaS (remote)

---

## Quick-Start Patterns

### Local Server (Recommended for Privacy)
```bash
pip install mcp-server-[TOPIC]
mcp-server-[TOPIC]
```

```json
{
  "mcpServers": {
    "[topic]": {
      "command": "mcp-server-[topic]",
      "args": []
    }
  }
}
```

### Remote Server (Easier Setup)
```json
{
  "mcpServers": {
    "[topic]": {
      "command": "npx",
      "args": ["mcp-remote", "https://mcp.example.com/mcp"]
    }
  }
}
```

---

## Common MCP Server Categories

| Category | Examples | Use Cases |
|----------|----------|-----------|
| **Developer Tools** | GitHub, GitLab, Docker, Kubernetes | Repo management, CI/CD, container ops |
| **Cloud/Infra** | AWS, GCP, Azure, Terraform | Resource management, monitoring |
| **Data/Analytics** | PostgreSQL, SQLite, DuckDB, BigQuery | Query databases, analyze data |
| **Web/API** | HTTP clients, GraphQL, REST, Playwright | Web scraping, API integration, browser automation |
| **Communication** | Slack, Discord, Email, Notion | Messaging, documentation, collaboration |
| **AI/ML** | HuggingFace, Ollama, LocalAI, Embeddings | Model inference, embeddings, fine-tuning |
| **Monitoring** | Prometheus, Grafana, Pulsetic | Uptime, metrics, alerting |
| **Finance/Data** | Yahoo Finance, CCXT, Polygon, Alpha Vantage | Market data, crypto, forex |
| **Science/Research** | arXiv, PubMed, Crossref, semantic-scholar | Paper search, citations, datasets |

---

## Pitfalls to Avoid
- ❌ Assuming all "free" MCP servers allow write operations (most are read-only)
- ❌ Not checking rate limits on free tiers
- ❌ Using remote MCP without reviewing data privacy policies
- ❌ Missing that many local servers require API keys anyway
- ❌ Not verifying maintenance status (abandoned servers = broken tools)

---

## Key Sources (All via Kimi WebBridge)
- mcpservers.org
- awesomeclaude.ai/mcp/
- github.com/topics/mcp-server
- github.com/topics/model-context-protocol
- Individual vendor MCP pages

---

## Output Format

Return structured findings:
```json
{
  "topic": "[user's research topic]",
  "servers_found": [
    {
      "name": "[server name]",
      "type": "local|remote",
      "category": "[category]",
      "free_tier": "[limits]",
      "key_features": ["feature1", "feature2"],
      "install_cmd": "[command]",
      "config_json": {},
      "github_url": "[url]",
      "stars": 123,
      "last_updated": "2026-01-15",
      "privacy": "local_keys_stay_local|remote_saas"
    }
  ],
  "recommendations": {
    "best_local": "[server name]",
    "best_remote": "[server name]",
    "easiest_setup": "[server name]"
  }
}
```