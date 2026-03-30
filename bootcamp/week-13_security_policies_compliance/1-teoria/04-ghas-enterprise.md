# Lección 04: GHAS Enterprise

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- Planificar el rollout de GHAS a escala empresarial
- Configurar políticas de seguridad organizacionales
- Implementar métricas y governance de seguridad
- Optimizar GHAS para reducir ruido y mejorar adopción

## 📚 Conceptos Teóricos

### ¿Qué es GHAS Enterprise?

**GitHub Advanced Security (GHAS)** a nivel enterprise incluye:

- **Code Scanning**: Análisis estático con CodeQL
- **Secret Scanning**: Detección de credenciales expuestas
- **Push Protection**: Bloqueo proactivo de secretos
- **Dependency Review**: Análisis de dependencias en PRs
- **Security Overview**: Dashboard centralizado

### Licenciamiento GHAS

```yaml
GitHub Plans:
  Free/Team:
    - Public repos: GHAS incluido ✅
    - Private repos: No disponible ❌
    
  Enterprise:
    - GHAS es add-on de pago
    - Precio por committer activo
    - Incluye todas las features
    
GHAS Features por Plan:
  | Feature              | Public | Private (no GHAS) | Private (GHAS) |
  |----------------------|--------|-------------------|----------------|
  | Dependabot alerts    | ✅     | ✅                | ✅             |
  | Dependabot updates   | ✅     | ✅                | ✅             |
  | Code scanning        | ✅     | ❌                | ✅             |
  | Secret scanning      | ✅     | ❌                | ✅             |
  | Push protection      | ✅     | ❌                | ✅             |
  | Dependency review    | ✅     | ❌                | ✅             |
  | Security overview    | ❌     | ❌                | ✅             |
```

---

## 🚀 Estrategia de Rollout

![GHAS Enterprise Rollout](../0-assets/04-ghas-enterprise-rollout.svg)

### Fase 1: Pilot (2-4 semanas)

```yaml
Objetivos:
  - Validar configuración técnica
  - Establecer baselines
  - Entrenar security champions
  - Documentar proceso

Selección de Repos:
  Criterios:
    - Alta criticidad de negocio
    - Equipo receptivo
    - Complejidad representativa
    - Mix de lenguajes/frameworks
  
  Cantidad: 2-5 repositories

Actividades:
  Week 1:
    - [ ] Enable Secret Scanning
    - [ ] Enable Push Protection (monitor mode)
    - [ ] Run initial code scan
    - [ ] Document baseline findings
    
  Week 2:
    - [ ] Triage initial alerts
    - [ ] Configure custom patterns
    - [ ] Enable Dependency Review
    - [ ] Train pilot team
    
  Week 3-4:
    - [ ] Fix critical findings
    - [ ] Document learnings
    - [ ] Refine configurations
    - [ ] Prepare expansion plan

Success Criteria:
  - [ ] MTTR < 7 days for critical
  - [ ] Team comfortable with workflow
  - [ ] False positive rate understood
  - [ ] Process documented
```

### Fase 2: Expand (4-8 semanas)

```yaml
Objetivos:
  - Expandir por equipos/BUs
  - Refinar configuraciones
  - Escalar training
  - Establecer métricas

Estrategia de Expansión:
  Option A - By Team:
    - Rollout por equipo de desarrollo
    - Security champion por equipo
    - 5-10 repos por ola
    
  Option B - By Criticality:
    - Tier 1: Customer-facing apps
    - Tier 2: Internal apps
    - Tier 3: Tools & utilities
    
  Option C - By Technology:
    - Ola 1: JavaScript/TypeScript
    - Ola 2: Python
    - Ola 3: Java/Go
    - Ola 4: Otros lenguajes

Actividades:
  - [ ] Enable features por ola
  - [ ] Push Protection en block mode
  - [ ] Custom CodeQL queries
  - [ ] Integrate con CI/CD
  - [ ] Weekly security office hours
  - [ ] Address backlog findings

Success Criteria:
  - [ ] 50%+ repos con GHAS
  - [ ] Alertas críticas < baseline
  - [ ] Developer adoption > 70%
```

### Fase 3: Scale (8-12 semanas)

```yaml
Objetivos:
  - Enablement org-wide
  - Políticas enforced
  - Automation completa
  - Compliance ready

Actividades:
  - [ ] Enable para todos los repos
  - [ ] Org-level rulesets
  - [ ] Required security checks
  - [ ] Automated remediation
  - [ ] SIEM/SOAR integration
  - [ ] Compliance reporting

Configuración Org-wide:
  Organization Settings:
    Code security and analysis:
      - Dependency graph: ✅ All repos
      - Dependabot alerts: ✅ All repos
      - Dependabot updates: ✅ All repos
      - Code scanning: ✅ All repos (default setup)
      - Secret scanning: ✅ All repos
      - Push protection: ✅ All repos

Success Criteria:
  - [ ] 100% coverage
  - [ ] Zero critical findings > 7 days
  - [ ] Audit-ready documentation
```

