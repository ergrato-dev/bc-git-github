# 🎯 Proyecto Semanal - Semana 09

## Custom Action Suite: Auto-Label & Notify

> **Duración**: 2 horas (33% del tiempo)  
> **Puntuación**: 25 puntos  
> **Entrega**: Pull Request con todos los componentes

---

## 📋 Descripción

Crear una suite completa de Custom Actions que automatice el etiquetado de Issues/PRs y notifique al equipo. El proyecto integra todos los conceptos de la semana:

- **JavaScript Action**: Auto-labeler inteligente
- **Composite Action**: Setup y notificación
- **Reusable Workflow**: Pipeline reutilizable
- **Dispatch Events**: Triggers manuales

---

## 🎯 Objetivos

- [ ] Crear una JavaScript Action funcional
- [ ] Implementar una Composite Action
- [ ] Diseñar un Reusable Workflow
- [ ] Configurar Dispatch Events
- [ ] Documentar todo el código

---

## 📁 Estructura del Proyecto

```
mi-proyecto-week-09_custom_actions_advanced_workflows/
├── .github/
│   ├── actions/
│   │   ├── auto-labeler/           # JavaScript Action
│   │   │   ├── action.yml
│   │   │   ├── package.json
│   │   │   ├── src/index.js
│   │   │   └── dist/index.js
│   │   │
│   │   └── notify-team/            # Composite Action
│   │       └── action.yml
│   │
│   └── workflows/
│       ├── labeler-template.yml    # Reusable Workflow
│       ├── on-issue.yml            # Caller para Issues
│       └── manual-label.yml        # workflow_dispatch
│
├── config/
│   └── labels.json                 # Configuración de labels
│
└── README.md                       # Documentación
```

---

## 🚀 Requisitos

### 1. JavaScript Action: Auto-Labeler (10 pts)

Crear `.github/actions/auto-labeler/action.yml`:

```yaml
name: 'Auto Labeler'
description: 'Automatically labels issues and PRs based on content'

inputs:
  github-token:
    description: 'GitHub token'
    required: true
  config-path:
    description: 'Path to labels config'
    default: 'config/labels.json'

outputs:
  labels-added:
    description: 'Labels that were added'
  labels-count:
    description: 'Number of labels added'

runs:
  using: 'node20'
  main: 'dist/index.js'
```

**Funcionalidad requerida**:
- Leer título y body del Issue/PR
- Buscar keywords en `config/labels.json`
- Añadir labels automáticamente
- Reportar labels añadidos como output

---

### 2. Composite Action: Notify Team (5 pts)

Crear `.github/actions/notify-team/action.yml`:

```yaml
name: 'Notify Team'
description: 'Send notification about labeled items'

inputs:
  title:
    description: 'Item title'
    required: true
  labels:
    description: 'Applied labels'
    required: true
  url:
    description: 'Item URL'
    required: true
  channel:
    description: 'Notification channel'
    default: 'github-summary'

runs:
  using: 'composite'
  steps:
    # Implementar notificación
```

---

### 3. Reusable Workflow (5 pts)

Crear `.github/workflows/labeler-template.yml`:

```yaml
name: Labeler Template

on:
  workflow_call:
    inputs:
      item-type:
        type: string
        required: true
      config-path:
        type: string
        default: 'config/labels.json'
    secrets:
      GITHUB_TOKEN:
        required: true
    outputs:
      labels:
        value: ${{ jobs.label.outputs.labels }}
```

---

### 4. Dispatch Events (5 pts)

Crear `.github/workflows/manual-label.yml`:

```yaml
name: Manual Labeling

on:
  workflow_dispatch:
    inputs:
      issue-number:
        description: 'Issue number to label'
        required: true
        type: number
      labels:
        description: 'Labels to add (comma-separated)'
        required: true
        type: string
```

---

## 📝 Configuración de Labels

Crear `config/labels.json`:

```json
{
  "rules": [
    {
      "keywords": ["bug", "error", "fix", "broken"],
      "label": "bug",
      "color": "d73a4a"
    },
    {
      "keywords": ["feature", "enhancement", "add", "new"],
      "label": "enhancement",
      "color": "a2eeef"
    },
    {
      "keywords": ["docs", "documentation", "readme"],
      "label": "documentation",
      "color": "0075ca"
    },
    {
      "keywords": ["help", "question", "how"],
      "label": "question",
      "color": "d876e3"
    }
  ]
}
```

---

## ✅ Criterios de Evaluación

| Componente | Puntos | Criterios |
|------------|--------|-----------|
| JavaScript Action | 10 | Funcional, usa toolkit, outputs correctos |
| Composite Action | 5 | Steps bien definidos, shell especificado |
| Reusable Workflow | 5 | Inputs/outputs/secrets configurados |
| Dispatch Events | 5 | Formulario funcional, validaciones |
| **Total** | **25** | |

---

## 📤 Entrega

1. Crear repositorio con la estructura indicada
2. Implementar todos los componentes
3. Probar que los workflows funcionan
4. Crear PR con descripción detallada
5. Incluir screenshots de Actions ejecutándose

---

## 💡 Tips

- Empieza por la JavaScript Action (más compleja)
- Usa `act` para testing local si es posible
- Revisa los logs de Actions para debugging
- Documenta cada decisión de diseño

---

## 📚 Recursos

- [Creating Actions](https://docs.github.com/en/actions/creating-actions)
- [Actions Toolkit](https://github.com/actions/toolkit)
- [Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)

---

[⬅️ Volver a Ejercicios](../2-practicas/README.md) · [📋 Semana 09](../README.md)
