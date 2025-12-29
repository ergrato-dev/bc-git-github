# ✅ Ejercicio 03: Approval Workflow

## 📋 Información del Ejercicio

| Campo | Detalle |
|-------|---------|
| **Duración** | 40 minutos |
| **Dificultad** | Intermedia-Avanzada |
| **Prerrequisitos** | Ejercicio 02 - Protection Rules |
| **Objetivos** | Implementar workflow con gates de aprobación manuales |

---

## 🎯 Objetivos

Al completar este ejercicio, habrás:

- [ ] Implementado un workflow con múltiples gates de aprobación
- [ ] Configurado notificaciones para reviewers
- [ ] Manejado aprobaciones y rechazos
- [ ] Creado un dashboard de deployment status

---

## 📝 Escenario

Tu equipo necesita un proceso de deployment formal con:
- Gate de QA después de staging
- Gate de Change Management antes de production
- Notificaciones automáticas a los equipos correspondientes

---

## 🚀 Instrucciones

### Parte 1: Configurar Environments con Gates (10 min)

#### 1.1 Crear Environment "qa-approval"

```bash
# EJERCICIO: Crear environment para gate de QA
# ¿QUÉ VAMOS A HACER?: Environment que requiere aprobación de QA
# ¿POR QUÉ LO HACEMOS?: QA debe verificar staging antes de prod
# ¿PARA QUÉ SIRVE?: Control de calidad formal en el pipeline
```

1. **Settings** → **Environments** → **New environment**
2. Name: `qa-approval`
3. **Required reviewers**: Agregar usuarios del equipo QA
4. **Save protection rules**

#### 1.2 Crear Environment "change-management"

1. **Settings** → **Environments** → **New environment**
2. Name: `change-management`
3. **Required reviewers**: Agregar tech lead o change manager
4. **Wait timer**: `5` minutos (tiempo para revisar)
5. **Save protection rules**

### Parte 2: Crear Workflow con Múltiples Gates (20 min)

Crea `.github/workflows/approval-pipeline.yml`:

