# 🚀 Week 07: GitHub Actions Fundamentos

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana serás capaz de:

- ✅ Comprender la arquitectura de GitHub Actions
- ✅ Crear workflows básicos usando sintaxis YAML
- ✅ Configurar triggers y eventos para workflows
- ✅ Usar actions del marketplace y runners
- ✅ Implementar workflows de CI básicos

---

## 📚 Requisitos Previos

- Completar Week 01 a Week 06
- Conocimiento básico de YAML
- Repository en GitHub para pruebas

---

## 🗂️ Estructura de la Semana

```text
week-07/
├── README.md                 # Este archivo
├── rubrica-evaluacion.md     # Criterios de evaluación
├── 0-assets/                 # Diagramas SVG
│   ├── 01-actions-architecture.svg
│   ├── 02-workflow-anatomy.svg
│   ├── 03-events-triggers.svg
│   └── 04-runners-execution.svg
├── 1-teoria/                 # Material teórico
│   ├── 01-introduccion-actions.md
│   ├── 02-sintaxis-yaml.md
│   ├── 03-events-triggers.md
│   └── 04-jobs-runners.md
├── 2-practicas/              # Ejercicios guiados
│   ├── ejercicio-01-hello-world/
│   ├── ejercicio-02-multiple-triggers/
│   ├── ejercicio-03-marketplace-actions/
│   └── ejercicio-04-matrix-strategy/
├── 3-proyecto/               # Proyecto CI básico
├── 4-recursos/               # Material adicional
└── 5-glosario/               # Términos clave
```

---

## 📝 Contenidos

### 1️⃣ Teoría (1.5 horas - 25%)

| # | Lección | Duración | Temas |
|---|---------|----------|-------|
| 01 | [Introducción a GitHub Actions](1-teoria/01-introduccion-actions.md) | 25 min | Arquitectura, componentes, beneficios |
| 02 | [Sintaxis YAML para Workflows](1-teoria/02-sintaxis-yaml.md) | 25 min | Estructura, keys, expressions |
| 03 | [Events y Triggers](1-teoria/03-events-triggers.md) | 20 min | push, pull_request, schedule, dispatch |
| 04 | [Jobs y Runners](1-teoria/04-jobs-runners.md) | 20 min | Jobs, steps, runners, matrix |

### 2️⃣ Prácticas (2.5 horas - 42%)

| # | Ejercicio | Duración | Objetivo |
|---|-----------|----------|----------|
| 01 | [Hello World Workflow](2-practicas/ejercicio-01-hello-world/) | 30 min | Crear primer workflow funcional |
| 02 | [Múltiples Triggers](2-practicas/ejercicio-02-multiple-triggers/) | 35 min | Configurar diferentes eventos |
| 03 | [Actions del Marketplace](2-practicas/ejercicio-03-marketplace-actions/) | 40 min | Usar checkout, setup-node, cache |
| 04 | [Matrix Strategy](2-practicas/ejercicio-04-matrix-strategy/) | 45 min | Tests en múltiples versiones/OS |

### 3️⃣ Proyecto (2 horas - 33%)

| Proyecto | Descripción |
|----------|-------------|
| [CI Básico para Node.js](3-proyecto/) | Implementar workflow completo: lint, test, build |

---

## ⏱️ Distribución del Tiempo (6 horas)

```
📖 Teoría     ████████░░░░░░░░░░░░░░░░  1.5h (25%)
💻 Prácticas  ██████████████░░░░░░░░░░  2.5h (42%)
🏗️ Proyecto   ████████████░░░░░░░░░░░░  2.0h (33%)
```

---

## 🔧 Referencia Rápida - Workflow YAML

```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run tests
        run: npm test
```

---

## 📌 Entregables

1. ✅ Workflow "Hello World" funcionando
2. ✅ Workflow con múltiples triggers configurados
3. ✅ Workflow usando actions del marketplace
4. ✅ Proyecto CI básico con lint + test + build

---

## 🎓 Certificación GitHub Actions

<table>
<tr>
<td>🏅</td>
<td><strong>GitHub Actions Certification</strong></td>
</tr>
<tr>
<td colspan="2">
<strong>Temas cubiertos esta semana:</strong><br>
• Actions fundamentals and architecture<br>
• Workflow syntax and YAML structure<br>
• Events, triggers, and workflow dispatch<br>
• Jobs, steps, and runners
</td>
</tr>
</table>

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 06: GitHub Features](../week-06/README.md) | [Bootcamp](../README.md) | [Week 08: CI/CD Pipelines](../week-08/README.md) |

---

_Week 07 | Bootcamp Git/GitHub | Fase 2: GitHub Actions Certification_

### 3️⃣ Proyecto

**Proyecto CI Básico**: Implementar workflow de CI que ejecute linting y tests en cada push y pull request.

---

## ⏱️ Distribución del Tiempo (8 horas)

| Actividad | Tiempo |
|-----------|--------|
| 📖 Teoría | 3 horas |
| 💻 Prácticas | 3 horas |
| 🏗️ Proyecto | 2 horas |

---

## 📌 Entregables

1. ✅ Workflow básico funcionando en repository
2. ✅ Documentación de sintaxis YAML utilizada
3. ✅ Workflow con múltiples jobs y dependencias
4. ✅ Proyecto CI básico implementado

---

## 🎓 Certificación Asociada

<table>
<tr>
<td>🏅</td>
<td><strong>GitHub Actions</strong></td>
</tr>
<tr>
<td colspan="2">Esta semana cubre: Actions fundamentals, Workflow syntax, Events and triggers</td>
</tr>
</table>

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 06: GitHub Features](../week-06/README.md) | [Bootcamp](../README.md) | [Week 08: CI/CD Pipelines](../week-08/README.md) |

---

_Week 07 | Bootcamp Git/GitHub_
