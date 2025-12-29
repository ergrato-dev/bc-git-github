# 📖 Glosario - Semana 10: Deployment Strategies

Términos clave relacionados con deployment strategies, environments y rollback.

---

## 🔤 Índice Rápido

[B](#b) | [C](#c) | [D](#d) | [E](#e) | [H](#h) | [P](#p) | [R](#r) | [S](#s) | [W](#w)

---

## B

### Blue-Green Deployment
Estrategia de deployment que mantiene **dos entornos idénticos** (Blue y Green). Mientras uno está activo sirviendo tráfico, el otro permanece en standby. El deploy se hace al entorno inactivo y luego se realiza un switch instantáneo. Permite rollback inmediato cambiando de vuelta el switch.

```
Blue (v1.0) ← 100% traffic
Green (v2.0) ← 0% traffic (standby)

Después del switch:
Blue (v1.0) ← 0% traffic (standby)
Green (v2.0) ← 100% traffic
```

---

## C

### Canary Deployment
Estrategia que despliega la nueva versión a un **pequeño porcentaje de usuarios** (típicamente 5-10%) mientras el resto sigue en la versión anterior. Permite validar con tráfico real antes de hacer rollout completo.

### Canary Release
Sinónimo de Canary Deployment. El nombre viene de los canarios usados en minas de carbón para detectar gases tóxicos.

### Continue-on-error
Propiedad en GitHub Actions que permite que un job o step continúe ejecutándose aunque falle. Útil para implementar rollback después de un health check fallido.

```yaml
- name: Health check
  continue-on-error: true
```

---

## D

### Deployment
Proceso de poner código en un environment específico para que esté disponible para usuarios o para pruebas.

### Deployment Branches
Regla de protección que restringe **qué branches pueden deployar** a un environment específico. Por ejemplo, solo permitir deployments a production desde `main`.

### Deployment History
Registro que GitHub mantiene de todos los deployments realizados a un environment, incluyendo: estado, commit, actor, timestamp y URL.

---

## E

### Environment
En GitHub Actions, una configuración que representa un **destino de deployment** como development, staging o production. Puede tener secrets, variables y protection rules específicas.

### Environment Secret
Variable encriptada disponible **solo para un environment específico**. Tiene mayor prioridad que repository secrets.

### Environment Variable
Variable de configuración no encriptada asociada a un environment específico. Accesible via `${{ vars.NOMBRE }}`.

---

## H

### Health Check
Verificación automática que determina si un deployment es **saludable** después de ejecutarse. Típicamente verifica endpoints HTTP, métricas o comandos específicos.

```yaml
# Ejemplo de health check
curl -sf https://app.example.com/health
```

---

## P

### Protection Rule
Control de seguridad que se aplica **antes** de que un job pueda ejecutarse en un environment. Incluye: required reviewers, wait timer, deployment branches.

---

## R

### Required Reviewers
Protection rule que requiere **aprobación manual** de una o más personas antes de que un deployment pueda proceder. Hasta 6 reviewers por environment.

### Rollback
Proceso de **revertir** a una versión anterior cuando un deployment falla o causa problemas. Puede ser automático (ante fallo de health check) o manual.

### Rolling Deployment
Estrategia que actualiza instancias **una a una** (o en batches), manteniendo siempre capacidad disponible. No requiere infraestructura adicional pero el rollback es más lento.

```
[v2.0] [v2.0] [v1→v2] [v1.0] [v1.0] [v1.0]
       ↑ actualizadas   ↑ en progreso   ↑ pendientes
```

---

## S

### Smoke Test
Pruebas básicas que verifican que las **funcionalidades críticas** funcionan después de un deployment. Más rápidas y superficiales que tests completos.

### Step Summary
Resumen en Markdown que aparece en la página del workflow run en GitHub. Se crea escribiendo a `$GITHUB_STEP_SUMMARY`.

```yaml
- run: echo "## Deploy Complete ✅" >> $GITHUB_STEP_SUMMARY
```

---

## W

### Wait Timer
Protection rule que establece un **delay obligatorio** (en minutos) antes de que un deployment pueda ejecutarse. Rango: 0 a 43,200 minutos (30 días).

### Workflow Dispatch
Trigger que permite ejecutar un workflow **manualmente** desde la UI de GitHub Actions, opcionalmente con inputs personalizados.

```yaml
on:
  workflow_dispatch:
    inputs:
      version:
        description: 'Version to deploy'
        required: true
```

---

## 📊 Tabla Comparativa: Deployment Strategies

| Estrategia | Rollback | Recursos | Riesgo | Complejidad |
|------------|----------|----------|--------|-------------|
| **Blue-Green** | Instantáneo | 2x | Bajo | Baja |
| **Canary** | Rápido | +5-10% | Muy bajo | Media-Alta |
| **Rolling** | Gradual | Mismo | Medio | Baja |

---

## 🔗 Referencias

- [GitHub Environments Docs](https://docs.github.com/en/actions/deployment/targeting-different-environments)
- [Protection Rules](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [Deployment Patterns - Martin Fowler](https://martinfowler.com/bliki/BlueGreenDeployment.html)

---

[⬅️ Volver a la semana](../README.md)
