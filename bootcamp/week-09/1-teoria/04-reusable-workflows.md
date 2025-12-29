# 📚 Lección 04: Reusable Workflows y Dispatch Events

> **Duración estimada**: 20 minutos  
> **Nivel**: Intermedio-Avanzado  
> **Prerequisitos**: Lecciones 01-03, experiencia con workflows multi-job

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- [ ] Crear workflows reutilizables con `workflow_call`
- [ ] Compartir workflows entre múltiples repositorios
- [ ] Configurar triggers manuales con `workflow_dispatch`
- [ ] Triggear workflows externamente con `repository_dispatch`

---

## 📖 Contenido Teórico

### Parte 1: Reusable Workflows

---

### 1. ¿Qué son los Reusable Workflows?

Los **Reusable Workflows** permiten definir un workflow completo una vez y llamarlo desde otros workflows. Son como "templates" de CI/CD.

![Reusable Workflows](../0-assets/03-reusable-workflows.svg)

**Diferencias con Actions**:

| Aspecto | Custom Action | Reusable Workflow |
|---------|---------------|-------------------|
| **Alcance** | Steps individuales | Jobs completos |
| **Trigger** | `uses:` en step | `uses:` en job |
| **Ubicación** | Cualquier carpeta | `.github/workflows/` |
| **Outputs** | Step outputs | Job outputs |
| **Secretos** | Via inputs | `secrets: inherit` |

---

### 2. Crear un Reusable Workflow

#### 2.1 Workflow Llamable (Callable)

```yaml
# .github/workflows/ci-template.yml
name: CI Template

# ========================================
# TRIGGER: workflow_call
# ========================================
# ¿Qué hace?: Permite que otros workflows llamen a este
# ¿Por qué?: Centralizar lógica de CI reutilizable
# ¿Para qué sirve?: DRY - No repetir el mismo workflow

on:
  workflow_call:
    # Inputs que el workflow llamador puede pasar
    inputs:
      node-version:
        description: 'Node.js version to use'
        required: false
        type: string
        default: '20'
      
      run-e2e:
        description: 'Run E2E tests'
        required: false
        type: boolean
        default: false
      
      environment:
        description: 'Deployment environment'
        required: false
        type: string  # choice no disponible en workflow_call
        default: 'staging'
    
    # Secrets que el workflow llamador debe proveer
    secrets:
      NPM_TOKEN:
        description: 'npm registry token'
        required: false
      
      DEPLOY_KEY:
        description: 'SSH deploy key'
        required: true
    
    # Outputs que el workflow llamador puede usar
    outputs:
      version:
        description: 'Built version'
        value: ${{ jobs.build.outputs.version }}
      
      artifact-url:
        description: 'URL to download artifact'
        value: ${{ jobs.build.outputs.artifact-url }}

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
      - run: npm ci
      - run: npm run lint
  
  test:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
      - run: npm ci
      - run: npm test
  
  e2e:
    if: ${{ inputs.run-e2e }}
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run test:e2e
  
  build:
    runs-on: ubuntu-latest
    needs: [lint, test]
    outputs:
      version: ${{ steps.version.outputs.version }}
      artifact-url: ${{ steps.upload.outputs.artifact-url }}
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
      
      - run: npm ci
      
      - name: Build
        run: npm run build
        env:
          NODE_ENV: production
      
      - name: Get version
        id: version
        run: echo "version=$(node -p "require('./package.json').version")" >> $GITHUB_OUTPUT
      
      - name: Upload artifact
        id: upload
        uses: actions/upload-artifact@v4
        with:
          name: build-${{ steps.version.outputs.version }}
          path: dist/
```

---

#### 2.2 Workflow Llamador (Caller)

```yaml
# .github/workflows/ci.yml (en otro repo o el mismo)
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  # ========================================
  # LLAMAR AL WORKFLOW REUTILIZABLE
  # ========================================
  # ¿Qué hace?: Ejecuta el workflow template como un job
  # ¿Por qué?: Reutilizar lógica de CI sin duplicar código
  # ¿Para qué sirve?: Mantener un solo lugar para actualizar CI
  
  ci:
    uses: org/shared-workflows/.github/workflows/ci-template.yml@v1
    with:
      node-version: '20'
      run-e2e: true
      environment: staging
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
      DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
  
  # Usar outputs del workflow llamado
  deploy:
    needs: ci
    runs-on: ubuntu-latest
    steps:
      - name: Show build info
        run: |
          echo "Version: ${{ needs.ci.outputs.version }}"
          echo "Artifact: ${{ needs.ci.outputs.artifact-url }}"
      
      - name: Deploy
        run: echo "Deploying version ${{ needs.ci.outputs.version }}..."
```

