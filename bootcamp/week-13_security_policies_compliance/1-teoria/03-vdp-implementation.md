# Lección 03: VDP Implementation

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- Diseñar un Vulnerability Disclosure Program (VDP) completo
- Implementar procesos de responsible disclosure
- Configurar programas de bug bounty
- Establecer cláusulas de safe harbor efectivas

## 📚 Conceptos Teóricos

### ¿Qué es un VDP?

Un **Vulnerability Disclosure Program (VDP)** es un proceso formal que permite a investigadores de seguridad externos reportar vulnerabilidades de forma segura y responsable.

### VDP vs Bug Bounty

| Característica | VDP | Bug Bounty |
|----------------|-----|------------|
| **Compensación** | Reconocimiento | Dinero + reconocimiento |
| **Costo** | Bajo/Gratis | Alto (presupuesto) |
| **Alcance** | Amplio | Específico |
| **Volumen** | Menor | Mayor |
| **Calidad** | Variable | Generalmente alta |
| **Obligación** | Ética | Contractual |

### ¿Por qué Implementar un VDP?

```
Sin VDP                          Con VDP
─────────                        ───────
❌ Full disclosure pública       ✅ Reporte privado
❌ Exploit en wild               ✅ Tiempo para parchear
❌ Daño reputacional             ✅ Colaboración positiva
❌ Riesgo legal para todos       ✅ Safe harbor claro
❌ Reactivo                      ✅ Proactivo
```

---

## 🔄 Workflow de Disclosure

![VDP Workflow](../0-assets/03-vdp-workflow.svg)

### Fases del Proceso

```yaml
Phase 1 - Discovery:
  Actor: Security researcher
  Action: Encuentra vulnerabilidad
  Output: Evidencia técnica

Phase 2 - Report:
  Actor: Security researcher
  Action: Envía reporte via canal seguro
  Output: Ticket/tracking ID

Phase 3 - Acknowledge:
  Actor: Security team
  Action: Confirma recepción
  Timeline: 24-48 horas
  Output: Acknowledgment + ID

Phase 4 - Triage:
  Actor: Security team
  Action: Valida y clasifica
  Timeline: 5-7 días
  Output: Severity rating (CVSS)

Phase 5 - Remediate:
  Actor: Engineering team
  Action: Desarrolla fix
  Timeline: Según severity
  Output: Patch ready

Phase 6 - Coordinate:
  Actor: Security team + Researcher
  Action: Acordar fecha de disclosure
  Timeline: Típico 90 días
  Output: Disclosure date

Phase 7 - Disclose:
  Actor: Both parties
  Action: Publicar advisory
  Output: CVE + Security advisory

Phase 8 - Reward:
  Actor: Organization
  Action: Compensar researcher
  Output: Payment/recognition
```

---

## 📋 Componentes de un VDP

### 1. Scope (Alcance)

Define qué está **dentro** y **fuera** del programa:

```markdown
## Scope

### In Scope
- *.example.com
- api.example.com
- mobile.example.com
- Example iOS/Android apps
- Open source repositories under github.com/example

### Out of Scope
- Third-party services (analytics, CDN)
- Physical security testing
- Social engineering attacks
- DoS/DDoS testing
- Automated scanning without coordination
- Issues in dependencies (report upstream)
```

### 2. Qualifying Vulnerabilities

```markdown
## Qualifying Vulnerabilities

### High Priority
- Remote Code Execution (RCE)
- SQL Injection
- Authentication bypass
- Privilege escalation
- Server-Side Request Forgery (SSRF)
- Sensitive data exposure

### Medium Priority
- Cross-Site Scripting (XSS)
- Cross-Site Request Forgery (CSRF)
- Insecure Direct Object Reference (IDOR)
- Information disclosure

### Low Priority
- Missing security headers
- Verbose error messages
- Rate limiting issues

### Not Qualifying
- Clickjacking on static pages
- Self-XSS
- Missing DNSSEC
- SSL/TLS best practices (unless exploitable)
- Theoretical vulnerabilities without PoC
```

### 3. Response SLAs

```markdown
## Response Timelines

| Severity | CVSS Score | Initial Response | Fix Target |
|----------|------------|------------------|------------|
| Critical | 9.0-10.0   | 24 hours         | 7 days     |
| High     | 7.0-8.9    | 48 hours         | 30 days    |
| Medium   | 4.0-6.9    | 5 days           | 90 days    |
| Low      | 0.1-3.9    | 7 days           | Best effort|

### Communication Cadence
- Initial acknowledgment: Within 48 hours
- Status updates: Every 14 days (or on significant progress)
- Final notification: Before public disclosure
```

### 4. Safe Harbor

```markdown
## Safe Harbor

We will not pursue legal action against security researchers who:

1. **Act in good faith** to avoid privacy violations, data destruction,
   and service disruption

2. **Follow responsible disclosure** by reporting through designated 
   channels and allowing reasonable time for remediation

3. **Do not access** data beyond what is necessary to demonstrate 
   the vulnerability

4. **Do not exfiltrate** any data, including customer data

5. **Do not publicly disclose** without mutual agreement on timing

6. **Comply with all applicable laws** while conducting research

### What We Commit To

- We will respond within the timelines specified
- We will work with you to understand and validate reports
- We will keep you informed of remediation progress
- We will credit you (if desired) in security advisories
- We will not pursue legal action when guidelines are followed
```

