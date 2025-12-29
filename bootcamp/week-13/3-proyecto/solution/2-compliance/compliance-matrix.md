# Compliance Control Matrix - NexaCloud Technologies

## 📋 Overview

Este documento mapea los controles de seguridad implementados en NexaCloud contra los frameworks de compliance requeridos: **SOC 2 Type II**, **GDPR**, e **ISO 27001:2022**.

---

## 🔐 Access Control

| Control | SOC 2 | GDPR | ISO 27001 | GitHub Implementation | Evidence Location |
|---------|-------|------|-----------|----------------------|-------------------|
| Multi-Factor Authentication | CC6.1 | Art.32 | A.8.5 | 2FA enforced org-wide | Org Settings Export |
| Single Sign-On (SAML) | CC6.1 | Art.32 | A.8.5 | Okta SAML configured | IdP Audit Logs |
| Role-Based Access | CC6.3 | Art.32 | A.5.15 | GitHub Teams + Roles | Team membership export |
| Least Privilege | CC6.3 | Art.25 | A.5.18 | Repository permissions | Permission audit |
| Access Reviews | CC6.2 | Art.32 | A.5.18 | Quarterly reviews | Review documentation |
| Privileged Access Management | CC6.1 | Art.32 | A.8.2 | Admin role restrictions | Admin audit log |
| Session Management | CC6.6 | Art.32 | A.8.11 | Session timeout config | Org settings |

---

## 📊 Audit & Monitoring

| Control | SOC 2 | GDPR | ISO 27001 | GitHub Implementation | Evidence Location |
|---------|-------|------|-----------|----------------------|-------------------|
| Audit Logging | CC7.2 | Art.30 | A.8.16 | Audit log streaming | Splunk/S3 |
| Security Monitoring | CC7.2 | Art.32 | A.8.16 | Security Overview dashboard | Dashboard export |
| Alert Configuration | CC7.3 | Art.33 | A.5.25 | Dependabot + Code scanning alerts | Alert history |
| Log Retention | CC7.2 | Art.30 | A.8.16 | 90-day GitHub + 1 year external | Retention policy doc |
| Activity Monitoring | CC7.2 | Art.30 | A.8.16 | Audit log events | Daily log exports |
| Anomaly Detection | CC7.2 | Art.32 | A.8.16 | SIEM correlation rules | SIEM config |
| Incident Logging | CC7.3 | Art.33 | A.5.26 | Incident tracking system | Incident records |

---

## 🛡️ Vulnerability Management

| Control | SOC 2 | GDPR | ISO 27001 | GitHub Implementation | Evidence Location |
|---------|-------|------|-----------|----------------------|-------------------|
| Dependency Scanning | CC7.1 | Art.32 | A.8.8 | Dependabot alerts enabled | Alert dashboard |
| Code Scanning | CC7.1 | Art.32 | A.8.8 | CodeQL enabled all repos | Security Overview |
| Secret Detection | CC6.7 | Art.32 | A.8.9 | Secret scanning + push protection | Alert history |
| Vulnerability Tracking | CC7.1 | Art.32 | A.8.8 | GitHub Security Advisories | Advisory list |
| Remediation SLAs | CC7.1 | Art.32 | A.8.8 | MTTR tracking | Metrics dashboard |
| Third-Party Assessment | CC7.1 | Art.32 | A.5.22 | Annual pen test | Pen test report |
| Patch Management | CC7.1 | Art.32 | A.8.8 | Dependabot security updates | PR history |

---

## 🔄 Change Management

| Control | SOC 2 | GDPR | ISO 27001 | GitHub Implementation | Evidence Location |
|---------|-------|------|-----------|----------------------|-------------------|
| Code Review | CC8.1 | Art.32 | A.8.9 | Required PR reviews | Branch protection |
| Branch Protection | CC8.1 | Art.32 | A.8.9 | Rules enforced | Ruleset config |
| CI/CD Security | CC8.1 | Art.32 | A.8.31 | Required status checks | Workflow config |
| Deployment Approval | CC8.1 | Art.32 | A.8.32 | Environment protection | Environment settings |
| Rollback Capability | CC8.1 | Art.32 | A.8.32 | Git revert + deployment | Deployment history |
| Change Documentation | CC8.1 | Art.30 | A.8.9 | PR descriptions + commits | Git history |
| Emergency Changes | CC8.1 | Art.32 | A.5.26 | Bypass with audit | Audit log |

---

## 🔒 Data Protection

| Control | SOC 2 | GDPR | ISO 27001 | GitHub Implementation | Evidence Location |
|---------|-------|------|-----------|----------------------|-------------------|
| Data Classification | CC6.7 | Art.30 | A.5.12 | Repository topics + labels | Repo metadata |
| Encryption at Rest | CC6.7 | Art.32 | A.8.24 | GitHub managed | GitHub SOC 2 |
| Encryption in Transit | CC6.7 | Art.32 | A.8.24 | TLS 1.2+ enforced | Config verification |
| Data Retention | CC6.5 | Art.17 | A.8.10 | Retention policies | Policy document |
| Data Deletion | CC6.5 | Art.17 | A.8.10 | Repo deletion process | Deletion logs |
| Backup & Recovery | CC9.1 | Art.32 | A.8.13 | GitHub redundancy | GitHub SLA |

---

## 📝 Policy & Governance

| Control | SOC 2 | GDPR | ISO 27001 | GitHub Implementation | Evidence Location |
|---------|-------|------|-----------|----------------------|-------------------|
| Security Policy | CC1.1 | Art.32 | A.5.1 | SECURITY.md in repos | File presence |
| Acceptable Use | CC1.2 | Art.32 | A.5.10 | Contributing guidelines | CONTRIBUTING.md |
| Incident Response | CC7.3 | Art.33 | A.5.24 | IR playbooks | Runbook repo |
| Vendor Management | CC9.2 | Art.28 | A.5.21 | GitHub BAA/DPA | Contract docs |
| Training | CC1.4 | Art.32 | A.6.3 | Security champion program | Training records |

---

## 📊 Summary Statistics

| Framework | Total Controls | Implemented | Coverage |
|-----------|----------------|-------------|----------|
| SOC 2 | 35 | 35 | 100% |
| GDPR | 35 | 35 | 100% |
| ISO 27001 | 35 | 35 | 100% |

---

## 🔄 Review Schedule

| Activity | Frequency | Owner | Next Review |
|----------|-----------|-------|-------------|
| Control Effectiveness | Quarterly | Security Team | Q1 2026 |
| Matrix Update | Bi-annually | Compliance Lead | June 2026 |
| Full Audit | Annually | External Auditor | December 2026 |

---

*Last Updated: December 2025*
*Owner: NexaCloud Compliance Team*
