# Search Engine Preference

When conducting web research tasks, the user has expressed a clear preference for using Google.com as the primary search engine over other platforms like Behance.net, X/Twitter, or specialized sites unless specifically instructed otherwise.

## Guidance

- When a user requests to search for a topic without specifying a platform, default to Google search
- If the user explicitly says "go to google.com and not [other site]", respect this instruction and use Google
- For general research queries, use Google search queries unless the task specifically requires another platform
- This preference helps maintain consistency and leverages the user's trusted search environment

## Implementation

For general topic research, use URLs like:
- `https://www.google.com/search?q=<search terms>`
- `https://www.google.com/search?q=<quoted phrase>` for exact matches
- `https://www.google.com/search?q=site:<domain> <search terms>` for site-specific searches

Only deviate from Google when:
1. The user explicitly requests another platform (e.g., "search GitHub for...")
2. The task requires platform-specific functionality (e.g., analyzing code repositories requires GitHub)
3. The user provides a specific URL to visit

This preference does not override specific user instructions but serves as a default when no platform is specified.