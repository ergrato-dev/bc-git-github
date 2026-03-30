# 📚 Recursos Adicionales - Semana 09

> Material complementario sobre Custom Actions y Advanced Workflows

---

## 📖 Documentación Oficial

### GitHub Actions
- [Creating Actions](https://docs.github.com/en/actions/creating-actions) - Guía completa
- [JavaScript Actions](https://docs.github.com/en/actions/creating-actions/creating-a-javascript-action)
- [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action)
- [Docker Actions](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
- [Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [workflow_dispatch](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch)

### Actions Toolkit
- [Toolkit Repository](https://github.com/actions/toolkit) - Monorepo oficial
- [@actions/core](https://github.com/actions/toolkit/tree/main/packages/core) - Inputs, outputs, logging
- [@actions/github](https://github.com/actions/toolkit/tree/main/packages/github) - Octokit + context
- [@actions/exec](https://github.com/actions/toolkit/tree/main/packages/exec) - Ejecutar comandos

---

## 🎥 Videos Recomendados

| Título | Duración | Enlace |
|--------|----------|--------|
| Creating Custom GitHub Actions | 15 min | [YouTube](https://www.youtube.com/watch?v=COPS4VMfaUc) |
| Reusable Workflows Deep Dive | 20 min | [GitHub Universe](https://www.youtube.com/watch?v=lRypYtmbKMs) |
| Building JS Actions from Scratch | 25 min | [DevOps Toolkit](https://www.youtube.com/watch?v=2S_i1bLgIJQ) |

---

## 📦 Actions de Referencia

### JavaScript Actions (Ejemplos)
- [actions/github-script](https://github.com/actions/github-script) - Ejecutar scripts con Octokit
- [actions/labeler](https://github.com/actions/labeler) - Auto-labeling de PRs
- [peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request)

### Composite Actions (Ejemplos)
- [actions/setup-node](https://github.com/actions/setup-node) - Mixto JS/Composite
- [pnpm/action-setup](https://github.com/pnpm/action-setup)

---

## 🛠️ Herramientas

| Herramienta | Descripción | Enlace |
|-------------|-------------|--------|
| @vercel/ncc | Compilador para Actions | [npm](https://www.npmjs.com/package/@vercel/ncc) |
| act | Ejecutar Actions localmente | [GitHub](https://github.com/nektos/act) |
| action-validator | Validar action.yml | [GitHub](https://github.com/mheap/json-schema-to-typescript) |

---

## 📝 Cheatsheet: action.yml

```yaml
# Metadata
name: 'Action Name'
description: 'What it does'
author: 'Your Name'

# Inputs
inputs:
  input-name:
    description: 'Description'
    required: true/false
    default: 'value'

# Outputs  
outputs:
  output-name:
    description: 'Description'
    value: ${{ steps.id.outputs.name }}

# JavaScript
runs:
  using: 'node20'
  main: 'dist/index.js'
  pre: 'setup.js'      # opcional
  post: 'cleanup.js'   # opcional

# Composite
runs:
  using: 'composite'
  steps:
    - run: command
      shell: bash      # OBLIGATORIO

# Docker
runs:
  using: 'docker'
  image: 'Dockerfile'

# Branding (Marketplace)
branding:
  icon: 'check-circle'
  color: 'green'
```

---

## 🔗 Links Útiles

- [GitHub Marketplace - Actions](https://github.com/marketplace?type=actions)
- [Awesome Actions](https://github.com/sdras/awesome-actions)
- [Actions Status](https://www.githubstatus.com/)

---

[⬅️ Volver a Semana 09](../README.md)
