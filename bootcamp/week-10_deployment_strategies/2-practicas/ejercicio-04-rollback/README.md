# 🔄 Ejercicio 04: Rollback Automático

## 📋 Información del Ejercicio

| Campo | Detalle |
|-------|---------|
| **Duración** | 40 minutos |
| **Dificultad** | Avanzada |
| **Prerrequisitos** | Ejercicio 03 - Approval Workflow |
| **Objetivos** | Implementar health checks y rollback automático |

---

## 🎯 Objetivos

Al completar este ejercicio, habrás:

- [ ] Implementado health checks post-deployment
- [ ] Configurado rollback automático ante fallos
- [ ] Creado workflow de rollback manual
- [ ] Implementado versionado para tracking de releases

---

## 📝 Escenario

Tu aplicación necesita recuperarse automáticamente si un deployment falla:
- Health check después de cada deploy
- Rollback automático si el health check falla
- Opción de rollback manual a cualquier versión anterior

---

## 🚀 Instrucciones

### Parte 1: Crear Aplicación de Prueba (5 min)

```bash
# EJERCICIO: Crear app que puede simular fallos
# ¿QUÉ VAMOS A HACER?: App con endpoint /health configurable
# ¿POR QUÉ LO HACEMOS?: Necesitamos simular deployments fallidos
# ¿PARA QUÉ SIRVE?: Probar el sistema de rollback

mkdir -p rollback-demo
cd rollback-demo
git init

# Crear archivo de versión
echo "1.0.0" > VERSION

# Crear script de health check simulado
cat > health-check.sh << 'EOF'
#!/bin/bash
# Simula health check
# Usa variable FORCE_FAIL para simular fallo

if [ "$FORCE_FAIL" = "true" ]; then
    echo "❌ Health check FAILED"
    exit 1
else
    echo "✅ Health check PASSED"
    exit 0
fi
EOF
chmod +x health-check.sh

# Crear script de deploy simulado
cat > deploy.sh << 'EOF'
#!/bin/bash
VERSION=$1
echo "🚀 Deploying version: $VERSION"
echo "$VERSION" > DEPLOYED_VERSION
sleep 2
echo "✅ Deploy complete"
EOF
chmod +x deploy.sh

# Crear script de rollback
cat > rollback.sh << 'EOF'
#!/bin/bash
TARGET_VERSION=$1
echo "🔄 Rolling back to version: $TARGET_VERSION"
echo "$TARGET_VERSION" > DEPLOYED_VERSION
sleep 2
echo "✅ Rollback complete"
EOF
chmod +x rollback.sh

mkdir -p .github/workflows
git add .
git commit -m "feat: initial rollback demo setup"
```

### Parte 2: Workflow con Auto-Rollback (15 min)

Crea `.github/workflows/deploy-with-rollback.yml`:

