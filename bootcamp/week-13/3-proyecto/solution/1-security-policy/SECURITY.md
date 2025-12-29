# Security Policy - NexaCloud Technologies

## 🛡️ Our Commitment

NexaCloud Technologies is committed to maintaining the security and privacy of our customers' data. We take security vulnerabilities seriously and appreciate the efforts of security researchers who help us maintain a safe environment.

This document outlines our security policy, including how to report vulnerabilities, our response process, and our commitment to working constructively with the security research community.

---

## 📋 Supported Versions

We provide security updates for the following versions:

| Product | Version | Support Level | End of Life | Notes |
|---------|---------|---------------|-------------|-------|
| NexaCloud Platform | 4.x | ✅ Full Support | Active | Current major version |
| NexaCloud Platform | 3.x | ⚠️ Security Only | December 2025 | Critical/High fixes only |
| NexaCloud Platform | 2.x | ❌ End of Life | June 2024 | No updates |
| NexaCloud CLI | 2.x | ✅ Full Support | Active | Current version |
| NexaCloud CLI | 1.x | ❌ End of Life | March 2024 | No updates |
| NexaCloud SDK (Go) | 1.x | ✅ Full Support | Active | |
| NexaCloud SDK (Python) | 1.x | ✅ Full Support | Active | |
| NexaCloud SDK (JS) | 2.x | ✅ Full Support | Active | |
| NexaCloud Terraform Provider | 3.x | ✅ Full Support | Active | |

**Support Level Definitions:**
- **Full Support**: All bug fixes and security updates
- **Security Only**: Only Critical and High severity security fixes
- **End of Life**: No updates; please upgrade immediately

---

## 🔐 Reporting a Vulnerability

### Primary Channel (Preferred)

**GitHub Private Vulnerability Reporting**

1. Navigate to our repository's Security tab
2. Click "Report a vulnerability"
3. Fill in the vulnerability details
4. Submit the report