### Fase 4: Optimize (Ongoing)

```yaml
Objetivos:
  - Reducir false positives
  - Mejora continua
  - Advanced features
  - Industry benchmarking

Actividades:
  - [ ] Custom CodeQL queries
  - [ ] Tune severity mappings
  - [ ] Autofix implementation
  - [ ] AI-assisted remediation
  - [ ] Security scorecards
  - [ ] Quarterly reviews
```

---

## 🏛️ Governance Structure

### Roles y Responsabilidades

```yaml
Executive Sponsor:
  - Budget approval
  - Priority decisions
  - Risk acceptance
  - Quarterly reviews

Security Team:
  - Policy definition
  - Tool configuration
  - Alert triage (escalated)
  - Metrics & reporting
  - Incident response

Security Champions:
  - Team-level support
  - First-line triage
  - Training delivery
  - Feedback collection
  
  Selection Criteria:
    - Interest in security
    - Technical credibility
    - Communication skills
    - 10-20% time allocation

Developers:
  - Fix vulnerabilities
  - Follow secure coding
  - Use tools daily
  - Report issues

RACI Matrix:
  | Activity              | Security | Champions | Developers | Exec |
  |-----------------------|----------|-----------|------------|------|
  | Policy definition     | R/A      | C         | I          | A    |
  | Tool configuration    | R/A      | C         | I          | I    |
  | Alert triage          | A        | R         | R          | I    |
  | Fix vulnerabilities   | C        | C         | R/A        | I    |
  | Training              | R/A      | R         | -          | I    |
  | Metrics reporting     | R/A      | C         | I          | I    |
```

### Security Champions Program

```markdown
## Security Champions Program

### Mission
Embed security expertise within development teams to accelerate 
secure coding practices and vulnerability remediation.

### Responsibilities
- Attend monthly security sync
- Triage team's security alerts
- Conduct code reviews with security focus
- Share security knowledge with team
- Escalate complex issues to security team

### Benefits
- Advanced security training
- Direct access to security team
- Recognition in org communications
- Career development opportunity

### Time Commitment
- 4-8 hours per month
- Monthly 1-hour sync meeting
- Ad-hoc consultations

### Selection Process
1. Nomination by manager or self
2. Interview with security team
3. Initial training (8 hours)
4. Shadow period (1 month)
5. Full champion status
```

---

## 📊 Métricas y KPIs

### Security Posture Metrics

```yaml
Coverage Metrics:
  - % repos with code scanning enabled
  - % repos with secret scanning enabled
  - % repos with push protection enabled
  - % repos with dependency review enabled
  
  Target: 100% for all

Vulnerability Metrics:
  - Total open alerts by severity
  - New alerts this period
  - Closed alerts this period
  - Alert age distribution
  
  Target: Zero critical/high > 7 days

Remediation Metrics:
  - MTTR (Mean Time To Remediate)
    - Critical: < 24-48 hours
    - High: < 7 days
    - Medium: < 30 days
    - Low: < 90 days
  
  - Fix rate: > 90%
  - Reopen rate: < 5%

Prevention Metrics:
  - Secrets blocked by push protection
  - PRs blocked by dependency review
  - Vulnerabilities caught pre-production
  
  Target: Increasing trend in blocks
```

### Dashboard Configuration

```yaml
# Security Overview Filters

# High-risk repositories
is:public archived:false 
severity:critical severity:high

# Repos without security features
code-scanning:not-enabled 
secret-scanning:not-enabled

# Alert aging
created:>2024-01-01 
state:open 
severity:critical

# Team-specific view
team:frontend-team 
state:open
```

### Reporting Template

```markdown
## Security Metrics Report - Q[X] 2025

### Executive Summary
GHAS coverage: 95% (+5% from last quarter)
Critical findings: 3 (↓ 60% from baseline)
MTTR Critical: 2.5 days (target: 7 days) ✅

### Coverage Progress
| Feature | Q1 | Q2 | Q3 | Target |
|---------|-----|-----|-----|--------|
| Code Scanning | 60% | 80% | 95% | 100% |
| Secret Scanning | 70% | 90% | 98% | 100% |
| Push Protection | 40% | 70% | 90% | 100% |

### Alert Trends
| Severity | Open | New | Closed | MTTR |
|----------|------|-----|--------|------|
| Critical | 3 | 5 | 8 | 2.5d |
| High | 12 | 20 | 25 | 5d |
| Medium | 45 | 60 | 50 | 20d |
| Low | 120 | 80 | 40 | 45d |

### Key Achievements
- Reduced critical backlog by 60%
- Blocked 150 secrets via push protection
- Trained 25 security champions

### Risks & Blockers
- Legacy repos need refactoring for scanning
- Some teams need additional training

### Next Quarter Focus
- Achieve 100% coverage
- Implement automated remediation
- Custom CodeQL queries for business logic
```

