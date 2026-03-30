# 🤖 Ejercicio 02: Configurar Dependabot

> **Duración**: 35 minutos
> 
> **Objetivo**: Configurar Dependabot alerts, security updates y version updates.

---

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio serás capaz de:

- ✅ Habilitar Dependabot alerts y security updates
- ✅ Crear un archivo dependabot.yml completo
- ✅ Configurar grupos y schedules
- ✅ Gestionar PRs de Dependabot

---

## 📋 Requisitos Previos

- Repository con dependencias (npm, pip, etc.)
- Acceso a Settings del repository
- Dependencias con actualizaciones disponibles

---

## 🏗️ Parte 1: Preparar Repository (8 min)

### Paso 1.1: Crear repository con dependencias antiguas

```bash
# ¿Qué hace?: Crea un nuevo repository para el ejercicio
mkdir security-lab-dependabot
cd security-lab-dependabot
git init
```

### Paso 1.2: Crear package.json con dependencias vulnerables

```json
{
  "name": "security-lab-dependabot",
  "version": "1.0.0",
  "description": "Lab para practicar Dependabot",
  "dependencies": {
    "lodash": "4.17.15",
    "axios": "0.21.0",
    "express": "4.17.1",
    "minimist": "1.2.0",
    "node-fetch": "2.6.0"
  },
  "devDependencies": {
    "jest": "26.0.0",
    "eslint": "7.0.0"
  }
}
```

> **Nota**: Estas versiones tienen vulnerabilidades conocidas (CVEs).

### Paso 1.3: Crear requirements.txt (Python)

```txt
# requirements.txt
django==2.2.0
requests==2.20.0
pyyaml==5.1
pillow==6.0.0
```

### Paso 1.4: Push inicial

```bash
git add .
git commit -m "feat: add project with outdated dependencies"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/security-lab-dependabot.git
git push -u origin main
```

---

## 🔔 Parte 2: Habilitar Dependabot Alerts (5 min)

### Paso 2.1: Habilitar en Settings

```
Repository → Settings → Security → Code security and analysis
```

Habilita:
- ✅ Dependency graph
- ✅ Dependabot alerts
- ✅ Dependabot security updates

### Paso 2.2: Ver alertas generadas

```
Repository → Security → Dependabot alerts
```

Deberías ver alertas para las dependencias vulnerables:

| Paquete | Severidad | CVE |
|---------|-----------|-----|
| lodash | 🔴 Critical | CVE-2021-23337 |
| axios | 🟠 High | CVE-2021-3749 |
| minimist | 🟠 High | CVE-2021-44906 |
| node-fetch | 🟡 Medium | CVE-2022-0235 |

### Paso 2.3: Examinar una alerta

Haz clic en la alerta de `lodash`:

```
┌─────────────────────────────────────────────────────────┐
│  lodash < 4.17.21                                       │
│  Command Injection                                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Severity: Critical (9.8)                              │
│  CVE: CVE-2021-23337                                   │
│  GHSA: GHSA-35jh-r3h4-6jhm                             │
│                                                         │
│  Affected: < 4.17.21                                   │
│  Patched: >= 4.17.21                                   │
│                                                         │
│  [Create Dependabot security update]                   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 📦 Parte 3: Configurar Version Updates (12 min)

### Paso 3.1: Crear dependabot.yml

Crea `.github/dependabot.yml`:

```yaml
# ¿Qué hace?: Configura actualizaciones automáticas de Dependabot
# ¿Por qué?: Mantener dependencias actualizadas reduce vulnerabilidades
# ¿Para qué sirve?: PRs automáticos para actualizar paquetes

version: 2

updates:
  # ══════════════════════════════════════════════════════
  # NPM - Dependencias de Node.js
  # ══════════════════════════════════════════════════════
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      # ¿Qué hace?: Revisa actualizaciones cada lunes
      interval: "weekly"
      day: "monday"
      time: "09:00"
      timezone: "America/Mexico_City"
    
    # ¿Qué hace?: Máximo 10 PRs abiertos a la vez
    open-pull-requests-limit: 10
    
    # ¿Qué hace?: Agrega labels a los PRs
    labels:
      - "dependencies"
      - "npm"
    
    # ¿Qué hace?: Prefijo para commits (conventional commits)
    commit-message:
      prefix: "deps(npm)"
    
    # ¿Qué hace?: Agrupa actualizaciones por tipo
    groups:
      # Grupo 1: Patches de producción (bajo riesgo)
      production-patches:
        dependency-type: "production"
        update-types:
          - "patch"
      
      # Grupo 2: Dev dependencies (menor importancia)
      development:
        dependency-type: "development"
        update-types:
          - "minor"
          - "patch"
    
    # ¿Qué hace?: Ignora ciertas actualizaciones
    ignore:
      # No actualizar major versions de express automáticamente
      - dependency-name: "express"
        update-types: ["version-update:semver-major"]

  # ══════════════════════════════════════════════════════
  # PIP - Dependencias de Python
  # ══════════════════════════════════════════════════════
  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "weekly"
    labels:
      - "dependencies"
      - "python"
    commit-message:
      prefix: "deps(pip)"
    groups:
      python-updates:
        patterns:
          - "*"
        update-types:
          - "minor"
          - "patch"

  # ══════════════════════════════════════════════════════
  # GitHub Actions - Mantener actions actualizadas
  # ══════════════════════════════════════════════════════
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
    labels:
      - "ci"
      - "github-actions"
    commit-message:
      prefix: "ci"
