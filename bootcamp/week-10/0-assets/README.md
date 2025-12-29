# 📊 Assets - Semana 10

Recursos visuales para la semana de **Deployment Strategies**.

## 📁 Contenido

| Archivo | Descripción | Usado en |
|---------|-------------|----------|
| [01-deployment-strategies.svg](01-deployment-strategies.svg) | Comparativa Blue-Green vs Canary vs Rolling | [Lección 01](../1-teoria/01-deployment-strategies.md) |
| [02-environments-flow.svg](02-environments-flow.svg) | Pipeline Dev → Staging → Production | [Lección 02](../1-teoria/02-github-environments.md) |
| [03-protection-rules.svg](03-protection-rules.svg) | Required reviewers, wait timer, branch rules | [Lección 03](../1-teoria/03-protection-rules.md) |
| [04-rollback-flow.svg](04-rollback-flow.svg) | Flujo de rollback automático y métodos | [Lección 04](../1-teoria/04-rollback-strategies.md) |

## 🎨 Especificaciones de Diseño

Todos los SVGs siguen los estándares del bootcamp:

- **Tema**: Dark mode
- **Fondo**: `#0d1117`
- **Texto principal**: `#c9d1d9`
- **Texto secundario**: `#8b949e`
- **Bordes**: `#30363d`

### Paleta de Colores por Contexto

| Contexto | Color | Hex |
|----------|-------|-----|
| Development | Verde | `#3fb950` / `#238636` |
| Staging | Naranja | `#f0883e` / `#9e6a03` |
| Production | Rojo | `#f85149` / `#da3633` |
| Actions/Build | Azul | `#58a6ff` / `#1f6feb` |
| Gates/Approval | Púrpura | `#a371f7` / `#8957e5` |

## 📐 Diagramas Incluidos

### 01 - Deployment Strategies
- Visualización de Blue-Green, Canary y Rolling
- Tabla comparativa con pros/contras
- Indicadores de tráfico y progreso

### 02 - Environments Flow
- Pipeline completo de deployment
- Configuración de secrets y variables por environment
- Referencia YAML para workflows

### 03 - Protection Rules
- Required Reviewers (hasta 6 por environment)
- Wait Timer (0 a 43,200 minutos)
- Deployment Branches (patterns)
- Custom Deployment Rules (GitHub Apps)

### 04 - Rollback Flow
- Flujo de health check automático
- Tres métodos: Re-run, Git Revert, Manual Dispatch
- Tracking de versiones con estados

## 🔗 Referencias

- [GitHub Environments Docs](https://docs.github.com/en/actions/deployment/targeting-different-environments)
- [Protection Rules](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [Deployment Best Practices](https://docs.github.com/en/actions/deployment/about-deployments)

[⬅️ Volver a la semana](../README.md)