```yaml
# ¿QUÉ HACE?: Pipeline con múltiples gates de aprobación
# ¿POR QUÉ?: Implementar proceso de cambio formal
# ¿PARA QUÉ SIRVE?: Asegurar revisiones en cada etapa crítica

name: Approval Pipeline

on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      skip_qa:
        description: 'Skip QA gate (emergencies only)'
        type: boolean
        default: false
      release_notes:
        description: 'Release notes for this deployment'
        type: string
        required: false

env:
  DEPLOYMENT_ID: ${{ github.run_id }}

jobs:
  # ═══════════════════════════════════════════════════════════
  # STAGE 1: BUILD & TEST
  # ═══════════════════════════════════════════════════════════
  build:
    name: 🔨 Build & Unit Tests
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.value }}
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Generate version
        id: version
        run: |
          VERSION="1.0.${{ github.run_number }}"
          echo "value=$VERSION" >> $GITHUB_OUTPUT
          echo "📦 Version: $VERSION"
      
      - name: Run unit tests
        run: |
          echo "🧪 Running unit tests..."
          sleep 2
          echo "✅ 42 tests passed"
      
      - name: Create deployment summary
        run: |
          cat >> $GITHUB_STEP_SUMMARY << 'EOF'
          ## 📦 Build Summary
          
          | Field | Value |
          |-------|-------|
          | Version | ${{ steps.version.outputs.value }} |
          | Commit | ${{ github.sha }} |
          | Branch | ${{ github.ref_name }} |
          | Triggered by | ${{ github.actor }} |
          
          ### 🧪 Test Results
          - Unit tests: ✅ 42 passed
          - Linting: ✅ No issues
          EOF

  # ═══════════════════════════════════════════════════════════
  # STAGE 2: DEPLOY TO DEVELOPMENT
  # ═══════════════════════════════════════════════════════════
  deploy-dev:
    name: 🌍 Development
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: development
      url: https://dev.example.com
    
    steps:
      - name: Deploy to Development
        run: |
          echo "🚀 Deploying v${{ needs.build.outputs.version }} to development"
          sleep 3
          echo "✅ Development deployment complete"

  # ═══════════════════════════════════════════════════════════
  # STAGE 3: DEPLOY TO STAGING
  # ═══════════════════════════════════════════════════════════
  deploy-staging:
    name: 🎭 Staging
    needs: [build, deploy-dev]
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.example.com
    
    steps:
      - name: Deploy to Staging
        run: |
          echo "🚀 Deploying v${{ needs.build.outputs.version }} to staging"
          sleep 3
          echo "✅ Staging deployment complete"
      
      - name: Run E2E tests
        run: |
          echo "🧪 Running E2E tests on staging..."
          sleep 5
          echo "✅ 15 E2E tests passed"
      
      - name: Notify QA team
        run: |
          echo "📧 Notifying QA team..."
          echo "   To: qa-team@example.com"
          echo "   Subject: v${{ needs.build.outputs.version }} ready for QA"
          echo ""
          cat >> $GITHUB_STEP_SUMMARY << 'EOF'
          
          ## 🎭 Staging Deployment
          
          ✅ Deployed successfully to staging
          
          ### 📋 Next Step
          **QA Approval Required**
          
          The QA team needs to:
          1. Review the changes at https://staging.example.com
          2. Run manual test cases
          3. Approve the deployment to continue
          
          [Review Deployment →](../../actions/runs/${{ github.run_id }})
          EOF

  # ═══════════════════════════════════════════════════════════
  # GATE 1: QA APPROVAL
  # ═══════════════════════════════════════════════════════════
  qa-gate:
    name: ✅ QA Approval Gate
    needs: deploy-staging
    runs-on: ubuntu-latest
    if: ${{ !inputs.skip_qa }}
    environment: qa-approval
    
    steps:
      - name: QA Approval received
        run: |
          echo "════════════════════════════════════════"
          echo "✅ QA APPROVAL GATE PASSED"
          echo "════════════════════════════════════════"
          echo ""
          echo "📋 QA Checklist verified:"
          echo "   ✅ Functional testing complete"
          echo "   ✅ Regression testing passed"
          echo "   ✅ No critical bugs found"
          echo "   ✅ Performance acceptable"
          echo ""
          echo "👤 Approved by: ${{ github.actor }}"
          echo "⏰ Approved at: $(date -u)"
      
      - name: Update deployment summary
        run: |
          cat >> $GITHUB_STEP_SUMMARY << 'EOF'
          
          ## ✅ QA Gate Passed
          
          | Field | Value |
          |-------|-------|
          | Approved by | ${{ github.actor }} |
          | Time | $(date -u) |
          
          QA has verified:
          - [x] Functional testing
          - [x] Regression testing  
          - [x] Performance testing
          - [x] No blocking issues
          EOF

  # ═══════════════════════════════════════════════════════════
  # GATE 2: CHANGE MANAGEMENT APPROVAL
  # ═══════════════════════════════════════════════════════════
  change-management-gate:
    name: 📋 Change Management Gate
    needs: qa-gate
    runs-on: ubuntu-latest
    environment: change-management
    
    steps:
      - name: Change Management Approval received
        run: |
          echo "════════════════════════════════════════"
          echo "📋 CHANGE MANAGEMENT GATE PASSED"
          echo "════════════════════════════════════════"
          echo ""
          echo "📝 Change Request Details:"
          echo "   Change ID: CHG-${{ github.run_number }}"
          echo "   Type: Standard Change"
          echo "   Risk: Low"
          echo "   Rollback Plan: Available"
          echo ""
          echo "👤 Approved by: ${{ github.actor }}"
      
      - name: Create change record
        run: |
          cat >> $GITHUB_STEP_SUMMARY << 'EOF'
          
          ## 📋 Change Management Approved
          
          | Field | Value |
          |-------|-------|
          | Change ID | CHG-${{ github.run_number }} |
          | Type | Standard Change |
          | Risk Level | Low |
          | Approved by | ${{ github.actor }} |
          
          ### 📝 Release Notes
          ${{ inputs.release_notes || 'No release notes provided' }}
          EOF

  # ═══════════════════════════════════════════════════════════
  # STAGE 4: DEPLOY TO PRODUCTION
  # ═══════════════════════════════════════════════════════════
  deploy-production:
    name: 🏭 Production
    needs: [build, change-management-gate]
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    
    steps:
      - name: Pre-deployment checklist
        run: |
          echo "📋 Pre-deployment checklist:"
          echo "   ✅ QA Approved"
          echo "   ✅ Change Management Approved"
          echo "   ✅ Rollback plan ready"
          echo "   ✅ Monitoring configured"
      
      - name: Deploy to Production
        run: |
          echo "🚀 Deploying v${{ needs.build.outputs.version }} to production"
          sleep 5
          echo "✅ Production deployment complete"
      
      - name: Smoke tests
        run: |
          echo "🔥 Running smoke tests..."
          sleep 3
          echo "✅ Smoke tests passed"
      
      - name: Final summary
        run: |
          cat >> $GITHUB_STEP_SUMMARY << 'EOF'
          
          ## 🎉 Production Deployment Complete!
          
          | Field | Value |
          |-------|-------|
          | Version | ${{ needs.build.outputs.version }} |
          | Environment | Production |
          | URL | https://app.example.com |
          | Status | ✅ Success |
          
          ### 📊 Deployment Timeline
          
          ```
          Build        → ✅ Complete
          Development  → ✅ Deployed
          Staging      → ✅ Deployed + Tested
          QA Gate      → ✅ Approved
          Change Mgmt  → ✅ Approved
          Production   → ✅ Deployed
          ```
          
          ### 🔗 Quick Links
          - [Production](https://app.example.com)
          - [Monitoring Dashboard](https://monitoring.example.com)
          - [Rollback Instructions](https://wiki.example.com/rollback)
          EOF

  # ═══════════════════════════════════════════════════════════
  # NOTIFICATION: ON COMPLETION
  # ═══════════════════════════════════════════════════════════
  notify:
    name: 📧 Notify
    needs: deploy-production
    runs-on: ubuntu-latest
    if: always()
    
    steps:
      - name: Send notification
        run: |
          if [ "${{ needs.deploy-production.result }}" == "success" ]; then
            echo "📧 Sending success notification..."
            echo "   ✅ Deployment successful!"
          else
            echo "📧 Sending failure notification..."
            echo "   ❌ Deployment failed or was cancelled"
          fi
```

