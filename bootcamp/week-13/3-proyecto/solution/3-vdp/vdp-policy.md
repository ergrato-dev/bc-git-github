# Vulnerability Disclosure Policy - NexaCloud Technologies

## 📋 Introduction

NexaCloud Technologies welcomes security researchers to report vulnerabilities responsibly. This Vulnerability Disclosure Policy (VDP) outlines how to submit reports, what to expect from us, and our commitment to working with the security community.

---

## 🎯 Scope

### Tier 1 - Critical Assets (Highest Priority)

| Asset | Type | Description |
|-------|------|-------------|
| `app.nexacloud.io` | Web Application | Main platform |
| `api.nexacloud.io` | API | Public REST/GraphQL API |
| `auth.nexacloud.io` | Auth Service | OAuth/SAML provider |
| `billing.nexacloud.io` | Payment | Billing portal |
| `*.nexacloud.io` APIs | API | All production APIs |

### Tier 2 - High Priority

| Asset | Type | Description |
|-------|------|-------------|
| `console.nexacloud.io` | Web Application | Admin console |
| NexaCloud CLI | Software | Command-line tool |
| NexaCloud SDKs | Libraries | Go, Python, JS, Java |
| Mobile Apps | iOS/Android | Official mobile apps |

### Tier 3 - Standard

| Asset | Type | Description |
|-------|------|-------------|
| `docs.nexacloud.io` | Documentation | Public docs |
| `status.nexacloud.io` | Status Page | Service status |
| Open Source Projects | GitHub | Public repositories |

### Out of Scope

- Third-party services and integrations
- Physical security attacks
- Social engineering (phishing, vishing)
- Denial of Service (DoS/DDoS)
- Spam or SEO issues
- Self-XSS without impact on others
- Issues requiring physical access
- Vulnerabilities in outdated browsers
- Missing security headers without exploit

---

## 📜 Rules of Engagement

### ✅ Permitted Activities

- Testing on your own accounts only
- Non-destructive vulnerability testing
- Reporting vulnerabilities via official channels
- Providing detailed reproduction steps
- Keeping findings confidential until resolved

### ❌ Prohibited Activities

- Accessing data belonging to other users
- Modifying or deleting data
- Executing denial of service attacks
- Social engineering NexaCloud employees
- Physical attacks on infrastructure
- Automated scanning without coordination
- Public disclosure before agreed timeline
- Selling or sharing vulnerability details

---

## 📝 Reporting Process

### Step 1: Discover

When you find a potential vulnerability, gather:
- Detailed description
- Steps to reproduce
- Proof of concept (screenshots, code, video)
- Impact assessment

### Step 2: Report

**Primary Channel** (Preferred):
- GitHub Private Vulnerability Reporting
- [Report Here](https://github.com/nexacloud/platform/security/advisories/new)

**Alternative Channel**:
- Email: security@nexacloud.io
- PGP Key: [Download](https://nexacloud.io/.well-known/pgp-key.txt)

### Step 3: Confirmation

- You'll receive acknowledgment within **24-48 hours**
- You'll receive a tracking ID (format: `NC-2025-XXXX`)

### Step 4: Collaboration

- We may ask clarifying questions
- We'll keep you updated on progress
- We'll coordinate disclosure timeline

### Step 5: Resolution

- We'll notify you when fixed
- We'll discuss public disclosure
- We'll recognize your contribution

---

## ⏱️ Response Commitment

| Severity | Acknowledgment | Triage | Target Fix |
|----------|----------------|--------|------------|
| 🔴 Critical (9.0-10.0) | 4 hours | 24 hours | 7 days |
| 🟠 High (7.0-8.9) | 24 hours | 48 hours | 30 days |
| 🟡 Medium (4.0-6.9) | 48 hours | 7 days | 60 days |
| 🟢 Low (0.1-3.9) | 72 hours | 14 days | 90 days |

---

## 🛡️ Safe Harbor Statement

NexaCloud commits to not pursue legal action against security researchers who:

1. **Act in good faith** and follow this policy
2. **Avoid privacy violations** - don't access others' data
3. **Avoid destruction** - don't delete or modify data
4. **Report exclusively** to NexaCloud first
5. **Allow reasonable time** for remediation
6. **Stop testing** once vulnerability is confirmed

### Our Pledge

> If you follow this policy, we will:
> - Consider your research authorized
> - Not pursue civil or criminal action
> - Work with you to understand and resolve issues
> - Recognize your contribution publicly (with consent)

### Conditions

This safe harbor **does not apply** if you:
- Violate any laws
- Access data beyond minimum necessary
- Disrupt services intentionally
- Extort or threaten NexaCloud
- Sell vulnerability information

---

## 🏆 Recognition Program

### Hall of Fame

Valid reporters are recognized on our [Security Hall of Fame](https://nexacloud.io/security/thanks) including:
- Name/handle (with consent)
- Vulnerability summary
- Date reported

### Rewards

| Severity | Recognition |
|----------|-------------|
| Critical | Hall of Fame + Premium Swag + Thank You Letter |
| High | Hall of Fame + Standard Swag |
| Medium | Hall of Fame + Stickers |
| Low | Hall of Fame |

> **Note**: NexaCloud does not currently offer monetary bounties. We are evaluating a paid program.

### Opt-Out

If you prefer anonymity, let us know. We respect your privacy.

---

## 📞 Contact

| Purpose | Contact |
|---------|---------|
| Vulnerability Reports | [GitHub](https://github.com/nexacloud/platform/security/advisories/new) |
| Encrypted Reports | security@nexacloud.io (PGP) |
| Questions | security-questions@nexacloud.io |
| Legal | legal@nexacloud.io |

---

## 📅 Policy Information

| Field | Value |
|-------|-------|
| Version | 1.0 |
| Effective Date | January 2025 |
| Last Updated | December 2025 |
| Next Review | June 2026 |
| Owner | Security Team |

---

*Thank you for helping keep NexaCloud and our users safe!*
