# 📚 Lección 01: Fundamentos de CI/CD

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- [ ] Definir CI, CD (Delivery) y CD (Deployment)
- [ ] Identificar los beneficios de implementar CI/CD
- [ ] Comprender las etapas de un pipeline típico
- [ ] Diferenciar entre integración y entrega continua

---

## 📋 Contenido

1. [¿Qué es CI/CD?](#1-qué-es-cicd)
2. [Continuous Integration (CI)](#2-continuous-integration-ci)
3. [Continuous Delivery vs Deployment](#3-continuous-delivery-vs-deployment)
4. [Etapas del Pipeline](#4-etapas-del-pipeline)
5. [Beneficios de CI/CD](#5-beneficios-de-cicd)
6. [CI/CD en GitHub Actions](#6-cicd-en-github-actions)

---

## 1. ¿Qué es CI/CD?

### Definición

**CI/CD** es un conjunto de prácticas de desarrollo de software que permiten entregar cambios de código de forma frecuente y confiable mediante automatización.

```
┌─────────────────────────────────────────────────────────────────────┐
│                           CI/CD Pipeline                            │
├─────────────────────────────┬───────────────────────────────────────┤
│   Continuous Integration    │   Continuous Delivery/Deployment      │
│         (CI)                │              (CD)                      │
├─────────────────────────────┼───────────────────────────────────────┤
│  • Commit frecuentes        │  • Delivery: Deploy manual            │
│  • Build automatizado       │  • Deployment: Deploy automático      │
│  • Tests automatizados      │  • Environments (staging, prod)       │
│  • Feedback rápido          │  • Release automation                 │
└─────────────────────────────┴───────────────────────────────────────┘
```

### El Problema que Resuelve

**Sin CI/CD:**
- "Integration Hell" - Merges dolorosos después de semanas
- "Works on my machine" - Diferentes entornos de desarrollo
- Deploys manuales propensos a errores
- Feedback lento sobre bugs

**Con CI/CD:**
- Integración diaria o más frecuente
- Entornos consistentes y reproducibles
- Deploys automatizados y confiables
- Feedback inmediato

---

## 2. Continuous Integration (CI)

### Definición

**Continuous Integration** es la práctica de integrar cambios de código al repositorio principal frecuentemente (varias veces al día), donde cada integración es verificada por un build automatizado y tests.

### Principios de CI

| Principio | Descripción |
|-----------|-------------|
| **Single Source of Truth** | Todo el código en un repositorio central |
| **Automate the Build** | Build ejecutable con un comando |
| **Self-Testing Build** | Tests ejecutan automáticamente |
| **Everyone Commits Daily** | Integración frecuente |
| **Fix Broken Builds Immediately** | Prioridad máxima |
| **Keep the Build Fast** | <10 minutos idealmente |

### Flujo de CI Típico

```
Developer    Repository     CI Server      Team
    │            │              │            │
    ├──push────►│              │            │
    │            ├──trigger───►│            │
    │            │              ├──build     │
    │            │              ├──test      │
    │            │              ├──lint      │
    │            │              │            │
    │◄───────────┴──────────────┼──notify───►│
    │         (pass/fail)       │            │
```

### Ejemplo de CI en GitHub Actions

```yaml
# .github/workflows/ci.yml
name: CI

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
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Lint
        run: npm run lint
      
      - name: Test
        run: npm test
      
      - name: Build
        run: npm run build
```

---

## 3. Continuous Delivery vs Deployment

### Continuous Delivery (CD)

**Definición:** Práctica donde el código está siempre en un estado deployable, pero el deploy a producción requiere aprobación manual.

```
Code → Build → Test → Stage → [Manual Approval] → Production
                                      ▲
                                      │
                               Human Decision
```

**Características:**
- Deploy a staging es automático
- Deploy a producción requiere "click"
- Útil para cumplimiento regulatorio
- Control sobre timing de releases

### Continuous Deployment (CD)

**Definición:** Práctica donde cada cambio que pasa todos los tests se despliega automáticamente a producción.

```
Code → Build → Test → Stage → Automated Tests → Production
                                                    │
                                              Automático
```

**Características:**
- Completamente automatizado
- Múltiples deploys por día
- Requiere excelente cobertura de tests
- Rollback automatizado

### Comparación

| Aspecto | Continuous Delivery | Continuous Deployment |
|---------|--------------------|-----------------------|
| **Deploy a staging** | Automático | Automático |
| **Deploy a producción** | Manual | Automático |
| **Frequencia de releases** | Controlada | Muy alta |
| **Riesgo por release** | Medio (batches) | Bajo (cambios pequeños) |
| **Requisito de tests** | Alto | Muy alto |
| **Ideal para** | Regulated industries | SaaS, startups |

---

## 4. Etapas del Pipeline

### Pipeline Típico

![Pipeline Flow](../0-assets/01-cicd-pipeline-flow.svg)

### Descripción de Etapas

#### 1. **Source/Code**
```yaml
# Trigger del pipeline
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
```
- Inicia con push o PR
- Checkout del código

#### 2. **Lint**
```yaml
- name: Lint
  run: npm run lint
```
- Análisis estático de código
- Verificar estilo y convenciones
- ESLint, Prettier, Pylint

#### 3. **Build**
```yaml
- name: Build
  run: npm run build
```
- Compilar código
- Transpilar (TypeScript → JavaScript)
- Bundling (Webpack, Vite)

#### 4. **Test**
```yaml
- name: Test
  run: npm test -- --coverage
```
- Unit tests
- Integration tests
- Coverage reports

#### 5. **Package**
```yaml
- name: Build Docker Image
  run: docker build -t app:${{ github.sha }} .
```
- Crear artifacts
- Build Docker images
- Package npm/pip

#### 6. **Deploy to Staging**
```yaml
- name: Deploy to Staging
  environment: staging
  run: ./deploy.sh staging
```
- Environment de pruebas
- Smoke tests
- QA manual

#### 7. **Deploy to Production**
```yaml
- name: Deploy to Production
  environment: production
  run: ./deploy.sh production
```
- Aprobación (si delivery)
- Deploy a producción
- Monitoring

---

## 5. Beneficios de CI/CD

### Para Desarrolladores

| Beneficio | Descripción |
|-----------|-------------|
| **Feedback rápido** | Saber en minutos si el código funciona |
| **Menos conflictos** | Integración frecuente = menos merge conflicts |
| **Confianza** | Tests automatizados validan cambios |
| **Focus** | Menos tiempo en tareas manuales |

### Para el Equipo

| Beneficio | Descripción |
|-----------|-------------|
| **Visibilidad** | Estado del proyecto siempre visible |
| **Colaboración** | PRs validados automáticamente |
| **Documentación** | Pipeline como documentación de proceso |
| **Consistencia** | Mismo proceso para todos |

### Para el Negocio

| Beneficio | Descripción |
|-----------|-------------|
| **Time to Market** | Releases más rápidos |
| **Calidad** | Menos bugs en producción |
| **Costo** | Menos tiempo en fixes y rollbacks |
| **Confiabilidad** | Deploys predecibles |

### Métricas de CI/CD

```
┌────────────────────────────────────────────────────────────┐
│                    DORA Metrics                            │
├────────────────────┬───────────────────────────────────────┤
│ Deployment Freq.   │ Cuántos deploys por día/semana/mes   │
│ Lead Time          │ Tiempo desde commit hasta producción │
│ MTTR               │ Tiempo para recuperar de fallas      │
│ Change Fail Rate   │ % de deploys que causan problemas    │
└────────────────────┴───────────────────────────────────────┘
```

---

## 6. CI/CD en GitHub Actions

### Estructura de Pipeline Completo

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  # ============================================
  # CI Jobs
  # ============================================
  lint:
    name: 🔍 Lint
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
    name: 🧪 Test
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
    name: 🏗️ Build
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
          name: dist
          path: dist/

  # ============================================
  # CD Jobs
  # ============================================
  deploy-staging:
    name: 🚀 Deploy Staging
    needs: build
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: dist
      - name: Deploy
        run: echo "Deploying to staging..."

  deploy-production:
    name: 🚀 Deploy Production
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: production
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: dist
      - name: Deploy
        run: echo "Deploying to production..."
```

### Visualización en GitHub

```
┌──────────────────────────────────────────────────────────┐
│                    Actions Workflow                       │
├──────────────────────────────────────────────────────────┤
│                                                          │
│   ┌──────┐    ┌──────┐    ┌───────┐                     │
│   │ lint │───▶│ test │───▶│ build │                     │
│   └──────┘    └──────┘    └───────┘                     │
│                              │                           │
│                              ▼                           │
│                    ┌─────────────────┐                  │
│                    │ deploy-staging  │                  │
│                    └─────────────────┘                  │
│                              │                           │
│                              ▼                           │
│                   ┌──────────────────┐                  │
│                   │ deploy-production│                  │
│                   │   (needs approval)│                  │
│                   └──────────────────┘                  │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **CI** | Integrar y validar código frecuentemente |
| **CD (Delivery)** | Código siempre deployable, deploy manual |
| **CD (Deployment)** | Deploy automático a producción |
| **Pipeline** | Secuencia de etapas automatizadas |
| **Feedback Loop** | Notificaciones rápidas de estado |

---

## 🔗 Recursos Adicionales

- [Continuous Integration - Martin Fowler](https://martinfowler.com/articles/continuousIntegration.html)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [DORA State of DevOps Report](https://dora.dev/)

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | ➡️ Siguiente |
|:-----------:|:---------:|:------------:|
| [README](../README.md) | [Semana 08](../README.md) | [Build y Testing](02-build-testing.md) |
