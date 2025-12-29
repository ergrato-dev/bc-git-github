# 📊 Rúbrica de Evaluación - Semana 10

## Deployment Strategies

> **Puntuación Total**: 100 puntos  
> **Aprobación mínima**: 70 puntos

---

## 📋 Distribución de Puntos

| Categoría | Puntos | Porcentaje |
|-----------|--------|------------|
| Fundamentos de Deployment | 15 | 15% |
| GitHub Environments | 20 | 20% |
| Protection Rules | 15 | 15% |
| Approval Workflows | 15 | 15% |
| Rollback Strategies | 10 | 10% |
| Proyecto Semanal | 25 | 25% |
| **Total** | **100** | **100%** |

---

## 1️⃣ Fundamentos de Deployment (15 pts)

### Conceptos Teóricos (8 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Blue-Green Deployment | 3 | Comprende el patrón y cuándo usarlo |
| Canary Deployment | 3 | Entiende rollout progresivo y métricas |
| Rolling Deployment | 2 | Conoce actualizaciones incrementales |

### Comparación de Estrategias (7 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Ventajas/Desventajas | 4 | Identifica pros y contras de cada estrategia |
| Caso de Uso | 3 | Selecciona estrategia apropiada según escenario |

---

## 2️⃣ GitHub Environments (20 pts)

### Configuración Básica (10 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Crear environments | 4 | Dev, staging, production configurados |
| Environment secrets | 3 | Secrets por environment correctos |
| Environment variables | 3 | Variables de configuración por entorno |

### Uso en Workflows (10 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Keyword `environment` | 4 | Usa `environment.name` y `environment.url` |
| Environment URL | 3 | Configura URL de deployment |
| Deployment status | 3 | Estado visible en GitHub UI |

---

## 3️⃣ Protection Rules (15 pts)

### Required Reviewers (8 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Configurar reviewers | 4 | Asigna aprobadores requeridos |
| Número de approvals | 2 | Define cantidad mínima de aprobaciones |
| Prevent self-review | 2 | Evita auto-aprobación |

### Otras Reglas (7 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Wait timer | 3 | Configura delay antes del deploy |
| Branch restrictions | 2 | Limita desde qué branches se puede deploy |
| Custom rules | 2 | Implementa reglas adicionales |

---

## 4️⃣ Approval Workflows (15 pts)

### Flujo de Aprobación (10 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Workflow pending | 4 | Job espera aprobación correctamente |
| Notificaciones | 3 | Reviewers reciben notificación |
| Approve/Reject | 3 | Proceso de aprobación funcional |

### Gestión de Gates (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Multiple gates | 3 | Varios puntos de aprobación en pipeline |
| Bypass rules | 2 | Entiende cuándo/cómo hacer bypass |

---

## 5️⃣ Rollback Strategies (10 pts)

### Automatización (6 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Health checks | 3 | Verifica salud post-deploy |
| Auto-rollback | 3 | Rollback automático en fallo |

### Versioning (4 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Version tracking | 2 | Mantiene registro de versiones |
| Manual rollback | 2 | Puede hacer rollback manual |

---

## 6️⃣ Proyecto Semanal (25 pts)

### Multi-Environment Pipeline

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **Environments (8 pts)** | | |
| - 3 environments configurados | 4 | Dev, staging, production |
| - Secrets por environment | 2 | Configuración de secrets |
| - Variables por environment | 2 | Variables diferenciadas |
| **Protection Rules (7 pts)** | | |
| - Required reviewers en prod | 4 | Aprobadores configurados |
| - Wait timer en staging | 3 | Delay implementado |
| **Pipeline Flow (10 pts)** | | |
| - Deploy secuencial | 4 | Dev → Staging → Production |
| - Rollback implementado | 3 | Mecanismo de reversión |
| - Documentación | 3 | README con instrucciones |

---

## 📈 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐ Excelente | Dominio completo de deployment strategies |
| 80-89 | ✅ Muy Bueno | Buen manejo de environments y protection |
| 70-79 | 👍 Aprobado | Comprensión básica de deployment |
| 60-69 | ⚠️ Necesita Mejora | Revisar conceptos de environments |
| <60 | ❌ No Aprobado | Requiere refuerzo significativo |

---

## ✅ Checklist de Evaluación

### Teoría
- [ ] Explica diferencias entre blue-green, canary, rolling
- [ ] Conoce cuándo usar cada estrategia
- [ ] Entiende GitHub Environments

### Práctica
- [ ] Environments configurados correctamente
- [ ] Protection rules implementadas
- [ ] Approval workflow funcional
- [ ] Rollback probado

### Proyecto
- [ ] Pipeline multi-environment completo
- [ ] Approvals funcionando
- [ ] Documentación clara

---

## 📚 Recursos de Evaluación

- [GitHub Environments Docs](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [Deployment Protection Rules](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#deployment-protection-rules)
- [Managing Deployments](https://docs.github.com/en/actions/deployment/about-deployments/managing-deployments)

---

[⬅️ Volver a Semana 10](README.md)
