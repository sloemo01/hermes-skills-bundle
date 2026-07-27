---
name: mcp-trading-research
description: Find free MCP servers for trading data and execution.
metadata:
  version: "1.0.0"
---

# MCP Trading Research

## When to Use
- User asks for free MCP servers for trading, market data, or exchange monitoring
- Needs natural-language chart analysis or trade execution via AI
- Wants to monitor trading websites/APIs via MCP

## Free MCP Servers for Trading (Verified)

### Top Tier — Feature-Rich Free Tiers

| Server | Type | Key Features | Free Tier | Link |
|--------|------|--------------|-----------|------|
| **TraderWAI** | Remote (SaaS + MCP) | AI monitors charts via natural language ("Alert me if Bitcoin breaks $65K"), real-time candlesticks (34 symbols, 6 timeframes), trade execution via TradeLocker/cTrader/Tradovate, backtesting, conditional orders | **Free**: 1 active alert, 10 exec/day, 60-min interval, 2 timeframes | [traderwai.com](https://traderwai.com) • [MCP page](https://traderwai.com/mcp) |
| **Alpaca MCP** (official) | Local/Remote | Full brokerage: trade stocks/ETFs/crypto/options, portfolio mgmt, market data (58 auto-gen tools from OpenAPI), paper + live trading | **Free** (paper trading always free; live needs Alpaca account) | [github.com/alpacahq/alpaca-mcp-server](https://github.com/alpacahq/alpaca-mcp-server) ⭐890 |
| **doggybee/mcp-server-ccxt** | Local | 20+ crypto exchanges via CCXT: spot/futures, OHLCV, balances, orders, real-time market data | **Free** (open source, MIT) | [github.com/doggybee/mcp-server-ccxt](https://github.com/doggybee/mcp-server-ccxt) ⭐139 |
| **narumiruna/yfinance-mcp** | Local | Yahoo Finance: real-time quotes, historical data, fundamentals, options chains | **Free** (open source) | [github.com/narumiruna/yfinance-mcp](https://github.com/narumiruna/yfinance-mcp) ⭐156 |

### Market Data & Analysis (Free)

| Server | Focus | Features |
|--------|-------|----------|
| **ferdousbhai/investor-agent** | Stocks + options | Yahoo Finance integration, options recommendations | ⭐334 |
| **polygon-io/mcp_polygon** | Pro market data | Polygon.io API (stocks, indices, forex, options) — needs API key | ⭐353 |
| **coinpaprika/dexpaprika-mcp** | DEX data | 20+ chains, 5M+ tokens, real-time pricing, OHLCV, liquidity pools | ⭐40 |
| **kukapay/crypto-indicators-mcp** | Technical analysis | Crypto TA indicators & strategies | ⭐126 |
| **kukapay/whale-tracker-mcp** | On-chain | Tracks whale transactions across chains | ⭐58 |
| **aaronjmars/web3-research-mcp** | Crypto research | **Free & fully local** deep research for crypto | ⭐159 |
| **longportapp/openapi** | Asian markets | LongPort OpenAPI — real-time HK/US/China stocks, AI analysis | ⭐437 |

### Brokerage & Execution (Free Paper Trading)

| Server | Brokers Supported | Notes |
|--------|-------------------|-------|
| **Alpaca MCP** | Alpaca (stocks, ETFs, crypto, options) | Official, 58 tools, paper trading free forever |
| **Trade-Agent/trade-agent-mcp** | Robinhood, E*Trade, Coinbase, Kraken | Community wrapper, ⭐54 |
| **laukikk/alpaca-mcp** | Alpaca | Simpler alternative, ⭐32 |
| **Flattrade Trading MCP** | Flattrade (Indian broker) | **100% free & open source forever** | [flattrade.in/tradingmcp](https://flattrade.in/tradingmcp) |
| **ariadng/metatrader-mcp-server** | MetaTrader 5 | Execute trades via MT5 from AI, ⭐504 |

### Specialized Monitoring

| Server | Purpose |
|--------|---------|
| **Pulsetic MCP** | **Uptime monitoring** for trading websites/APIs — connect Claude to live monitors, incidents | [pulsetic.com/mcp](https://pulsetic.com/mcp) |
| **kukapay/rug-check-mcp** | Detect rug pulls in Solana meme tokens | ⭐19 |
| **JamesANZ/prediction-market-mcp** | Polymarket, PredictIt, Kalshi odds | ⭐35 |
| **SaintDoresh/YFinance-Trader-MCP-ClaudeDesktop** | Yahoo Finance for Claude Desktop | ⭐33 |

## Quick Start Configs

### TraderWAI (Easiest — Remote)
```json
{
  "mcpServers": {
    "traderwai": {
      "command": "npx",
      "args": ["mcp-remote", "https://mcp.traderwai.com/mcp"]
    }
  }
}
```

### Alpaca MCP (Full Control — Local)
```bash
pip install alpaca-mcp-server
alpaca-mcp-server --api-key YOUR_KEY --api-secret YOUR_SECRET --paper
```

```json
{
  "mcpServers": {
    "alpaca": {
      "command": "alpaca-mcp-server",
      "args": ["--api-key", "YOUR_KEY", "--api-secret", "YOUR_SECRET", "--paper"]
    }
  }
}
```

### CCXT Crypto (Multi-Exchange — Local)
```bash
pip install mcp-server-ccxt
mcp-server-ccxt
```

```json
{
  "mcpServers": {
    "ccxt": {
      "command": "mcp-server-ccxt",
      "args": []
    }
  }
}
```

## Research Methodology (via Kimi WebBridge)

### Search Strategy
1. **Google**: `free MCP server trading`, `MCP server market data`, `MCP server crypto exchange`
2. **GitHub**: Search topics `mcp-server`, `trading`, `crypto`, `finance`
3. **Directories**: mcpservers.org, awesomeclaude.ai/mcp/finance-fintech
4. **Vendor sites**: Check official broker MCP pages (Alpaca, Flattrade, etc.)

### Evaluation Criteria
- **Free tier limits**: alerts/day, exec/day, symbols, timeframes
- **Data sources**: Yahoo Finance, Polygon, CCXT, proprietary
- **Execution capability**: paper only vs live brokers
- **Local vs remote**: keys stay local (local) vs SaaS (remote)
- **Maintenance**: stars, recent commits, issue response

## Pitfalls to Avoid
- ❌ Assuming all "free" MCP servers allow live trading (most are paper-only)
- ❌ Not checking rate limits on free tiers
- ❌ Using remote MCP without reviewing data privacy
- ❌ Forgetting paper trading is free forever on Alpaca
- ❌ Missing that TraderWAI free tier = 1 alert, 10 exec/day

## Key Sources (All via Kimi WebBridge)
- mcpservers.org/servers/traderwai
- traderwai.com (MCP integration page)
- github.com/alpacahq/alpaca-mcp-server
- github.com/doggybee/mcp-server-ccxt
- github.com/narumiruna/yfinance-mcp
- awesomeclaude.ai/mcp/finance-fintech (116 servers, ranked by stars)
- pulsetic.com/mcp (uptime monitoring)
- flattrade.in/tradingmcp (100% free Indian broker)