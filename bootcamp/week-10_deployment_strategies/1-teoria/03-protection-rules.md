# 🛡️ Lección 03: Protection Rules

## 📋 Información de la Lección

| Campo | Detalle |
|-------|---------|
| **Duración** | 25 minutos |
| **Nivel** | Intermedio |
| **Prerrequisitos** | Lección 02 - GitHub Environments |
| **Objetivos** | Configurar reglas de protección para deployments seguros |

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- [ ] Configurar required reviewers para environments
- [ ] Implementar wait timers antes de deployments
- [ ] Restringir branches que pueden deployar
- [ ] Combinar múltiples protection rules

---

## 📚 Contenido

### 1. ¿Qué son las Protection Rules?

Las **protection rules** son controles de seguridad que se aplican **antes** de que un job pueda ejecutarse en un environment.

![Protection Rules](../0-assets/03-protection-rules.svg)

#### Tipos de Protection Rules

| Regla | Descripción |
|-------|-------------|
| **Required reviewers** | Aprobación manual antes del deploy |
| **Wait timer** | Delay obligatorio antes del deploy |
| **Deployment branches** | Restringir qué branches pueden deployar |
| **Custom rules** | Integraciones con GitHub Apps |

---

### 2. Required Reviewers

#### ¿Qué es?

Requiere que una o más personas **aprueben manualmente** el deployment antes de que se ejecute.

#### Configuración

1. **Settings** → **Environments** → [environment]
2. ✅ **Required reviewers**
3. Agregar hasta **6 usuarios o equipos**
4. Guardar

#### Opciones de Aprobación

| Opción | Comportamiento |
|--------|---------------|
| **Cualquiera** (default) | Un solo reviewer puede aprobar |
| **Todos** | Todos los reviewers deben aprobar |

#### Ejemplo en Workflow

```yaml
# ¿QUÉ HACE?: Deploy a production con aprobación requerida
# ¿POR QUÉ?: Producción necesita revisión humana antes del deploy
# ¿PARA QUÉ SIRVE?: Evitar deployments accidentales o no autorizados

name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production    # ← Tiene required reviewers configurado
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy
        run: ./deploy.sh --env production
```

#### Flujo de Aprobación

```
1. Workflow se triggerea
2. Job llega al environment "production"
3. ⏸️ PAUSA - "Waiting for review"
4. Reviewer recibe notificación
5. Reviewer va a Actions → Workflow run
6. Click en "Review deployments"
7. Aprobar o Rechazar
8. Si aprobado → Job continúa
   Si rechazado → Job falla
```

#### UI de Aprobación

Cuando un deployment requiere aprobación:

```
┌─────────────────────────────────────────────────────────┐
│  🟡 deploy                                              │
│     Waiting for review                                  │
│     Environment: production                             │
│                                                         │
│     [Review pending deployments]                        │
│                                                         │
│     Reviewers: @alice, @bob                             │
│     Requested: 2 minutes ago                            │
└─────────────────────────────────────────────────────────┘
```

---

### 3. Wait Timer

#### ¿Qué es?

Un **delay obligatorio** entre que el job está listo y cuando realmente se ejecuta.

#### Casos de Uso

| Caso | Tiempo Sugerido |
|------|-----------------|
| Staging QA | 5-15 minutos |
| Pre-producción | 30-60 minutos |
| Cambios críticos | 24 horas |
| Compliance | Según política |

#### Configuración

1. **Settings** → **Environments** → [environment]
2. ✅ **Wait timer**
3. Ingresar minutos (0 - 43,200 = 30 días)
4. Guardar

#### Ejemplo con Wait Timer

```yaml
# ¿QUÉ HACE?: Deploy a staging con delay de 5 minutos
# ¿POR QUÉ?: Tiempo para detectar problemas en dev antes de staging
# ¿PARA QUÉ SIRVE?: Ventana de cancelación si algo sale mal

name: Staged Deploy

on:
  push:
    branches: [main]

jobs:
  deploy-dev:
    runs-on: ubuntu-latest
    environment: development
    steps:
      - name: Deploy to dev
        run: ./deploy.sh --env dev

  deploy-staging:
    needs: deploy-dev
    runs-on: ubuntu-latest
    environment: staging    # ← Tiene wait timer de 5 min
    
    steps:
      # Este job esperará 5 minutos antes de ejecutarse
      - name: Deploy to staging
        run: ./deploy.sh --env staging
```

#### Comportamiento del Wait Timer

```
Tiempo    Estado
────────────────────────────────────
T+0       Job entra en queue
T+0       ⏳ "Waiting" - Timer inicia
T+1min    ⏳ "Waiting" - 4 min restantes
T+5min    ▶️ Job comienza a ejecutarse
```

#### Cancelar Durante el Wait

Durante el wait timer, cualquiera con permisos puede:

- **Cancelar el workflow**: El job nunca se ejecutará
- **Aprobar temprano**: Si también hay reviewers, aprobar no salta el timer

---

### 4. Deployment Branches

#### ¿Qué es?

Restringe **qué branches** pueden deployar a un environment específico.

#### Opciones

| Opción | Descripción |
|--------|-------------|
| **All branches** | Cualquier branch puede deployar |
| **Protected branches** | Solo branches con protection rules |
| **Selected branches** | Lista específica o patterns |

#### Configuración de Patterns

```
# Ejemplos de patterns válidos:

main                    # Solo main
release/*               # release/v1.0, release/v2.0
feature/*               # Cualquier feature branch
v*                      # v1.0, v2.0-beta
main, release/*         # main O cualquier release
```

#### Ejemplo: Solo Main a Production

