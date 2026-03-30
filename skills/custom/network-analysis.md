---
name: network-analysis
description: Interprets and documents network output — nmap scans, traceroutes, routing tables, firewall rules, VLAN configs, packet captures, interface states. Produces structured summaries, flags anomalies, and identifies risks.
---

## When to use this skill

Use when given raw network output to interpret, document, or investigate:
- nmap / masscan scan results
- traceroute / pathping output
- routing tables (`ip route`, `show ip route`, `netstat -r`)
- firewall rule sets (iptables, Windows Firewall, pfSense, Cisco ACLs)
- VLAN/switching configs (`show vlan`, `show interfaces trunk`)
- interface states (`ip link`, `show interfaces`, `ifconfig`)
- ARP tables, MAC address tables
- DNS queries / dig / nslookup output
- Wireshark / tcpdump summaries

## Analysis approach

### 1. Identify what was provided
State clearly: what tool produced this output, what target/scope, and when (if known).

### 2. Parse and summarise
Extract the key facts in structured form — don't re-dump the raw output. Tables where appropriate.

### 3. Flag anomalies
Look for:
- Open ports that shouldn't be exposed (RDP/22/23/3389 on internet-facing hosts)
- Services running on non-standard ports
- Missing expected services
- Routing asymmetry or suboptimal paths
- Firewall rules that are overly permissive (ANY/ANY, 0.0.0.0/0)
- Unused or disabled interfaces that should be active
- VLAN mismatches or trunk issues
- Unexpected hosts on a segment
- DNS inconsistencies (PTR missing, CNAME loops)

### 4. Risk rating
Rate each finding:
- **High** — direct security or availability risk
- **Medium** — potential issue, warrants investigation
- **Low** — informational, best practice deviation
- **Info** — no action needed, context only

### 5. Recommendations
For each High and Medium finding, give a specific, actionable recommendation. Name the fix, not just the problem.

## Output format

```
## Network Analysis — [Description of input]

**Input type:** [nmap / traceroute / routing table / etc.]
**Scope/target:** [if known]
**Date:** [if known]

---

## Summary
[2–4 sentences: what was analysed, overall posture, key findings count]

## Findings

| # | Finding | Severity | Detail |
|---|---------|----------|--------|
| 1 | [finding] | High/Medium/Low/Info | [brief detail] |

## Finding Detail

### [#] [Finding title] — [Severity]
**Observed:** [what the data shows]
**Risk:** [why this matters]
**Recommendation:** [specific fix]

---

## Full Parsed Output
[Structured table or list of all parsed data — hosts, ports, routes, rules, etc.]
```

## Subnet / IP utilities

When asked, perform:
- Subnet calculations (CIDR to range, usable hosts, broadcast)
- IP class identification
- Supernetting / summarisation
- VLSM design for a given address space and requirement list

Show working so the user can verify.

## Keywords
nmap, traceroute, routing, firewall, ACL, VLAN, network scan, ports, interfaces, subnets, CIDR, iptables, Cisco, pfSense, packet capture, Wireshark, DNS, ARP
