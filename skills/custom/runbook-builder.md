---
name: runbook-builder
description: Turns a described procedure into a formatted runbook with prerequisites, numbered steps, verification checks, and rollback instructions. Use for SOPs, deployment procedures, maintenance windows, or any repeatable IT operation.
---

## When to use this skill

Use when asked to create, document, or formalise any repeatable procedure:
- Deployment and release procedures
- Maintenance window tasks
- Disaster recovery steps
- Onboarding/offboarding procedures
- Scheduled operational tasks
- Troubleshooting guides

## Information to gather before writing

If the user hasn't provided these, ask:
1. **What is the procedure?** (name and one-line description)
2. **Who runs this?** (role/team — affects language complexity)
3. **What environment?** (prod / staging / lab — affects risk warnings)
4. **Are there dependencies?** (what must be true before starting)
5. **What does success look like?** (verification criteria)
6. **Is there a rollback?** (what to do if it goes wrong)

## Output format

```markdown
# Runbook: [Procedure Name]

**Version:** 1.0
**Last updated:** [date]
**Owner:** [team/role]
**Environment:** [prod/staging/lab]
**Estimated duration:** [time]

---

## Purpose
[One sentence. What this procedure does and why.]

## Prerequisites
- [ ] [System/access/state that must be true before starting]
- [ ] [List each dependency]

## Risk level
[Low / Medium / High] — [one sentence justification]

> **Warning:** [Any destructive or irreversible steps called out here]

---

## Steps

### 1. [Step name]
**Run as:** [user/role]

[Clear instruction. One action per step. Use code blocks for commands.]

```bash
# example command
```

**Verify:** [How to confirm this step succeeded before continuing]

---

### 2. [Step name]
...

---

## Verification
[How to confirm the entire procedure completed successfully]

```bash
# verification command or check
```

Expected output:
```
[what success looks like]
```

---

## Rollback
> Only follow if the procedure fails and needs to be reversed.

### 1. [Rollback step]
...

**Rollback verification:** [how to confirm rollback succeeded]

---

## Notes
- [Any edge cases, known issues, or environment-specific variations]

## Change log
| Version | Date | Author | Change |
|---------|------|--------|--------|
| 1.0 | [date] | [author] | Initial version |
```

## Rules

- One action per step — never combine two operations into one step
- Every step has a verification check
- Commands go in code blocks with the correct shell specified
- Destructive or irreversible steps get a `> **Warning:**` callout
- Rollback section is mandatory for Medium and High risk procedures
- Apply `stop-slop` rules — direct language, name the actor, no filler

## Keywords
runbook, SOP, procedure, deployment, maintenance, steps, checklist, operations, playbook
