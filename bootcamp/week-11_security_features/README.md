# 🔒 Week 11: Security Features

> **Fase 3: GitHub Advanced Security** (Semana 1 de 3)
> 
> Introducción a GitHub Advanced Security: Code Scanning, Dependabot, Secret Scanning y Security Policies.

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana serás capaz de:

- ✅ Comprender el ecosistema de GitHub Advanced Security (GHAS)
- ✅ Implementar Code Scanning con CodeQL
- ✅ Configurar Dependabot alerts y security updates
- ✅ Habilitar y configurar Secret Scanning
- ✅ Crear Dependency Review en Pull Requests
- ✅ Establecer Security Policies con SECURITY.md

---

## 📚 Requisitos Previos

- ✅ Completar Weeks 01-10 (Git + GitHub Actions)
- ✅ Repository público con código (JavaScript, Python o similar)
- ✅ Cuenta GitHub con acceso a Security features
- ✅ Conocimientos básicos de vulnerabilidades (CVE, CVSS)

---

## 🗂️ Estructura de la Semana

```
week-11_security_features/
├── README.md                 # Este archivo
├── rubrica-evaluacion.md     # Criterios de evaluación (100 pts)
├── 0-assets/                 # Diagramas SVG
│   ├── 01-ghas-overview.svg
│   ├── 02-code-scanning-flow.svg
│   ├── 03-dependabot-flow.svg
│   └── 04-secret-scanning.svg
├── 1-teoria/                 # Material teórico (90 min)
│   ├── 01-github-advanced-security.md
│   ├── 02-code-scanning.md
│   ├── 03-dependabot.md
│   └── 04-secret-scanning.md
├── 2-practicas/              # Ejercicios guiados (150 min)
│   ├── ejercicio-01-code-scanning/
│   ├── ejercicio-02-dependabot/
│   ├── ejercicio-03-dependency-review/
│   └── ejercicio-04-secret-scanning/
├── 3-proyecto/               # Proyecto semanal (2h)
├── 4-recursos/               # Material adicional
└── 5-glosario/               # Términos de seguridad
```

---

## 📖 Contenido Teórico (90 minutos)

| # | Lección | Duración | Temas |
|---|---------|----------|-------|
| 01 | [GitHub Advanced Security](1-teoria/01-github-advanced-security.md) | 20 min | GHAS overview, features, licensing, público vs privado |
| 02 | [Code Scanning](1-teoria/02-code-scanning.md) | 25 min | CodeQL, SARIF, custom queries, workflow configuration |
| 03 | [Dependabot](1-teoria/03-dependabot.md) | 25 min | Alerts, security updates, version updates, auto-merge |
| 04 | [Secret Scanning](1-teoria/04-secret-scanning.md) | 20 min | Tokens detectados, push protection, custom patterns |

---

## 💻 Ejercicios Prácticos (150 minutos)

| # | Ejercicio | Duración | Habilidades |
|---|-----------|----------|-------------|
| 01 | [Code Scanning con CodeQL](2-practicas/ejercicio-01-code-scanning/) | 40 min | Habilitar CodeQL, interpretar resultados, fix vulnerabilities |
| 02 | [Configurar Dependabot](2-practicas/ejercicio-02-dependabot/) | 35 min | dependabot.yml, alerts, auto-merge PRs |
| 03 | [Dependency Review](2-practicas/ejercicio-03-dependency-review/) | 35 min | Workflow de review, bloquear PRs inseguros |
| 04 | [Secret Scanning](2-practicas/ejercicio-04-secret-scanning/) | 40 min | Push protection, custom patterns, alertas |

---

## 🏗️ Proyecto Semanal (2 horas)

### Security Hardening Pipeline

**Objetivo**: Implementar un pipeline completo de seguridad que integre todas las features de GHAS en un repository existente.

**Entregables**:
1. Repository con Code Scanning habilitado
2. Dependabot configurado con auto-merge seguro
3. Workflow de Dependency Review
4. Secret Scanning con push protection
5. SECURITY.md con política de divulgación
6. Documentación del proceso

📋 [Ver instrucciones completas](3-proyecto/README.md)

---

## ⏱️ Distribución del Tiempo (6 horas)

| Actividad | Tiempo | Porcentaje |
|-----------|--------|------------|
| 📖 Teoría | 1.5 horas | 25% |
| 💻 Prácticas | 2.5 horas | 42% |
| 🏗️ Proyecto | 2 horas | 33% |
| **Total** | **6 horas** | **100%** |

---

## 📊 Evaluación

| Criterio | Puntos |
|----------|--------|
| Comprensión de GHAS | 15 pts |
| Code Scanning funcional | 20 pts |
| Dependabot configurado | 15 pts |
| Dependency Review workflow | 15 pts |
| Secret Scanning activo | 10 pts |
| Proyecto Security Hardening | 25 pts |
| **Total** | **100 pts** |

📋 [Ver rúbrica detallada](rubrica-evaluacion.md)

---

## 🔑 Conceptos Clave

```
┌─────────────────────────────────────────────────────────────┐
│                 GitHub Advanced Security                     │
├─────────────────┬─────────────────┬─────────────────────────┤
│  Code Scanning  │   Dependabot    │    Secret Scanning      │
│    (CodeQL)     │    (Alerts)     │   (Push Protection)     │
├─────────────────┼─────────────────┼─────────────────────────┤
│ Análisis SAST   │ Dep. vulnerable │ Tokens/API keys         │
│ Custom queries  │ Security updates│ Custom patterns         │
│ SARIF reports   │ Version updates │ Alert notifications     │
└─────────────────┴─────────────────┴─────────────────────────┘
```

---

## 📌 Quick Reference

### Habilitar Code Scanning
```yaml
# .github/workflows/codeql.yml
name: "CodeQL"
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  analyze:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v3
        with:
          languages: javascript
      - uses: github/codeql-action/analyze@v3
```

### Configurar Dependabot
```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

### Dependency Review Action
```yaml
- uses: actions/dependency-review-action@v4
  with:
    fail-on-severity: moderate
```

---

## 🎓 Certificación Asociada

<table>
<tr>
<td width="60">🛡️</td>
<td><strong>GitHub Advanced Security Certification</strong></td>
</tr>
<tr>
<td colspan="2">
<em>Esta semana cubre:</em><br>
• Code Scanning y CodeQL<br>
• Dependabot alerts y updates<br>
• Secret Scanning y push protection<br>
• Dependency Review<br>
• Security Policies
</td>
</tr>
</table>

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 10: Deployment Strategies](../week-10_deployment_strategies/README.md) | [Bootcamp](../README.md) | [Week 12: Vulnerability Management](../week-12_vulnerability_management/README.md) |

---

<div align="center">

**Week 11** · Security Features · Bootcamp Git/GitHub

*Fase 3: GitHub Advanced Security (1/3)*

</div>