### Parte 3: Probar el Workflow (10 min)

```bash
# EJERCICIO: Ejecutar y probar los gates de aprobación
# ¿QUÉ VAMOS A HACER?: Triggear el workflow y aprobar cada gate
# ¿POR QUÉ LO HACEMOS?: Verificar que las aprobaciones funcionan
# ¿PARA QUÉ SIRVE?: Entender el flujo completo de deployment formal

# Paso 1: Commit y push
git add .
git commit -m "feat: add approval pipeline workflow"
git push origin main

# Paso 2: Observar en Actions
# - Build y deploy-dev se ejecutan automáticamente
# - deploy-staging espera su wait timer (si configurado)
# - qa-gate muestra "Waiting for review"

# Paso 3: Aprobar QA Gate
# - Click en el workflow run
# - Click "Review pending deployments"
# - Seleccionar "qa-approval"
# - Agregar comentario: "QA testing complete, all tests passed"
# - Click "Approve and deploy"

# Paso 4: Aprobar Change Management Gate
# - Esperar a que qa-gate complete
# - change-management-gate mostrará "Waiting for review"
# - Aprobar de la misma manera

# Paso 5: Verificar Production Deploy
# - Después de ambas aprobaciones, production se despliega
# - Revisar el Job Summary para ver el timeline completo
```

---

## ✅ Verificación

### Checklist de Completado

- [ ] Environment `qa-approval` creado con reviewers
- [ ] Environment `change-management` creado con reviewers + wait timer
- [ ] Workflow ejecuta en secuencia correcta
- [ ] QA gate pausa y espera aprobación
- [ ] Change management gate pausa y espera aprobación
- [ ] Production solo deploya después de ambas aprobaciones
- [ ] Job Summary muestra timeline completo

### Timeline Esperado

```
[00:00] Build starts
[00:30] Build complete, deploy-dev starts
[01:00] deploy-dev complete, deploy-staging starts
[01:30] deploy-staging complete
[01:30] qa-gate: ⏸️ WAITING FOR REVIEW
        ↓ (QA approves)
[02:00] qa-gate complete
[02:00] change-management-gate: ⏸️ WAITING FOR REVIEW
        ↓ (Change manager approves)
[02:30] change-management-gate complete
[02:30] deploy-production starts
[03:00] ✅ DEPLOYMENT COMPLETE
```

---

## 🎯 Desafío Extra

1. Agrega un gate de "Security Review" entre QA y Change Management
2. Implementa `workflow_dispatch` input para skip de emergencia
3. Agrega notificación a Slack cuando se requiere aprobación
4. Crea un workflow separado para ver estado de todas las aprobaciones

---

## 📚 Recursos

- [GitHub Docs: Reviewing deployments](https://docs.github.com/en/actions/managing-workflow-runs/reviewing-deployments)
- [GitHub Docs: Job summaries](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#adding-a-job-summary)

---

**Siguiente ejercicio**: [04 - Rollback](../ejercicio-04-rollback/README.md)
