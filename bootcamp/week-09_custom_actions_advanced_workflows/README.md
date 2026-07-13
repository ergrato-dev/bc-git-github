# 📅 Week 09: Custom Actions y Advanced Workflows

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana serás capaz de:

- ✅ Crear custom actions (JavaScript, Composite, Docker)
- ✅ Estructurar y documentar actions para el Marketplace
- ✅ Implementar reusable workflows entre repositorios
- ✅ Usar workflow dispatch y repository dispatch
- ✅ Entender self-hosted runners y su configuración

---

## 📚 Requisitos Previos

- ✅ Completar Week 07 (Fundamentos GitHub Actions)
- ✅ Completar Week 08 (CI/CD Pipelines)
- ✅ Conocimiento básico de JavaScript/Node.js
- ✅ Experiencia con YAML y workflows

---

## 🗂️ Estructura de la Semana

```
week-09_custom_actions_advanced_workflows/
├── README.md                 # Este archivo
├── rubrica-evaluacion.md     # Criterios de evaluación (100 pts)
├── 0-assets/                 # Diagramas SVG
│   ├── 01-custom-actions-types.svg
│   ├── 02-action-architecture.svg
│   ├── 03-reusable-workflows.svg
│   └── 04-dispatch-events.svg
├── 1-teoria/                 # Lecciones teóricas
│   ├── 01-custom-actions-intro.md
│   ├── 02-javascript-actions.md
│   ├── 03-composite-actions.md
│   └── 04-reusable-workflows.md
├── 2-practicas/              # Ejercicios guiados
│   ├── ejercicio-01-javascript-action/
│   ├── ejercicio-02-composite-action/
│   ├── ejercicio-03-reusable-workflow/
│   └── ejercicio-04-dispatch-events/
├── 3-proyecto/               # Proyecto: Custom Action completa
├── 4-recursos/               # Material complementario
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/               # Términos de la semana
```

---

## 📝 Contenidos

### 1️⃣ Teoría (1.5 horas - 25%)

| # | Lección | Descripción | Tiempo |
|---|---------|-------------|--------|
| 01 | [Custom Actions Intro](1-teoria/01-custom-actions-intro.md) | Tipos, casos de uso, estructura básica | 20 min |
| 02 | [JavaScript Actions](1-teoria/02-javascript-actions.md) | @actions/core, @actions/github, inputs/outputs | 25 min |
| 03 | [Composite Actions](1-teoria/03-composite-actions.md) | Reutilizar steps, shell scripts, best practices | 25 min |
| 04 | [Reusable Workflows](1-teoria/04-reusable-workflows.md) | workflow_call, inputs, secrets, dispatch events | 20 min |

### 2️⃣ Prácticas (2.5 horas - 42%)

| # | Ejercicio | Descripción | Tiempo |
|---|-----------|-------------|--------|
| 01 | [JavaScript Action](2-practicas/ejercicio-01-javascript-action/) | Crear action con Node.js y @actions/core | 40 min |
| 02 | [Composite Action](2-practicas/ejercicio-02-composite-action/) | Action que combina múltiples steps | 35 min |
| 03 | [Reusable Workflow](2-practicas/ejercicio-03-reusable-workflow/) | Workflow compartido entre repos | 35 min |
| 04 | [Dispatch Events](2-practicas/ejercicio-04-dispatch-events/) | workflow_dispatch y repository_dispatch | 40 min |

### 3️⃣ Proyecto (2 horas - 33%)

**[Custom Action Completa](3-proyecto/README.md)**: Desarrollar una custom action funcional con:
- Inputs y outputs definidos
- Manejo de errores
- Documentación completa (README, action.yml)
- Tests de la action
- Ejemplo de uso

---

## ⏱️ Distribución del Tiempo (6 horas)

```
┌────────────────────────────────────────────────────────────┐
│                    WEEK 09 - 6 HORAS                       │
├──────────────┬────────────────────┬───────────────────────┤
│   TEORÍA     │     PRÁCTICAS      │       PROYECTO        │
│   1.5h       │       2.5h         │         2h            │
│    25%       │        42%         │         33%           │
├──────────────┼────────────────────┼───────────────────────┤
│ • Tipos      │ • JS Action        │ • Custom Action       │
│ • JavaScript │ • Composite        │ • Documentación       │
│ • Composite  │ • Reusable WF      │ • Tests               │
│ • Reusable   │ • Dispatch         │ • Ejemplo uso         │
└──────────────┴────────────────────┴───────────────────────┘
```

---

## 🚀 Quick Reference: Custom Action

### Estructura mínima de una action:

```
my-action/
├── action.yml          # Metadata obligatorio
├── README.md           # Documentación
├── dist/               # Código compilado (JS)
│   └── index.js
└── src/                # Código fuente
    └── index.js
```

### action.yml básico:

```yaml
name: 'My Custom Action'
description: 'Descripción de lo que hace'
author: 'Tu nombre'

inputs:
  my-input:
    description: 'Descripción del input'
    required: true
    default: 'valor por defecto'

outputs:
  my-output:
    description: 'Descripción del output'

runs:
  using: 'node20'
  main: 'dist/index.js'

branding:
  icon: 'check-circle'
  color: 'green'
```

### Uso de la action:

```yaml
- name: Run my action
  uses: owner/my-action@v1
  with:
    my-input: 'valor'
```

---

## 📌 Entregables

| # | Entregable | Puntos |
|---|------------|--------|
| 1 | JavaScript Action funcional | 20 |
| 2 | Composite Action funcional | 15 |
| 3 | Reusable Workflow implementado | 15 |
| 4 | Dispatch events configurados | 10 |
| 5 | Proyecto: Custom Action completa | 25 |
| 6 | Documentación de todas las actions | 15 |
| **Total** | | **100** |

---

## 🎓 Certificación GitHub Actions

Esta semana cubre temas del examen:

| Tema | Cobertura |
|------|-----------|
| Creating custom actions | ⭐⭐⭐⭐⭐ |
| Reusable workflows | ⭐⭐⭐⭐⭐ |
| Workflow triggers | ⭐⭐⭐⭐ |
| Self-hosted runners | ⭐⭐⭐ |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | ➡️ Siguiente |
|:-----------:|:---------:|:------------:|
| [Week 08](../week-08_cicd_pipelines/) | [Bootcamp](../README.md) | [Week 10](../week-10_deployment_strategies/) |

---

*Week 09 de 16 | Fase 2: GitHub Actions Certification | Bootcamp Git/GitHub*
