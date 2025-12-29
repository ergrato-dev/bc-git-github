# 🏋️ Ejercicio 03: Reusable Workflow - CI Template

> **Duración estimada**: 35 minutos  
> **Dificultad**: Intermedia-Avanzada  
> **Prerequisitos**: Lección 04 - Reusable Workflows

---

## 🎯 Objetivo

Crear un workflow reutilizable que implemente un pipeline de CI completo (lint, test, build) y pueda ser llamado desde múltiples repositorios con diferentes configuraciones.

---

## 📋 Lo que aprenderás

- [ ] Crear workflows con trigger `workflow_call`
- [ ] Definir inputs tipados y secrets
- [ ] Exponer outputs desde jobs
- [ ] Llamar workflows reutilizables con `uses:`
- [ ] Usar `secrets: inherit`

---

## 📁 Estructura Final

```
.github/workflows/
├── ci-template.yml      # Workflow reutilizable (callable)
├── ci.yml               # Workflow llamador (caller)
└── ci-prod.yml          # Otro caller con config diferente
```

---

## 🚀 Pasos del Ejercicio

### Paso 1: Crear el workflow reutilizable

Crea `.github/workflows/ci-template.yml`:

```yaml
# .github/workflows/ci-template.yml
# ========================================
# REUSABLE WORKFLOW: CI Template
# ========================================
# ¿Qué hace?: Define un pipeline CI completo y reutilizable
# ¿Por qué?: Centralizar lógica de CI en un solo lugar
# ¿Para qué sirve?: Múltiples repos pueden usar el mismo CI

name: CI Template (Reusable)

on:
  # ========================================
  # TRIGGER: workflow_call
  # ========================================
  # ¿Qué hace?: Permite que otros workflows llamen a este
  # ¿Por qué?: Es el mecanismo para hacer el workflow reutilizable
  # ¿Para qué sirve?: Actúa como una "función" de workflows
  
  workflow_call:
    inputs:
      node-version:
        description: 'Versión de Node.js'
        type: string
        required: false
        default: '20'
      
      working-directory:
        description: 'Directorio de trabajo'
        type: string
        required: false
        default: '.'
      
      run-lint:
        description: 'Ejecutar linting'
        type: boolean
        required: false
        default: true
      
      run-tests:
        description: 'Ejecutar tests'
        type: boolean
        required: false
        default: true
      
      run-build:
        description: 'Ejecutar build'
        type: boolean
        required: false
        default: true
      
      artifact-name:
        description: 'Nombre del artifact de build'
        type: string
        required: false
        default: 'build-output'
    
    secrets:
      NPM_TOKEN:
        description: 'Token para registry privado'
        required: false
    
    # ========================================
    # OUTPUTS del workflow
    # ========================================
    outputs:
      version:
        description: 'Versión del paquete'
        value: ${{ jobs.build.outputs.version }}
      
      lint-status:
        description: 'Resultado del linting'
        value: ${{ jobs.lint.outputs.status }}
      
      test-status:
        description: 'Resultado de tests'
        value: ${{ jobs.test.outputs.status }}

# ========================================
# JOBS
# ========================================
jobs:
  # ----------------------------------------
  # JOB: Lint
  # ----------------------------------------
  lint:
    if: ${{ inputs.run-lint }}
    runs-on: ubuntu-latest
    outputs:
      status: ${{ steps.lint.outcome }}
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
          cache: 'npm'
          cache-dependency-path: ${{ inputs.working-directory }}/package-lock.json
      
      - name: Install dependencies
        working-directory: ${{ inputs.working-directory }}
        run: npm ci
      
      - name: Run ESLint
        id: lint
        working-directory: ${{ inputs.working-directory }}
        run: |
          echo "🔍 Running ESLint..."
          npm run lint --if-present || echo "No lint script found"

  # ----------------------------------------
  # JOB: Test
  # ----------------------------------------
  test:
    if: ${{ inputs.run-tests }}
    runs-on: ubuntu-latest
    outputs:
      status: ${{ steps.test.outcome }}
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
          cache: 'npm'
          cache-dependency-path: ${{ inputs.working-directory }}/package-lock.json
      
      - name: Install dependencies
        working-directory: ${{ inputs.working-directory }}
        run: npm ci
      
      - name: Run tests
        id: test
        working-directory: ${{ inputs.working-directory }}
        run: |
          echo "🧪 Running tests..."
          npm test --if-present || echo "No test script found"

  # ----------------------------------------
  # JOB: Build
  # ----------------------------------------
  build:
    if: ${{ inputs.run-build }}
    needs: [lint, test]
    # Ejecutar si lint/test pasaron o fueron skipped
    if: |
      always() &&
      (needs.lint.result == 'success' || needs.lint.result == 'skipped') &&
      (needs.test.result == 'success' || needs.test.result == 'skipped')
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
          cache: 'npm'
          cache-dependency-path: ${{ inputs.working-directory }}/package-lock.json
      
      - name: Install dependencies
        working-directory: ${{ inputs.working-directory }}
        run: npm ci
        env:
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
      
      - name: Get version
        id: version
        working-directory: ${{ inputs.working-directory }}
        run: |
          VERSION=$(node -p "require('./package.json').version" 2>/dev/null || echo "0.0.0")
          echo "version=$VERSION" >> $GITHUB_OUTPUT
          echo "📦 Version: $VERSION"
      
      - name: Build
        working-directory: ${{ inputs.working-directory }}
        run: |
          echo "🏗️ Building..."
          npm run build --if-present || echo "No build script found"
      
      - name: Upload artifact
        uses: actions/upload-artifact@v4
        with:
          name: ${{ inputs.artifact-name }}
          path: |
            ${{ inputs.working-directory }}/dist
            ${{ inputs.working-directory }}/build
          if-no-files-found: warn

  # ----------------------------------------
  # JOB: Summary
  # ----------------------------------------
  summary:
    needs: [lint, test, build]
    if: always()
    runs-on: ubuntu-latest
    steps:
      - name: Generate summary
        run: |
          echo "## 📊 CI Pipeline Results" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "| Job | Status |" >> $GITHUB_STEP_SUMMARY
          echo "|-----|--------|" >> $GITHUB_STEP_SUMMARY
          echo "| Lint | ${{ needs.lint.result || 'skipped' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Test | ${{ needs.test.result || 'skipped' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Build | ${{ needs.build.result || 'skipped' }} |" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "**Node.js:** ${{ inputs.node-version }}" >> $GITHUB_STEP_SUMMARY
```