---

### 3. Pasar Secretos

Hay tres formas de manejar secretos en reusable workflows:

#### 3.1 Secretos Explícitos

```yaml
# Caller
jobs:
  ci:
    uses: org/repo/.github/workflows/template.yml@v1
    secrets:
      TOKEN: ${{ secrets.MY_TOKEN }}
```

#### 3.2 Inherit (Heredar Todos)

```yaml
# Caller - pasa todos los secretos automáticamente
jobs:
  ci:
    uses: org/repo/.github/workflows/template.yml@v1
    secrets: inherit
```

#### 3.3 Secretos Opcionales

```yaml
# Called workflow
on:
  workflow_call:
    secrets:
      OPTIONAL_TOKEN:
        required: false  # No falla si no se provee
```

---

### 4. Limitaciones de Reusable Workflows

| Limitación | Detalle |
|------------|---------|
| **Anidamiento** | Máximo 4 niveles de profundidad |
| **Cantidad** | Máximo 20 workflows llamados por run |
| **env** | Variables `env` del caller no se heredan |
| **Matrices** | El caller puede usar matrix, el called no tiene acceso directo |
| **Permisos** | `permissions` del caller aplican |

---

### Parte 2: Dispatch Events

---

### 5. workflow_dispatch - Trigger Manual

El evento `workflow_dispatch` permite ejecutar workflows manualmente desde la UI de GitHub o via API.

![Dispatch Events](../0-assets/04-dispatch-events.svg)

```yaml
name: Manual Deployment

on:
  workflow_dispatch:
    inputs:
      # ========================================
      # INPUT TIPO STRING
      # ========================================
      environment:
        description: 'Target environment'
        required: true
        type: string
        default: 'staging'
      
      # ========================================
      # INPUT TIPO CHOICE (Dropdown)
      # ========================================
      region:
        description: 'AWS Region'
        required: true
        type: choice
        options:
          - us-east-1
          - us-west-2
          - eu-west-1
        default: 'us-east-1'
      
      # ========================================
      # INPUT TIPO BOOLEAN (Checkbox)
      # ========================================
      dry-run:
        description: 'Perform dry run only'
        required: false
        type: boolean
        default: false
      
      # ========================================
      # INPUT TIPO ENVIRONMENT
      # ========================================
      target:
        description: 'GitHub Environment'
        required: true
        type: environment

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ inputs.target }}
    steps:
      - name: Show inputs
        run: |
          echo "Environment: ${{ inputs.environment }}"
          echo "Region: ${{ inputs.region }}"
          echo "Dry run: ${{ inputs.dry-run }}"
          echo "Target: ${{ inputs.target }}"
      
      - name: Deploy (if not dry run)
        if: ${{ !inputs.dry-run }}
        run: |
          echo "Deploying to ${{ inputs.environment }} in ${{ inputs.region }}..."
```

**Tipos de inputs disponibles**:

| Tipo | Descripción | Ejemplo en UI |
|------|-------------|---------------|
| `string` | Texto libre | Input de texto |
| `choice` | Selector dropdown | Lista desplegable |
| `boolean` | Verdadero/Falso | Checkbox |
| `environment` | GitHub Environment | Dropdown de environments |

---

### 6. Ejecutar workflow_dispatch via API

```bash
# ¿Qué hace?: Dispara el workflow manualmente via REST API
# ¿Por qué?: Automatizar triggers desde scripts externos
# ¿Para qué sirve?: Integrar con otros sistemas (Slack, Jenkins, etc.)

curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  https://api.github.com/repos/OWNER/REPO/actions/workflows/deploy.yml/dispatches \
  -d '{
    "ref": "main",
    "inputs": {
      "environment": "production",
      "region": "us-east-1",
      "dry-run": "false"
    }
  }'
```

---

### 7. repository_dispatch - Trigger Externo

El evento `repository_dispatch` permite triggear workflows desde sistemas externos sin autenticación de usuario.

