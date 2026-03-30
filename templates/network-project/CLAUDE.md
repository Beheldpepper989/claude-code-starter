# Network Project

## Context
This is a network assessment, documentation, or troubleshooting project. Work involves analysing network output, documenting topology, or investigating connectivity issues.

## Active Skills
- `network-analysis` — use for all network output interpretation and subnet work
- `runbook-builder` — use for any remediation or change procedure
- `stop-slop` — apply to all written output; findings go to external or internal audiences

## Behaviour Rules
- **Never assume** — if the network output is ambiguous, ask before concluding
- **Timestamp everything** — note when data was collected; stale data produces wrong conclusions
- **Separate observation from inference** — label what the data shows vs. what it suggests
- **Flag scope gaps** — if the provided data doesn't cover something relevant, say so explicitly
- **External-safe output** — treat all output as potentially shareable; no internal IPs, hostnames, or credentials in examples unless the user confirms it's internal-only

## Standard deliverables
For assessments, produce in this order:
1. Executive summary (1 paragraph, non-technical)
2. Findings table (severity-sorted)
3. Finding detail with remediation
4. Full parsed output / topology notes

For troubleshooting, produce:
1. Symptom and scope
2. Evidence gathered
3. Root cause
4. Fix applied / recommended

## Assumptions to clarify at session start
- Is this a security assessment, documentation exercise, or live troubleshooting?
- What is the scope? (single host / segment / full network)
- Will output be shared externally?
- What tools/data are available?
