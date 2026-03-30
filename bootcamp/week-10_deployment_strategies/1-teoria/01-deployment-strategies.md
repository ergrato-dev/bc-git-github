# 🚀 Lección 01: Deployment Strategies

## 📋 Información de la Lección

| Campo | Detalle |
|-------|---------|
| **Duración** | 25 minutos |
| **Nivel** | Intermedio |
| **Prerrequisitos** | Week 09 - Custom Actions |
| **Objetivos** | Comprender Blue-Green, Canary y Rolling deployments |

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- [ ] Explicar las diferencias entre Blue-Green, Canary y Rolling deployments
- [ ] Identificar cuándo usar cada estrategia según el contexto
- [ ] Evaluar trade-offs de recursos, riesgo y complejidad
- [ ] Diseñar pipelines que implementen estas estrategias

---

## 📚 Contenido

### 1. ¿Por Qué Importan las Deployment Strategies?

En producción, un deployment mal ejecutado puede significar:

- **Downtime**: Usuarios sin acceso al servicio
- **Bugs en producción**: Errores que afectan a todos los usuarios
- **Pérdida de datos**: En casos extremos
- **Impacto en el negocio**: Pérdida de ingresos y confianza

Las **deployment strategies** son patrones probados que minimizan estos riesgos.

---

### 2. Blue-Green Deployment

#### ¿Qué es?

Mantener **dos entornos idénticos** (Blue y Green) donde uno está activo y otro en standby.

```
┌─────────────────────────────────────────────────────────┐
│                    LOAD BALANCER                        │
│                         │                               │
│            ┌────────────┴────────────┐                 │
│            ▼                         ▼                  │
│   ┌─────────────────┐       ┌─────────────────┐        │
│   │     BLUE        │       │     GREEN       │        │
│   │   (v1.0)        │       │   (v2.0)        │        │
│   │   [ACTIVE]      │       │   [STANDBY]     │        │
│   │   100% traffic  │       │   0% traffic    │        │
│   └─────────────────┘       └─────────────────┘        │
└─────────────────────────────────────────────────────────┘
```

#### Flujo de Deployment

1. **Green** tiene la nueva versión (v2.0) deployada
2. Tests y validaciones en Green (sin tráfico real)
3. **Switch**: Load balancer redirige 100% del tráfico a Green
4. Green pasa a ser **ACTIVE**, Blue pasa a **STANDBY**
5. Si hay problemas: switch instantáneo de vuelta a Blue

#### Ventajas

| Ventaja | Descripción |
|---------|-------------|
| ✅ **Rollback instantáneo** | Solo cambiar el switch del load balancer |
| ✅ **Zero downtime** | El switch es prácticamente instantáneo |
| ✅ **Testing en producción** | Probar en Green con datos reales antes del switch |
| ✅ **Simplicidad conceptual** | Fácil de entender y explicar |

#### Desventajas

| Desventaja | Descripción |
|------------|-------------|
| ❌ **Doble infraestructura** | Necesitas 2x los recursos |
| ❌ **Sincronización de datos** | Bases de datos deben estar sincronizadas |
| ❌ **Costo** | Mayor gasto en infraestructura |

#### Cuándo Usar Blue-Green

- Releases críticos donde el rollback rápido es esencial
- Aplicaciones con requerimientos estrictos de uptime
- Cuando el costo de infraestructura no es un problema
- Deployments poco frecuentes pero importantes

#### Ejemplo en GitHub Actions

```yaml
# ¿QUÉ HACE?: Deploy Blue-Green con switch de tráfico
# ¿POR QUÉ?: Permite rollback instantáneo si hay problemas
# ¿PARA QUÉ SIRVE?: Zero downtime deployments críticos

name: Blue-Green Deploy

on:
  push:
    branches: [main]

jobs:
  deploy-green:
    runs-on: ubuntu-latest
    environment: production-green
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy to Green environment
        run: |
          # Deploy a Green (standby)
          ./deploy.sh --target green --version ${{ github.sha }}
      
      - name: Run smoke tests on Green
        run: |
          # Validar que Green funciona correctamente
          ./test-smoke.sh --endpoint https://green.example.com
      
      - name: Switch traffic to Green
        run: |
          # Cambiar load balancer para enviar tráfico a Green
          ./switch-traffic.sh --from blue --to green
      
      - name: Verify deployment
        run: |
          # Confirmar que todo funciona
          ./verify-deployment.sh --endpoint https://app.example.com
```

