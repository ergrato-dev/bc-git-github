# Ejercicio 02: Múltiples Triggers

## 🎯 Objetivo

Configurar un workflow con múltiples eventos trigger y filtros avanzados.

**Duración estimada:** 35 minutos

---

## 📋 Requisitos Previos

- Completar Ejercicio 01
- Repositorio actions-lab creado

---

## 📝 Descripción

En este ejercicio configurarás:
1. Múltiples eventos (push, pull_request, schedule)
2. Filtros de branches y paths
3. Trigger manual con inputs
4. Condicionales basadas en eventos

---

## 🚀 Instrucciones

### Paso 1: Crear Workflow con Múltiples Triggers

```bash
cd actions-lab

cat > .github/workflows/multi-trigger.yml << 'EOF'
# ============================================
# WORKFLOW: Multi-Trigger Demo
# ============================================
name: Multi-Trigger Demo

# ============================================
# TRIGGERS: Múltiples eventos
# ============================================
on:
  # ------------------------------------
  # Push con filtros
  # ------------------------------------
  push:
    branches:
      - main
      - develop
      - 'feature/**'      # Glob: feature/login, feature/api
    paths:
      - 'src/**'          # Solo cambios en src/
      - 'package.json'
      - '.github/workflows/**'
    paths-ignore:
      - '**.md'           # Ignorar markdown
      - 'docs/**'
  
  # ------------------------------------
  # Pull Request con tipos específicos
  # ------------------------------------
  pull_request:
    branches:
      - main
    types:
      - opened
      - synchronize
      - reopened
  
  # ------------------------------------
  # Schedule (Cron)
  # ------------------------------------
  schedule:
    # Cada día a las 6:00 AM UTC
    - cron: '0 6 * * *'
    # Cada lunes a las 9:00 AM UTC
    - cron: '0 9 * * 1'
  
  # ------------------------------------
  # Manual con inputs
  # ------------------------------------
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        default: 'development'
        type: choice
        options:
          - development
          - staging
          - production
      
      debug_mode:
        description: 'Enable debug output'
        required: false
        type: boolean
        default: false
      
      version:
        description: 'Version to deploy'
        required: false
        type: string
        default: 'latest'

# ============================================
# JOBS
# ============================================
jobs:
  # ------------------------------------
  # Job: Información del Trigger
  # ------------------------------------
  trigger-info:
    name: Show Trigger Info
    runs-on: ubuntu-latest
    
    steps:
      - name: Event Information
        run: |
          echo "🔔 Trigger Information"
          echo "================================"
          echo "Event Name: ${{ github.event_name }}"
          echo "Ref: ${{ github.ref }}"
          echo "Ref Name: ${{ github.ref_name }}"
          echo "SHA: ${{ github.sha }}"
      
      # Solo en push
      - name: Push Details
        if: github.event_name == 'push'
        run: |
          echo "📤 Push Event Details"
          echo "================================"
          echo "Pusher: ${{ github.event.pusher.name }}"
          echo "Commit Message: ${{ github.event.head_commit.message }}"
          echo "Commits Count: ${{ github.event.commits.length }}"
      
      # Solo en pull_request
      - name: PR Details
        if: github.event_name == 'pull_request'
        run: |
          echo "🔀 Pull Request Details"
          echo "================================"
          echo "PR Number: ${{ github.event.pull_request.number }}"
          echo "PR Title: ${{ github.event.pull_request.title }}"
          echo "PR Author: ${{ github.event.pull_request.user.login }}"
          echo "Base Branch: ${{ github.event.pull_request.base.ref }}"
          echo "Head Branch: ${{ github.event.pull_request.head.ref }}"
      
      # Solo en schedule
      - name: Schedule Details
        if: github.event_name == 'schedule'
        run: |
          echo "⏰ Scheduled Run"
          echo "================================"
          echo "Cron: ${{ github.event.schedule }}"
          echo "Time: $(date -u)"
      
      # Solo en workflow_dispatch
      - name: Manual Dispatch Details
        if: github.event_name == 'workflow_dispatch'
        run: |
          echo "🖱️ Manual Dispatch"
          echo "================================"
          echo "Environment: ${{ inputs.environment }}"
          echo "Debug Mode: ${{ inputs.debug_mode }}"
          echo "Version: ${{ inputs.version }}"

  # ------------------------------------
  # Job: Condicional por Evento
  # ------------------------------------
  build:
    name: Build
    runs-on: ubuntu-latest
    # Solo en push y pull_request
    if: github.event_name == 'push' || github.event_name == 'pull_request'
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Build
        run: echo "Building for ${{ github.event_name }}..."

  # ------------------------------------
  # Job: Deploy (solo manual)
  # ------------------------------------
  deploy:
    name: Deploy to ${{ inputs.environment || 'N/A' }}
    runs-on: ubuntu-latest
    # Solo en dispatch manual
    if: github.event_name == 'workflow_dispatch'
    
    steps:
      - name: Deploy
        run: |
          echo "🚀 Deploying to ${{ inputs.environment }}"
          echo "Version: ${{ inputs.version }}"
          
          if [ "${{ inputs.debug_mode }}" == "true" ]; then
            echo "🐛 Debug mode enabled"
            set -x
          fi
          
          echo "Deployment complete!"

  # ------------------------------------
  # Job: Cleanup (schedule only)
  # ------------------------------------
  cleanup:
    name: Scheduled Cleanup
    runs-on: ubuntu-latest
    if: github.event_name == 'schedule'
    
    steps:
      - name: Cleanup Old Data
        run: |
          echo "🧹 Running scheduled cleanup"
          echo "Cron expression: ${{ github.event.schedule }}"
          echo "Cleanup complete!"
EOF
```

