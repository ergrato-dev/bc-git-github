# 🏋️ Ejercicio 04: Dispatch Events - Manual Deploy

> **Duración estimada**: 40 minutos  
> **Dificultad**: Intermedia-Avanzada  
> **Prerequisitos**: Lección 04 - Dispatch Events

---

## 🎯 Objetivo

Crear workflows que respondan a triggers manuales (`workflow_dispatch`) y externos (`repository_dispatch`), implementando un sistema de deployment controlado.

---

## 📋 Lo que aprenderás

- [ ] Configurar `workflow_dispatch` con inputs tipados
- [ ] Usar `repository_dispatch` para triggers externos
- [ ] Crear formularios en la UI de GitHub Actions
- [ ] Triggear workflows via API REST
- [ ] Implementar lógica condicional según el trigger

---

## 📁 Estructura Final

```
.github/workflows/
├── manual-deploy.yml     # workflow_dispatch
├── external-trigger.yml  # repository_dispatch
└── unified-deploy.yml    # Ambos triggers combinados
```

---

## 🚀 Pasos del Ejercicio

### Paso 1: Crear workflow con workflow_dispatch

Crea `.github/workflows/manual-deploy.yml`:

```yaml
# .github/workflows/manual-deploy.yml
# ========================================
# WORKFLOW: Manual Deployment
# ========================================
# ¿Qué hace?: Permite deployments manuales desde la UI
# ¿Por qué?: A veces necesitamos control manual sobre deploys
# ¿Para qué sirve?: Deploys de emergencia, rollbacks, testing

name: Manual Deploy

on:
  workflow_dispatch:
    inputs:
      # ========================================
      # INPUT: Environment (choice)
      # ========================================
      environment:
        description: 'Target environment'
        required: true
        type: choice
        options:
          - development
          - staging
          - production
        default: 'staging'
      
      # ========================================
      # INPUT: Version (string)
      # ========================================
      version:
        description: 'Version to deploy (e.g., v1.2.3 or latest)'
        required: true
        type: string
        default: 'latest'
      
      # ========================================
      # INPUT: Dry Run (boolean)
      # ========================================
      dry-run:
        description: 'Perform dry run only (no actual deploy)'
        required: false
        type: boolean
        default: false
      
      # ========================================
      # INPUT: Skip Tests (boolean)
      # ========================================
      skip-tests:
        description: 'Skip pre-deployment tests'
        required: false
        type: boolean
        default: false
      
      # ========================================
      # INPUT: Notify (choice)
      # ========================================
      notify:
        description: 'Notification channel'
        required: false
        type: choice
        options:
          - none
          - slack
          - email
          - all
        default: 'slack'

jobs:
  # ----------------------------------------
  # JOB: Validate
  # ----------------------------------------
  validate:
    runs-on: ubuntu-latest
    outputs:
      proceed: ${{ steps.check.outputs.proceed }}
    steps:
      - name: Validate inputs
        id: check
        run: |
          echo "🔍 Validating deployment request..."
          echo ""
          echo "Environment: ${{ inputs.environment }}"
          echo "Version: ${{ inputs.version }}"
          echo "Dry Run: ${{ inputs.dry-run }}"
          echo "Skip Tests: ${{ inputs.skip-tests }}"
          echo "Triggered by: ${{ github.actor }}"
          
          # Validación: producción requiere versión específica
          if [[ "${{ inputs.environment }}" == "production" && "${{ inputs.version }}" == "latest" ]]; then
            echo "❌ ERROR: Production deployments require specific version"
            echo "proceed=false" >> $GITHUB_OUTPUT
            exit 1
          fi
          
          echo "proceed=true" >> $GITHUB_OUTPUT
          echo "✅ Validation passed"

  # ----------------------------------------
  # JOB: Pre-deploy Tests
  # ----------------------------------------
  pre-tests:
    needs: validate
    if: ${{ needs.validate.outputs.proceed == 'true' && inputs.skip-tests == false }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run pre-deployment tests
        run: |
          echo "🧪 Running pre-deployment tests..."
          # Simular tests
          sleep 2
          echo "✅ All tests passed"

  # ----------------------------------------
  # JOB: Deploy
  # ----------------------------------------
  deploy:
    needs: [validate, pre-tests]
    if: |
      always() &&
      needs.validate.outputs.proceed == 'true' &&
      (needs.pre-tests.result == 'success' || needs.pre-tests.result == 'skipped')
    runs-on: ubuntu-latest
    environment: ${{ inputs.environment }}
    steps:
      - uses: actions/checkout@v4
      
      - name: Configure deployment
        run: |
          echo "⚙️ Configuring deployment..."
          echo "TARGET_ENV=${{ inputs.environment }}" >> $GITHUB_ENV
          echo "DEPLOY_VERSION=${{ inputs.version }}" >> $GITHUB_ENV
      
      - name: Deploy (Dry Run)
        if: ${{ inputs.dry-run }}
        run: |
          echo "🔄 DRY RUN - No changes will be made"
          echo ""
          echo "Would deploy:"
          echo "  - Version: ${{ inputs.version }}"
          echo "  - Environment: ${{ inputs.environment }}"
          echo "  - Actor: ${{ github.actor }}"
          echo ""
          echo "✅ Dry run completed successfully"
      
      - name: Deploy (Real)
        if: ${{ !inputs.dry-run }}
        run: |
          echo "🚀 Deploying ${{ inputs.version }} to ${{ inputs.environment }}..."
          # Aquí iría el deploy real
          sleep 3
          echo "✅ Deployment completed!"
      
      - name: Generate summary
        run: |
          echo "## 🚀 Deployment Summary" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "| Parameter | Value |" >> $GITHUB_STEP_SUMMARY
          echo "|-----------|-------|" >> $GITHUB_STEP_SUMMARY
          echo "| Environment | ${{ inputs.environment }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Version | ${{ inputs.version }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Dry Run | ${{ inputs.dry-run }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Triggered By | ${{ github.actor }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Status | ✅ Success |" >> $GITHUB_STEP_SUMMARY

  # ----------------------------------------
  # JOB: Notify
  # ----------------------------------------
  notify:
    needs: deploy
    if: ${{ inputs.notify != 'none' }}
    runs-on: ubuntu-latest
    steps:
      - name: Send notification
        run: |
          echo "📢 Sending notification via: ${{ inputs.notify }}"
          
          case "${{ inputs.notify }}" in
            slack)
              echo "Would send Slack message to #deployments"
              ;;
            email)
              echo "Would send email to team@example.com"
              ;;
            all)
              echo "Would notify all channels"
              ;;
          esac
```

