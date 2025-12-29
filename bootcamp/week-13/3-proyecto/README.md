# 🎯 Proyecto Semanal: Enterprise Security Policy Suite

## 📋 Descripción

En este proyecto integrador, crearás un **Enterprise Security Policy Suite** completo para una organización ficticia, aplicando todos los conceptos de la Semana 13: políticas de seguridad, compliance, VDP y estrategia GHAS.

---

## 🏢 Contexto del Proyecto

### La Empresa: NexaCloud Technologies

**NexaCloud** es una empresa de tecnología cloud con las siguientes características:

| Aspecto | Detalle |
|---------|---------|
| **Industria** | Cloud Infrastructure / SaaS |
| **Empleados** | 1,500 (400 developers) |
| **Repositories** | 300+ |
| **Clientes** | 5,000+ empresas globales |
| **Regulaciones** | SOC 2 Type II, GDPR, ISO 27001 |
| **Presencia** | USA, EU, LATAM |

### Stack Tecnológico

- **Backend**: Go, Python, Java
- **Frontend**: React, TypeScript
- **Infrastructure**: Kubernetes, Terraform
- **Data**: PostgreSQL, Redis, Elasticsearch

### Situación Actual

NexaCloud está experimentando un crecimiento rápido y necesita:

1. **Formalizar** sus políticas de seguridad
2. **Cumplir** con auditorías de compliance próximas
3. **Establecer** un programa de vulnerability disclosure
4. **Implementar** GHAS de forma estructurada

---

## 🎯 Objetivos del Proyecto

Al completar este proyecto, habrás creado:

1. ✅ SECURITY.md enterprise-grade
2. ✅ security.txt válido (RFC 9116)
3. ✅ Compliance mapping document
4. ✅ VDP completo con safe harbor
5. ✅ GHAS rollout plan
6. ✅ Governance documentation

---

## ⏱️ Duración Estimada

**2 horas** (120 minutos)

| Fase | Duración |
|------|----------|
| Análisis y planificación | 15 min |
| Security Policy Suite | 40 min |
| Compliance Documentation | 25 min |
| VDP Design | 20 min |
| GHAS Strategy | 20 min |

---

## 📝 Instrucciones Detalladas

### Fase 1: Análisis y Planificación (15 min)

#### 1.1 Stakeholder Analysis

Identifica los stakeholders clave y sus necesidades:

```markdown
## Stakeholder Analysis

| Stakeholder | Role | Security Needs | Priority |
|-------------|------|----------------|----------|
| CISO | Executive sponsor | Compliance, risk reduction | High |
| Engineering VP | Development lead | Developer experience, velocity | High |
| Legal | Compliance | Safe harbor, liability | High |
| Security Team | Operations | Tooling, processes | Medium |
| Developers | Implementation | Clear guidelines, low friction | Medium |
| Auditors | External | Evidence, documentation | High |
```

#### 1.2 Current State Assessment

Documenta el estado actual (asume lo siguiente):

- No hay SECURITY.md formal
- Compliance documentation dispersa
- No existe VDP
- GHAS no implementado
- Alertas de Dependabot ignoradas

---

### Fase 2: Security Policy Suite (40 min)

#### 2.1 SECURITY.md (25 min)

Crea un archivo `SECURITY.md` completo con:

**Secciones Requeridas:**

1. **Introduction &amp; Commitment**
   - Declaración de compromiso
   - Scope del programa

2. **Supported Versions**
   ```markdown
   | Product | Version | Support Level | EOL |
   |---------|---------|---------------|-----|
   | NexaCloud Platform | 4.x | Full | Active |
   | NexaCloud Platform | 3.x | Security only | Dec 2025 |
   | NexaCloud CLI | 2.x | Full | Active |
   | NexaCloud SDK | 1.x | Full | Active |
   ```

3. **Reporting Vulnerabilities**
   - Método principal: GitHub Private Reporting
   - Alternativa: security@nexacloud.io (con PGP)
   - Información requerida en reportes

