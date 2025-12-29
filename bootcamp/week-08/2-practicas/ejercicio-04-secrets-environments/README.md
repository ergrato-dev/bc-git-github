# 🧪 Ejercicio 04: Secrets y Environments

## 🎯 Objetivo

Configurar secrets a nivel de repositorio, crear environments con protecciones, y usar variables de entorno en workflows de forma segura.

---

## 📋 Información del Ejercicio

| Aspecto | Detalle |
|---------|---------|
| **Duración** | 40 minutos |
| **Dificultad** | Avanzada |
| **Requisitos** | Ejercicios 01-03, acceso admin al repo |
| **Temas** | Secrets, variables, environments, approvals, GITHUB_TOKEN |

---

## 📚 Conceptos Previos

- [x] Diferencia entre secrets y variables
- [x] Niveles de secretos (repo, environment, org)
- [x] GITHUB_TOKEN automático
- [x] Environments para staging/production

---

## 🎬 Escenario

Tu aplicación necesita hacer deploy a dos ambientes:

1. **Staging**: Deploy automático, sin aprobación
2. **Production**: Requiere aprobación manual

Además, necesitas:
- Configurar credenciales de deploy (secrets)
- Variables de configuración por ambiente
- Protección contra deploys accidentales

---

## 📊 Arquitectura de Environments

```
┌─────────────────────────────────────────────────────────────┐
│                    REPOSITORY SECRETS                        │
│  ┌─────────────────┐  ┌─────────────────┐                   │
│  │ NPM_TOKEN       │  │ CODECOV_TOKEN   │                   │
│  │ (para publish)  │  │ (para coverage) │                   │
│  └─────────────────┘  └─────────────────┘                   │
├─────────────────────────────────────────────────────────────┤
│                      ENVIRONMENTS                            │
│                                                              │
│  ┌──────────────────────┐  ┌──────────────────────┐        │
│  │      STAGING         │  │     PRODUCTION       │        │
│  │                      │  │                      │        │
│  │ Secrets:             │  │ Secrets:             │        │
│  │ - DEPLOY_KEY         │  │ - DEPLOY_KEY         │        │
│  │ - SERVER_URL         │  │ - SERVER_URL         │        │
│  │                      │  │                      │        │
│  │ Variables:           │  │ Variables:           │        │
│  │ - ENV_NAME=staging   │  │ - ENV_NAME=prod      │        │
│  │                      │  │                      │        │
│  │ Protection:          │  │ Protection:          │        │
│  │ - None               │  │ - Required reviewers │        │
│  │                      │  │ - Wait timer: 5 min  │        │
│  └──────────────────────┘  └──────────────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

---

## 🚀 Instrucciones

### Paso 1: Crear Repository Secrets (10 min)

**En GitHub → Settings → Secrets and variables → Actions:**

```
1. Click "New repository secret"
2. Agregar los siguientes secrets:

┌─────────────────────────────────────────┐
│ Name: DEPLOY_TOKEN                      │
│ Secret: ******** (valor ficticio)       │
│ [Add secret]                            │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ Name: NOTIFICATION_WEBHOOK              │
│ Secret: https://example.com/webhook     │
│ [Add secret]                            │
└─────────────────────────────────────────┘
```

**Importante:** Los secrets son valores sensibles que:
- ❌ NUNCA se muestran en logs (aparecen como `***`)
- ❌ NO se pueden leer después de guardarse
- ✅ Solo se pueden sobrescribir o eliminar

### Paso 2: Crear Repository Variables (5 min)

**En GitHub → Settings → Secrets and variables → Actions → Variables:**

```
1. Click "New repository variable"
2. Agregar:

┌─────────────────────────────────────────┐
│ Name: APP_NAME                          │
│ Value: mi-aplicacion                    │
│ [Add variable]                          │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│ Name: NODE_VERSION                      │
│ Value: 20                               │
│ [Add variable]                          │
└─────────────────────────────────────────┘
```

**Variables vs Secrets:**
- Variables: Valores de configuración visibles
- Secrets: Credenciales y datos sensibles ocultos

### Paso 3: Crear Environments (10 min)

**En GitHub → Settings → Environments:**

#### Environment: staging

```
1. Click "New environment"
2. Name: staging
3. [Configure environment]

Environment protection rules:
☐ Required reviewers (deshabilitado para staging)

Environment secrets:
┌─────────────────────────────────────────┐
│ Name: DEPLOY_URL                        │
│ Secret: https://staging.example.com     │
└─────────────────────────────────────────┘

