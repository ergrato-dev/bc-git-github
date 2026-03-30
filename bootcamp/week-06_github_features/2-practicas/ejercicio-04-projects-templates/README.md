# Ejercicio 04: Projects y Templates

## Descripcion

Configurar un GitHub Project completo y crear templates para estandarizar Issues y PRs.

**Duracion estimada:** 40 minutos

---

## Objetivos

- Crear GitHub Project con multiples vistas
- Configurar campos personalizados
- Agregar automatizaciones
- Crear templates avanzados (Issue forms)
- Integrar todo el workflow

---

## Requisitos Previos

- Completar ejercicios anteriores
- Repositorio con Issues y PRs
- Cuenta de GitHub con acceso a Projects

---

## Parte 1: Crear GitHub Project (10 min)

### Paso 1.1: Crear proyecto nuevo

1. Ir a tu perfil de GitHub
2. Click pestaña **Projects**
3. Click **New project**
4. Seleccionar **Board** template
5. Nombre: `Issue Practice Board`
6. Click **Create**

### Paso 1.2: Configurar columnas

Por defecto tendras: Todo, In Progress, Done

Agregar columnas adicionales:

1. Click **+** al final de las columnas
2. Agregar: **Backlog**
3. Agregar: **In Review**

Reordenar (drag & drop):
- Backlog | Todo | In Progress | In Review | Done

### Paso 1.3: Agregar campos personalizados

1. Click **+** en el header de cualquier columna
2. Agregar campo **Priority**:
   - Tipo: Single select
   - Opciones: `Low`, `Medium`, `High`, `Critical`
   - Colores: Verde, Amarillo, Naranja, Rojo

3. Agregar campo **Story Points**:
   - Tipo: Number
   - Para estimacion de esfuerzo

4. Agregar campo **Sprint**:
   - Tipo: Iteration
   - Duracion: 2 weeks
   - Crear: Sprint 1, Sprint 2

---

## Parte 2: Agregar Items al Project (5 min)

### Paso 2.1: Agregar Issues existentes

1. Click **+ Add item** en columna Backlog
2. Buscar por `#` los Issues de tu repositorio
3. Agregar todos los Issues disponibles

### Paso 2.2: Crear Draft items

1. Click **+ Add item**
2. Escribir directamente (sin `#`):
   - "Investigar libreria de testing"
   - "Configurar CI/CD pipeline"
   - "Documentar API"

### Paso 2.3: Asignar valores

Para cada item:
1. Click en el item
2. En sidebar, asignar:
   - Priority
   - Story Points (1, 2, 3, 5, 8)
   - Sprint

---

## Parte 3: Crear Vistas Adicionales (5 min)

### Paso 3.1: Vista de Tabla

1. Click **+ New view**
2. Seleccionar **Table**
3. Nombrar: "Sprint Planning"
4. Configurar columnas visibles:
   - Title, Status, Priority, Story Points, Sprint, Assignee

### Paso 3.2: Vista filtrada

1. Click **+ New view**
2. Seleccionar **Board**
3. Nombrar: "My Tasks"
4. Agregar filtro: `assignee:@me`
5. Guardar vista

### Paso 3.3: Vista de Roadmap (si disponible)

1. Click **+ New view**
2. Seleccionar **Roadmap**
3. Nombrar: "Timeline"
4. Configurar Date field si tienes fechas

---

## Parte 4: Configurar Automatizaciones (5 min)

### Paso 4.1: Acceder a Workflows

1. Click **...** (menu del proyecto)
2. Click **Workflows**

### Paso 4.2: Activar workflows

Activar los siguientes:

| Workflow | Configuracion |
|----------|---------------|
| Item added to project | Set Status = Backlog |
| Item reopened | Set Status = Todo |
| Item closed | Set Status = Done |
| Pull request merged | Set Status = Done |
| Code review approved | Set Status = In Review |

### Paso 4.3: Probar automatizacion

1. Crear nuevo Issue en el repositorio
2. Agregar al proyecto
3. Verificar que Status = Backlog automaticamente
4. Cerrar el Issue
5. Verificar que Status = Done

---

## Parte 5: Templates Avanzados - Issue Forms (10 min)

### Paso 5.1: Crear Issue Form (YAML)

```bash
cd issue-practice

# Crear config para Issue templates
cat > .github/ISSUE_TEMPLATE/config.yml << 'EOF'
blank_issues_enabled: false
contact_links:
  - name: Documentation
    url: https://github.com/tu-usuario/issue-practice#readme
    about: Check the documentation before opening an issue
EOF
```

### Paso 5.2: Bug Report Form