---

### Paso 2: Crear workflow con repository_dispatch

Crea `.github/workflows/external-trigger.yml`:

```yaml
# .github/workflows/external-trigger.yml
# ========================================
# WORKFLOW: External Trigger Handler
# ========================================
# ¿Qué hace?: Responde a eventos externos via API
# ¿Por qué?: Integrar con sistemas externos (CI, chatbots, webhooks)
# ¿Para qué sirve?: Automatización cross-system

name: External Trigger

on:
  repository_dispatch:
    types:
      - deploy-request
      - rollback-request
      - health-check

jobs:
  # ----------------------------------------
  # JOB: Handle Deploy Request
  # ----------------------------------------
  handle-deploy:
    if: github.event.action == 'deploy-request'
    runs-on: ubuntu-latest
    steps:
      - name: Process deploy request
        run: |
          echo "📥 Received deploy request from external system"
          echo ""
          echo "Event Type: ${{ github.event.action }}"
          echo "Client Payload:"
          echo '${{ toJson(github.event.client_payload) }}'
          echo ""
          echo "Extracted values:"
          echo "  Version: ${{ github.event.client_payload.version }}"
          echo "  Environment: ${{ github.event.client_payload.environment }}"
          echo "  Requester: ${{ github.event.client_payload.requester }}"
      
      - name: Deploy
        run: |
          VERSION="${{ github.event.client_payload.version }}"
          ENV="${{ github.event.client_payload.environment }}"
          
          echo "🚀 Deploying $VERSION to $ENV..."
          sleep 2
          echo "✅ Deploy completed"

  # ----------------------------------------
  # JOB: Handle Rollback Request
  # ----------------------------------------
  handle-rollback:
    if: github.event.action == 'rollback-request'
    runs-on: ubuntu-latest
    steps:
      - name: Process rollback
        run: |
          echo "⏪ Received rollback request"
          echo "Target version: ${{ github.event.client_payload.target_version }}"
          echo "Reason: ${{ github.event.client_payload.reason }}"
          
          # Simular rollback
          sleep 2
          echo "✅ Rollback completed"

  # ----------------------------------------
  # JOB: Handle Health Check
  # ----------------------------------------
  handle-health:
    if: github.event.action == 'health-check'
    runs-on: ubuntu-latest
    steps:
      - name: Run health check
        run: |
          echo "🏥 Running health check..."
          echo "Requested by: ${{ github.event.client_payload.source }}"
          
          # Simular checks
          echo "✅ API: healthy"
          echo "✅ Database: healthy"
          echo "✅ Cache: healthy"
```