---

### 3. Canary Deployment

#### ¿Qué es?

Desplegar la nueva versión a un **pequeño porcentaje de usuarios** primero, monitoreando métricas antes de expandir.

```
┌─────────────────────────────────────────────────────────┐
│                    LOAD BALANCER                        │
│                         │                               │
│            ┌────────────┴────────────┐                 │
│            │ 95%                 5%  │                  │
│            ▼                         ▼                  │
│   ┌─────────────────┐       ┌─────────────────┐        │
│   │   PRODUCTION    │       │     CANARY      │        │
│   │     (v1.0)      │       │     (v2.0)      │        │
│   │   Stable        │       │   Testing       │        │
│   └─────────────────┘       └─────────────────┘        │
└─────────────────────────────────────────────────────────┘
```

#### Flujo de Deployment

1. Deploy v2.0 a instancia **Canary** (5% del tráfico)
2. Monitorear métricas: errores, latencia, CPU, memoria
3. Si métricas son buenas → aumentar a 25%, 50%, 100%
4. Si métricas son malas → rollback solo el 5% afectado

#### Progresión Típica de Canary

```
Tiempo    Canary    Producción    Acción
───────────────────────────────────────────
T+0       5%        95%           Deploy inicial
T+15min   25%       75%           Métricas OK
T+30min   50%       50%           Métricas OK
T+1h      100%      0%            Rollout completo
```

#### Ventajas

| Ventaja | Descripción |
|---------|-------------|
| ✅ **Riesgo mínimo** | Solo afecta a un pequeño % de usuarios |
| ✅ **Feedback real** | Métricas con tráfico de producción |
| ✅ **Rollback rápido** | Solo rollback del % canary |
| ✅ **A/B Testing** | Comparar versiones con usuarios reales |

#### Desventajas

| Desventaja | Descripción |
|------------|-------------|
| ❌ **Complejidad** | Requiere routing inteligente |
| ❌ **Monitoreo** | Necesita métricas detalladas |
| ❌ **Sesiones** | Sticky sessions pueden complicarse |
| ❌ **Tiempo** | Rollout completo es más lento |

#### Cuándo Usar Canary

- Features nuevas con riesgo de bugs
- Cambios que podrían afectar performance
- Cuando quieres validar con usuarios reales antes de full rollout
- A/B testing de funcionalidades

#### Ejemplo en GitHub Actions

```yaml
# ¿QUÉ HACE?: Canary deployment progresivo
# ¿POR QUÉ?: Minimiza impacto si hay bugs
# ¿PARA QUÉ SIRVE?: Validar con usuarios reales antes de full rollout

name: Canary Deploy

on:
  push:
    branches: [main]

jobs:
  canary-5:
    runs-on: ubuntu-latest
    environment: canary-5
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy Canary (5%)
        run: ./deploy.sh --target canary --percentage 5
      
      - name: Wait and monitor (15 min)
        run: |
          sleep 900
          ./check-metrics.sh --threshold error_rate<0.1
  
  canary-25:
    needs: canary-5
    runs-on: ubuntu-latest
    environment: canary-25
    steps:
      - name: Increase Canary to 25%
        run: ./deploy.sh --target canary --percentage 25
      
      - name: Wait and monitor (15 min)
        run: |
          sleep 900
          ./check-metrics.sh --threshold error_rate<0.1
  
  full-rollout:
    needs: canary-25
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Full production rollout
        run: ./deploy.sh --target production --percentage 100
```

---

### 4. Rolling Deployment

#### ¿Qué es?

Actualizar instancias **una a una** (o en batches), manteniendo siempre capacidad disponible.

```
Estado Inicial:
┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│ v1.0 │ │ v1.0 │ │ v1.0 │ │ v1.0 │ │ v1.0 │ │ v1.0 │
└──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘

Paso 1 (17%):
┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│ v2.0 │ │ v1.0 │ │ v1.0 │ │ v1.0 │ │ v1.0 │ │ v1.0 │
└──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘

Paso 3 (50%):
┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│ v2.0 │ │ v2.0 │ │ v2.0 │ │ v1.0 │ │ v1.0 │ │ v1.0 │
└──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘

Completo (100%):
┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│ v2.0 │ │ v2.0 │ │ v2.0 │ │ v2.0 │ │ v2.0 │ │ v2.0 │
└──────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘
```

