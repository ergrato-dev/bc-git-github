# 📅 Semana 08: CI/CD Pipelines

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana serás capaz de:

- [ ] Comprender los principios fundamentales de CI/CD
- [ ] Diseñar y construir pipelines de integración continua completos
- [ ] Implementar estrategias de testing automatizado (unit, integration, e2e)
- [ ] Configurar caching para optimizar tiempos de ejecución
- [ ] Usar artifacts para compartir datos entre jobs
- [ ] Gestionar secrets y variables de forma segura
- [ ] Aplicar best practices de CI/CD en proyectos reales

---

## 📋 Información General

| Aspecto | Detalle |
|---------|---------|
| **Duración** | 6 horas |
| **Modalidad** | Teórico-práctica |
| **Nivel** | Intermedio |
| **Certificación** | GitHub Actions |
| **Fase** | 2 - GitHub Actions Certification |

---

## 📚 Requisitos Previos

- ✅ Completar Semana 07 (GitHub Actions Fundamentos)
- ✅ Conocer sintaxis YAML para workflows
- ✅ Experiencia creando workflows básicos
- ✅ Entender events, jobs, steps y runners
- ✅ Familiaridad con Node.js o Python para ejemplos

---

## 🗂️ Estructura de la Semana

```text
week-08_cicd_pipelines/
├── README.md                     # Este archivo
├── rubrica-evaluacion.md         # Criterios de evaluación
├── 0-assets/                     # Diagramas SVG
│   ├── 01-cicd-pipeline-flow.svg
│   ├── 02-testing-pyramid.svg
│   ├── 03-caching-strategy.svg
│   └── 04-secrets-management.svg
├── 1-teoria/                     # Lecciones teóricas
│   ├── 01-fundamentos-cicd.md
│   ├── 02-build-testing.md
│   ├── 03-artifacts-caching.md
│   └── 04-secrets-variables.md
├── 2-practicas/                  # Ejercicios guiados
│   ├── ejercicio-01-pipeline-completo/
│   ├── ejercicio-02-caching-dependencias/
│   ├── ejercicio-03-artifacts-jobs/
│   └── ejercicio-04-secrets-environments/
├── 3-proyecto/                   # Proyecto semanal
│   └── README.md
├── 4-recursos/                   # Material adicional
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/                   # Términos CI/CD
    └── README.md
```

---

## 📝 Contenidos

### 1️⃣ Teoría (1.5 horas - 25%)

| # | Lección | Temas | Duración |
|---|---------|-------|----------|
| 01 | [Fundamentos CI/CD](1-teoria/01-fundamentos-cicd.md) | Conceptos, beneficios, pipeline stages | 20 min |
| 02 | [Build y Testing](1-teoria/02-build-testing.md) | Compilación, testing pyramid, coverage | 25 min |
| 03 | [Artifacts y Caching](1-teoria/03-artifacts-caching.md) | Upload/download, cache keys, estrategias | 25 min |
| 04 | [Secrets y Variables](1-teoria/04-secrets-variables.md) | Secrets, vars, environments, OIDC | 20 min |

### 2️⃣ Prácticas (2.5 horas - 42%)

| # | Ejercicio | Descripción | Duración |
|---|-----------|-------------|----------|
| 01 | [Pipeline CI Completo](2-practicas/ejercicio-01-pipeline-completo/) | Build → Test → Lint en secuencia | 35 min |
| 02 | [Caching de Dependencias](2-practicas/ejercicio-02-caching-dependencias/) | npm, pip, cache keys dinámicas | 35 min |
| 03 | [Artifacts entre Jobs](2-practicas/ejercicio-03-artifacts-jobs/) | Compartir builds, reports, logs | 40 min |
| 04 | [Secrets y Environments](2-practicas/ejercicio-04-secrets-environments/) | Configurar secrets, environments, approval | 40 min |

### 3️⃣ Proyecto (2 horas - 33%)

| Proyecto | Descripción |
|----------|-------------|
| [Full CI/CD Pipeline](3-proyecto/README.md) | Pipeline completo para aplicación React con lint, test, build, coverage y artifacts |

---

## ⏱️ Distribución del Tiempo

```
Total: 6 horas
├── 📖 Teoría ········· 1.5h (25%) ████░░░░░░░░
├── 💻 Prácticas ······ 2.5h (42%) ███████░░░░░
└── 🚀 Proyecto ······· 2.0h (33%) █████░░░░░░░
```

---

## 🔑 Conceptos Clave

### Pipeline Stages
```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│  Lint   │───▶│  Build  │───▶│  Test   │───▶│ Package │───▶│ Deploy  │
└─────────┘    └─────────┘    └─────────┘    └─────────┘    └─────────┘
     CI                                CI/CD                      CD
```

### Testing Pyramid
```
          ╱╲
         ╱  ╲        E2E Tests (10%)
        ╱────╲       - Lentos, costosos
       ╱      ╲      - Prueban flujo completo
      ╱────────╲
     ╱          ╲    Integration Tests (20%)
    ╱────────────╲   - Interacción entre módulos
   ╱              ╲
  ╱────────────────╲ Unit Tests (70%)
 ╱                  ╲ - Rápidos, aislados
╱────────────────────╲
```

### Cache Strategy
```yaml
# Key pattern recomendado
key: ${{ runner.os }}-${{ hashFiles('**/lock-file') }}
restore-keys: |
  ${{ runner.os }}-
```

---

## 📌 Entregables

Al finalizar la semana deberás entregar:

- [ ] **Ejercicio 01:** Pipeline CI con build y tests pasando
- [ ] **Ejercicio 02:** Workflow con caching optimizado
- [ ] **Ejercicio 03:** Jobs compartiendo artifacts
- [ ] **Ejercicio 04:** Secrets y environments configurados
- [ ] **Proyecto:** Full CI/CD pipeline para aplicación React

---

## 🎓 Preparación para Certificación

### GitHub Actions Certification

Esta semana cubre los siguientes temas del examen:

| Tema | Cobertura | Peso en Examen |
|------|-----------|----------------|
| CI/CD Concepts | ⭐⭐⭐⭐⭐ | 15% |
| Build Automation | ⭐⭐⭐⭐⭐ | 10% |
| Testing in Workflows | ⭐⭐⭐⭐ | 10% |
| Artifacts & Caching | ⭐⭐⭐⭐⭐ | 10% |
| Secrets Management | ⭐⭐⭐⭐⭐ | 10% |

**Temas de práctica:**
- Diseñar pipelines CI/CD eficientes
- Configurar caching para diferentes ecosistemas
- Implementar estrategias de testing
- Gestionar secrets de forma segura

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | ➡️ Siguiente |
|:-----------:|:---------:|:------------:|
| [Semana 07: Actions Fundamentos](../week-07_github_actions_fundamentos/README.md) | [Bootcamp](../README.md) | [Semana 09: Actions Avanzadas](../week-09_custom_actions_advanced_workflows/README.md) |

---

## 📚 Quick Reference

### Pipeline Completo Básico

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint

  test:
    needs: lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm test -- --coverage
      - uses: actions/upload-artifact@v4
        with:
          name: coverage
          path: coverage/

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run build
      - uses: actions/upload-artifact@v4
        with:
          name: build
          path: dist/
```

---

_Semana 08 | Fase 2: GitHub Actions Certification | Bootcamp Git/GitHub_