```yaml
# Este workflow SOLO deployará a production si viene de main
# Si se ejecuta desde otra branch, el job fallará

name: Production Deploy

on:
  push:
    branches: [main, develop]  # Se triggerea en ambas

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production    # ← Solo permite main
    
    steps:
      - name: Deploy
        run: ./deploy.sh
```

Si el push viene de `develop`:

```
❌ Error: Deployment to production is not allowed from branch 'develop'.
   Only deployments from 'main' are allowed.
```

#### Matriz de Branches por Environment

| Environment | Branches Permitidos |
|-------------|---------------------|
| `development` | All branches |
| `staging` | `main`, `release/*` |
| `production` | `main` only |

---

### 5. Combinando Protection Rules

Puedes combinar múltiples rules en un mismo environment:

#### Ejemplo: Production Completo

**Configuración del environment `production`:**

- ✅ Required reviewers: `@security-team`, `@tech-lead`
- ✅ Wait timer: 30 minutes
- ✅ Deployment branches: `main` only

**Flujo resultante:**

```
1. Push a main triggerea workflow
2. Job llega a "production" environment
3. ⏳ Wait timer inicia (30 min)
4. Mientras espera, reviewers son notificados
5. Reviewer aprueba
6. Sigue esperando hasta completar 30 min
7. Timer completo + Aprobado → Job ejecuta
```

#### Workflow Completo

```yaml
# ¿QUÉ HACE?: Pipeline de deployment con todas las protection rules
# ¿POR QUÉ?: Máxima seguridad para deployments a producción
# ¿PARA QUÉ SIRVE?: Cumplir políticas de cambio y auditoría

name: Secure Deploy Pipeline

on:
  push:
    branches: [main]

jobs:
  # ═══════════════════════════════════════════
  # STAGE 1: BUILD & TEST
  # ═══════════════════════════════════════════
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run build
      - run: npm test
      
      - uses: actions/upload-artifact@v4
        with:
          name: build
          path: dist/

  # ═══════════════════════════════════════════
  # STAGE 2: DEVELOPMENT (sin protection rules)
  # ═══════════════════════════════════════════
  deploy-dev:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: development
      url: https://dev.example.com
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: build
      - run: ./deploy.sh --env development

  # ═══════════════════════════════════════════
  # STAGE 3: STAGING (wait timer: 5 min)
  # ═══════════════════════════════════════════
  deploy-staging:
    needs: deploy-dev
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.example.com
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: build
      - run: ./deploy.sh --env staging
      - run: npm run test:e2e

  # ═══════════════════════════════════════════
  # STAGE 4: PRODUCTION (reviewers + wait + branch)
  # ═══════════════════════════════════════════
  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: build
      
      - name: Deploy to production
        run: ./deploy.sh --env production
      
      - name: Smoke tests
        run: ./smoke-test.sh --url https://app.example.com
      
      - name: Notify success
        run: |
          echo "✅ Production deployment successful"
          # Enviar notificación a Slack/Teams
```

---

### 6. Prevent Self-Approval

Por defecto, quien triggerea el workflow **puede aprobar su propio deployment**.

#### Deshabilitar Self-Approval (Enterprise)

En GitHub Enterprise, puedes configurar:

```
Settings → Environments → production
☑️ Prevent users from approving their own deployments
```

#### Workaround para GitHub Free/Pro

Usar CODEOWNERS + Branch Protection:

```
# .github/CODEOWNERS
/.github/workflows/deploy*.yml @security-team
```

---

### 7. Custom Deployment Protection Rules

> ⚠️ Disponible en GitHub Enterprise Cloud

Permite integrar GitHub Apps como gates de deployment:

#### Casos de Uso

| Integración | Validación |
|-------------|------------|
| Security scanner | Verificar vulnerabilidades |
| Change management | Ticket aprobado en ServiceNow |
| Compliance | Aprobación en sistema externo |
| Feature flags | Verificar flags activos |

#### Ejemplo Conceptual

```yaml
# La GitHub App "security-gate" debe aprobar antes del deploy
# Esta validación es adicional a required reviewers

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production  # ← Custom rule: security-gate
    steps:
      - run: ./deploy.sh
```

---

### 8. Tabla de Configuración Recomendada

| Environment | Reviewers | Wait Timer | Branches |
|-------------|-----------|------------|----------|
| `development` | ❌ No | ❌ No | All |
| `staging` | ❌ No | ✅ 5 min | main, release/* |
| `production` | ✅ 2 personas | ✅ 30 min | main only |

---

## 💡 Tips y Mejores Prácticas

### Reviewers

- Incluir al menos 2 reviewers para redundancia
- Usar teams en lugar de individuos cuando sea posible
- Tener reviewers de diferentes zonas horarias

### Wait Timers

- Usar timers más largos para cambios de alto riesgo
- El timer da tiempo para detectar problemas en stages anteriores
- Considerar horarios de trabajo del equipo

### Deployment Branches

- Production: solo `main`
- Staging: `main` + `release/*`
- Development: sin restricciones

---

## 🔗 Recursos Adicionales

- [GitHub Docs: Required reviewers](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#required-reviewers)
- [GitHub Docs: Wait timer](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#wait-timer)
- [GitHub Docs: Deployment branches](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#deployment-branches)

---

## ✅ Checklist de Comprensión

Antes de continuar, asegúrate de poder responder:

- [ ] ¿Qué pasa si un reviewer rechaza un deployment?
- [ ] ¿El wait timer y los reviewers se ejecutan en paralelo o secuencialmente?
- [ ] ¿Cómo restringir deployments solo desde tags?
- [ ] ¿Qué configuración usarías para un environment de QA?

---

**Siguiente lección**: [04 - Rollback Strategies](04-rollback-strategies.md)