---

## ⚙️ Configuración Avanzada

### Organization-Level Settings

```yaml
# Via GitHub UI or API
Organization Settings:
  Code security and analysis:
    # Automatic enablement
    Dependency graph: 
      Automatically enable for new repositories: ✅
    
    Dependabot alerts:
      Automatically enable for new repositories: ✅
    
    Dependabot security updates:
      Automatically enable for new repositories: ✅
    
    Code scanning:
      Automatically enable for new repositories: ✅
      Default setup: CodeQL (recommended)
    
    Secret scanning:
      Automatically enable for new repositories: ✅
      Scan for generic secrets: ✅
    
    Push protection:
      Automatically enable for new repositories: ✅
    
    Private vulnerability reporting:
      Automatically enable for new repositories: ✅
```

### Repository Rulesets

```yaml
# Organization-level ruleset for security
name: Security Requirements
target: branch
enforcement: active

conditions:
  ref_name:
    include: ["~DEFAULT_BRANCH"]
  repository_name:
    include: ["*"]
    exclude: ["*-sandbox", "*-test"]

rules:
  - type: pull_request
    parameters:
      required_approving_review_count: 1
      dismiss_stale_reviews_on_push: true
      require_code_owner_review: true
      require_last_push_approval: true
      
  - type: required_status_checks
    parameters:
      strict_required_status_checks_policy: true
      required_status_checks:
        - context: "CodeQL"
        - context: "dependency-review"
        - context: "secret-scan"
        
  - type: required_signatures
    # Require signed commits
```

### Custom Secret Patterns

```yaml
# Organization-level custom patterns
# Settings → Code security → Secret scanning → Custom patterns

patterns:
  - name: Internal API Key
    pattern: 'INTERNAL_[A-Z]{3}_[a-zA-Z0-9]{32}'
    description: Internal service API keys
    
  - name: Database Connection String
    pattern: '(mysql|postgres|mongodb)://[^:]+:[^@]+@[^/]+'
    description: Database credentials in connection strings
    
  - name: JWT Secret
    pattern: 'JWT_SECRET[=:]\s*["\']?[A-Za-z0-9+/=]{32,}["\']?'
    description: JWT signing secrets
    
  - name: Private Key Header
    pattern: '-----BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----'
    description: Private key files
```

### CodeQL Configuration

```yaml
# .github/codeql/codeql-config.yml
name: "Enterprise CodeQL Config"

queries:
  - uses: security-extended
  - uses: security-and-quality
  
# Custom queries from internal repo
packs:
  - myorg/custom-queries

paths-ignore:
  - '**/test/**'
  - '**/tests/**'
  - '**/spec/**'
  - '**/vendor/**'
  - '**/node_modules/**'

query-filters:
  - exclude:
      tags contain: /correctness/
```

---

## 🔄 CI/CD Integration

### Workflow Template

```yaml
# .github/workflows/security-gates.yml
name: Security Gates

on:
  pull_request:
    branches: [main, develop]
  push:
    branches: [main]

permissions:
  contents: read
  security-events: write
  pull-requests: write

jobs:
  code-scanning:
    name: CodeQL Analysis
    runs-on: ubuntu-latest
    strategy:
      matrix:
        language: [javascript, python]
    steps:
      - uses: actions/checkout@v4
      
      - name: Initialize CodeQL
        uses: github/codeql-action/init@v3
        with:
          languages: ${{ matrix.language }}
          config-file: .github/codeql/codeql-config.yml
          
      - name: Autobuild
        uses: github/codeql-action/autobuild@v3
        
      - name: Perform Analysis
        uses: github/codeql-action/analyze@v3
        with:
          category: "/language:${{ matrix.language }}"

  dependency-review:
    name: Dependency Review
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
    steps:
      - uses: actions/checkout@v4
      
      - name: Dependency Review
        uses: actions/dependency-review-action@v4
        with:
          fail-on-severity: high
          deny-licenses: GPL-3.0, AGPL-3.0
          allow-ghsas: GHSA-xxxx-yyyy-zzzz  # Known acceptable

  secret-scan:
    name: Secret Scan Check
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
          
      - name: Check for secrets in diff
        run: |
          # Additional secret scanning with truffleHog
          docker run --rm -v "$PWD:/pwd" \
            trufflesecurity/trufflehog:latest \
            git file:///pwd --since-commit HEAD~1 --fail

  security-gate:
    name: Security Gate
    needs: [code-scanning, dependency-review, secret-scan]
    runs-on: ubuntu-latest
    steps:
      - name: Check Critical Alerts
        uses: actions/github-script@v7
        with:
          script: |
            const { data: alerts } = await github.rest.codeScanning.listAlertsForRepo({
              owner: context.repo.owner,
              repo: context.repo.repo,
              state: 'open',
              severity: 'critical'
            });
            
            if (alerts.length > 0) {
              core.setFailed(`${alerts.length} critical alerts must be fixed`);
            }
```

