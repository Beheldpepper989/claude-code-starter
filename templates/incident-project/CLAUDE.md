# Incident Response

## Context
An incident is active or under investigation. This session is focused on resolution and documentation.

## Active Skills
- `incident-response` — primary workflow, follow all phases in order
- `internal-comms` — for stakeholder updates and post-incident reports
- `stop-slop` — all comms must be direct and factual; no filler under pressure

## Immediate priorities (in order)
1. Establish severity (P1–P4) and impact scope
2. Containment — stop it spreading before investigating root cause
3. Communication — who needs to know, what do they need to know right now
4. Investigation — root cause only after containment
5. Recovery — restore in dependency order, verify at each step
6. Documentation — maintain live timeline throughout, produce PIR at close

## Live timeline (maintain throughout)
Start this immediately and update as events occur:
```
## Incident Timeline — [name/ID] — [date]

| Time (UTC) | Event |
|------------|-------|
| HH:MM | Incident detected / reported |
| HH:MM | [next event] |
```

## Communication cadence
- **P1:** Update stakeholders every 30 minutes until resolved
- **P2:** Update every hour
- **P3/P4:** Update at containment and at resolution

Update format (use `internal-comms` skill):
```
[TIME] STATUS UPDATE — [Incident name]
Status: Investigating / Contained / Resolving / Resolved
Impact: [current impact statement]
Last action: [what was just done]
Next action: [what happens next]
ETA: [if known] / Unknown
```

## Behaviour rules
- **Timebox investigation** — if root cause isn't found in 20 minutes, escalate and contain first
- **One change at a time** — don't make multiple changes simultaneously; you won't know what fixed it
- **Document as you go** — add to the timeline in real time, not from memory after
- **Confirm before remediation steps** — state what will change and what the rollback is
- **No blame** — PIR language is systemic, not personal

## Session close checklist
- [ ] Timeline complete and accurate
- [ ] Root cause confirmed (not just symptom)
- [ ] All containment / eradication / recovery steps logged
- [ ] Action items assigned with owners and due dates
- [ ] PIR drafted using `incident-response` skill
- [ ] Stakeholders notified of resolution