```

### Paso 3.2: Commit y push

```bash
# ¿Qué hace?: Sube la configuración de Dependabot
git add .github/dependabot.yml
git commit -m "ci: add Dependabot configuration"
git push origin main
```

### Paso 3.3: Verificar que Dependabot se activa

```
Repository → Insights → Dependency graph → Dependabot
```

Deberías ver los ecosistemas configurados.

---

## 🔄 Parte 4: Gestionar PRs de Dependabot (10 min)

### Paso 4.1: Ver PRs generados

Dependabot creará PRs automáticamente. Ve a:

```
Repository → Pull requests → Author: dependabot[bot]
```

### Paso 4.2: Anatomía de un PR de Dependabot

```
┌─────────────────────────────────────────────────────────┐
│  deps(npm): bump lodash from 4.17.15 to 4.17.21        │
│  dependabot[bot] wants to merge 1 commit               │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Bumps lodash from 4.17.15 to 4.17.21.                 │
│                                                         │
│  Release notes:                                        │
│  - v4.17.21: Security fix for command injection        │
│                                                         │
│  Changelog:                                            │
│  - See full changelog                                  │
│                                                         │
│  Commits:                                              │
│  - abc1234: bump to 4.17.21                           │
│                                                         │
│  ────────────────────────────────────────────          │
│  Dependabot compatibility score: 98%                   │
│                                                         │
│  Dependabot commands:                                  │
│  @dependabot rebase                                    │
│  @dependabot recreate                                  │
│  @dependabot merge                                     │
│  @dependabot squash and merge                          │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Paso 4.3: Comandos de Dependabot

En cualquier PR de Dependabot, puedes comentar:

| Comando | Acción |
|---------|--------|
| `@dependabot rebase` | Hace rebase del PR |
| `@dependabot recreate` | Recrea el PR desde cero |
| `@dependabot merge` | Mergea el PR (si CI pasa) |
| `@dependabot squash and merge` | Squash merge |
| `@dependabot cancel merge` | Cancela auto-merge |
| `@dependabot close` | Cierra el PR |
| `@dependabot ignore this major version` | Ignora major |
| `@dependabot ignore this minor version` | Ignora minor |
| `@dependabot ignore this dependency` | Ignora completamente |

### Paso 4.4: Mergear un PR de seguridad

1. Abre el PR de `lodash`
2. Verifica que CI pasa
3. Comenta: `@dependabot squash and merge`

O usa el botón "Merge pull request".

---

## 🤖 Bonus: Auto-merge para Patches

### Crear workflow de auto-merge

Crea `.github/workflows/dependabot-auto-merge.yml`:

```yaml
# ¿Qué hace?: Auto-merge PRs de Dependabot que son patches
# ¿Por qué?: Patches tienen bajo riesgo de breaking changes
# ¿Para qué sirve?: Reducir trabajo manual de actualización

name: Dependabot Auto-merge

on: pull_request

permissions:
  contents: write
  pull-requests: write

jobs:
  auto-merge:
    runs-on: ubuntu-latest
    # Solo para PRs de Dependabot
    if: github.actor == 'dependabot[bot]'
    
    steps:
      - name: Fetch Dependabot metadata
        id: metadata
        uses: dependabot/fetch-metadata@v2
        with:
          github-token: "${{ secrets.GITHUB_TOKEN }}"
      
      - name: Auto-merge patch updates
        # ¿Qué hace?: Solo auto-merge si es patch
        if: steps.metadata.outputs.update-type == 'version-update:semver-patch'
        run: |
          echo "Auto-merging patch update"
          gh pr merge --auto --squash "$PR_URL"
        env:
          PR_URL: ${{ github.event.pull_request.html_url }}
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Auto-merge minor security updates
        # ¿Qué hace?: Auto-merge security updates hasta minor
        if: |
          steps.metadata.outputs.update-type == 'version-update:semver-minor' &&
          steps.metadata.outputs.dependency-type == 'direct:production'
        run: |
          echo "Auto-merging minor security update"
          gh pr merge --auto --squash "$PR_URL"
        env:
          PR_URL: ${{ github.event.pull_request.html_url }}
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

---

## ✅ Verificación Final

### Checklist de Completado

- [ ] Dependabot alerts habilitado
- [ ] Dependabot security updates habilitado
- [ ] dependabot.yml creado con 3 ecosistemas
- [ ] Groups configurados
- [ ] Al menos 1 PR de Dependabot mergeado
- [ ] (Bonus) Auto-merge workflow configurado

### Ver estado de Dependabot

```
Insights → Dependency graph → Dependabot
```

---

## 📝 Preguntas de Reflexión

1. ¿Por qué agrupar updates por tipo (patch, minor, major)?
2. ¿Cuál es el riesgo de auto-merge en major updates?
3. ¿Cómo afecta `open-pull-requests-limit` al flujo de trabajo?
4. ¿Por qué configurar GitHub Actions como ecosistema?

---

## 🔗 Recursos

- [Dependabot Configuration Options](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file)
- [Dependabot Grouping](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file#groups)
- [GitHub Advisory Database](https://github.com/advisories)

---

[⬅️ Ejercicio 01](../ejercicio-01-code-scanning/README.md) | [Siguiente: Ejercicio 03 →](../ejercicio-03-dependency-review/README.md)
