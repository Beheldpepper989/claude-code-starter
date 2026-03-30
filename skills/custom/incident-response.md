---
name: incident-response
description: Structured IT incident response workflow. Use when handling, investigating, or documenting an incident. Guides through triage, containment, eradication, recovery, and produces a final write-up.
---

## When to use this skill

Use for any IT incident — outages, security events, degraded services, data issues, config failures. Also use to produce post-incident reports and lessons learned.

## Workflow

Work through each phase in order. Do not skip phases. Confirm with the user before moving to the next phase.

### Phase 1 — Triage
Establish the facts:
- What is the impact? (users affected, systems down, data at risk)
- When did it start? (exact timestamp if known)
- Who reported it and how?
- What changed recently? (deployments, patches, config changes, access changes)
- Current severity: **P1** (critical, production down) / **P2** (major, degraded) / **P3** (minor, workaround exists) / **P4** (informational)

Output: Incident summary with severity, impact statement, and initial hypothesis.

### Phase 2 — Containment
Stop the bleeding:
- What immediate actions can limit spread or impact?
- Is isolation needed? (network segment, account suspension, service shutdown)
- Is data at risk? (backups needed, access revoked?)
- Who needs to be notified now? (on-call, management, users)

Output: Containment actions taken with timestamps.

### Phase 3 — Investigation
Find the root cause:
- Gather logs, metrics, alerts relevant to the timeframe
- Map the sequence of events (timeline format: `HH:MM — event`)
- Identify the root cause (not just the symptom)
- Confirm hypothesis with evidence

Output: Root cause statement + evidence-backed event timeline.

### Phase 4 — Eradication
Remove the cause:
- What needs to be fixed, patched, removed, or rolled back?
- Are there related vulnerabilities or misconfigs to address at the same time?
- Verify the fix in a safe way before applying to production where possible

Output: Eradication steps with verification method.

### Phase 5 — Recovery
Restore service:
- Restore in correct order (dependencies first)
- Verify each component before proceeding
- Confirm service is healthy (metrics, synthetic checks, user validation)
- Define monitoring period before declaring resolved

Output: Recovery steps and confirmation of service restoration.

### Phase 6 — Post-Incident Report
Produce a structured write-up using `internal-comms` skill format if available, otherwise:

```
## Incident Report — [Title]

**Date:** [date]
**Severity:** [P1–P4]
**Duration:** [start] → [end] ([total duration])
**Affected systems:** [list]
**Root cause:** [one sentence]

## Timeline
[HH:MM — event, one per line]

## Impact
[Who/what was affected, quantified where possible]

## Root Cause Analysis
[Detailed explanation]

## Actions Taken
[Containment, eradication, recovery steps]

## Lessons Learned
[What went wrong systemically, not just technically]

## Action Items
| Item | Owner | Due date |
|------|-------|----------|
```

Apply `stop-slop` rules to the final report — no filler, direct language, name the actor.

## Keywords
incident, outage, P1, P2, triage, containment, root cause, post-mortem, RCA, IR, security event, degraded service