➡️ [Report via GitHub](https://github.com/nexacloud/platform/security/advisories/new)

### Alternative Channel

**Email (PGP Encrypted)**

- **Address**: security@nexacloud.io
- **PGP Key**: [Download Public Key](https://nexacloud.io/.well-known/pgp-key.txt)
- **Key Fingerprint**: `ABCD 1234 EFGH 5678 IJKL 9012 MNOP 3456 QRST 7890`

### What to Include in Your Report

Please provide as much of the following information as possible:

```markdown
## Vulnerability Report

**Summary**: [Brief description]

**Affected Product/Version**: 
- Product: [e.g., NexaCloud Platform]
- Version: [e.g., 4.2.1]

**Vulnerability Type**: [e.g., SQL Injection, XSS, IDOR]

**Severity Assessment**: [Your estimate: Critical/High/Medium/Low]

**Steps to Reproduce**:
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Proof of Concept**: [Code, screenshots, or video]

**Impact**: [What could an attacker achieve?]

**Suggested Fix**: [Optional but appreciated]

**Your Contact Info**: [For follow-up questions]
```

### What NOT to Do

- ❌ Do not publicly disclose before we've had a chance to fix
- ❌ Do not access data belonging to other users
- ❌ Do not perform destructive testing
- ❌ Do not use automated scanners without coordination
- ❌ Do not perform physical or social engineering attacks

---

## ⏱️ Response Timeline

We commit to the following response times based on severity:

| Severity | CVSS Score | Acknowledgment | Triage | Resolution Target |
|----------|------------|----------------|--------|-------------------|
| 🔴 Critical | 9.0 - 10.0 | 4 hours | 24 hours | 7 days |
| 🟠 High | 7.0 - 8.9 | 24 hours | 48 hours | 30 days |
| 🟡 Medium | 4.0 - 6.9 | 48 hours | 7 days | 60 days |
| 🟢 Low | 0.1 - 3.9 | 72 hours | 14 days | 90 days |

**Process Overview:**

1. **Acknowledgment**: We confirm receipt of your report
2. **Triage**: We validate and assess severity
3. **Investigation**: We investigate root cause and impact
4. **Fix Development**: We develop and test the fix
5. **Release**: We deploy the fix to production
6. **Disclosure**: We coordinate public disclosure with you

---

## 🛡️ Safe Harbor

NexaCloud Technologies supports responsible security research. We pledge the following:

### Our Commitment

We will not initiate legal action against security researchers who:

1. **Act in good faith** to avoid privacy violations, destruction of data, and interruption of services
2. **Follow responsible disclosure** by reporting findings directly to us and allowing reasonable time to fix
3. **Do not exploit** findings beyond what is necessary to demonstrate the vulnerability
4. **Do not exfiltrate** data, establish persistent access, or pivot to other systems
5. **Comply with applicable laws** and the terms of this policy

### Conditions

This safe harbor applies when you:

- ✅ Report the vulnerability exclusively to NexaCloud
- ✅ Give us reasonable time to fix before any disclosure
- ✅ Do not access or modify data belonging to others
- ✅ Stop testing once you've established a vulnerability exists
- ✅ Do not perform attacks that could harm service availability

### Limitations

This safe harbor does **not** apply to:

- Physical attacks against our facilities or employees
- Social engineering attacks against our staff
- Denial of service attacks
- Attacks on third-party services we don't control
- Actions that violate any applicable law

> **Note**: This safe harbor statement is based on [Disclose.io](https://disclose.io/terms) and represents our commitment to working constructively with security researchers.

---

## 🎯 Scope

### In-Scope Assets

#### Tier 1 - Critical (Highest Priority)
| Asset | Description |
|-------|-------------|
| `app.nexacloud.io` | Main application platform |
| `api.nexacloud.io` | Public API endpoints |
| `auth.nexacloud.io` | Authentication services |
| `billing.nexacloud.io` | Payment processing |

#### Tier 2 - High
| Asset | Description |
|-------|-------------|
| `console.nexacloud.io` | Admin console |
| `docs.nexacloud.io` | Documentation portal |
| NexaCloud CLI | Command-line tool |
| NexaCloud SDKs | Official client libraries |

#### Tier 3 - Standard
| Asset | Description |
|-------|-------------|
| `status.nexacloud.io` | Status page |
| `blog.nexacloud.io` | Company blog |
| `careers.nexacloud.io` | Careers site |

### Out-of-Scope

The following are **explicitly out of scope**:

- Third-party services (even if accessed via our platform)
- Physical attacks or social engineering
- Denial of service attacks
- Spam or social engineering vulnerabilities
- Issues in outdated browsers or plugins
- Self-XSS that cannot affect other users
- Missing security headers without demonstrated impact
- Software version disclosure without exploit
- Clickjacking on pages without sensitive actions
- CSRF on forms without sensitive actions
- Host header injection without clear impact

### Vulnerability Types We Care About

| High Interest | Medium Interest | Lower Interest |
|---------------|-----------------|----------------|
| Remote Code Execution | Stored XSS | Reflected XSS |
| SQL Injection | IDOR | Information disclosure (limited) |
| Authentication Bypass | CSRF (sensitive actions) | Missing headers |
| Sensitive Data Exposure | SSRF | Self-XSS |
| Privilege Escalation | Open Redirect (with phishing) | Clickjacking |

---

## 🏆 Recognition Program

We appreciate the security research community and recognize contributions through:

### Hall of Fame

Researchers who report valid vulnerabilities will be acknowledged in our [Security Hall of Fame](https://nexacloud.io/security/thanks) (with consent).

### Swag Program

For valid reports, we offer:

| Severity | Recognition |
|----------|-------------|
| Critical | Hall of Fame + Premium Swag Kit + Personal Thank You |
| High | Hall of Fame + Standard Swag Kit |
| Medium | Hall of Fame + Sticker Pack |
| Low | Hall of Fame mention |

### Current Status

> **Note**: NexaCloud does not currently offer monetary bounties. We are evaluating a paid bug bounty program for future implementation.

### Recognition Opt-Out

If you prefer to remain anonymous, please let us know and we will honor your request.

---

## 📞 Contact Information

| Channel | Contact | Use For |
|---------|---------|---------|
| **Security Reports** | [GitHub Private Reporting](https://github.com/nexacloud/platform/security/advisories/new) | Vulnerability reports |
| **Security Email** | security@nexacloud.io | Alternative reports (PGP) |
| **Security Questions** | security-questions@nexacloud.io | General security inquiries |
| **Legal/Compliance** | legal@nexacloud.io | Legal matters |

---

## 📅 Policy Information

| Attribute | Value |
|-----------|-------|
| **Policy Version** | 2.0 |
| **Last Updated** | December 2025 |
| **Next Review** | June 2026 |
| **Owner** | NexaCloud Security Team |
| **Approved By** | CISO, Legal |

---

## 🔗 Related Resources

- [security.txt](https://nexacloud.io/.well-known/security.txt)
- [PGP Public Key](https://nexacloud.io/.well-known/pgp-key.txt)
- [Security Hall of Fame](https://nexacloud.io/security/thanks)
- [Security Blog](https://nexacloud.io/blog/security)
- [Status Page](https://status.nexacloud.io)

---

**Thank you for helping keep NexaCloud and our users safe!**
