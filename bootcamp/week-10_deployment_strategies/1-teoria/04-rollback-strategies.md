# 🔄 Lección 04: Rollback Strategies

## 📋 Información de la Lección

| Campo | Detalle |
|-------|---------|
| **Duración** | 20 minutos |
| **Nivel** | Intermedio |
| **Prerrequisitos** | Lección 03 - Protection Rules |
| **Objetivos** | Implementar estrategias de rollback automático y manual |

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- [ ] Implementar health checks para detectar deployments fallidos
- [ ] Configurar rollback automático ante fallos
- [ ] Ejecutar rollback manual cuando sea necesario
- [ ] Mantener versiones para recuperación rápida

---

## 📚 Contenido

### 1. ¿Por Qué Necesitamos Rollback?

Incluso con las mejores prácticas, los deployments pueden fallar:

| Causa | Ejemplo |
|-------|---------|
| **Bugs no detectados** | Error en edge case no testeado |
| **Problemas de infraestructura** | Base de datos saturada |
| **Dependencias externas** | API de tercero caída |
| **Configuración incorrecta** | Variables mal configuradas |
| **Performance issues** | Memory leak bajo carga |

**El objetivo**: Detectar rápido y recuperar más rápido.

---

### 2. Flujo de Rollback Automático

![Rollback Flow](../0-assets/04-rollback-flow.svg)

#### Componentes del Flujo

```
Deploy → Health Check → ¿OK? → Sí → ✅ Continuar
                          │
                          └─ No → Rollback → Verificar → Alertar
```

---

### 3. Health Checks

#### ¿Qué es un Health Check?

Una verificación automática que determina si el deployment es **saludable**.

#### Tipos de Health Checks

| Tipo | Verifica | Ejemplo |
|------|----------|---------|
| **HTTP** | Endpoint responde | `GET /health → 200 OK` |
| **TCP** | Puerto abierto | Conectar a puerto 443 |
| **Command** | Comando exitoso | `./check-db.sh → exit 0` |
| **Metrics** | Métricas normales | Error rate < 1% |

#### Implementación de Health Check

```yaml
# ¿QUÉ HACE?: Verifica que la aplicación responde correctamente
# ¿POR QUÉ?: Detectar problemas inmediatamente después del deploy
# ¿PARA QUÉ SIRVE?: Decidir si hacer rollback automático

- name: Health check
  id: health
  run: |
    MAX_RETRIES=5
    RETRY_INTERVAL=10
    
    for i in $(seq 1 $MAX_RETRIES); do
      echo "Health check attempt $i/$MAX_RETRIES"
      
      RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
        https://app.example.com/health)
      
      if [ "$RESPONSE" = "200" ]; then
        echo "✅ Health check passed"
        echo "healthy=true" >> $GITHUB_OUTPUT
        exit 0
      fi
      
      echo "❌ Got status $RESPONSE, retrying in ${RETRY_INTERVAL}s..."
      sleep $RETRY_INTERVAL
    done
    
    echo "❌ Health check failed after $MAX_RETRIES attempts"
    echo "healthy=false" >> $GITHUB_OUTPUT
    exit 1
```

#### Health Check Avanzado con Métricas

```yaml
- name: Advanced health check
  run: |
    # Esperar que la aplicación se estabilice
    sleep 60
    
    # Obtener métricas de los últimos 5 minutos
    ERROR_RATE=$(curl -s "https://metrics.example.com/api/v1/query" \
      --data-urlencode 'query=rate(http_errors_total[5m])' \
      | jq '.data.result[0].value[1] | tonumber')
    
    LATENCY_P99=$(curl -s "https://metrics.example.com/api/v1/query" \
      --data-urlencode 'query=histogram_quantile(0.99, http_latency_bucket)' \
      | jq '.data.result[0].value[1] | tonumber')
    
    echo "Error rate: $ERROR_RATE"
    echo "P99 Latency: ${LATENCY_P99}ms"
    
    # Validar umbrales
    if (( $(echo "$ERROR_RATE > 0.01" | bc -l) )); then
      echo "❌ Error rate too high: $ERROR_RATE > 1%"
      exit 1
    fi
    
    if (( $(echo "$LATENCY_P99 > 500" | bc -l) )); then
      echo "❌ Latency too high: ${LATENCY_P99}ms > 500ms"
      exit 1
    fi
    
    echo "✅ All metrics within thresholds"
```