---

### Paso 2: Crear workflow caller (desarrollo)

Crea `.github/workflows/ci.yml`:

```yaml
# .github/workflows/ci.yml
# ========================================
# CALLER WORKFLOW: CI para desarrollo
# ========================================
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  ci:
    # ========================================
    # LLAMAR AL WORKFLOW REUTILIZABLE
    # ========================================
    # ¿Qué hace?: Ejecuta el template de CI
    # ¿Por qué?: Reutilizar lógica sin duplicar código
    # ¿Para qué sirve?: Mantener CI consistente
    
    uses: ./.github/workflows/ci-template.yml
    with:
      node-version: '20'
      run-lint: true
      run-tests: true
      run-build: true
    secrets: inherit  # Pasa todos los secrets automáticamente
  
  # Job adicional que usa outputs del workflow
  notify:
    needs: ci
    runs-on: ubuntu-latest
    steps:
      - name: Show results
        run: |
          echo "✅ CI completado"
          echo "Version: ${{ needs.ci.outputs.version }}"
          echo "Lint: ${{ needs.ci.outputs.lint-status }}"
          echo "Test: ${{ needs.ci.outputs.test-status }}"
```

---

### Paso 3: Crear workflow caller (producción)

Crea `.github/workflows/ci-prod.yml`:

```yaml
# .github/workflows/ci-prod.yml
# ========================================
# CALLER WORKFLOW: CI para producción
# ========================================
name: CI Production

on:
  push:
    tags: ['v*']
  workflow_dispatch:

jobs:
  ci-prod:
    uses: ./.github/workflows/ci-template.yml
    with:
      node-version: '20'
      run-lint: true
      run-tests: true
      run-build: true
      artifact-name: 'production-build'
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
  
  # Deploy solo si CI pasa
  deploy:
    needs: ci-prod
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Download artifact
        uses: actions/download-artifact@v4
        with:
          name: production-build
      
      - name: Deploy
        run: |
          echo "🚀 Deploying version ${{ needs.ci-prod.outputs.version }}..."
          ls -la
```

---

## ✅ Verificación

Tu ejercicio está completo si:

- [ ] `ci-template.yml` tiene trigger `workflow_call`
- [ ] Los inputs tienen tipos correctos (string, boolean)
- [ ] Los outputs se propagan desde jobs
- [ ] Los callers pueden usar `secrets: inherit`
- [ ] El summary muestra resultados de todos los jobs

---

## 🎯 Desafíos Extra (Opcional)

1. **Añadir job de security scan** con `npm audit`
2. **Input `matrix-os`** para ejecutar en múltiples sistemas
3. **Crear workflow en repo separado** y llamarlo cross-repo

---

## 📚 Recursos

- [Reusing workflows - GitHub Docs](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [workflow_call inputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_callinputs)

---

[⬅️ Ejercicio anterior](../ejercicio-02-composite-action/README.md) · [Siguiente: Ejercicio 04 →](../ejercicio-04-dispatch-events/README.md)