```yaml
name: External Trigger Handler

on:
  repository_dispatch:
    types:
      - deploy           # Evento personalizado 1
      - rollback         # Evento personalizado 2
      - webhook-received # Evento personalizado 3

jobs:
  handle-deploy:
    if: github.event.action == 'deploy'
    runs-on: ubuntu-latest
    steps:
      - name: Process deploy event
        run: |
          echo "Event type: ${{ github.event.action }}"
          echo "Client payload: ${{ toJson(github.event.client_payload) }}"
          echo "Version: ${{ github.event.client_payload.version }}"
          echo "Environment: ${{ github.event.client_payload.environment }}"
  
  handle-rollback:
    if: github.event.action == 'rollback'
    runs-on: ubuntu-latest
    steps:
      - name: Process rollback
        run: |
          echo "Rolling back to version: ${{ github.event.client_payload.target_version }}"
```

**Enviar evento via API**:

```bash
# ¿Qué hace?: Envía un evento repository_dispatch con payload custom
# ¿Por qué?: Triggear workflows desde sistemas externos (webhooks)
# ¿Para qué sirve?: Integración con CI externos, chatbots, etc.

curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  https://api.github.com/repos/OWNER/REPO/dispatches \
  -d '{
    "event_type": "deploy",
    "client_payload": {
      "version": "1.2.3",
      "environment": "production",
      "triggered_by": "slack-bot"
    }
  }'
```

---

### 8. Comparativa: workflow_dispatch vs repository_dispatch

| Aspecto | workflow_dispatch | repository_dispatch |
|---------|-------------------|---------------------|
| **Trigger** | UI GitHub / API | Solo API |
| **Inputs** | Definidos en YAML | `client_payload` libre |
| **Validación** | Tipos forzados | Sin validación |
| **UI** | Formulario en Actions | No hay UI |
| **Uso típico** | Deploys manuales | Webhooks externos |
| **Event type** | N/A | Custom (`types:`) |

---

### 9. Caso de Uso: CI/CD Completo

```yaml
name: Complete CI/CD

on:
  # Trigger automático
  push:
    branches: [main]
  
  # Trigger manual
  workflow_dispatch:
    inputs:
      environment:
        type: choice
        options: [staging, production]
        default: staging
      skip-tests:
        type: boolean
        default: false
  
  # Trigger externo
  repository_dispatch:
    types: [deploy-request]

jobs:
  # Determinar configuración
  config:
    runs-on: ubuntu-latest
    outputs:
      environment: ${{ steps.config.outputs.env }}
      skip-tests: ${{ steps.config.outputs.skip }}
    steps:
      - id: config
        run: |
          # Diferentes fuentes de configuración según el trigger
          if [ "${{ github.event_name }}" == "workflow_dispatch" ]; then
            echo "env=${{ inputs.environment }}" >> $GITHUB_OUTPUT
            echo "skip=${{ inputs.skip-tests }}" >> $GITHUB_OUTPUT
          elif [ "${{ github.event_name }}" == "repository_dispatch" ]; then
            echo "env=${{ github.event.client_payload.environment }}" >> $GITHUB_OUTPUT
            echo "skip=false" >> $GITHUB_OUTPUT
          else
            echo "env=staging" >> $GITHUB_OUTPUT
            echo "skip=false" >> $GITHUB_OUTPUT
          fi
  
  # CI usando reusable workflow
  ci:
    needs: config
    if: needs.config.outputs.skip-tests != 'true'
    uses: ./.github/workflows/ci-template.yml
    with:
      environment: ${{ needs.config.outputs.environment }}
    secrets: inherit
  
  # Deploy
  deploy:
    needs: [config, ci]
    if: always() && !failure()
    runs-on: ubuntu-latest
    environment: ${{ needs.config.outputs.environment }}
    steps:
      - run: echo "Deploying to ${{ needs.config.outputs.environment }}..."
```

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **Reusable Workflow** | Workflow llamable via `workflow_call` |
| **workflow_call** | Trigger que permite llamar al workflow |
| **workflow_dispatch** | Trigger manual desde UI o API |
| **repository_dispatch** | Trigger externo via API con payload custom |
| **secrets: inherit** | Heredar todos los secretos del caller |
| **client_payload** | Datos enviados en repository_dispatch |

---

## 🔗 Recursos Adicionales

- [📖 Reusable Workflows - GitHub Docs](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [📖 workflow_dispatch - GitHub Docs](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch)
- [📖 repository_dispatch - GitHub Docs](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch)
- [📖 REST API Workflows](https://docs.github.com/en/rest/actions/workflows)

---

## ✅ Fin del Módulo de Teoría

Has completado las 4 lecciones teóricas de la Semana 09. Ahora es momento de practicar:

[🏋️ Ir a Ejercicios →](../2-practicas/README.md)

---

[⬅️ Lección anterior](03-composite-actions.md) · [📋 Semana 09](../README.md)