---

### 4. Rollback Automático

#### Método 1: Rollback en el Mismo Workflow

```yaml
# ¿QUÉ HACE?: Deploy con rollback automático si falla health check
# ¿POR QUÉ?: Minimizar tiempo de downtime ante problemas
# ¿PARA QUÉ SIRVE?: Recuperación automática sin intervención manual

name: Deploy with Auto-Rollback

on:
  push:
    branches: [main]

env:
  PREVIOUS_VERSION: ""

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    
    steps:
      - uses: actions/checkout@v4
      
      # ═══════════════════════════════════════════
      # PASO 1: Guardar versión actual (para rollback)
      # ═══════════════════════════════════════════
      - name: Get current version
        id: current
        run: |
          # Obtener la versión actualmente deployada
          CURRENT=$(curl -s https://app.example.com/version)
          echo "version=$CURRENT" >> $GITHUB_OUTPUT
          echo "📌 Current version: $CURRENT"
      
      # ═══════════════════════════════════════════
      # PASO 2: Deploy nueva versión
      # ═══════════════════════════════════════════
      - name: Deploy new version
        run: |
          echo "🚀 Deploying version ${{ github.sha }}"
          ./deploy.sh --version ${{ github.sha }}
      
      # ═══════════════════════════════════════════
      # PASO 3: Health check
      # ═══════════════════════════════════════════
      - name: Health check
        id: health
        continue-on-error: true    # ← No falla el job, permite rollback
        run: |
          sleep 30  # Esperar que la app arranque
          
          for i in {1..5}; do
            if curl -sf https://app.example.com/health; then
              echo "healthy=true" >> $GITHUB_OUTPUT
              exit 0
            fi
            sleep 10
          done
          
          echo "healthy=false" >> $GITHUB_OUTPUT
          exit 1
      
      # ═══════════════════════════════════════════
      # PASO 4: Rollback si health check falló
      # ═══════════════════════════════════════════
      - name: Rollback on failure
        if: steps.health.outputs.healthy == 'false'
        run: |
          echo "⚠️ Health check failed, rolling back..."
          echo "🔄 Restoring version ${{ steps.current.outputs.version }}"
          
          ./deploy.sh --version ${{ steps.current.outputs.version }}
          
          echo "✅ Rollback complete"
      
      # ═══════════════════════════════════════════
      # PASO 5: Verificar estado final
      # ═══════════════════════════════════════════
      - name: Verify final state
        run: |
          DEPLOYED=$(curl -s https://app.example.com/version)
          echo "📌 Currently deployed: $DEPLOYED"
          
          if [ "${{ steps.health.outputs.healthy }}" == "false" ]; then
            echo "::error::Deployment failed, rolled back to $DEPLOYED"
            exit 1
          fi
          
          echo "✅ Deployment successful"
      
      # ═══════════════════════════════════════════
      # PASO 6: Notificar resultado
      # ═══════════════════════════════════════════
      - name: Notify on failure
        if: failure()
        run: |
          # Enviar alerta a Slack/Teams/PagerDuty
          echo "🚨 Deployment failed and was rolled back"
```

---

### 5. Métodos de Rollback

#### Método 1: Re-run Previous Workflow

**Cuándo usar**: Rollback rápido sin cambios de código

```
1. Actions → All workflows
2. Encontrar el último deploy exitoso
3. Click → "Re-run all jobs"
4. El deploy anterior se ejecuta de nuevo
```

#### Método 2: Git Revert

