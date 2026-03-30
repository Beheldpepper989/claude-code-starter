---
name: cloud-review
description: Reviews cloud configurations (Azure, AWS) for security issues, misconfigurations, and cost problems. Works from pasted config, ARM/Bicep/Terraform output, CLI output, or policy exports. Produces a prioritised findings list with remediation steps.
---

## When to use this skill

Use when given cloud configuration to review:
- ARM templates / Bicep files
- Terraform plans or state
- Azure CLI / AWS CLI output
- IAM policies, role assignments, security group rules
- Storage account / S3 bucket configs
- Network security groups / VPC security groups
- Key Vault / Secrets Manager configs
- VM / EC2 instance configs
- Azure Policy / AWS Config rules
- Cost and usage reports

## Review framework

### Security (check first)

**Identity and Access**
- Overly permissive roles (Owner/Contributor/AdministratorAccess assigned broadly)
- Service principals / IAM users with more permissions than needed
- MFA not enforced on privileged accounts
- Stale accounts or unused service principals
- Secrets stored in environment variables, tags, or template parameters instead of Key Vault / Secrets Manager

**Network**
- NSG/security group rules with source `*` / `0.0.0.0/0` on management ports (22, 3389, 5985)
- Public IPs on resources that don't need them
- No private endpoints where available
- Missing DDoS protection on public-facing resources
- Unrestricted outbound rules

**Data**
- Storage accounts / S3 buckets with public access enabled
- Unencrypted disks or storage
- No soft delete / versioning on storage
- Backup not configured or retention too short
- Diagnostic logs not enabled or retention too short

**Compute**
- VMs running without endpoint protection
- Auto-patching disabled
- Deprecated OS versions
- Managed identity not used where service principal is used instead

### Cost (check second)

- Unattached disks, NICs, public IPs, or unused resources
- VMs sized larger than workload requires
- Resources in wrong tier (Premium where Standard works)
- No auto-shutdown on dev/lab VMs
- Reservations or savings plans not used for stable workloads
- Orphaned resource groups or deployments

### Compliance / Best Practice (check third)

- Missing tags (environment, owner, cost centre)
- Resources not in correct region (data residency)
- No resource locks on production resources
- Diagnostic settings not configured
- Azure Policy / AWS Config not covering the resource type

## Output format

```
## Cloud Review — [Description of input]

**Platform:** [Azure / AWS / multi-cloud]
**Config type:** [ARM / Terraform / CLI output / etc.]
**Scope:** [subscription / account / resource group / specific resource]

---

## Summary
[2–4 sentences: what was reviewed, overall posture, total findings by severity]

## Findings

| # | Finding | Severity | Resource | Category |
|---|---------|----------|----------|----------|
| 1 | [finding] | Critical/High/Medium/Low/Info | [resource name] | Security/Cost/Compliance |

## Finding Detail

### [#] [Finding title] — [Severity]
**Resource:** [resource name / type]
**Observed:** [what the config shows]
**Risk:** [why this matters]
**Remediation:** [specific steps to fix — include CLI command or config snippet where applicable]

---

## Positive Findings
[What is configured correctly — brief list]
```

## Severity definitions

| Severity | Meaning |
|---|---|
| **Critical** | Immediate risk — data exposure, privilege escalation, active exploit surface |
| **High** | Significant risk requiring prompt remediation |
| **Medium** | Should be fixed, not urgent |
| **Low** | Best practice deviation, low direct risk |
| **Info** | Observation, no action required |

## Rules

- Always check security before cost before compliance
- Give a specific remediation for every Critical and High finding — not "review your permissions"
- Include CLI snippets or config examples in remediations where possible
- Note if a finding cannot be confirmed from the provided input and what additional info is needed
- Apply `stop-slop` rules — direct language, name the resource and actor

## Keywords
Azure, AWS, cloud, ARM, Bicep, Terraform, IAM, NSG, security group, storage, S3, Key Vault, RBAC, cost, misconfig, review, audit, compliance
