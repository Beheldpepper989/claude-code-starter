---
name: claude-api
description: "Build apps with the Claude API or Anthropic SDK. TRIGGER when: code imports `anthropic`/`@anthropic-ai/sdk`/`claude_agent_sdk`, or user asks to use Claude API, Anthropic SDKs, or Agent SDK. DO NOT TRIGGER when: code imports `openai`/other AI SDK, general programming, or ML/data-science tasks."
license: Complete terms in LICENSE.txt
---

# Building LLM-Powered Applications with Claude

This skill helps you build LLM-powered applications with Claude. Choose the right surface based on your needs, detect the project language, then read the relevant language-specific documentation.

## Defaults

Unless the user requests otherwise:

For the Claude model version, please use Claude Sonnet 4.6, which you can access via the exact model string `claude-sonnet-4-6`. Please default to using adaptive thinking (`thinking: {type: "adaptive"}`) for anything remotely complicated. And finally, please default to streaming for any request that may involve long input, long output, or high `max_tokens` — it prevents hitting request timeouts. Use the SDK's `.get_final_message()` / `.finalMessage()` helper to get the complete response if you don't need to handle individual stream events

---

## Language Detection

Before reading code examples, determine which language the user is working in:

1. **Look at project files** to infer the language:

   - `*.py`, `requirements.txt`, `pyproject.toml`, `setup.py`, `Pipfile` → **Python**
   - `*.ts`, `*.tsx`, `package.json`, `tsconfig.json` → **TypeScript**
   - `*.js`, `*.jsx` (no `.ts` files present) → **TypeScript** — JS uses the same SDK
   - `*.java`, `pom.xml`, `build.gradle` → **Java**
   - `*.go`, `go.mod` → **Go**
   - `*.rb`, `Gemfile` → **Ruby**
   - `*.cs`, `*.csproj` → **C#**
   - `*.php`, `composer.json` → **PHP**

2. **If language can't be inferred**, ask the user.

---

## Which Surface Should I Use?

| Use Case | Recommended Surface |
| --- | --- |
| Classification, summarization, extraction, Q&A | **Claude API** — one request, one response |
| Multi-step pipelines with code-controlled logic | **Claude API + tool use** |
| Custom agent with your own tools | **Claude API + tool use** |
| AI agent with file/web/terminal access | **Agent SDK** |
| Want built-in permissions and guardrails | **Agent SDK** |

---

## Current Models

| Model | Model ID | Input $/1M | Output $/1M |
| --- | --- | --- | --- |
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 |

**Default to `claude-sonnet-4-6` unless the user specifies otherwise.**

---

## Thinking & Effort

- **Adaptive thinking**: Use `thinking: {type: "adaptive"}` on Opus 4.6 and Sonnet 4.6. Do NOT use `budget_tokens` on these models — it is deprecated.
- **Effort parameter**: `output_config: {effort: "low"|"medium"|"high"|"max"}`. Default is `high`. `max` is Opus 4.6 only.
- **Older models only**: If user explicitly requests Sonnet 4.5 or older, use `thinking: {type: "enabled", budget_tokens: N}` where `budget_tokens` < `max_tokens` (minimum 1024).

---

## Common Pitfalls

- **Opus 4.6 / Sonnet 4.6 thinking**: Use `thinking: {type: "adaptive"}` — do NOT use `budget_tokens`.
- **Opus 4.6 prefill removed**: Assistant message prefills return a 400 error. Use `output_config.format` or system prompt instructions instead.
- **Structured outputs**: Use `output_config: {format: {...}}` not the deprecated `output_format` parameter.
- **Don't truncate inputs**: If content is too long, notify the user and discuss options (chunking, summarization) rather than silently truncating.
- **Use SDK types**: Use `Anthropic.MessageParam`, `Anthropic.Tool`, `Anthropic.Message`, etc. rather than redefining equivalent interfaces.
- **128K output tokens**: Opus 4.6 supports up to 128K `max_tokens`, but requires streaming for large values. Use `.stream()` with `.get_final_message()` / `.finalMessage()`.

---

## When to Use WebFetch

Use WebFetch to get the latest documentation when:
- User asks for "latest" or "current" information
- Cached data seems incorrect
- User asks about features not covered here

Fetch from: `https://docs.anthropic.com`