**Cuándo usar**: Quieres registrar el rollback en el historial

```bash
# ¿QUÉ HACE?: Crea un commit que revierte los cambios
# ¿POR QUÉ?: Mantiene historial limpio de lo que pasó
# ¿PARA QUÉ SIRVE?: El push triggerea un nuevo deploy

# Revertir el último commit
git revert HEAD --no-edit

# Push triggerea el workflow de deploy
git push origin main
```

```yaml
# Workflow que se triggerea con el revert
name: Deploy on Push

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      # El código ahora es la versión anterior
      - run: ./deploy.sh
```

#### Método 3: workflow_dispatch Manual

**Cuándo usar**: Control total sobre qué versión deployar

```yaml
# ¿QUÉ HACE?: Permite deployar cualquier versión manualmente
# ¿POR QUÉ?: Máximo control para casos de emergencia
# ¿PARA QUÉ SIRVE?: Rollback a cualquier versión específica

name: Manual Deploy/Rollback

on:
  workflow_dispatch:
    inputs:
      version:
        description: 'Version to deploy (commit SHA or tag)'
        required: true
        type: string
      environment:
        description: 'Target environment'
        required: true
        type: choice
        options:
          - staging
          - production

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ inputs.environment }}
    
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ inputs.version }}    # ← Checkout versión específica
      
      - name: Deploy specified version
        run: |
          echo "🚀 Deploying version: ${{ inputs.version }}"
          echo "🎯 Target: ${{ inputs.environment }}"
          ./deploy.sh --version ${{ inputs.version }}
```

**Uso desde UI:**
1. Actions → Manual Deploy/Rollback
2. Click "Run workflow"
3. Ingresar version: `abc1234` (SHA del commit bueno)
4. Seleccionar environment: `production`
5. Click "Run workflow"

---

### 6. Versionado para Rollback

#### Estrategia: Tags Semánticos

```bash
# Crear tag para release
git tag -a v1.2.3 -m "Release 1.2.3"
git push origin v1.2.3

# Rollback a versión específica
# En workflow_dispatch, usar: v1.2.2
```

#### Estrategia: Commit SHA

```yaml
# Guardar SHA de deploys exitosos
- name: Record successful deploy
  if: success()
  run: |
    echo "${{ github.sha }}" >> deployed_versions.txt
    # Guardar en artifact o external storage
```

#### Estrategia: Docker Tags

```yaml
# Cada deploy crea una imagen con tag único
- name: Build and push
  run: |
    docker build -t myapp:${{ github.sha }} .
    docker push myapp:${{ github.sha }}
    
    # También tagear como latest si es exitoso
    docker tag myapp:${{ github.sha }} myapp:latest
    docker push myapp:latest

# Rollback: cambiar la imagen en el deployment
- name: Rollback
  run: |
    kubectl set image deployment/myapp \
      myapp=myapp:${{ inputs.version }}
```

---

### 7. Monitoreo Post-Deploy

```yaml
# ¿QUÉ HACE?: Monitorea la aplicación después del deploy
# ¿POR QUÉ?: Detectar problemas que aparecen con el tiempo
# ¿PARA QUÉ SIRVE?: Trigger de rollback si las métricas degradan

- name: Post-deploy monitoring
  run: |
    echo "📊 Starting 10-minute monitoring window"
    
    for minute in {1..10}; do
      echo "Minute $minute/10"
      
      # Verificar métricas cada minuto
      ERROR_RATE=$(./get-error-rate.sh)
      
      if (( $(echo "$ERROR_RATE > 0.05" | bc -l) )); then
        echo "❌ Error rate exceeded 5%: $ERROR_RATE"
        echo "🔄 Initiating rollback..."
        ./rollback.sh --to-previous
        exit 1
      fi
      
      sleep 60
    done
    
    echo "✅ Monitoring complete, deployment stable"
```

---

### 8. Comparativa de Métodos de Rollback

