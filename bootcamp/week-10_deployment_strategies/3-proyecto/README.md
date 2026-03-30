# 🚀 Proyecto Semanal: Multi-Environment Deployment Pipeline

## 📋 Información del Proyecto

| Campo | Detalle |
|-------|---------|
| **Duración** | 2 horas |
| **Modalidad** | Individual |
| **Peso** | 25% de la evaluación semanal |
| **Entrega** | Repositorio GitHub con workflow funcional |

---

## 🎯 Objetivo

Construir un **pipeline de deployment completo** que implemente todas las estrategias y controles aprendidos esta semana:

- Múltiples environments (dev, staging, production)
- Protection rules configuradas
- Health checks y rollback automático
- Notificaciones y documentación

---

## 📝 Escenario

Tu empresa "TechCorp" necesita un sistema de deployment profesional para su nueva aplicación web. El equipo de DevOps (tú) debe implementar:

1. **Pipeline automatizado** desde push hasta producción
2. **Controles de calidad** en cada etapa
3. **Recuperación automática** ante fallos
4. **Documentación** para el equipo

---

## 🏗️ Requerimientos

### Parte 1: Configuración de Environments (30 min)

Crear **4 environments** en el repositorio:

| Environment | Propósito | Protection Rules |
|-------------|-----------|------------------|
| `development` | Testing inicial | Ninguna |
| `staging` | Pre-producción | Wait timer: 2 min |
| `qa-approval` | Gate de QA | 1 reviewer |
| `production` | Producción | 1 reviewer + solo `main` |

**Secrets por environment:**
- `API_KEY`: Diferente para cada env
- `DATABASE_URL`: Diferente para cada env

**Variables por environment:**
- `APP_ENV`: development/staging/production
- `LOG_LEVEL`: debug/info/warn

### Parte 2: Workflow Principal (45 min)

Crear `.github/workflows/deploy-pipeline.yml`:

```yaml
# Estructura requerida (implementar cada job):

name: TechCorp Deploy Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:
    inputs:
      skip_qa:
        description: 'Skip QA approval (emergencies)'
        type: boolean
        default: false

jobs:
  # Job 1: Build & Test
  build:
    # - Checkout código
    # - Setup Node.js 20
    # - npm ci && npm test
    # - Upload artifact

  # Job 2: Deploy Development
  deploy-dev:
    # - Needs: build
    # - Environment: development
    # - Deploy simulado
    # - Smoke test

  # Job 3: Deploy Staging
  deploy-staging:
    # - Needs: deploy-dev
    # - Environment: staging (tiene wait timer)
    # - Deploy simulado
    # - E2E tests
    # - Notificar QA

  # Job 4: QA Gate
  qa-gate:
    # - Needs: deploy-staging
    # - Environment: qa-approval
    # - Logging de aprobación
    # - Skip si input.skip_qa

  # Job 5: Deploy Production
  deploy-production:
    # - Needs: qa-gate
    # - Environment: production
    # - Health check con retries
    # - Output: status, version

  # Job 6: Auto-Rollback
  auto-rollback:
    # - Needs: deploy-production
    # - If: deploy-production failed
    # - Ejecutar rollback
    # - Verificar salud
    # - Crear issue

  # Job 7: Summary
  summary:
    # - Always run
    # - Crear GitHub Step Summary
    # - Mostrar timeline completo
```

### Parte 3: Workflow de Rollback Manual (20 min)

Crear `.github/workflows/manual-rollback.yml`:

```yaml
# Workflow que permita:
# - Input: version a deployar
# - Input: environment target
# - Input: razón del rollback
# - Ejecutar rollback
# - Verificar health
# - Crear registro
```

### Parte 4: Documentación (25 min)

Crear `docs/deployment-guide.md`:

```markdown
# Guía de Deployment - TechCorp

## Environments

[Tabla de environments y sus configuraciones]

## Pipeline Flow

[Diagrama del flujo]

## Cómo Hacer Rollback

### Automático
[Explicación]

### Manual
[Pasos]

## Troubleshooting

### El deployment falla en staging
[Solución]

### El health check falla
[Solución]

### No puedo aprobar el deployment
[Solución]
```

---

## 📁 Estructura del Proyecto

```
proyecto-deployment/
├── .github/
│   └── workflows/
│       ├── deploy-pipeline.yml      # Pipeline principal
│       └── manual-rollback.yml      # Rollback manual
├── docs/
│   └── deployment-guide.md          # Documentación
├── src/
│   └── app.js                       # App de ejemplo
├── scripts/
│   ├── deploy.sh                    # Script de deploy
│   ├── rollback.sh                  # Script de rollback
│   └── health-check.sh              # Health check
├── package.json
└── README.md                        # README del proyecto
```

---

## ✅ Criterios de Evaluación

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **Environments** | 15 | 4 environments configurados correctamente |
| **Pipeline** | 35 | Workflow completo con todos los jobs |
| **Protection Rules** | 15 | Reviewers, timer, branches configurados |
| **Rollback** | 20 | Auto-rollback + manual funcionando |
| **Documentación** | 15 | Guía clara y completa |
| **Total** | 100 | |

### Rúbrica Detallada

#### Environments (15 pts)
- 4 pts: Los 4 environments existen
- 4 pts: Secrets configurados por env
- 4 pts: Variables configuradas por env
- 3 pts: URLs de deployment configuradas

#### Pipeline (35 pts)
- 7 pts: Build job con tests y artifacts
- 7 pts: Deploy secuencial (dev → staging → prod)
- 7 pts: Health checks implementados
- 7 pts: Job Summary completo
- 7 pts: Notificaciones configuradas

#### Protection Rules (15 pts)
- 5 pts: Wait timer en staging
- 5 pts: Required reviewers en qa y prod
- 5 pts: Branch restriction en production

#### Rollback (20 pts)
- 10 pts: Auto-rollback funcional
- 5 pts: Manual rollback funcional
- 5 pts: Issue creado automáticamente

#### Documentación (15 pts)
- 5 pts: Descripción de environments
- 5 pts: Proceso de rollback documentado
- 5 pts: Troubleshooting incluido

---

## 📤 Entrega

1. **Repositorio público** en GitHub
2. **Workflow ejecutado** al menos una vez con éxito
3. **Screenshot** del pipeline completo
4. **Link al repositorio** en el formulario de entrega

---

## 💡 Tips

1. **Empieza simple**: Primero haz que el pipeline básico funcione
2. **Agrega complejidad gradualmente**: Protection rules, rollback, etc.
3. **Prueba cada cambio**: No acumules muchos cambios sin probar
4. **Usa Job Summary**: Facilita la revisión del resultado
5. **Documenta mientras construyes**: No lo dejes para el final

---

## 🎯 Desafío Extra (Bonus)

Para los que terminen antes, implementar:

1. **Canary deployment**: 10% tráfico inicial, luego 50%, luego 100%
2. **Slack notifications**: Notificar en cada stage
3. **Métricas**: Guardar tiempo de deployment por stage
4. **Matrix deployment**: Deployar a múltiples regiones

---

## 🔗 Recursos

- [GitHub Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments)
- [Protection Rules](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [Job Summaries](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#adding-a-job-summary)

---

**¡Buena suerte! 🚀**
- Preguntar en el foro o Discord del bootcamp

---

**💡 Tip:** Comienza temprano y no dudes en pedir ayuda si te atascas. El objetivo es aprender, no solo entregar.
