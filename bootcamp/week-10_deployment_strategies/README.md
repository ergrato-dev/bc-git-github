# 📅 Semana 10: Deployment Strategies

> **Fase 2**: GitHub Actions Certification (Semana 4 de 4 - **Final**)  
> **Duración**: 6 horas  
> **Tema**: Estrategias de deployment, environments, approvals y rollback

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana serás capaz de:

- [ ] Implementar estrategias de deployment (blue-green, canary, rolling)
- [ ] Configurar GitHub Environments con variables y secrets
- [ ] Establecer protection rules y required reviewers
- [ ] Implementar flujos de approval manual
- [ ] Diseñar estrategias de rollback automatizado
- [ ] Gestionar deployments multi-environment (dev → staging → prod)

---

## ⏱️ Distribución del Tiempo

| Actividad | Tiempo | Porcentaje |
|-----------|--------|------------|
| 📖 Teoría | 1.5 horas | 25% |
| 💻 Ejercicios | 2.5 horas | 42% |
| 🎯 Proyecto | 2 horas | 33% |
| **Total** | **6 horas** | **100%** |

---

## 📚 Contenido

### 1️⃣ Teoría (1.5h)

| # | Lección | Duración | Tema |
|---|---------|----------|------|
| 01 | [Deployment Strategies](1-teoria/01-deployment-strategies.md) | 25 min | Blue-green, canary, rolling deployments |
| 02 | [GitHub Environments](1-teoria/02-github-environments.md) | 20 min | Configuración, variables, secrets |
| 03 | [Protection Rules](1-teoria/03-protection-rules.md) | 25 min | Required reviewers, wait timer, branch policies |
| 04 | [Rollback Strategies](1-teoria/04-rollback-strategies.md) | 20 min | Automatización, versioning, recovery |

### 2️⃣ Ejercicios (2.5h)

| # | Ejercicio | Duración | Práctica |
|---|-----------|----------|----------|
| 01 | [Configurar Environments](2-practicas/ejercicio-01-environments/README.md) | 35 min | Dev, staging, production setup |
| 02 | [Protection Rules](2-practicas/ejercicio-02-protection-rules/README.md) | 35 min | Reviewers, wait timer, restrictions |
| 03 | [Approval Workflow](2-practicas/ejercicio-03-approval-workflow/README.md) | 40 min | Manual gates, notifications |
| 04 | [Rollback Pipeline](2-practicas/ejercicio-04-rollback/README.md) | 40 min | Automated rollback, health checks |

### 3️⃣ Proyecto (2h)

| Proyecto | Descripción | Puntos |
|----------|-------------|--------|
| [Multi-Environment Pipeline](3-proyecto/README.md) | Pipeline completo con 3 environments, approvals y rollback | 25 pts |

---

## 📁 Estructura de Carpetas

```
week-10_deployment_strategies/
├── README.md                    # Este archivo
├── rubrica-evaluacion.md        # Criterios de evaluación (100 pts)
├── 0-assets/                    # Diagramas SVG
│   ├── 01-deployment-strategies.svg
│   ├── 02-environments-flow.svg
│   ├── 03-protection-rules.svg
│   └── 04-rollback-flow.svg
├── 1-teoria/                    # Lecciones teóricas
├── 2-practicas/                 # Ejercicios guiados
├── 3-proyecto/                  # Proyecto semanal
├── 4-recursos/                  # Material adicional
└── 5-glosario/                  # Términos clave
```

---

## 🎓 Certificación Asociada

| Certificación | Relevancia | Cobertura |
|---------------|------------|-----------|
| **GitHub Actions** | 🔴 Alta | Deployment strategies, Environments, Protection rules |

> **🏆 Semana Final de Fase 2**: Esta semana completa la preparación para la certificación GitHub Actions.

---

## 📋 Quick Reference

### Workflow con Environment

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    steps:
      - name: Deploy
        run: echo "Deploying to production"
```

### Protection Rule Types

| Rule | Descripción |
|------|-------------|
| `required_reviewers` | Aprobadores requeridos antes del deploy |
| `wait_timer` | Tiempo de espera antes de ejecutar |
| `prevent_self_review` | Evitar auto-aprobación |
| `branch_policy` | Solo desde branches específicos |

---

## 📌 Entregables

- [ ] Environments configurados (dev, staging, production)
- [ ] Protection rules implementadas
- [ ] Workflow con approval gates funcional
- [ ] Rollback automatizado probado
- [ ] Proyecto multi-environment completado

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Semana 09: Custom Actions](../week-09_custom_actions_advanced_workflows/README.md) | [Bootcamp](../README.md) | [Semana 11: Security Features](../week-11_security_features/README.md) |

---

[📁 Assets](0-assets/) · [📖 Teoría](1-teoria/) · [💻 Ejercicios](2-practicas/) · [🎯 Proyecto](3-proyecto/) · [📚 Recursos](4-recursos/) · [📖 Glosario](5-glosario/)