4. **Response SLAs**
   - Por severidad (Critical → Low)
   - Tiempos de acknowledgment, triage, fix

5. **Safe Harbor**
   - Basado en Disclose.io
   - Condiciones claras
   - Compromiso de no acción legal

6. **Scope**
   - Assets in-scope (tiered)
   - Exclusiones explícitas

7. **Recognition Program**
   - Hall of Fame
   - Swag program
   - No bounties (por ahora)

#### 2.2 security.txt (10 min)

Crea un archivo `security.txt` válido:

```text
# NexaCloud Security Contact
# Generated: [fecha]
# https://securitytxt.org/

Contact: mailto:security@nexacloud.io
Contact: https://github.com/nexacloud/platform/security/advisories/new
Expires: [fecha + 1 año]
Encryption: https://nexacloud.io/.well-known/pgp-key.txt
Acknowledgments: https://nexacloud.io/security/thanks
Preferred-Languages: en, es
Canonical: https://nexacloud.io/.well-known/security.txt
Policy: https://github.com/nexacloud/platform/security/policy
Hiring: https://nexacloud.io/careers/security
```

#### 2.3 Organization Security Policy (5 min)

Define la política default para el repository `.github`:

```markdown
# Default Security Policy

This security policy applies to all repositories in the NexaCloud 
organization unless a repository-specific policy exists.

[Link a SECURITY.md principal]
```

---

### Fase 3: Compliance Documentation (25 min)

#### 3.1 Compliance Matrix

Crea una matriz de controles para SOC 2 + GDPR + ISO 27001:

```markdown
## NexaCloud Compliance Control Matrix

### Access Control
| Control | SOC 2 | GDPR | ISO 27001 | GitHub Implementation | Evidence |
|---------|-------|------|-----------|----------------------|----------|
| MFA | CC6.1 | Art.32 | A.8.5 | 2FA enforced | Org settings |
| SSO | CC6.1 | Art.32 | A.8.5 | SAML configured | IdP logs |
| ... | | | | | |
```

**Categorías a cubrir:**
- Access Control (5+ controles)
- Audit &amp; Monitoring (5+ controles)
- Vulnerability Management (5+ controles)
- Change Management (5+ controles)

#### 3.2 Evidence Collection Guide

```markdown
## Evidence Collection Procedures

### Quarterly Evidence Collection

| Control | Evidence Type | Collection Method | Storage |
|---------|---------------|-------------------|---------|
| 2FA Status | Report | gh api /orgs/nexacloud/members | S3/compliance |
| Audit Log | Export | Audit log streaming | Splunk |
| ... | | | |
```

---

### Fase 4: VDP Design (20 min)

#### 4.1 VDP Policy Document

Crea el documento de política VDP:

```markdown
# NexaCloud Vulnerability Disclosure Policy

## Scope
[In-scope assets tiered por criticidad]

## Rules of Engagement
[Qué está permitido y qué no]

## Reporting Process
[Paso a paso]

## Response Commitment
[SLAs]

## Safe Harbor
[Statement completo]

## Recognition
[Cómo se reconoce a researchers]
```

#### 4.2 Triage Playbook

```markdown
## VDP Triage Playbook

### Receipt Checklist
- [ ] Acknowledge within 24h
- [ ] Assign tracking ID
- [ ] Log in security tracker

### Validation Steps
1. Verify reproduction steps
2. Confirm scope
3. Check for duplicates
4. Assess severity (CVSS)

### Escalation Matrix
| Severity | Escalate To | Timeline |
|----------|-------------|----------|
| Critical | CISO + On-call | Immediate |
| High | Security Lead | 4 hours |
| Medium | Security Team | 24 hours |
| Low | Triage rotation | 48 hours |
```

---

### Fase 5: GHAS Strategy (20 min)

#### 5.1 Rollout Plan Executive Summary