### Paso 2: Crear Estructura de Prueba

```bash
# Crear estructura src/ para probar filtros de paths
mkdir -p src
echo "console.log('Hello');" > src/index.js

# Crear docs/ (será ignorado)
mkdir -p docs
echo "# Documentation" > docs/README.md
```

### Paso 3: Probar Push Trigger

```bash
# Commit y push
git add .
git commit -m "feat: add multi-trigger workflow"
git push origin main

# Verificar que el workflow se ejecutó
gh run list --workflow=multi-trigger.yml
```

### Paso 4: Probar con Cambios en Paths

```bash
# Cambio en src/ - DEBE disparar workflow
echo "console.log('Updated');" > src/index.js
git add src/
git commit -m "feat: update src"
git push

# Cambio en docs/ - NO debe disparar workflow
echo "# Updated docs" > docs/README.md
git add docs/
git commit -m "docs: update documentation"
git push
```

### Paso 5: Probar Pull Request Trigger

```bash
# Crear branch feature
git checkout -b feature/test-trigger

# Hacer cambio
echo "// New feature" >> src/index.js
git add .
git commit -m "feat: add new feature"
git push -u origin feature/test-trigger

# Crear PR
gh pr create --title "Test PR Trigger" --body "Testing pull_request event"

# Verificar que el workflow se ejecutó
gh run list --workflow=multi-trigger.yml
```

### Paso 6: Probar Dispatch Manual

```bash
# Ejecutar workflow manualmente con inputs
gh workflow run multi-trigger.yml \
  -f environment=staging \
  -f debug_mode=true \
  -f version=1.2.3

# Ver la ejecución
gh run list --workflow=multi-trigger.yml
gh run view --log
```

---

## ✅ Verificación

- [ ] Push a main dispara el workflow
- [ ] Cambios en `src/` disparan el workflow
- [ ] Cambios solo en `docs/` o `*.md` NO disparan workflow
- [ ] Crear PR hacia main dispara el workflow
- [ ] Dispatch manual funciona con inputs
- [ ] Cada job se ejecuta según su condición

---

## 🔍 Análisis de Logs

Compara los logs de diferentes ejecuciones:

1. **Push event**: Verifica "Push Details"
2. **PR event**: Verifica "PR Details"
3. **Manual**: Verifica inputs recibidos

---

## 🎯 Desafío Extra

1. Agregar trigger `release` para publicaciones
2. Agregar filtro de `branches-ignore`
3. Crear un input de tipo `environment` para deploy

```yaml
# Hint: Release trigger
on:
  release:
    types: [published]

jobs:
  release-deploy:
    if: github.event_name == 'release'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying ${{ github.event.release.tag_name }}"
```

---

## 📚 Conceptos Aprendidos

| Concepto | Descripción |
|----------|-------------|
| `branches` | Filtrar por branches específicos |
| `paths` | Ejecutar solo si cambian ciertos archivos |
| `paths-ignore` | Ignorar cambios en ciertos archivos |
| `types` | Tipos específicos de eventos |
| `schedule` | Ejecución programada con cron |
| `workflow_dispatch` | Ejecución manual con inputs |
| `inputs` | Parámetros para dispatch manual |

---

## 🧹 Limpieza

```bash
# Volver a main y eliminar branch de prueba
git checkout main
git branch -d feature/test-trigger
git push origin --delete feature/test-trigger

# Cerrar PR si quedó abierto
gh pr close --delete-branch
```

---

[⬅️ Anterior: Hello World](../ejercicio-01-hello-world/) | [➡️ Siguiente: Marketplace Actions](../ejercicio-03-marketplace-actions/)

---

_Ejercicio 02 | Week 07 | GitHub Actions Fundamentos_
