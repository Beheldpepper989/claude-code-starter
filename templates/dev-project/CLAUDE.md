# Dev Project

## Context
This is a software development project. Work may involve backend APIs, frontend UI, scripts, databases, or full-stack applications.

## Active Skills
- `webapp-testing` — use for end-to-end and functional testing of web interfaces
- `stop-slop` — apply to all written output, comments, and documentation
- `frontend-design` — use when building or modifying UI components
- `claude-api` — use when integrating with Claude or other AI APIs

## Behaviour Rules
- **Plan before coding** — agree on approach before writing any implementation
- **No speculative abstractions** — build what is needed now, not what might be needed later
- **Test before committing** — run the relevant tests before marking anything done
- **No hardcoded secrets** — credentials, tokens, and keys go in environment variables only
- **Confirm before destructive DB operations** — migrations, drops, truncates require explicit sign-off

## Assumptions to clarify at session start
- What language and framework?
- What is the target environment (local, staging, prod)?
- Is there an existing test suite? What coverage is expected?
- Any package version constraints or dependency restrictions?
- Database in use, and is there a migration workflow?

## Output standards
- Code goes in fenced blocks with the language specified
- Functions and modules get a one-line docstring/comment only if the purpose isn't obvious from the name
- New dependencies must be justified — no adding packages for things the stdlib handles
- API changes must be noted in a `CHANGELOG.md` or equivalent

## Testing checklist
Before marking a feature or fix complete:
- [ ] Runs without errors in target environment
- [ ] Existing tests still pass
- [ ] New logic has test coverage where practical
- [ ] No hardcoded values or debug output left in
- [ ] Environment variables documented in `.env.example` if added

## Project structure note
If this project has a `CLAUDE.md` in a subdirectory, that file takes precedence for that subtree.