#### Flujo de Deployment

1. Seleccionar instancia(s) para actualizar
2. Sacar del load balancer (drain connections)
3. Deploy nueva versión
4. Health check
5. Volver a agregar al load balancer
6. Repetir con siguiente batch

#### Ventajas

| Ventaja | Descripción |
|---------|-------------|
| ✅ **Sin infraestructura extra** | Usa las mismas instancias |
| ✅ **Costo efectivo** | No necesita duplicar recursos |
| ✅ **Gradual** | Puedes detectar problemas temprano |
| ✅ **Estándar** | Soportado nativamente por Kubernetes, ECS, etc. |

#### Desventajas

| Desventaja | Descripción |
|------------|-------------|
| ❌ **Rollback lento** | Hay que hacer rolling hacia atrás |
| ❌ **Versiones mixtas** | Durante el deploy hay v1 y v2 activas |
| ❌ **Capacidad reducida** | Temporalmente menos instancias disponibles |
| ❌ **Compatibilidad** | APIs deben ser backward compatible |

#### Cuándo Usar Rolling

- Updates frecuentes y pequeños
- Cuando la infraestructura está limitada
- Aplicaciones stateless
- Cuando la compatibilidad hacia atrás está garantizada

---

### 5. Tabla Comparativa

![Deployment Strategies](../0-assets/01-deployment-strategies.svg)

| Característica | Blue-Green | Canary | Rolling |
|----------------|------------|--------|---------|
| **Velocidad Rollback** | ⚡ Instantáneo | 🚀 Rápido | 🐢 Gradual |
| **Recursos Necesarios** | 2x infraestructura | +5-10% | Misma |
| **Riesgo de Impacto** | Bajo (switch) | Muy bajo (5%) | Medio |
| **Complejidad** | Baja | Media-Alta | Baja |
| **Zero Downtime** | ✅ Sí | ✅ Sí | ✅ Sí |
| **Testing Real** | En standby | Con usuarios | Durante rollout |

---

### 6. Eligiendo la Estrategia Correcta

```
¿Necesitas rollback instantáneo?
    │
    ├─ SÍ → ¿Puedes pagar 2x infraestructura?
    │           │
    │           ├─ SÍ → BLUE-GREEN
    │           │
    │           └─ NO → CANARY (con porcentajes bajos)
    │
    └─ NO → ¿Tienes muchas instancias?
                │
                ├─ SÍ → ROLLING
                │
                └─ NO → ¿Feature arriesgado?
                            │
                            ├─ SÍ → CANARY
                            │
                            └─ NO → ROLLING
```

---

## 💡 Tips y Mejores Prácticas

### Para Blue-Green
- Usa bases de datos compatibles con ambas versiones
- Automatiza el switch del load balancer
- Mantén Blue listo para rollback por al menos 24h

### Para Canary
- Define métricas claras antes del deploy
- Automatiza la progresión basada en métricas
- Ten alertas configuradas para el % canary

### Para Rolling
- Configura health checks robustos
- Asegura backward compatibility de APIs
- Define batch sizes apropiados (25-33%)

---

## 🔗 Recursos Adicionales

- [GitHub: Configuring environments](https://docs.github.com/en/actions/deployment/targeting-different-environments)
- [Martin Fowler: Blue-Green Deployment](https://martinfowler.com/bliki/BlueGreenDeployment.html)
- [Kubernetes: Rolling Updates](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/)

---

## ✅ Checklist de Comprensión

Antes de continuar, asegúrate de poder responder:

- [ ] ¿Cuál es la diferencia principal entre Blue-Green y Canary?
- [ ] ¿Por qué Rolling deployment requiere backward compatibility?
- [ ] ¿Cuándo elegirías Canary sobre Blue-Green?
- [ ] ¿Qué estrategia usarías para un deploy crítico con presupuesto limitado?

---

**Siguiente lección**: [02 - GitHub Environments](02-github-environments.md)