### Branch Protection Integration

```yaml
Branch Protection Rules:
  main:
    Require status checks:
      - CodeQL
      - dependency-review
      - secret-scan
      - security-gate
    
    Require branches to be up to date: ✅
    
    Require signed commits: ✅
    
    Require linear history: ✅
    
    Do not allow bypassing: ✅ (even for admins)
```

---

## 🔧 Troubleshooting

### Common Issues

```yaml
Issue: Too many alerts overwhelming teams
Solution:
  - Prioritize by severity
  - Use code scanning categories
  - Implement gradual rollout
  - Set realistic SLAs

Issue: High false positive rate
Solution:
  - Configure paths-ignore
  - Use query filters
  - Create suppressions file
  - Custom CodeQL configs

Issue: Slow code scanning
Solution:
  - Optimize codeql-config.yml
  - Use matrix builds
  - Implement caching
  - Consider self-hosted runners

Issue: Push protection blocking legitimate commits
Solution:
  - Review bypass reasons
  - Add to allow list if appropriate
  - Train developers on proper secret management
  - Implement pre-commit hooks locally
```

### Bypass Tracking

```yaml
# Monitor push protection bypasses
# API endpoint for bypass events

GET /orgs/{org}/secret-scanning/push-protection-bypasses

# Automate review with GitHub Actions
name: Review Push Protection Bypasses

on:
  schedule:
    - cron: '0 9 * * 1'  # Weekly Monday 9am

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - name: Get bypasses
        env:
          GH_TOKEN: ${{ secrets.ORG_ADMIN_TOKEN }}
        run: |
          gh api /orgs/$ORG/secret-scanning/push-protection-bypasses \
            --jq '.[] | select(.created_at > (now - 604800 | todate))' \
            > bypasses.json
            
      - name: Alert if bypasses exist
        run: |
          if [ -s bypasses.json ]; then
            # Send alert to security team
            echo "::warning::Push protection bypasses detected"
          fi
```

---

## ✅ Enterprise Readiness Checklist

```markdown
## Pre-Rollout
- [ ] Executive sponsorship secured
- [ ] Budget approved
- [ ] Security team trained
- [ ] Pilot repos identified
- [ ] Success criteria defined
- [ ] Communication plan ready

## Technical Setup
- [ ] GHAS licenses provisioned
- [ ] Organization settings configured
- [ ] Rulesets defined
- [ ] Custom patterns created
- [ ] CI/CD templates ready
- [ ] Integrations configured (SIEM, ticketing)

## People & Process
- [ ] Security champions identified
- [ ] Training materials prepared
- [ ] Runbooks documented
- [ ] Escalation paths defined
- [ ] SLAs communicated

## Governance
- [ ] Policies documented
- [ ] Metrics dashboards configured
- [ ] Reporting cadence established
- [ ] Review process defined
- [ ] Compliance mapping complete

## Go-Live
- [ ] Pilot completed successfully
- [ ] Lessons learned documented
- [ ] Expansion plan approved
- [ ] Support channels ready
- [ ] Monitoring active
```

---

## 🔗 Recursos Adicionales

- [GitHub Advanced Security Documentation](https://docs.github.com/en/enterprise-cloud@latest/code-security)
- [GHAS Rollout Guide](https://resources.github.com/security/ghas-rollout-guide/)
- [CodeQL Documentation](https://codeql.github.com/docs/)
- [Security Overview Documentation](https://docs.github.com/en/enterprise-cloud@latest/code-security/security-overview)
- [GitHub Security Lab](https://securitylab.github.com/)

---

## 📝 Resumen

| Fase | Duración | Objetivo | Cobertura |
|------|----------|----------|-----------|
| **Pilot** | 2-4 sem | Validar | 5-10 repos |
| **Expand** | 4-8 sem | Escalar | 50%+ repos |
| **Scale** | 8-12 sem | Org-wide | 100% repos |
| **Optimize** | Ongoing | Mejorar | Mantenimiento |

### Key Success Factors

1. **Executive Support**: Budget y prioridad
2. **Champions**: Expertise distribuida
3. **Gradual Rollout**: Evitar overwhelm
4. **Metrics**: Medir para mejorar
5. **Automation**: Reducir fricción

---

**Siguiente**: [Ejercicio Práctico - GHAS Rollout Plan](../2-practicas/ejercicio-04-ghas-rollout/README.md)
