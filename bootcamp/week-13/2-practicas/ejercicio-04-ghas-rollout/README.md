# Ejercicio 04: GHAS Rollout Plan

## 🎯 Objetivo

Crear un plan de implementación de GitHub Advanced Security (GHAS) para una organización enterprise, incluyendo fases, métricas, governance y change management.

## ⏱️ Duración

35 minutos

## 📋 Contexto

Eres el **Security Architect** de **GlobalFintech**, una empresa financiera con:

- 2,000 desarrolladores
- 500+ repositories
- Mix de lenguajes: Java, Python, JavaScript, Go
- Regulaciones: PCI-DSS, SOC 2
- Budget aprobado para GHAS Enterprise

Tu tarea es crear el plan de rollout para implementar GHAS en toda la organización.

---

## 📝 Instrucciones

### Parte 1: Assessment & Planning (10 minutos)

#### 1.1 Current State Assessment

```markdown
# GHAS Rollout Plan - GlobalFintech

## Current State Assessment

### Repository Inventory
| Category | Count | Languages | Criticality |
|----------|-------|-----------|-------------|
| Customer-Facing | | | Critical |
| Internal Apps | | | High |
| Libraries/SDKs | | | Medium |
| Tools/Scripts | | | Low |
| Archived | | | N/A |

### Current Security Tooling
| Tool | Purpose | Coverage | Gap |
|------|---------|----------|-----|
| [Tool actual] | | | |

### Team Readiness
| Team | Size | Security Maturity | Champion? |
|------|------|-------------------|-----------|
| [Equipo] | | 1-5 | Yes/No |
```

#### 1.2 Success Criteria

```markdown
## Success Criteria

### Phase 1 (Pilot)
- [ ] [Criterio medible]
- [ ] [Criterio medible]

### Phase 2 (Expand)
- [ ] [Criterio medible]

### Phase 3 (Scale)
- [ ] [Criterio medible]

### Phase 4 (Optimize)
- [ ] [Criterio medible]
```

---

### Parte 2: Rollout Phases (15 minutos)

#### 2.1 Phase 1: Pilot

```markdown
## Phase 1: Pilot (Weeks 1-4)

### Objectives
- [Objetivo 1]
- [Objetivo 2]

### Scope
- Repositories: [Lista de 3-5 repos]
- Teams: [Teams participantes]

### Week-by-Week Plan

#### Week 1: Setup
| Day | Activity | Owner | Deliverable |
|-----|----------|-------|-------------|
| Mon | | | |
| Tue | | | |
| Wed | | | |
| Thu | | | |
| Fri | | | |

#### Week 2: Enable Features
[Detalle similar]

#### Week 3-4: Triage & Learn
[Detalle similar]

### Exit Criteria
- [ ] [Criterio para pasar a Phase 2]
```

#### 2.2 Phase 2: Expand

```markdown
## Phase 2: Expand (Weeks 5-12)

### Expansion Strategy
- [ ] By Team
- [ ] By Criticality  
- [ ] By Technology

### Wave Planning

#### Wave 1 (Weeks 5-6)
| Team | Repos | Features | Champion |
|------|-------|----------|----------|
| | | | |

#### Wave 2 (Weeks 7-8)
[Similar]

#### Wave 3 (Weeks 9-10)
[Similar]

#### Wave 4 (Weeks 11-12)
[Similar]

### Training Plan
| Session | Audience | Duration | Content |
|---------|----------|----------|---------|
| | | | |
```

#### 2.3 Phase 3: Scale

```markdown
## Phase 3: Scale (Weeks 13-20)

### Org-Wide Enablement

#### Configuration
```yaml
# Organization settings to enable
Code security and analysis:
  Dependency graph: [setting]
  Dependabot alerts: [setting]
  # [Completar resto]
```

#### Rulesets
```yaml
# Repository ruleset for security
name: Security Requirements
[Completar configuración]
```

### Integration Points
| System | Integration Type | Purpose |
|--------|------------------|---------|
| CI/CD | | |
| SIEM | | |
| Ticketing | | |
```