Environment variables:
┌─────────────────────────────────────────┐
│ Name: ENV_NAME                          │
│ Value: staging                          │
└─────────────────────────────────────────┘
```

#### Environment: production

```
1. Click "New environment"
2. Name: production
3. [Configure environment]

Environment protection rules:
☑ Required reviewers
   Add: tu-usuario (o tu equipo)
   
☑ Wait timer: 5 minutes

Deployment branches:
☑ Selected branches
   Add: main

Environment secrets:
┌─────────────────────────────────────────┐
│ Name: DEPLOY_URL                        │
│ Secret: https://prod.example.com        │
└─────────────────────────────────────────┘

Environment variables:
┌─────────────────────────────────────────┐
│ Name: ENV_NAME                          │
│ Value: production                       │
└─────────────────────────────────────────┘
```

### Paso 4: Workflow con Secrets y Environments (10 min)

**Archivo: `.github/workflows/deploy.yml`**

```yaml
# =============================================================================
# Deploy Pipeline con Secrets y Environments
# =============================================================================
# ¿QUÉ HACE?: Deploy a staging (automático) y production (con aprobación)
# ¿POR QUÉ?: Diferentes ambientes requieren diferentes niveles de protección
# ¿PARA QUÉ?: Prevenir deploys accidentales a producción
# =============================================================================

name: Deploy Pipeline

on:
  push:
    branches: [main]
  workflow_dispatch:  # Permite trigger manual

# Variables disponibles en todo el workflow
env:
  # Variable de repositorio
  APP_NAME: ${{ vars.APP_NAME }}
  NODE_VERSION: ${{ vars.NODE_VERSION }}

jobs:
  # ===========================================================================
  # JOB: BUILD
  # ===========================================================================
  build:
    name: 🏗️ Build
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      
      - run: npm ci
      - run: npm run build
      
      - uses: actions/upload-artifact@v4
        with:
          name: build-output
          path: dist/

  # ===========================================================================
  # JOB: DEPLOY TO STAGING
  # ===========================================================================
  deploy-staging:
    name: 🚀 Deploy to Staging
    runs-on: ubuntu-latest
    needs: build
    
    # =========================================
    # ENVIRONMENT: staging
    # =========================================
    # ¿QUÉ?: Vincula este job al environment 'staging'
    # ¿POR QUÉ?: Accede a secrets/variables de staging
    # ¿PARA QUÉ?: Deploy automático sin aprobación
    environment:
      name: staging
      url: https://staging.example.com
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: build-output
          path: dist/
      
      # =========================================
      # USAR SECRETS Y VARIABLES
      # =========================================
      - name: Deploy to Staging
        env:
          # Secret de environment (staging)
          DEPLOY_URL: ${{ secrets.DEPLOY_URL }}
          # Variable de environment
          ENV_NAME: ${{ vars.ENV_NAME }}
          # Secret de repositorio
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
        run: |
          echo "## 🚀 Deploying to $ENV_NAME" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "- **Target:** $DEPLOY_URL" >> $GITHUB_STEP_SUMMARY
          echo "- **App:** $APP_NAME" >> $GITHUB_STEP_SUMMARY
          echo "- **Token:** Present (hidden)" >> $GITHUB_STEP_SUMMARY
          
          # Simular deploy (en real usarías SSH, rsync, etc.)
          echo "Deploying to: $DEPLOY_URL"
          echo "Using token: ${DEPLOY_TOKEN:0:4}***" # Solo muestra primeros 4 chars
          ls -la dist/
      
      - name: Notify deployment
        run: |
          echo "✅ Staging deployment complete"
          # Aquí podrías llamar a ${{ secrets.NOTIFICATION_WEBHOOK }}

  # ===========================================================================
  # JOB: DEPLOY TO PRODUCTION
  # ===========================================================================
  deploy-production:
    name: 🚀 Deploy to Production
    runs-on: ubuntu-latest
    needs: deploy-staging  # Solo después de staging exitoso
    
    # =========================================
    # ENVIRONMENT: production (con aprobación)
    # =========================================
    # ¿QUÉ?: Vincula al environment 'production'
    # ¿POR QUÉ?: Production tiene required reviewers
    # ¿PARA QUÉ?: El workflow PAUSA esperando aprobación manual
    environment:
      name: production
      url: https://prod.example.com
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: build-output
          path: dist/
      
      - name: Deploy to Production
        env:
          DEPLOY_URL: ${{ secrets.DEPLOY_URL }}
          ENV_NAME: ${{ vars.ENV_NAME }}
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
        run: |
          echo "## 🚀 Deploying to $ENV_NAME" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "⚠️ **PRODUCTION DEPLOYMENT**" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "- **Target:** $DEPLOY_URL" >> $GITHUB_STEP_SUMMARY
          echo "- **Approved by:** Manual review" >> $GITHUB_STEP_SUMMARY
          
          echo "Deploying to PRODUCTION: $DEPLOY_URL"
          ls -la dist/
      
      - name: Post-deployment verification
        run: |
          echo "✅ Production deployment complete"
          echo "Running smoke tests..."
          # Aquí ejecutarías tests de verificación