---

### Paso 3: Script para triggear via API

Crea `scripts/trigger-deploy.sh`:

```bash
#!/bin/bash
# scripts/trigger-deploy.sh
# ========================================
# SCRIPT: Trigger deployment via API
# ========================================
# ¿Qué hace?: Envía un repository_dispatch event
# ¿Por qué?: Automatizar triggers desde línea de comandos
# ¿Para qué sirve?: Integración con scripts externos

# Uso: ./trigger-deploy.sh <version> <environment>
# Ejemplo: ./trigger-deploy.sh v1.2.3 staging

VERSION=${1:-"latest"}
ENVIRONMENT=${2:-"staging"}
REPO="owner/repo"  # Cambiar por tu repo

# Verificar que tenemos token
if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ Error: GITHUB_TOKEN not set"
  echo "Run: export GITHUB_TOKEN=your_token"
  exit 1
fi

echo "🚀 Triggering deployment..."
echo "   Version: $VERSION"
echo "   Environment: $ENVIRONMENT"
echo ""

# Enviar repository_dispatch
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/$REPO/dispatches" \
  -d "{
    \"event_type\": \"deploy-request\",
    \"client_payload\": {
      \"version\": \"$VERSION\",
      \"environment\": \"$ENVIRONMENT\",
      \"requester\": \"$(whoami)\",
      \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"
    }
  }"

if [ $? -eq 0 ]; then
  echo "✅ Dispatch sent successfully"
  echo "Check: https://github.com/$REPO/actions"
else
  echo "❌ Failed to send dispatch"
fi
```

---

### Paso 4: Script para workflow_dispatch via API

Crea `scripts/trigger-manual.sh`:

```bash
#!/bin/bash
# scripts/trigger-manual.sh
# ========================================
# SCRIPT: Trigger workflow_dispatch via API
# ========================================

WORKFLOW="manual-deploy.yml"
REF="main"
REPO="owner/repo"  # Cambiar por tu repo

# Parámetros
ENVIRONMENT=${1:-"staging"}
VERSION=${2:-"latest"}
DRY_RUN=${3:-"true"}

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ Error: GITHUB_TOKEN not set"
  exit 1
fi

echo "🚀 Triggering manual deployment workflow..."

curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO/actions/workflows/$WORKFLOW/dispatches" \
  -d "{
    \"ref\": \"$REF\",
    \"inputs\": {
      \"environment\": \"$ENVIRONMENT\",
      \"version\": \"$VERSION\",
      \"dry-run\": \"$DRY_RUN\",
      \"skip-tests\": \"false\",
      \"notify\": \"slack\"
    }
  }"

echo "✅ Workflow dispatch sent"
```

---

## ✅ Verificación

Tu ejercicio está completo si:

- [ ] `workflow_dispatch` muestra formulario en UI de GitHub
- [ ] Los inputs tipo `choice` muestran dropdown
- [ ] `repository_dispatch` responde a diferentes `event_type`
- [ ] Los scripts de API funcionan con token válido
- [ ] El summary se genera correctamente

---

## 🎯 Desafíos Extra (Opcional)

1. **Añadir input `environment`** tipo GitHub Environment
2. **Implementar approval** para producción
3. **Integrar con Slack** usando webhook real

---

## 📚 Recursos

- [workflow_dispatch - GitHub Docs](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch)
- [repository_dispatch - GitHub Docs](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch)
- [REST API - Create workflow dispatch](https://docs.github.com/en/rest/actions/workflows#create-a-workflow-dispatch-event)

---

[⬅️ Ejercicio anterior](../ejercicio-03-reusable-workflow/README.md) · [📋 Volver a Ejercicios](../README.md)