```yaml
# ¿QUÉ HACE?: Deploy con health check y rollback automático
# ¿POR QUÉ?: Recuperarse automáticamente de deployments fallidos
# ¿PARA QUÉ SIRVE?: Minimizar downtime y impacto de bugs

name: Deploy with Auto-Rollback

on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      force_fail:
        description: 'Force health check to fail (for testing)'
        type: boolean
        default: false
      version:
        description: 'Version to deploy (leave empty for auto)'
        type: string
        required: false

env:
  VERSIONS_FILE: deployed_versions.txt

jobs:
  # ═══════════════════════════════════════════════════════════
  # STAGE 1: BUILD
  # ═══════════════════════════════════════════════════════════
  build:
    name: 🔨 Build
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.value }}
      previous_version: ${{ steps.previous.outputs.value }}
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Get current version
        id: version
        run: |
          if [ -n "${{ inputs.version }}" ]; then
            VERSION="${{ inputs.version }}"
          else
            VERSION=$(cat VERSION)
            # Append run number for uniqueness
            VERSION="${VERSION}-build.${{ github.run_number }}"
          fi
          echo "value=$VERSION" >> $GITHUB_OUTPUT
          echo "📦 Version to deploy: $VERSION"
      
      - name: Get previous deployed version
        id: previous
        run: |
          # In real scenario, this would come from deployment tracking
          PREVIOUS="1.0.0-build.$((github.run_number - 1))"
          echo "value=$PREVIOUS" >> $GITHUB_OUTPUT
          echo "📌 Previous version: $PREVIOUS"
      
      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: deploy-scripts
          path: |
            deploy.sh
            rollback.sh
            health-check.sh
            VERSION

  # ═══════════════════════════════════════════════════════════
  # STAGE 2: DEPLOY TO STAGING
  # ═══════════════════════════════════════════════════════════
  deploy-staging:
    name: 🎭 Deploy Staging
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.example.com
    outputs:
      status: ${{ steps.health.outputs.status }}
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: deploy-scripts
      
      - name: Make scripts executable
        run: chmod +x *.sh
      
      - name: Deploy to staging
        run: |
          echo "════════════════════════════════════════"
          echo "🎭 STAGING DEPLOYMENT"
          echo "════════════════════════════════════════"
          ./deploy.sh "${{ needs.build.outputs.version }}"
      
      - name: Health check
        id: health
        run: |
          echo ""
          echo "🏥 Running health check..."
          
          # Simulate health check (use input to force fail for testing)
          if [ "${{ inputs.force_fail }}" = "true" ]; then
            export FORCE_FAIL=true
          fi
          
          if ./health-check.sh; then
            echo "status=healthy" >> $GITHUB_OUTPUT
          else
            echo "status=unhealthy" >> $GITHUB_OUTPUT
            echo "::warning::Health check failed on staging"
          fi
      
      - name: Staging summary
        run: |
          if [ "${{ steps.health.outputs.status }}" = "healthy" ]; then
            echo "✅ Staging deployment healthy"
          else
            echo "⚠️ Staging deployment unhealthy - will not proceed to production"
          fi

  # ═══════════════════════════════════════════════════════════
  # STAGE 3: DEPLOY TO PRODUCTION
  # ═══════════════════════════════════════════════════════════
  deploy-production:
    name: 🏭 Deploy Production
    needs: [build, deploy-staging]
    if: needs.deploy-staging.outputs.status == 'healthy'
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    outputs:
      status: ${{ steps.health.outputs.status }}
      deployed_version: ${{ needs.build.outputs.version }}
      previous_version: ${{ needs.build.outputs.previous_version }}
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: deploy-scripts
      
      - name: Make scripts executable
        run: chmod +x *.sh
      
      - name: Record pre-deploy state
        id: pre_deploy
        run: |
          echo "📌 Recording current state before deployment"
          echo "Previous version: ${{ needs.build.outputs.previous_version }}"
      
      - name: Deploy to production
        run: |
          echo "════════════════════════════════════════"
          echo "🏭 PRODUCTION DEPLOYMENT"
          echo "════════════════════════════════════════"
          ./deploy.sh "${{ needs.build.outputs.version }}"
      
      - name: Health check with retries
        id: health
        continue-on-error: true
        run: |
          echo ""
          echo "🏥 Running health checks with retries..."
          
          MAX_RETRIES=3
          RETRY_DELAY=5
          
          for i in $(seq 1 $MAX_RETRIES); do
            echo "Attempt $i of $MAX_RETRIES"
            
            # Use FORCE_FAIL only if explicitly set for testing
            if [ "${{ inputs.force_fail }}" = "true" ]; then
              export FORCE_FAIL=true
            fi
            
            if ./health-check.sh; then
              echo "status=healthy" >> $GITHUB_OUTPUT
              echo "✅ Health check passed on attempt $i"
              exit 0
            fi
            
            if [ $i -lt $MAX_RETRIES ]; then
              echo "⏳ Retrying in ${RETRY_DELAY}s..."
              sleep $RETRY_DELAY
            fi
          done
          
          echo "status=unhealthy" >> $GITHUB_OUTPUT
          echo "❌ Health check failed after $MAX_RETRIES attempts"
          exit 1
      
      - name: Production summary
        if: steps.health.outputs.status == 'healthy'
        run: |
          echo "✅ Production deployment successful"
          echo "📌 Version: ${{ needs.build.outputs.version }}"
          
          cat >> $GITHUB_STEP_SUMMARY << EOF
          ## 🎉 Production Deployment Successful
          
          | Field | Value |
          |-------|-------|
          | Version | ${{ needs.build.outputs.version }} |
          | Previous | ${{ needs.build.outputs.previous_version }} |
          | Health | ✅ Healthy |
          EOF

  # ═══════════════════════════════════════════════════════════
  # STAGE 4: AUTO-ROLLBACK (if health check failed)
  # ═══════════════════════════════════════════════════════════
  auto-rollback:
    name: 🔄 Auto-Rollback
    needs: [build, deploy-production]
    if: always() && needs.deploy-production.outputs.status == 'unhealthy'
    runs-on: ubuntu-latest
    environment: production
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: deploy-scripts
      
      - name: Make scripts executable
        run: chmod +x *.sh
      
      - name: Execute rollback
        run: |
          echo "════════════════════════════════════════"
          echo "🔄 AUTO-ROLLBACK INITIATED"
          echo "════════════════════════════════════════"
          echo ""
          echo "❌ Deployment of ${{ needs.build.outputs.version }} failed health check"
          echo "🔄 Rolling back to ${{ needs.build.outputs.previous_version }}"
          echo ""
          
          ./rollback.sh "${{ needs.build.outputs.previous_version }}"
      
      - name: Verify rollback
        run: |
          echo ""
          echo "🏥 Verifying rollback..."
          
          # Unset FORCE_FAIL for rollback verification
          unset FORCE_FAIL
          
          if ./health-check.sh; then
            echo "✅ Rollback successful, system healthy"
          else
            echo "❌ CRITICAL: Rollback also failed!"
            exit 1
          fi
      
      - name: Rollback summary
        run: |
          cat >> $GITHUB_STEP_SUMMARY << EOF
          ## ⚠️ Auto-Rollback Executed
          
          | Field | Value |
          |-------|-------|
          | Failed Version | ${{ needs.build.outputs.version }} |
          | Rolled Back To | ${{ needs.build.outputs.previous_version }} |
          | Status | ✅ Rollback Successful |
          
          ### 📋 Action Required
          
          1. Investigate why v${{ needs.build.outputs.version }} failed
          2. Check logs for error details
          3. Fix the issue before re-deploying
          
          ### 🔗 Useful Links
          - [Failed Deployment Logs](#)
          - [Rollback Procedure](https://wiki.example.com/rollback)
          EOF
      
      - name: Create issue for failed deployment
        uses: actions/github-script@v7
        with:
          script: |
            await github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: `🔴 Deployment Failed: v${{ needs.build.outputs.version }}`,
              body: `## Deployment Failure Report
              
              | Field | Value |
              |-------|-------|
              | Version | ${{ needs.build.outputs.version }} |
              | Workflow Run | [#${{ github.run_number }}](${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}) |
              | Triggered by | @${{ github.actor }} |
              | Time | ${new Date().toISOString()} |
              
              ### Status
              - ❌ Health check failed
              - ✅ Auto-rollback to v${{ needs.build.outputs.previous_version }} successful
              
              ### Required Actions
              - [ ] Investigate root cause
              - [ ] Fix the issue
              - [ ] Re-run deployment
              
              /cc @${{ github.actor }}`,
              labels: ['deployment-failure', 'needs-investigation']
            });

  # ═══════════════════════════════════════════════════════════
  # FINAL STATUS
  # ═══════════════════════════════════════════════════════════
  final-status:
    name: 📊 Final Status
    needs: [deploy-staging, deploy-production, auto-rollback]
    if: always()
    runs-on: ubuntu-latest
    
    steps:
      - name: Determine final status
        run: |
          echo "════════════════════════════════════════"
          echo "📊 DEPLOYMENT FINAL STATUS"
          echo "════════════════════════════════════════"
          echo ""
          
          if [ "${{ needs.deploy-production.result }}" = "success" ]; then
            echo "✅ DEPLOYMENT SUCCESSFUL"
            echo "Status: Production is running the new version"
          elif [ "${{ needs.auto-rollback.result }}" = "success" ]; then
            echo "⚠️ DEPLOYMENT FAILED - ROLLBACK SUCCESSFUL"
            echo "Status: Production rolled back to previous version"
          elif [ "${{ needs.deploy-staging.outputs.status }}" = "unhealthy" ]; then
            echo "❌ STAGING FAILED - PRODUCTION NOT ATTEMPTED"
            echo "Status: Fix staging issues before retrying"
          else
            echo "❌ DEPLOYMENT FAILED"
            echo "Status: Check logs for details"
          fi
```

### Parte 3: Workflow de Rollback Manual (10 min)

Crea `.github/workflows/manual-rollback.yml`:

```yaml
# ¿QUÉ HACE?: Permite rollback manual a cualquier versión
# ¿POR QUÉ?: A veces necesitas rollback sin re-deploy
# ¿PARA QUÉ SIRVE?: Control manual para emergencias

name: Manual Rollback

on:
  workflow_dispatch:
    inputs:
      target_version:
        description: 'Version to rollback to'
        required: true
        type: string
      environment:
        description: 'Environment to rollback'
        required: true
        type: choice
        options:
          - staging
          - production
      reason:
        description: 'Reason for rollback'
        required: true
        type: string

jobs:
  rollback:
    name: 🔄 Manual Rollback
    runs-on: ubuntu-latest
    environment: ${{ inputs.environment }}
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Validate inputs
        run: |
          echo "════════════════════════════════════════"
          echo "🔄 MANUAL ROLLBACK REQUEST"
          echo "════════════════════════════════════════"
          echo ""
          echo "📌 Target version: ${{ inputs.target_version }}"
          echo "🎯 Environment: ${{ inputs.environment }}"
          echo "📝 Reason: ${{ inputs.reason }}"
          echo "👤 Requested by: ${{ github.actor }}"
          echo ""
      
      - name: Confirm rollback
        run: |
          echo "⚠️ ROLLBACK CONFIRMATION"
          echo "This will rollback ${{ inputs.environment }} to version ${{ inputs.target_version }}"
          echo ""
          echo "Proceeding with rollback..."
      
      - name: Execute rollback
        run: |
          echo "🔄 Executing rollback..."
          chmod +x rollback.sh
          ./rollback.sh "${{ inputs.target_version }}"
      
      - name: Verify rollback
        run: |
          echo "🏥 Verifying rollback health..."
          chmod +x health-check.sh
          ./health-check.sh
      
      - name: Rollback summary
        run: |
          cat >> $GITHUB_STEP_SUMMARY << EOF
          ## 🔄 Manual Rollback Complete
          
          | Field | Value |
          |-------|-------|
          | Environment | ${{ inputs.environment }} |
          | Target Version | ${{ inputs.target_version }} |
          | Requested by | ${{ github.actor }} |
          | Reason | ${{ inputs.reason }} |
          | Status | ✅ Successful |
          | Time | $(date -u) |
          
          ### 📋 Next Steps
          
          1. Verify the application is working correctly
          2. Investigate the original issue
          3. Create a fix and re-deploy when ready
          EOF
```

### Parte 4: Probar Rollback Automático (10 min)

```bash
# EJERCICIO: Probar el sistema de rollback
# ¿QUÉ VAMOS A HACER?: Simular un deployment fallido
# ¿POR QUÉ LO HACEMOS?: Verificar que el rollback funciona
# ¿PARA QUÉ SIRVE?: Confianza en el sistema de recuperación

# Paso 1: Push inicial (deployment exitoso)
git add .
git commit -m "feat: add rollback workflow"
git push origin main

# Observar: El deployment debe ser exitoso

# Paso 2: Trigger con fallo simulado
# - Ve a Actions → "Deploy with Auto-Rollback"
# - Click "Run workflow"
# - ✅ Marca "Force health check to fail"
# - Click "Run workflow"

# Observar:
# 1. Build y deploy-staging ejecutan
# 2. deploy-production ejecuta pero health check falla
# 3. auto-rollback se ejecuta automáticamente
# 4. Se crea un Issue reportando el fallo

# Paso 3: Probar rollback manual
# - Ve a Actions → "Manual Rollback"
# - Click "Run workflow"
# - Ingresar:
#   - Version: "1.0.0"
#   - Environment: "production"
#   - Reason: "Testing manual rollback"
# - Click "Run workflow"
```

---

## ✅ Verificación

### Checklist de Completado

- [ ] Workflow de deploy con auto-rollback funciona
- [ ] Health check detecta fallos correctamente
- [ ] Rollback se ejecuta automáticamente ante fallos
- [ ] Rollback verifica salud después de ejecutarse
- [ ] Issue se crea automáticamente al fallar
- [ ] Workflow de rollback manual funciona
- [ ] Job Summary muestra información completa

### Flujo Esperado (Fallo)

```
[Build]           ✅ Complete
     ↓
[Deploy Staging]  ✅ Healthy
     ↓
[Deploy Prod]     ❌ Health check failed (3 retries)
     ↓
[Auto-Rollback]   ✅ Rolled back to previous version
     ↓
[Issue Created]   📝 Deployment failure tracked
```

---

## 🎯 Desafío Extra

1. Implementa rollback basado en métricas (error rate > 5%)
2. Agrega soporte para rollback de múltiples servicios
3. Crea un dashboard de historial de deployments
4. Implementa notificaciones a Slack/Teams en rollback

---

## 📚 Recursos

- [GitHub Actions: continue-on-error](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepscontinue-on-error)
- [GitHub Actions: Job outputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idoutputs)
- [GitHub Script Action](https://github.com/actions/github-script)

---

**Siguiente**: [Proyecto Semanal](../../3-proyecto/README.md)
