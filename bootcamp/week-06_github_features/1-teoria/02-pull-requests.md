# Leccion 02: Pull Requests

## Objetivos de Aprendizaje

Al finalizar esta leccion seras capaz de:

- Entender el flujo completo de un Pull Request
- Crear PRs bien estructurados
- Vincular PRs con Issues
- Manejar los diferentes estados de un PR
- Usar Draft PRs y templates

---

## Que es un Pull Request?

Un **Pull Request** (PR) es una solicitud para incorporar cambios de una branch a otra.

### Proposito

- Proponer cambios al codigo
- Facilitar code review
- Documentar cambios
- Discutir implementacion antes de merge

![Pull Request Workflow](../0-assets/02-pull-request-workflow.svg)

---

## Flujo de un Pull Request

### Pasos del Workflow

1. **Crear branch** desde main
2. **Hacer cambios** (commits)
3. **Push** branch al remote
4. **Abrir PR** en GitHub
5. **Code Review** por reviewers
6. **Resolver feedback** (mas commits si necesario)
7. **Aprobar** el PR
8. **Merge** a main
9. **Eliminar** branch (opcional)

---

## Crear un Pull Request

### Desde GitHub UI

1. Push tu branch al remote
2. Ve a tu repositorio en GitHub
3. Click en **Compare & pull request** (banner amarillo)
4. O ir a **Pull requests** > **New pull request**
5. Seleccionar base branch y compare branch
6. Completar titulo y descripcion
7. Click **Create pull request**

### Desde GitHub CLI

```bash
# Crear PR interactivo
gh pr create

# Crear PR con opciones
gh pr create --title "feat: add login" --body "Adds login functionality"

# Crear PR y abrir en browser
gh pr create --web

# Crear draft PR
gh pr create --draft
```

---

## Estructura de un Buen PR

### Titulo

Usar Conventional Commits:

```
feat: add user authentication
fix: resolve login timeout issue
docs: update API documentation
refactor: simplify validation logic
```

### Descripcion

```markdown
## Description

Brief description of what this PR does.

## Related Issue

Closes #42

## Type of Change

- [ ] Bug fix (non-breaking change that fixes an issue)
- [x] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Changes Made

- Added login form component
- Implemented JWT authentication
- Added unit tests for auth service

## How to Test

1. Clone this branch
2. Run `npm install`
3. Run `npm test`
4. Navigate to /login

## Screenshots (if applicable)

[images here]

## Checklist

- [x] My code follows the project's style guidelines
- [x] I have performed a self-review
- [x] I have commented my code where necessary
- [x] I have updated the documentation
- [x] My changes generate no new warnings
- [x] I have added tests
- [x] All tests pass locally
```

---

## Estados de un Pull Request

| Estado | Descripcion | Icono |
|--------|-------------|-------|
| **Draft** | Trabajo en progreso, no listo para review | Gris |
| **Open** | Listo para review | Verde |
| **Changes Requested** | Reviewer solicito cambios | Rojo |
| **Approved** | Reviewer aprobo | Verde check |
| **Merged** | Incorporado a base branch | Purpura |
| **Closed** | Cerrado sin merge | Rojo |

---

## Draft Pull Requests

PRs marcados como "trabajo en progreso".

### Cuando Usar Drafts

- Compartir progreso temprano
- Obtener feedback antes de completar
- Indicar que no esta listo para merge

### Crear Draft PR

```bash
# Desde CLI
gh pr create --draft

# Desde UI
Al crear PR, click "Create draft pull request"
```

### Convertir Draft a Ready

```bash
# Desde CLI
gh pr ready 123

# Desde UI
Click "Ready for review" en el PR
```

---

## Vincular con Issues

### Keywords para Cerrar Issues

En el titulo o descripcion del PR:

```markdown
Closes #42
Fixes #42
Resolves #42
```

### Multiples Issues

```markdown
This PR closes #42, fixes #15, and resolves #28
```

### Referencias sin Cerrar

```markdown
Related to #42
See #15
Part of #28
```

---

## Reviewers y Assignees

### Reviewers

Personas que revisaran el codigo:

- Solicitar review automaticamente con CODEOWNERS
- Agregar manualmente desde sidebar
- Minimo reviewers configurables en branch protection

