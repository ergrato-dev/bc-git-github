# Leccion 01: GitHub Issues

## Objetivos de Aprendizaje

Al finalizar esta leccion seras capaz de:

- Comprender el proposito y uso de Issues en GitHub
- Crear Issues bien documentados
- Usar labels, milestones y assignees efectivamente
- Vincular Issues con codigo y Pull Requests

---

## Que es un Issue?

Un **Issue** es una unidad de trabajo en GitHub que permite:

- Reportar bugs
- Solicitar features
- Documentar tareas
- Discutir ideas
- Trackear progreso

![Anatomia de un Issue](../0-assets/01-github-issues-anatomy.svg)

---

## Anatomia de un Issue

### Componentes Principales

| Componente | Descripcion |
|------------|-------------|
| **Title** | Titulo descriptivo y conciso |
| **Number** | Identificador unico (#1, #42, etc.) |
| **Description** | Cuerpo con detalles (soporta Markdown) |
| **Labels** | Etiquetas para categorizar |
| **Assignees** | Personas responsables |
| **Milestone** | Agrupacion por objetivo/release |
| **Project** | Tablero de proyecto asociado |

---

## Crear un Issue Efectivo

### Estructura Recomendada

```markdown
## Descripcion

Descripcion clara del problema o solicitud.

## Pasos para Reproducir (bugs)

1. Paso 1
2. Paso 2
3. Paso 3

## Comportamiento Esperado

Que deberia suceder.

## Comportamiento Actual

Que sucede actualmente.

## Ambiente

- OS: Windows 11
- Browser: Chrome 120
- Version: 2.1.0

## Screenshots

[Adjuntar imagenes si aplica]
```

---

## Labels (Etiquetas)

Los labels categorizan y filtran Issues.

### Labels Predeterminados

| Label | Color | Uso |
|-------|-------|-----|
| `bug` | Rojo | Reportar errores |
| `documentation` | Azul | Mejoras a docs |
| `duplicate` | Gris | Issue duplicado |
| `enhancement` | Cyan | Mejora o feature |
| `good first issue` | Verde | Para nuevos contributors |
| `help wanted` | Verde | Necesita ayuda |
| `invalid` | Gris | No valido |
| `question` | Purpura | Pregunta o duda |
| `wontfix` | Blanco | No se arreglara |

### Crear Labels Personalizados

1. Ir a **Issues** > **Labels**
2. Click **New label**
3. Definir nombre, descripcion y color

```markdown
Ejemplos de labels personalizados:
- priority: high (rojo)
- priority: medium (naranja)
- priority: low (amarillo)
- area: frontend
- area: backend
- area: database
```

---

## Milestones

Los **Milestones** agrupan Issues relacionados con un objetivo comun.

### Casos de Uso

- Releases (v1.0, v2.0)
- Sprints (Sprint 1, Sprint 2)
- Features grandes (Feature X)

### Crear un Milestone

1. Ir a **Issues** > **Milestones**
2. Click **New milestone**
3. Definir titulo, fecha limite y descripcion

```markdown
Milestone: v2.0 Release
Due date: 2025-03-01
Description: Todas las features para la version 2.0
```

---

## Assignees

Asignar responsables a un Issue.

### Opciones de Asignacion

- **Self-assign**: Asignarte a ti mismo
- **Assign others**: Asignar a colaboradores
- **Multiple assignees**: Varios responsables

### Buenas Practicas

- Maximo 2-3 assignees por Issue
- Asignar solo a personas con acceso
- Reasignar si cambia el responsable

---

## Referencias y Vinculaciones

### Referenciar Issues

```markdown
# En commits
git commit -m "fix: resolve issue #42"

# En otros Issues o PRs
Related to #42
See also #15

# Cerrar automaticamente
Closes #42
Fixes #42
Resolves #42
```

### Keywords que Cierran Issues

Estos keywords en un PR cierran el Issue automaticamente al merge:

- `close`, `closes`, `closed`
- `fix`, `fixes`, `fixed`
- `resolve`, `resolves`, `resolved`

```markdown
# En descripcion de PR
This PR fixes #42 and closes #15
```

---

## Templates de Issues

Crear templates para estandarizar Issues.

### Ubicacion

```
.github/
└── ISSUE_TEMPLATE/
    ├── bug_report.md
    ├── feature_request.md
    └── config.yml
```

### Ejemplo: Bug Report Template

```markdown
---
name: Bug Report
about: Report a bug to help us improve
title: '[BUG] '
labels: 'bug'
assignees: ''
---

## Describe the bug
A clear and concise description.

## To Reproduce
Steps to reproduce:
1. Go to '...'
2. Click on '....'
3. See error

## Expected behavior
What you expected to happen.

## Screenshots
If applicable, add screenshots.

## Environment
- OS: [e.g. Windows 11]
- Browser: [e.g. Chrome 120]
- Version: [e.g. 2.1.0]
```

---

## GitHub CLI para Issues

### Comandos Basicos

```bash
# Listar Issues
gh issue list

# Crear Issue
gh issue create --title "Bug: login fails" --body "Description"

# Crear con labels
gh issue create --title "Add feature X" --label "enhancement,priority: high"

# Ver Issue
gh issue view 42

# Cerrar Issue
gh issue close 42

# Reabrir Issue
gh issue reopen 42

# Asignarse
gh issue develop 42
```

---

## Busqueda y Filtrado

### Filtros en la UI

```
is:open          # Solo abiertos
is:closed        # Solo cerrados
label:bug        # Con label bug
author:usuario   # Creados por usuario
assignee:usuario # Asignados a usuario
milestone:v2.0   # En milestone v2.0
no:label         # Sin labels
no:assignee      # Sin asignar
```

### Ejemplos de Busquedas

```
is:open label:bug assignee:@me
is:open label:"help wanted" no:assignee
is:closed milestone:v1.0
```

---

## Ejercicio Practico

### Crear un Issue Completo

1. Ve a tu repositorio de practica
2. Click **Issues** > **New issue**
3. Usa esta estructura:

```markdown
Title: Bug: Form validation not working

## Description
The email validation on the signup form accepts invalid formats.

## Steps to Reproduce
1. Go to /signup
2. Enter "invalid-email" in email field
3. Click Submit
4. Form submits without error

## Expected Behavior
Form should show error: "Invalid email format"

## Current Behavior
Form submits with invalid email

## Environment
- Browser: Chrome 120
- OS: Windows 11
```

4. Agregar labels: `bug`, `priority: high`
5. Asignarte como responsable
6. Agregar a un Milestone si existe

---

## Resumen

| Concepto | Descripcion |
|----------|-------------|
| Issue | Unidad de trabajo (bug, feature, tarea) |
| Labels | Categorizar y filtrar |
| Milestones | Agrupar por objetivo |
| Assignees | Asignar responsables |
| Templates | Estandarizar formato |
| Referencias | Vincular con commits/PRs |

---

## Recursos Adicionales

- [GitHub Docs: Issues](https://docs.github.com/en/issues)
- [Issue Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests)
- [GitHub CLI: Issues](https://cli.github.com/manual/gh_issue)

---

[Siguiente leccion: Pull Requests](02-pull-requests.md)