---

## 🛡️ GitHub Private Vulnerability Reporting

### Configuración

```yaml
# Habilitar para un repository específico
Repository Settings:
  Security:
    Private vulnerability reporting: ✅ Enable

# Habilitar para toda la organización
Organization Settings:
  Code security and analysis:
    Private vulnerability reporting:
      Enable for all repositories: ✅
      Automatically enable for new repositories: ✅
```

### Proceso de Reporte

```
Researcher                          Maintainer
    │                                    │
    ├──► Security tab                    │
    │    └──► Report vulnerability       │
    │         └──► Fill form             │
    │              └──► Submit ─────────►├──► Notification
    │                                    │    └──► Review
    │◄─────────────── Comment ──────────◄┤
    │                                    │
    │    [Collaborate on fix]            │
    │                                    │
    │◄─────────── Request CVE ──────────◄┤
    │                                    │
    │◄──────── Publish advisory ────────◄┤
    │                                    │
    ▼                                    ▼
  Credit                             Fixed!
```

### Draft Security Advisory

Cuando se recibe un reporte, se crea un **draft advisory**:

```yaml
Draft Advisory Contents:
  - Title: Descriptive title
  - Description: Technical details
  - Severity: CVSS score
  - Affected versions: Version ranges
  - Patched versions: Fixed versions
  - CVE ID: Request or assign
  - Credits: Researcher attribution
  - Temporary private fork: For fix development
```

### Workflow Completo con GitHub

```yaml
# .github/workflows/security-advisory.yml
name: Security Advisory Workflow

on:
  repository_advisory:
    types: [reported]

jobs:
  triage:
    runs-on: ubuntu-latest
    steps:
      - name: Notify security team
        uses: slackapi/slack-github-action@v1
        with:
          channel-id: 'security-alerts'
          slack-message: |
            🔐 New vulnerability reported!
            Repository: ${{ github.repository }}
            Reporter: ${{ github.event.advisory.reporter.login }}
            Severity: ${{ github.event.advisory.severity }}
            
      - name: Create tracking issue
        uses: actions/github-script@v7
        with:
          script: |
            await github.rest.issues.create({
              owner: context.repo.owner,
              repo: 'security-tracking',
              title: `[VULN] ${context.payload.advisory.summary}`,
              body: `Tracking advisory in ${context.repo.repo}`,
              labels: ['security', 'triage']
            });
```

---

## 💰 Bug Bounty Programs

### Plataformas Populares

| Plataforma | Tipo | Características |
|------------|------|-----------------|
| **HackerOne** | Managed | Triage, mediation, compliance |
| **Bugcrowd** | Managed | Researcher vetting, validation |
| **Intigriti** | Managed | EU-focused, GDPR compliant |
| **GitHub** | Self-managed | Private reporting, advisories |
| **Self-hosted** | Custom | Full control, más trabajo |

### Estructura de Rewards

```markdown
## Reward Structure

| Severity | CVSS | Reward Range |
|----------|------|--------------|
| Critical | 9.0+ | $5,000 - $20,000 |
| High     | 7.0-8.9 | $2,000 - $5,000 |
| Medium   | 4.0-6.9 | $500 - $2,000 |
| Low      | 0.1-3.9 | $100 - $500 |

### Bonus Multipliers
- First report of type: 1.5x
- Exceptional quality: 1.25x
- Working exploit: 1.5x
- Suggested fix: 1.25x

### Payment Methods
- PayPal
- Bank transfer
- Cryptocurrency (BTC, ETH)
- Donation to charity
```

### Política de Duplicados

```markdown
## Duplicate Policy

The first valid report of a unique vulnerability receives the bounty.

### What Counts as Duplicate
- Same root cause
- Same vulnerable component
- Same attack vector

### What Doesn't Count as Duplicate
- Same vulnerability in different endpoints (multiple rewards)
- Different attack vectors for same underlying issue (case by case)
```

---

## 📝 Plantilla VDP Completa

```markdown
# Vulnerability Disclosure Policy

## Introduction

[Organization Name] is committed to the security of our systems and 
data. We value the security community and believe that responsible 
disclosure of security vulnerabilities helps us ensure the security 
and privacy of all our users.

## Scope

### Systems in Scope
| Asset | Description |
|-------|-------------|
| *.example.com | Production web applications |
| api.example.com | REST API |
| Example Mobile Apps | iOS and Android |

### Out of Scope
- Third-party services and applications
- Physical attacks
- Social engineering
- Denial of Service attacks

## How to Report

### Preferred Method
Report via GitHub's private vulnerability reporting:
1. Navigate to the repository's Security tab
2. Click "Report a vulnerability"
3. Complete the form with technical details

### Alternative
Email: security@example.com
PGP Key: [Link to key]

## What to Include
- Description of the vulnerability
- Steps to reproduce
- Proof of concept (if applicable)
- Impact assessment
- Suggested remediation (optional)

## What to Expect

| Stage | Timeline |
|-------|----------|
| Acknowledgment | 48 hours |
| Initial triage | 7 days |
| Status updates | Every 14 days |
| Resolution | Based on severity |

## Safe Harbor

We will not pursue legal action against researchers who:
- Follow this policy
- Act in good faith
- Avoid privacy violations
- Do not disrupt services

## Recognition

Researchers who report valid vulnerabilities will be:
- Credited in security advisories (unless anonymity requested)
- Listed in our Security Hall of Fame
- Eligible for rewards (bug bounty program participants)

## Legal

This policy is subject to change. Testing must comply with all 
applicable laws and regulations.
```

