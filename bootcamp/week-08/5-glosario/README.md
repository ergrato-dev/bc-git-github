# 📖 Glosario - Semana 08: CI/CD Pipelines

Términos clave de Integración Continua, Entrega Continua y Despliegue Continuo con GitHub Actions.

---

## 🔤 Índice Alfabético

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [E](#e) | [F](#f) | [G](#g) | [H](#h) | [I](#i) | [J](#j) | [L](#l) | [M](#m) | [N](#n) | [O](#o) | [P](#p) | [R](#r) | [S](#s) | [T](#t) | [U](#u) | [V](#v) | [W](#w) | [Y](#y)

---

## A

### Artifact
**Español:** Artefacto  
**Definición:** Archivo o conjunto de archivos generados durante un workflow que pueden compartirse entre jobs o descargarse después de la ejecución.  
**Ejemplo:** Build output, coverage reports, logs.

### Approval
**Español:** Aprobación  
**Definición:** Revisión manual requerida antes de continuar con un deployment a un environment protegido.  
**Uso:** Production deployments suelen requerir approval de uno o más reviewers.

---

## B

### Build
**Español:** Compilación  
**Definición:** Proceso de transformar código fuente en un formato ejecutable o distribuible.  
**Ejemplo:** `npm run build` genera archivos en `dist/`.

### Blue-Green Deployment
**Español:** Despliegue azul-verde  
**Definición:** Estrategia de deployment con dos ambientes idénticos (blue y green) para minimizar downtime.

---

## C

### Cache
**Español:** Caché  
**Definición:** Almacenamiento temporal de dependencias o archivos para acelerar ejecuciones futuras de workflows.  
**Beneficio:** Reduce tiempo de `npm install` de minutos a segundos.

### Cache Key
**Español:** Clave de caché  
**Definición:** Identificador único que determina cuándo usar o invalidar un cache.  
**Ejemplo:** `${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}`

### Canary Deployment
**Español:** Despliegue canario  
**Definición:** Estrategia donde se despliega a un pequeño porcentaje de usuarios antes del rollout completo.

### CD (Continuous Delivery)
**Español:** Entrega Continua  
**Definición:** Práctica donde el código está siempre listo para ser desplegado a producción con un click manual.

### CD (Continuous Deployment)
**Español:** Despliegue Continuo  
**Definición:** Práctica donde cada cambio que pasa los tests se despliega automáticamente a producción.

### CI (Continuous Integration)
**Español:** Integración Continua  
**Definición:** Práctica de integrar cambios de código frecuentemente, ejecutando builds y tests automáticos.

### Coverage
**Español:** Cobertura  
**Definición:** Métrica que indica qué porcentaje del código está siendo ejecutado por los tests.  
**Objetivo típico:** 80%+ de cobertura.

---

## D

### Deployment
**Español:** Despliegue  
**Definición:** Proceso de poner código en un ambiente (staging, production) para que esté disponible.

### DORA Metrics
**Español:** Métricas DORA  
**Definición:** Cuatro métricas clave de rendimiento DevOps: Deployment Frequency, Lead Time, MTTR, Change Failure Rate.

---

## E

### E2E Test
**Español:** Test de extremo a extremo  
**Definición:** Test que valida el flujo completo de una aplicación desde la perspectiva del usuario.  
**Herramientas:** Playwright, Cypress, Selenium.

### Environment
**Español:** Ambiente/Entorno  
**Definición:** Configuración aislada en GitHub con sus propios secrets, variables y reglas de protección.  
**Ejemplos:** staging, production, development.

### Environment Secret
**Español:** Secreto de ambiente  
**Definición:** Secret que solo está disponible para jobs que usan un environment específico.

---

## F

### Fail-Fast
**Español:** Fallo rápido  
**Definición:** Comportamiento donde el pipeline se detiene al primer fallo en lugar de continuar.  
**Configuración:** `strategy.fail-fast: true`

---

## G

### GITHUB_TOKEN
**Definición:** Token de autenticación generado automáticamente para cada workflow run con permisos configurables.  
**Uso:** Operaciones en el repositorio sin necesidad de PAT.

---

## H

### hashFiles()
**Definición:** Función de GitHub Actions que genera un hash de uno o más archivos.  
**Uso:** Crear cache keys dinámicas basadas en lockfiles.

---

## I

### Integration Test
**Español:** Test de integración  
**Definición:** Test que valida la interacción entre múltiples componentes o servicios.

---

## J

### Job
**Español:** Trabajo  
**Definición:** Conjunto de steps que se ejecutan en el mismo runner dentro de un workflow.

---

## L

### Linting
**Español:** Análisis estático  
**Definición:** Proceso de analizar código en busca de errores de sintaxis, estilo o potenciales bugs.  
**Herramientas:** ESLint, Prettier, Pylint.

---

## M

### Matrix Strategy
**Español:** Estrategia de matriz  
**Definición:** Forma de ejecutar un job múltiples veces con diferentes combinaciones de variables.  
**Ejemplo:** Probar en Node 18, 20 y 22 simultáneamente.

### MTTR
**Español:** Tiempo medio de recuperación  
**Definición:** Mean Time To Recovery - tiempo promedio para restaurar servicio después de un incidente.

---

## N

### needs
**Definición:** Palabra clave en YAML que define dependencias entre jobs.  
**Ejemplo:** `needs: [lint, test]` - el job espera a que lint y test terminen.

---

## O

### OIDC (OpenID Connect)
**Definición:** Protocolo de autenticación que permite a workflows obtener tokens de cloud providers sin secrets estáticos.  
**Beneficio:** Elimina necesidad de almacenar credenciales de AWS/Azure/GCP.

---

## P

### Pipeline
**Español:** Tubería  
**Definición:** Secuencia automatizada de stages que llevan código desde commit hasta producción.

### Production
**Español:** Producción  
**Definición:** Environment donde la aplicación está disponible para usuarios finales.

---

## R

### Restore Key
**Español:** Clave de restauración  
**Definición:** Cache key alternativa usada cuando no hay match exacto con la key principal.  
**Propósito:** Usar cache parcial en lugar de empezar de cero.

### Retention
**Español:** Retención  
**Definición:** Período de tiempo que un artifact permanece almacenado antes de eliminarse.  
**Default:** 90 días para artifacts en GitHub.

### Rollback
**Español:** Reversión  
**Definición:** Proceso de volver a una versión anterior después de un deployment fallido.

### Runner
**Español:** Ejecutor  
**Definición:** Servidor que ejecuta los jobs de GitHub Actions.  
**Tipos:** GitHub-hosted, self-hosted.

---

## S

### Secret
**Español:** Secreto  
**Definición:** Valor encriptado almacenado en GitHub para usar en workflows de forma segura.  
**Característica:** Nunca se muestra en logs (aparece como `***`).

### Self-Hosted Runner
**Español:** Ejecutor auto-hospedado  
**Definición:** Runner que configuras y mantienes en tu propia infraestructura.

### Smoke Test
**Español:** Test de humo  
**Definición:** Test rápido que verifica que las funcionalidades básicas funcionan después de un deployment.

### Staging
**Español:** Pre-producción  
**Definición:** Environment que replica producción para testing antes del deployment final.

### Step
**Español:** Paso  
**Definición:** Unidad mínima de ejecución dentro de un job, puede ser un comando o una action.

### Step Summary
**Español:** Resumen de paso  
**Definición:** Markdown que aparece en la UI de GitHub Actions al final de un workflow run.  
**Uso:** `echo "## Title" >> $GITHUB_STEP_SUMMARY`

---

## T

### Test Pyramid
**Español:** Pirámide de tests  
**Definición:** Modelo que sugiere muchos unit tests, menos integration tests, y pocos E2E tests.  
**Proporción:** ~70% unit, ~20% integration, ~10% E2E.

### Trigger
**Español:** Disparador  
**Definición:** Evento que inicia la ejecución de un workflow.  
**Ejemplos:** push, pull_request, workflow_dispatch, schedule.

---

## U

### Unit Test
**Español:** Test unitario  
**Definición:** Test que valida una función o componente de forma aislada.  
**Características:** Rápido, sin dependencias externas.

### Upload/Download Artifact
**Definición:** Actions oficiales para subir y descargar artifacts entre jobs.

---

## V

### Variable
**Español:** Variable  
**Definición:** Valor de configuración almacenado en GitHub, visible (no encriptado) y reutilizable en workflows.  
**Diferencia con Secret:** Variables son visibles, secrets están encriptados.

---

## W

### Wait Timer
**Español:** Temporizador de espera  
**Definición:** Tiempo de espera obligatorio antes de permitir deployment a un environment protegido.  
**Uso:** Dar tiempo para cancelar deployments accidentales.

### Workflow
**Español:** Flujo de trabajo  
**Definición:** Archivo YAML que define uno o más jobs a ejecutar cuando ocurre un evento.

### workflow_dispatch
**Definición:** Trigger que permite iniciar workflows manualmente desde la UI o API de GitHub.

---

## Y

### YAML
**Definición:** "YAML Ain't Markup Language" - formato de serialización usado para archivos de configuración de GitHub Actions.

---

## 📊 Tabla Resumen: CI vs CD

| Término | Significado | Automatización | Ejemplo |
|---------|-------------|----------------|---------|
| **CI** | Continuous Integration | Build + Test automáticos | Cada push ejecuta tests |
| **CD (Delivery)** | Continuous Delivery | + Deploy manual | Click para producción |
| **CD (Deployment)** | Continuous Deployment | + Deploy automático | Producción sin intervención |

---

## 📚 Recursos Adicionales

- [Documentación de GitHub Actions](https://docs.github.com/en/actions)
- [GitHub Actions Glossary](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions)
- [Glosario Semana 07](../../week-07/5-glosario/)

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana |
|:-----------:|:---------:|
| [Recursos](../4-recursos/) | [Week 08](../README.md) |