### Assignees

Personas responsables del PR (usualmente el autor).

### CODEOWNERS

Archivo `.github/CODEOWNERS`:

```
# Syntax: path owner

# Default owner for everything
* @team-lead

# Frontend
/src/components/ @frontend-team
*.css @design-team

# Backend
/api/ @backend-team

# Documentation
/docs/ @docs-team
*.md @docs-team
```

---

## Merge Options

### Merge Commit

```
*   Merge pull request #42 from feature/login
|\
| * feat: add login form
| * feat: add auth service
|/
* Previous commit on main
```

- Preserva historial completo
- Crea commit de merge

### Squash and Merge

```
* feat: add user login (#42)
* Previous commit on main
```

- Combina todos los commits en uno
- Historial mas limpio

### Rebase and Merge

```
* feat: add auth service
* feat: add login form
* Previous commit on main
```

- Aplica commits linealmente
- Sin commit de merge

---

## PR Templates

### Ubicacion

```
.github/
└── PULL_REQUEST_TEMPLATE.md
```

### Ejemplo de Template

```markdown
## Description

<!-- Describe your changes in detail -->

## Related Issue

<!-- Link to the issue this PR addresses -->
Closes #

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation

## Checklist

- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Self-review completed
- [ ] No new warnings
```

---

## Comandos CLI Utiles

```bash
# Listar PRs
gh pr list

# Ver PR
gh pr view 42

# Checkout de un PR
gh pr checkout 42

# Ver diff
gh pr diff 42

# Aprobar PR
gh pr review 42 --approve

# Solicitar cambios
gh pr review 42 --request-changes --body "Need to add tests"

# Merge PR
gh pr merge 42

# Merge con squash
gh pr merge 42 --squash

# Cerrar PR sin merge
gh pr close 42
```

---

## Conflictos en PRs

### Cuando Ocurren

- Cambios en main afectan los mismos archivos
- GitHub muestra "This branch has conflicts"

### Resolver Conflictos

**Opcion 1: Desde GitHub UI**
1. Click "Resolve conflicts"
2. Editar archivos en el editor web
3. Mark as resolved
4. Commit merge

**Opcion 2: Localmente**

```bash
# Actualizar main
git checkout main
git pull origin main

# Ir a tu branch
git checkout feature/login

# Hacer rebase (o merge)
git rebase main

# Resolver conflictos
# Editar archivos
git add .
git rebase --continue

# Push forzado (si hiciste rebase)
git push --force-with-lease
```

---

## Branch Protection Rules

Configurar reglas para PRs en branches protegidas.

### Opciones Comunes

| Regla | Descripcion |
|-------|-------------|
| Require PR | No push directo, solo via PR |
| Require reviews | Minimo N aprobaciones |
| Dismiss stale reviews | Invalidar reviews si hay nuevos commits |
| Require status checks | CI debe pasar |
| Require linear history | Solo squash o rebase |
| Restrict who can push | Limitar quien puede merge |

---

## Ejercicio Practico

### Crear un PR Completo

1. Crear branch:
   ```bash
   git checkout -b feat/add-footer
   ```

2. Hacer cambios y commit:
   ```bash
   echo "<footer>Copyright 2025</footer>" >> index.html
   git add index.html
   git commit -m "feat: add footer with copyright"
   ```

3. Push:
   ```bash
   git push -u origin feat/add-footer
   ```

4. Crear PR:
   ```bash
   gh pr create --title "feat: add footer component" \
     --body "## Description
   Adds footer with copyright.
   
   Closes #10
   
   ## Checklist
   - [x] Code reviewed
   - [x] Tests pass"
   ```

---

## Resumen

| Concepto | Descripcion |
|----------|-------------|
| Pull Request | Solicitud de merge entre branches |
| Draft PR | PR en progreso, no listo |
| Reviewers | Quienes revisan el codigo |
| CODEOWNERS | Asignacion automatica de reviewers |
| Merge options | Merge, Squash, Rebase |
| Branch protection | Reglas para merges |

---

## Recursos Adicionales

- [GitHub Docs: Pull Requests](https://docs.github.com/en/pull-requests)
- [About CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)

---

[Siguiente leccion: Code Reviews](03-code-reviews.md)