```

### Paso 5: Usar GITHUB_TOKEN (5 min)

El `GITHUB_TOKEN` es un secret automático con permisos configurables:

```yaml
jobs:
  create-release:
    runs-on: ubuntu-latest
    
    # =========================================
    # PERMISOS DEL GITHUB_TOKEN
    # =========================================
    permissions:
      contents: write      # Para crear releases
      pull-requests: write # Para comentar en PRs
      issues: write        # Para crear/editar issues
    
    steps:
      - uses: actions/checkout@v4
      
      # Usar GITHUB_TOKEN para operaciones en el repo
      - name: Create a release
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          gh release create v1.0.0 \
            --title "Release v1.0.0" \
            --notes "Automated release"
      
      # Comentar en un PR
      - name: Comment on PR
        if: github.event_name == 'pull_request'
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          gh pr comment ${{ github.event.pull_request.number }} \
            --body "✅ Build passed! Ready for review."
```

---

## ✅ Verificación

### Checklist

- [ ] Secrets de repositorio creados (DEPLOY_TOKEN, NOTIFICATION_WEBHOOK)
- [ ] Variables de repositorio creadas (APP_NAME, NODE_VERSION)
- [ ] Environment staging configurado
- [ ] Environment production con required reviewers
- [ ] Workflow ejecuta staging automáticamente
- [ ] Workflow pausa en production esperando aprobación
- [ ] Secrets no aparecen en logs (muestran `***`)

### Flujo esperado al hacer push:

```
Push to main
    │
    ▼
┌─────────────┐
│    Build    │ ✅ Auto
└─────────────┘
    │
    ▼
┌─────────────┐
│   Staging   │ ✅ Auto
└─────────────┘
    │
    ▼
┌─────────────┐
│ Production  │ ⏸️ Waiting for approval
└─────────────┘
    │
    ▼ (manual approval)
┌─────────────┐
│ Production  │ ✅ Deployed
└─────────────┘
```

---

## 🔧 Solución de Problemas

### Secret no disponible en el job

```yaml
# ¿El job tiene el environment correcto?
jobs:
  deploy:
    environment: staging  # ← Necesario para secrets de staging
```

### Error de permisos con GITHUB_TOKEN

```yaml
# Agregar permisos explícitos
permissions:
  contents: write
  pull-requests: write
```

### El workflow no pausa en production

```bash
# Verificar en Settings → Environments → production:
# - Required reviewers está habilitado
# - Tu usuario está en la lista de reviewers
```

---

## 🎯 Desafíos Adicionales

### Desafío 1: Secret condicional

```yaml
- name: Deploy with optional debug
  env:
    DEBUG: ${{ secrets.ENABLE_DEBUG || 'false' }}
  run: |
    if [ "$DEBUG" == "true" ]; then
      echo "Debug mode enabled"
    fi
```

### Desafío 2: Rollback environment

```yaml
# Crear environment 'rollback' con sus propios secrets
rollback:
  environment: rollback
  steps:
    - name: Rollback to previous version
      env:
        ROLLBACK_VERSION: ${{ vars.LAST_STABLE_VERSION }}
      run: echo "Rolling back to $ROLLBACK_VERSION"
```

### Desafío 3: OIDC Authentication

```yaml
# Para cloud providers (AWS, Azure, GCP)
permissions:
  id-token: write
  contents: read

steps:
  - name: Configure AWS credentials
    uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::123456789:role/my-role
      aws-region: us-east-1
```

---

## 📚 Recursos

- [Lección 04: Secrets y Variables](../../1-teoria/04-secrets-variables.md)
- [GitHub Docs - Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitHub Docs - Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)

---

## 🔗 Navegación

| ⬅️ Anterior | 📚 Prácticas | ➡️ Siguiente |
|:-----------:|:------------:|:------------:|
| [Ejercicio 03](../ejercicio-03-artifacts-jobs/README.md) | [README](../README.md) | [Proyecto Semanal](../../3-proyecto/README.md) |