#### 2.4 Phase 4: Optimize

```markdown
## Phase 4: Optimize (Ongoing)

### Continuous Improvement

#### Monthly Activities
- [ ] Review false positive trends
- [ ] Update custom patterns
- [ ] [Más actividades]

#### Quarterly Activities
- [ ] [Actividades trimestrales]

### Advanced Features Roadmap
| Feature | Timeline | Prerequisites |
|---------|----------|---------------|
| Custom CodeQL | | |
| Autofix | | |
| [Más features] | | |
```

---

### Parte 3: Governance & Metrics (10 minutes)

#### 3.1 Governance Structure

```markdown
## Governance Structure

### RACI Matrix
| Activity | Security | Champions | Dev Teams | Exec |
|----------|----------|-----------|-----------|------|
| Policy Definition | | | | |
| Tool Configuration | | | | |
| Alert Triage | | | | |
| Fix Implementation | | | | |
| Training | | | | |
| Reporting | | | | |

### Meeting Cadence
| Meeting | Frequency | Attendees | Agenda |
|---------|-----------|-----------|--------|
| Security Standup | | | |
| Champion Sync | | | |
| Executive Review | | | |

### Escalation Path
[Diagrama o descripción del path de escalación]
```

#### 3.2 Metrics Dashboard

```markdown
## Metrics Dashboard

### Coverage Metrics
| Metric | Baseline | Month 1 | Month 3 | Month 6 | Target |
|--------|----------|---------|---------|---------|--------|
| Repos with Code Scanning | 0% | | | | 100% |
| Repos with Secret Scanning | 0% | | | | 100% |
| Repos with Push Protection | 0% | | | | 100% |

### Vulnerability Metrics
| Metric | Baseline | Target |
|--------|----------|--------|
| Open Critical Alerts | | 0 |
| Open High Alerts | | <10 |
| MTTR Critical | N/A | <48h |
| MTTR High | N/A | <7d |

### Adoption Metrics
| Metric | Target |
|--------|--------|
| Developer Training Completion | 90% |
| Champion Coverage | 1 per team |
| PR Block Rate (security) | <5% |
```

#### 3.3 Risk Management

```markdown
## Risk Management

### Identified Risks
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Developer resistance | | | |
| Alert fatigue | | | |
| False positives | | | |
| [Más riesgos] | | | |

### Contingency Plans
[Planes de contingencia para riesgos principales]
```

---

## 📦 Entregables

1. **assessment.md** - Current state assessment
2. **rollout-plan.md** - Plan detallado por fases
3. **governance.md** - Estructura de governance
4. **metrics-dashboard.md** - Dashboard de métricas
5. **risk-register.md** - Registro de riesgos

---

## ✅ Criterios de Éxito

| Criterio | Puntos |
|----------|--------|
| Assessment completo y realista | 15 |
| Plan de fases detallado | 30 |
| Governance structure clara | 20 |
| Métricas relevantes y medibles | 20 |
| Gestión de riesgos | 15 |
| **Total** | **100** |

---

## 💡 Tips

1. **Be Realistic**: Los timelines deben ser alcanzables
2. **Get Buy-in**: Involucra a stakeholders desde el inicio
3. **Start with Champions**: Son críticos para el éxito
4. **Measure Everything**: Lo que no se mide no se mejora
5. **Plan for Resistance**: Habrá pushback, prepárate

---

## 🔗 Recursos

- [GitHub GHAS Rollout Guide](https://resources.github.com/security/ghas-rollout-guide/)
- [Enterprise Security Best Practices](https://docs.github.com/en/enterprise-cloud@latest/admin/overview/best-practices-for-enterprises)
- [Change Management Models](https://www.prosci.com/methodology/adkar)

---

## 📁 Estructura de Archivos

```
ejercicio-04-ghas-rollout/
├── README.md                    # Este archivo
├── starter/
│   └── rollout-template.md      # Plantilla inicial
└── solution/
    ├── assessment.md
    ├── rollout-plan.md
    ├── governance.md
    ├── metrics-dashboard.md
    └── risk-register.md
```