---

## 🔐 CVSS Scoring

### CVSS v3.1 Calculator

```yaml
Base Score Metrics:
  Attack Vector (AV):
    - Network (N): 0.85
    - Adjacent (A): 0.62
    - Local (L): 0.55
    - Physical (P): 0.20
    
  Attack Complexity (AC):
    - Low (L): 0.77
    - High (H): 0.44
    
  Privileges Required (PR):
    - None (N): 0.85
    - Low (L): 0.62/0.68
    - High (H): 0.27/0.50
    
  User Interaction (UI):
    - None (N): 0.85
    - Required (R): 0.62
    
  Scope (S):
    - Unchanged (U): -
    - Changed (C): -
    
  Impact (C/I/A):
    - High (H): 0.56
    - Low (L): 0.22
    - None (N): 0.00
```

### Ejemplos de Scoring

```yaml
SQL Injection (Unauthenticated):
  AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
  Score: 9.8 (Critical)

Stored XSS:
  AV:N/AC:L/PR:L/UI:R/S:C/C:L/I:L/A:N
  Score: 5.4 (Medium)

Information Disclosure:
  AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N
  Score: 5.3 (Medium)
```

---

## 📊 Métricas de VDP

### KPIs Importantes

```yaml
Volume Metrics:
  - Reports received per month
  - Valid vs invalid reports
  - Duplicate rate
  - Severity distribution

Time Metrics:
  - Time to acknowledge
  - Time to triage
  - Time to fix (by severity)
  - Time to disclosure

Quality Metrics:
  - Report quality score
  - Researcher satisfaction
  - False positive rate
  
Business Metrics:
  - Cost per vulnerability
  - Vulnerabilities prevented
  - Security posture improvement
```

### Dashboard Template

```markdown
## VDP Monthly Report - [Month Year]

### Summary
| Metric | This Month | Last Month | Trend |
|--------|------------|------------|-------|
| Reports Received | 45 | 38 | ↑ 18% |
| Valid Reports | 28 | 25 | ↑ 12% |
| Critical/High | 5 | 3 | ↑ 67% |
| Avg Time to Fix | 12 days | 15 days | ↓ 20% |
| Researcher Satisfaction | 4.5/5 | 4.3/5 | ↑ |

### Severity Distribution
- Critical: 2 (7%)
- High: 3 (11%)
- Medium: 15 (54%)
- Low: 8 (28%)

### Top Vulnerability Types
1. XSS (8 reports)
2. IDOR (5 reports)
3. Information Disclosure (5 reports)
```

---

## ✅ Checklist de Implementación

```markdown
## Pre-Launch
- [ ] Define scope (in/out)
- [ ] Establish SLAs
- [ ] Draft safe harbor clause
- [ ] Set up secure reporting channel
- [ ] Create internal triage process
- [ ] Prepare response templates
- [ ] Train team on process

## Launch
- [ ] Publish SECURITY.md
- [ ] Enable GitHub private reporting
- [ ] Publish security.txt
- [ ] Announce program

## Operations
- [ ] Monitor incoming reports
- [ ] Track SLA compliance
- [ ] Update hall of fame
- [ ] Generate monthly reports
- [ ] Review and improve process

## Maturity
- [ ] Consider bug bounty expansion
- [ ] Automate triage where possible
- [ ] Integrate with security tooling
- [ ] Benchmark against industry
```

---

## 🔗 Recursos Adicionales

- [ISO 29147 - Vulnerability Disclosure](https://www.iso.org/standard/72311.html)
- [ISO 30111 - Vulnerability Handling](https://www.iso.org/standard/69725.html)
- [FIRST CVSS Calculator](https://www.first.org/cvss/calculator/3.1)
- [HackerOne VDP Guide](https://www.hackerone.com/vulnerability-disclosure-policy)
- [Disclose.io](https://disclose.io/) - Safe harbor templates

---

## 📝 Resumen

| Componente | Propósito |
|------------|-----------|
| **Scope** | Define qué puede ser testeado |
| **Safe Harbor** | Protección legal para researchers |
| **SLAs** | Tiempos de respuesta comprometidos |
| **Rewards** | Incentivos para reportes de calidad |
| **Process** | Flujo desde reporte hasta resolución |

---

**Próxima lección**: [GHAS Enterprise](./04-ghas-enterprise.md) - Despliegue a escala de GitHub Advanced Security
