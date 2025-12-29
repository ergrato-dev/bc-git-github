# VDP Triage Playbook - NexaCloud Technologies

## 📋 Overview

Este playbook define el proceso de triage para reportes de vulnerabilidades recibidos a través del VDP de NexaCloud.

---

## 📥 Receipt Phase

### Initial Receipt Checklist

```markdown
## Report Receipt - NC-2025-XXXX

**Received**: [timestamp]
**Channel**: [ ] GitHub PVR  [ ] Email  [ ] Other
**Reporter**: [name/handle]
**Contact**: [email]

### Initial Actions
- [ ] Log in tracking system
- [ ] Assign tracking ID
- [ ] Send acknowledgment (within SLA)
- [ ] Assign to on-call triager
```

### Acknowledgment Template

```markdown
Subject: [NC-2025-XXXX] Vulnerability Report Received

Dear [Researcher],

Thank you for your security report to NexaCloud Technologies.

**Tracking ID**: NC-2025-XXXX
**Received**: [date/time UTC]
**Status**: Under Review

We will triage your report and respond with our assessment 
within [SLA timeframe based on initial severity estimate].

Please use this tracking ID in all future communications.

Best regards,
NexaCloud Security Team
security@nexacloud.io
```

---

## 🔍 Validation Phase

### Validation Checklist

```markdown
## Validation - NC-2025-XXXX

### 1. Scope Check
- [ ] Asset is in scope (Tier 1/2/3)
- [ ] Vulnerability type is in scope
- [ ] Testing was within rules of engagement

### 2. Reproduction
- [ ] Steps are clear and complete
- [ ] Reproduced in test environment
- [ ] Screenshots/PoC verified
- [ ] Confirmed not false positive

### 3. Duplicate Check
- [ ] Checked against open reports
- [ ] Checked against recently fixed
- [ ] Checked against known issues

### 4. Validation Result
- [ ] VALID - New vulnerability
- [ ] DUPLICATE - Reference: NC-XXXX-XXXX
- [ ] INVALID - Reason: _______________
- [ ] OUT OF SCOPE - Reason: _______________
```

---

## 📊 Severity Assessment

### CVSS 3.1 Calculator

Use [FIRST CVSS Calculator](https://www.first.org/cvss/calculator/3.1)

### Quick Severity Guide

| Vulnerability Type | Typical CVSS | Severity |
|--------------------|--------------|----------|
| Unauthenticated RCE | 9.8 | Critical |
| SQL Injection (data access) | 8.6 | High |
| Auth bypass | 8.1 | High |
| Stored XSS (admin) | 7.5 | High |
| IDOR (sensitive data) | 6.5 | Medium |
| Reflected XSS | 5.4 | Medium |
| Information disclosure | 4.3 | Medium |
| Open redirect | 3.7 | Low |

### Severity Decision Matrix

```markdown
## Severity Assessment - NC-2025-XXXX

**CVSS Vector**: [paste vector string]
**CVSS Score**: [0.0-10.0]

### Impact Analysis
- Confidentiality: [ ] None [ ] Low [ ] High
- Integrity: [ ] None [ ] Low [ ] High  
- Availability: [ ] None [ ] Low [ ] High

### Business Context
- Affected users: [ ] None [ ] Some [ ] All
- Data type: [ ] Public [ ] Internal [ ] Sensitive [ ] PII
- Exploitability: [ ] Theoretical [ ] PoC [ ] Active

### Final Severity
- [ ] 🔴 Critical (9.0-10.0)
- [ ] 🟠 High (7.0-8.9)
- [ ] 🟡 Medium (4.0-6.9)
- [ ] 🟢 Low (0.1-3.9)
- [ ] ⚪ Informational (0.0)
```

---

## 🚨 Escalation Matrix

| Severity | Escalate To | Timeline | Actions |
|----------|-------------|----------|---------|
| 🔴 Critical | CISO + On-call Lead | Immediate | Page, war room |
| 🟠 High | Security Lead | 4 hours | Slack alert |
| 🟡 Medium | Security Team | 24 hours | Ticket |
| 🟢 Low | Triage Rotation | 48 hours | Queue |

### Critical Escalation Procedure

```markdown
## CRITICAL ESCALATION - NC-2025-XXXX

1. [ ] Page CISO via PagerDuty
2. [ ] Page Security Lead
3. [ ] Create war room (Slack: #incident-XXXX)
4. [ ] Initial assessment (15 min)
5. [ ] Determine if active exploitation
6. [ ] Initiate incident response if needed
7. [ ] Assign remediation owner
8. [ ] Establish communication cadence
```

---

## 📝 Triage Response Templates

### Valid - Accepted

```markdown
Subject: [NC-2025-XXXX] Vulnerability Confirmed

Dear [Researcher],

Thank you for your report. We have validated your finding.

**Tracking ID**: NC-2025-XXXX
**Status**: Confirmed
**Severity**: [Critical/High/Medium/Low]
**CVSS Score**: [X.X]

We are working on a fix and will keep you updated on progress.
Expected resolution: [target date]

Thank you for helping keep NexaCloud secure.

Best regards,
NexaCloud Security Team
```

### Invalid - Not Reproducible

```markdown
Subject: [NC-2025-XXXX] Unable to Reproduce

Dear [Researcher],

Thank you for your report. Unfortunately, we were unable to 
reproduce the vulnerability based on the information provided.

Could you please provide:
- Exact URL/endpoint tested
- Browser/tool version
- Account type used
- Network conditions
- Additional screenshots or video

We're happy to re-evaluate with more details.

Best regards,
NexaCloud Security Team
```

### Duplicate

```markdown
Subject: [NC-2025-XXXX] Duplicate Report

Dear [Researcher],

Thank you for your report. This vulnerability was previously 
reported and is being tracked internally.

**Original Report**: [date of first report]
**Status**: [In Progress / Fixed]

While we cannot offer recognition for duplicate findings, 
we appreciate your effort to improve our security.

Best regards,
NexaCloud Security Team
```

### Out of Scope

```markdown
Subject: [NC-2025-XXXX] Out of Scope

Dear [Researcher],

Thank you for your report. Unfortunately, the reported item 
falls outside the scope of our VDP:

**Reason**: [specific reason]

Please review our scope at:
https://github.com/nexacloud/platform/security/policy

We encourage you to continue testing within scope.

Best regards,
NexaCloud Security Team
```

---

## 📊 Metrics to Track

| Metric | Target | Measurement |
|--------|--------|-------------|
| Acknowledgment SLA | 100% | Time to first response |
| Triage SLA | 95% | Time to severity assignment |
| Valid Report Rate | Track | Valid / Total reports |
| Duplicate Rate | <20% | Duplicates / Total |
| MTTR by Severity | Per SLA | Time to fix |
| Researcher Satisfaction | >4.0/5 | Survey score |

---

## 🔄 Weekly Triage Review

```markdown
## Weekly VDP Review - Week of [date]

### Summary
- New reports: X
- Closed: X
- Open: X

### By Severity
| Severity | New | Closed | Open |
|----------|-----|--------|------|
| Critical | 0 | 0 | 0 |
| High | X | X | X |
| Medium | X | X | X |
| Low | X | X | X |

### SLA Compliance
- Acknowledgment: XX%
- Triage: XX%
- Resolution: XX%

### Action Items
1. [item]
2. [item]
```

---

*Last Updated: December 2025*
*Owner: NexaCloud Security Team*
