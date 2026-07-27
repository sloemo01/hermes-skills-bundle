# Working with @e References in Kimi WebBridge

## Understanding @e References

The `@e` references returned by the `snapshot` tool (e.g., `@e58`, `@e100`) are **internal identifiers** used by the Kimi WebBridge extension to track DOM elements. They are **not** CSS selectors, XPath expressions that can be used with standard DOM methods like `document.querySelector()`.

## Common Error Pattern

Attempting to use `@e` references in JavaScript evaluation will fail:
```javascript
// ❌ WRONG - Causes "Failed to execute 'querySelector' on 'Document': '@e58' is not a valid selector"
document.querySelector("@e58").href

// ❌ WRONG - Causes JSON parsing issues when '@' appears in wrong context
{"action":"evaluate","args":{"code":"document.querySelector(\"@e58\").href"}}
```

## Correct Usage Patterns

### 1. For Actions (Click, Fill)
Pass `@e` references directly as the `selector` parameter:
```bash
# ✅ CORRECT
curl -s -X POST http://127.0.0.1:10086/command \
  -d '{"action":"click","args":{"selector":"@e58"},"session":"research-session"}'
```

### 2. For Attribute Extraction
Use the `@e` reference inside the `evaluate` code:
```bash
# ✅ CORRECT
curl -s -X POST http://127.0.0.1:10086/command \
  -d '{"action":"evaluate","args":{"code":"const el = document.querySelector(\"@e58\"); return el ? el.href : null;"},"session":"research-session"}'
```

### 3. For Text Content
Similar approach for getting text:
```bash
# ✅ CORRECT
curl -s -X POST http://127.0.0.1:10086/command \
  -d '{"action":"evaluate","args":{"code":"const el = document.querySelector(\"@e58\"); return el ? el.textContent.trim() : null;"},"session":"research-session"}'
```

## Workflow Best Practices

1. **Discover**: Use `snapshot` to get the accessibility tree with `@e` references
2. **Identify**: Find the target element by its `@e` reference and associated role/name/text
3. **Act**: For clicks/fills, pass `@e` reference directly as `selector`
4. **Extract**: For attributes/text, use `evaluate` with `@e` reference in the JS code
5. **Navigate**: For navigation, use `navigate` with the extracted URL

## Why This Design?

The `@e` references are internal to the Kimi WebBridge extension's DOM wrapper. They cannot be used as standard selectors because:
- They don't conform to CSS selector syntax
- They're not valid XPath expressions
- They're extension-specific identifiers that only work within the tool parameters

Attempting to use them in `document.querySelector()` or similar methods will always fail because the browser's native DOM API doesn't recognize these extension-specific identifiers.

## Troubleshooting

If you get errors like:
- `"Failed to execute 'querySelector' on 'Document': '@e58' is not a valid selector"`
- `"invalid JSON: invalid character '@' after object key:value pair"`

You're likely trying to use an `@e` reference incorrectly - either in a DOM query method or in a JSON context where it's breaking parsing.

Remember: `@e` references are **opaque tokens** meant only for direct use in the `selector` parameter of Kimi WebBridge tools.