```bash
cat > .github/ISSUE_TEMPLATE/bug-report.yml << 'EOF'
name: Bug Report
description: Report a bug to help us improve
title: "[BUG] "
labels: ["bug", "triage"]
assignees: []
body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to fill out this bug report!
        
  - type: input
    id: version
    attributes:
      label: Version
      description: What version are you running?
      placeholder: ex. 1.0.0
    validations:
      required: true
      
  - type: dropdown
    id: severity
    attributes:
      label: Severity
      description: How severe is this bug?
      options:
        - Critical - App crashes
        - High - Feature broken
        - Medium - Feature impaired
        - Low - Minor issue
    validations:
      required: true
      
  - type: textarea
    id: description
    attributes:
      label: Bug Description
      description: A clear description of the bug
      placeholder: Describe what happened
    validations:
      required: true
      
  - type: textarea
    id: steps
    attributes:
      label: Steps to Reproduce
      description: How can we reproduce this issue?
      placeholder: |
        1. Go to '...'
        2. Click on '...'
        3. See error
    validations:
      required: true
      
  - type: textarea
    id: expected
    attributes:
      label: Expected Behavior
      description: What did you expect to happen?
    validations:
      required: true
      
  - type: dropdown
    id: os
    attributes:
      label: Operating System
      options:
        - Windows
        - macOS
        - Linux
        - Other
    validations:
      required: true
      
  - type: dropdown
    id: browser
    attributes:
      label: Browser
      options:
        - Chrome
        - Firefox
        - Safari
        - Edge
        - Other
    validations:
      required: false
      
  - type: textarea
    id: logs
    attributes:
      label: Relevant Log Output
      description: Please paste any relevant log output
      render: shell
      
  - type: checkboxes
    id: checklist
    attributes:
      label: Checklist
      options:
        - label: I have searched for existing issues
          required: true
        - label: I have provided all required information
          required: true
EOF
```

### Paso 5.3: Feature Request Form

```bash
cat > .github/ISSUE_TEMPLATE/feature-request.yml << 'EOF'
name: Feature Request
description: Suggest a new feature
title: "[FEAT] "
labels: ["enhancement"]
body:
  - type: markdown
    attributes:
      value: |
        Thanks for suggesting a feature!
        
  - type: textarea
    id: problem
    attributes:
      label: Problem Statement
      description: What problem does this feature solve?
      placeholder: I'm always frustrated when...
    validations:
      required: true
      
  - type: textarea
    id: solution
    attributes:
      label: Proposed Solution
      description: Describe your ideal solution
    validations:
      required: true
      
  - type: textarea
    id: alternatives
    attributes:
      label: Alternatives Considered
      description: Other solutions you've thought about
      
  - type: dropdown
    id: priority
    attributes:
      label: Priority
      description: How important is this feature to you?
      options:
        - Nice to have
        - Important
        - Critical for my use case
    validations:
      required: true
      
  - type: checkboxes
    id: contribution
    attributes:
      label: Contribution
      options:
        - label: I would be willing to help implement this feature
EOF
```

### Paso 5.4: Commit y push

```bash
git add .github/
git commit -m "docs: add advanced issue form templates"
git push origin main
```

### Paso 5.5: Probar templates

1. Ir a **Issues** > **New issue**
2. Ver los nuevos formularios
3. Crear un Issue usando el Bug Report form
4. Verificar que los campos se muestran correctamente

---

## Parte 6: PR Template Completo (5 min)

```bash
cat > .github/PULL_REQUEST_TEMPLATE.md << 'EOF'
## Description

<!-- Describe your changes in detail -->

## Related Issue

<!-- Link to the issue this PR addresses -->
Closes #

## Type of Change

<!-- Mark with an `x` the type that applies -->

- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to change)
- [ ] 📚 Documentation update
- [ ] 🔧 Configuration change
- [ ] ♻️ Refactoring (no functional changes)

## How Has This Been Tested?

<!-- Describe the tests you ran -->

- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing

## Screenshots (if applicable)

<!-- Add screenshots to help explain your changes -->

## Checklist

<!-- Mark with an `x` all that apply -->

- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published

## Additional Notes

<!-- Any additional information that reviewers should know -->
EOF

git add .github/PULL_REQUEST_TEMPLATE.md
git commit -m "docs: add comprehensive PR template"
git push origin main
```

---

## Verificacion Final

### Project Board Checklist

- [ ] Proyecto creado con 5 columnas
- [ ] 3 campos personalizados (Priority, Story Points, Sprint)
- [ ] 3+ vistas configuradas (Board, Table, Filtered)
- [ ] Automatizaciones activadas
- [ ] Items agregados y organizados

### Templates Checklist

- [ ] Bug Report form (YAML) funcionando
- [ ] Feature Request form funcionando
- [ ] PR template creado
- [ ] Config.yml deshabilitando blank issues

### Comandos de Verificacion

```bash
# Ver estructura de templates
ls -la .github/ISSUE_TEMPLATE/

# Ver proyectos (requiere gh extension)
gh project list

# Crear Issue usando template
gh issue create --template bug-report.yml
```

---

## Reto Extra

### 1. Agregar mas tipos de Issue

- Question template
- Documentation request template

### 2. GitHub Project Insights

1. Ir a Project > Insights
2. Ver metricas de items
3. Configurar graficos

### 3. Automatizacion con GitHub Actions

```yaml
# .github/workflows/project-automation.yml
name: Add to Project

on:
  issues:
    types: [opened]

jobs:
  add-to-project:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/add-to-project@v0.5.0
        with:
          project-url: https://github.com/users/TU-USUARIO/projects/1
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

---

## Resumen del Workflow Completo

```
1. Issue creado (via form template)
   ↓
2. Automaticamente agregado al Project (Backlog)
   ↓
3. Asignar Priority, Story Points, Sprint
   ↓
4. Mover a Todo cuando listo para trabajar
   ↓
5. Crear branch y PR (usando PR template)
   ↓
6. PR vinculado al Issue
   ↓
7. Code Review (In Review en Project)
   ↓
8. Merge PR → Issue cerrado → Done en Project
```

---

## Recursos

- [GitHub Projects Docs](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Issue Forms Syntax](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms)
- [Configuring Issue Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository)

---

[Anterior: Code Review](../ejercicio-03-code-review/README.md) | [Volver a Ejercicios](../README.md)