| Método | Velocidad | Historial | Automatizable | Uso |
|--------|-----------|-----------|---------------|-----|
| **Re-run workflow** | ⚡ Rápido | ❌ No modifica | ✅ Parcial | Emergencias |
| **Git revert** | 🚀 Medio | ✅ Limpio | ✅ Sí | Estándar |
| **workflow_dispatch** | 🎯 Control | ❌ No modifica | ✅ Sí | Planificado |
| **Auto-rollback** | ⚡ Instantáneo | ❌ No modifica | ✅ Total | Ideal |

---

### 9. Workflow Completo con Rollback

```yaml
name: Production Deploy with Rollback

on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      rollback_to:
        description: 'Version to rollback to (leave empty for normal deploy)'
        required: false
        type: string

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    outputs:
      deployed_version: ${{ steps.deploy.outputs.version }}
      previous_version: ${{ steps.current.outputs.version }}
    
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ inputs.rollback_to || github.sha }}
      
      - name: Get current production version
        id: current
        run: |
          VERSION=$(curl -s https://app.example.com/version || echo "unknown")
          echo "version=$VERSION" >> $GITHUB_OUTPUT
      
      - name: Deploy
        id: deploy
        run: |
          VERSION="${{ inputs.rollback_to || github.sha }}"
          echo "Deploying: $VERSION"
          ./deploy.sh --version "$VERSION"
          echo "version=$VERSION" >> $GITHUB_OUTPUT
      
      - name: Health check with retry
        id: health
        run: |
          for i in {1..10}; do
            if curl -sf https://app.example.com/health; then
              echo "status=healthy" >> $GITHUB_OUTPUT
              exit 0
            fi
            echo "Attempt $i failed, waiting..."
            sleep 15
          done
          echo "status=unhealthy" >> $GITHUB_OUTPUT
          exit 1
      
      - name: Auto-rollback on failure
        if: failure() && steps.health.outputs.status == 'unhealthy'
        run: |
          echo "🔄 Auto-rollback to ${{ steps.current.outputs.version }}"
          ./deploy.sh --version "${{ steps.current.outputs.version }}"
      
      - name: Final verification
        run: |
          curl -sf https://app.example.com/health
          echo "✅ Deployment verified"

  notify:
    needs: deploy
    if: always()
    runs-on: ubuntu-latest
    steps:
      - name: Notify result
        run: |
          if [ "${{ needs.deploy.result }}" == "success" ]; then
            echo "✅ Deploy successful: ${{ needs.deploy.outputs.deployed_version }}"
          else
            echo "❌ Deploy failed, rolled back to: ${{ needs.deploy.outputs.previous_version }}"
          fi
```

---

## 💡 Tips y Mejores Prácticas

### Health Checks
- Timeout razonable (30s) pero con retries (5x)
- Verificar más que solo HTTP 200 (métricas, dependencias)
- Health endpoint debe ser rápido y sin side effects

### Rollback
- Siempre tener al menos la versión anterior disponible
- Probar el proceso de rollback regularmente
- Documentar qué versiones son "safe" para rollback

### Monitoreo
- Alertas automáticas si error rate > umbral
- Dashboard visible durante deployments
- Logs accesibles para debugging rápido

---

## 🔗 Recursos Adicionales

- [GitHub Actions: Handling failures](https://docs.github.com/en/actions/learn-github-actions/expressions#failure)
- [Kubernetes: Rolling back a deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-a-deployment)
- [Feature Flags for Safe Rollouts](https://martinfowler.com/articles/feature-toggles.html)

---

## ✅ Checklist de Comprensión

Antes de continuar, asegúrate de poder responder:

- [ ] ¿Cuál es la diferencia entre re-run workflow y git revert?
- [ ] ¿Cómo implementarías un health check que verifique métricas?
- [ ] ¿Qué información necesitas guardar para hacer rollback?
- [ ] ¿Cuándo usarías rollback automático vs manual?

---

**Siguiente**: [Ejercicios Prácticos](../2-practicas/README.md)
