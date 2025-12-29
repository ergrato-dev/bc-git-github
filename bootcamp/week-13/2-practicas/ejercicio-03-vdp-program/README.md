# Ejercicio 03: VDP Program Design

## 🎯 Objetivo

Diseñar un Vulnerability Disclosure Program (VDP) completo para una organización, incluyendo política, procesos, safe harbor y métricas.

## ⏱️ Duración

35 minutos

## 📋 Contexto

Eres el **Head of Security** de **CloudScale**, una empresa de infraestructura cloud con:

- 500+ empleados
- Plataforma SaaS usada por 10,000+ empresas
- APIs públicas
- Aplicaciones móviles
- Presencia global

La empresa nunca ha tenido un VDP formal. Tu misión es diseñar uno desde cero.

---

## 📝 Instrucciones

### Parte 1: Diseño del VDP (15 minutos)

#### 1.1 Definir el Scope

Crea el documento de scope del programa:

```markdown
# CloudScale VDP - Scope Document

## In-Scope Assets

### Tier 1 - Critical (Highest Priority)
| Asset | Description | Owner |
|-------|-------------|-------|
| [Completar] | | |

### Tier 2 - Important
| Asset | Description | Owner |
|-------|-------------|-------|
| [Completar] | | |

### Tier 3 - Standard
| Asset | Description | Owner |
|-------|-------------|-------|
| [Completar] | | |

## Out-of-Scope

### Explicitly Excluded
- [Lista de exclusiones]

### Testing Restrictions
- [Qué tipos de testing no están permitidos]
```

**Requisitos**:
- Al menos 5 assets in-scope
- Clasificación por tiers
- Justificación de exclusiones

#### 1.2 Definir Vulnerability Categories

```markdown
## Qualifying Vulnerabilities

### Critical (CVSS 9.0-10.0)
- Remote Code Execution
- [Agregar más...]

### High (CVSS 7.0-8.9)
- [Completar lista]

### Medium (CVSS 4.0-6.9)
- [Completar lista]

### Low (CVSS 0.1-3.9)
- [Completar lista]

### Not Qualifying
- [Lista de issues que NO califican]
```

#### 1.3 Response SLAs

Define SLAs realistas:

```markdown
## Response SLAs

| Stage | Critical | High | Medium | Low |
|-------|----------|------|--------|-----|
| Acknowledgment | | | | |
| Triage Complete | | | | |
| Fix Development | | | | |
| Fix Deployed | | | | |
| Public Disclosure | | | | |
```

---

### Parte 2: Safe Harbor & Legal (10 minutos)

#### 2.1 Safe Harbor Statement

Crea un safe harbor completo:

```markdown
# Safe Harbor Statement

## Our Commitment

CloudScale will not pursue legal action against security researchers who:

1. [Condición 1]
2. [Condición 2]
3. [Condición 3]
...

## What We Commit To

- [Compromiso 1]
- [Compromiso 2]
...

## Limitations

This safe harbor does not extend to:
- [Limitación 1]
- [Limitación 2]

## Legal Disclaimer

[Disclaimer legal]
```

**Requisitos**:
- Lenguaje claro y protector
- Basado en estándares (Disclose.io, ISO 29147)
- Aprobable por equipo legal

#### 2.2 Disclosure Timeline

```markdown
## Coordinated Disclosure Policy

### Standard Timeline
- Day 0: Vulnerability reported
- Day [X]: [Etapa]
- Day [X]: [Etapa]
- Day 90: Public disclosure (default)

### Extension Requests
[Política para extensiones]

### Early Disclosure
[Condiciones para disclosure anticipado]
```

---

### Parte 3: Operaciones (10 minutos)

#### 3.1 Proceso de Triage

```markdown
## Triage Workflow

### Step 1: Receipt
- [ ] [Acción]
- [ ] [Acción]

### Step 2: Validation
- [ ] [Acción]
- [ ] [Acción]

### Step 3: Classification
- [ ] [Acción]
- [ ] [Acción]

### Step 4: Assignment
- [ ] [Acción]

### Step 5: Communication
- [ ] [Acción]
```

#### 3.2 Templates de Comunicación

Crea templates para:

```markdown
## Communication Templates

### Acknowledgment Template
Subject: [VDP-XXXX] Vulnerability Report Received

Dear [Researcher],

[Cuerpo del mensaje]

### Update Template
Subject: [VDP-XXXX] Status Update

[Cuerpo del mensaje]

### Resolution Template
Subject: [VDP-XXXX] Vulnerability Resolved

[Cuerpo del mensaje]

### Decline Template
Subject: [VDP-XXXX] Report Assessment

[Cuerpo del mensaje para reportes no válidos]
```

#### 3.3 Métricas del Programa

```markdown
## VDP Metrics Dashboard

### Volume Metrics
| Metric | Definition | Target |
|--------|------------|--------|
| Reports/Month | | |
| Valid Rate | | |
| Duplicate Rate | | |

### Time Metrics
| Metric | Definition | Target |
|--------|------------|--------|
| MTTA | | |
| MTTR | | |
| Time to Disclosure | | |

### Quality Metrics
| Metric | Definition | Target |
|--------|------------|--------|
| Researcher Satisfaction | | |
| False Positive Rate | | |
| Reopen Rate | | |
```

---

## 📦 Entregables

1. **vdp-scope.md** - Documento de scope completo
2. **safe-harbor.md** - Safe harbor statement
3. **triage-process.md** - Proceso de triage documentado
4. **communication-templates.md** - Templates de comunicación
5. **metrics-dashboard.md** - Definición de métricas

---

## ✅ Criterios de Éxito

| Criterio | Puntos |
|----------|--------|
| Scope bien definido y tiered | 20 |
| Safe harbor completo y protector | 25 |
| SLAs realistas y medibles | 15 |
| Proceso de triage claro | 20 |
| Templates profesionales | 10 |
| Métricas relevantes | 10 |
| **Total** | **100** |

---

## 💡 Tips

1. **Benchmark**: Revisa VDPs públicos de empresas similares
2. **Legal Review**: En producción, el safe harbor necesita revisión legal
3. **Start Small**: Es mejor empezar conservador y expandir
4. **Automate**: Considera cómo automatizar partes del proceso
5. **Iterate**: Un VDP evoluciona con el tiempo

---

## 🔗 Recursos

- [Disclose.io Templates](https://disclose.io/terms)
- [HackerOne VDP Basics](https://www.hackerone.com/vulnerability-disclosure-policy)
- [ISO 29147](https://www.iso.org/standard/72311.html)
- [FIRST Guidelines](https://www.first.org/global/sigs/vulnerability-coordination/multiparty/guidelines-v1.1)

---

## 📁 Estructura de Archivos

```
ejercicio-03-vdp-program/
├── README.md                    # Este archivo
├── starter/
│   └── vdp-template.md          # Plantilla inicial
└── solution/
    ├── vdp-scope.md
    ├── safe-harbor.md
    ├── triage-process.md
    ├── communication-templates.md
    └── metrics-dashboard.md
```