```markdown
# GHAS Implementation Plan - NexaCloud

## Executive Summary
[1 párrafo resumen]

## Timeline
- Phase 1 (Pilot): Weeks 1-4 - 10 critical repos
- Phase 2 (Expand): Weeks 5-12 - All customer-facing
- Phase 3 (Scale): Weeks 13-20 - Organization-wide
- Phase 4 (Optimize): Ongoing

## Investment
- GHAS licenses: [estimate]
- Training: [estimate]
- Tooling integration: [estimate]

## Expected Outcomes
- 100% code scanning coverage by Q2
- MTTR Critical < 48 hours
- Zero secrets in code by Q3
```

#### 5.2 Governance Structure

```markdown
## Security Governance

### Roles
- Executive Sponsor: CISO
- Program Lead: Security Architect
- Security Champions: 1 per team (15 total)

### Meetings
| Meeting | Frequency | Attendees |
|---------|-----------|-----------|
| Security Standup | Daily | Security team |
| Champion Sync | Weekly | Champions + Security |
| Executive Review | Monthly | CISO + VPs |

### Metrics
[Top 5 KPIs a trackear]
```

---

## 📦 Entregables

Organiza tus entregables en la siguiente estructura:

```
proyecto-entrega/
├── 1-security-policy/
│   ├── SECURITY.md
│   ├── security.txt
│   └── org-default-policy.md
├── 2-compliance/
│   ├── compliance-matrix.md
│   └── evidence-collection.md
├── 3-vdp/
│   ├── vdp-policy.md
│   └── triage-playbook.md
├── 4-ghas/
│   ├── rollout-plan.md
│   └── governance.md
└── README.md (índice de entregables)
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **SECURITY.md** | 20 | Completo, profesional, todas las secciones |
| **security.txt** | 5 | Válido según RFC 9116 |
| **Compliance Matrix** | 20 | Mapeo correcto, evidencias definidas |
| **VDP Policy** | 20 | Scope claro, safe harbor sólido |
| **GHAS Plan** | 20 | Fases realistas, métricas definidas |
| **Governance** | 10 | Roles claros, cadencia establecida |
| **Calidad General** | 5 | Formato, claridad, profesionalismo |
| **Total** | **100** | |

---

## 💡 Consejos

1. **Piensa como auditor**: ¿Qué evidencia necesitarías?
2. **Sé específico**: Evita lenguaje vago
3. **Sé realista**: SLAs y timelines alcanzables
4. **Documenta decisiones**: Incluye el "por qué"
5. **Itera**: Estos documentos evolucionan

---

## 🔗 Recursos de Referencia

- [GitHub Security Documentation](https://docs.github.com/en/code-security)
- [Disclose.io Templates](https://disclose.io/terms)
- [SOC 2 Trust Services Criteria](https://www.aicpa.org)
- [GDPR Official Text](https://gdpr-info.eu/)
- [ISO 27001:2022](https://www.iso.org/standard/27001)

---

## 📁 Estructura del Proyecto

```
3-proyecto/
├── README.md                    # Este archivo
├── starter/
│   └── project-template.md      # Plantilla inicial
└── solution/
    └── README.md                # Solución de referencia
```

- [ ] Código fuente del proyecto
- [ ] Documentación técnica
- [ ] README.md del proyecto
- [ ] Reflexión personal (aprendizajes)

## 🏆 Criterios de Evaluación

| Criterio          | Peso | Descripción                                     |
| ----------------- | ---- | ----------------------------------------------- |
| **Funcionalidad** | 40%  | El proyecto cumple con todos los requerimientos |
| **Código**        | 30%  | Calidad, organización y best practices          |
| **Documentación** | 20%  | README y comentarios claros                     |
| **Creatividad**   | 10%  | Mejoras o características adicionales           |

## 📚 Recursos de Apoyo

- Revisar las lecciones de la carpeta `1- teoría/`
- Consultar ejercicios resueltos en `2- ejercicios/`
- Usar material adicional de `3- recursos/`
- Preguntar en el foro o Discord del bootcamp

---

**💡 Tip:** Comienza temprano y no dudes en pedir ayuda si te atascas. El objetivo es aprender, no solo entregar.
