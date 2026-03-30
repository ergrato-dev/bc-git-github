# Leccion 04: GitHub Projects

## Objetivos de Aprendizaje

Al finalizar esta leccion seras capaz de:

- Crear y configurar GitHub Projects
- Usar tableros Kanban para gestion
- Configurar vistas y campos personalizados
- Automatizar flujos de trabajo
- Integrar Projects con Issues y PRs

---

## Que es GitHub Projects?

**GitHub Projects** es una herramienta de gestion de proyectos integrada con GitHub.

### Caracteristicas

- Tableros Kanban
- Vistas personalizables (tabla, board, roadmap)
- Campos personalizados
- Automatizaciones
- Integracion con Issues y PRs

![GitHub Projects Board](../0-assets/04-github-projects-board.svg)

---

## Tipos de Projects

### Project (New)

- Interfaz moderna
- Multiples vistas
- Campos personalizados
- Automatizaciones avanzadas
- Puede incluir items de multiples repos

### Project (Classic) - Deprecated

- Tablero Kanban simple
- Limitado a un repositorio
- Sin campos personalizados
- Ya no recomendado

---

## Crear un Project

### Desde GitHub UI

1. Ir a tu perfil o repositorio
2. Click pestaña **Projects**
3. Click **New project**
4. Seleccionar template o empezar en blanco
5. Nombrar el proyecto
6. Click **Create**

### Templates Disponibles

| Template | Descripcion |
|----------|-------------|
| **Kanban** | Tablero con To do, In progress, Done |
| **Team planning** | Para planificacion de equipo |
| **Bug tracker** | Seguimiento de bugs |
| **Feature** | Desarrollo de features |
| **Roadmap** | Vista de linea de tiempo |

---

## Anatomia de un Project

### Componentes

| Componente | Descripcion |
|------------|-------------|
| **Items** | Issues, PRs o notas (drafts) |
| **Fields** | Campos de datos (status, prioridad, etc.) |
| **Views** | Formas de visualizar (board, table, roadmap) |
| **Filters** | Filtrar items por criterios |
| **Groups** | Agrupar items por campo |

---

## Vistas (Views)

### Board View (Tablero)

Vista Kanban con columnas por status.

```
| Backlog | To Do | In Progress | Done |
|---------|-------|-------------|------|
| #15     | #12   | #10         | #8   |
| #18     | #14   |             | #5   |
| #22     |       |             |      |
```

### Table View (Tabla)

Vista de hoja de calculo.

| Title | Status | Priority | Assignee | Due Date |
|-------|--------|----------|----------|----------|
| #10 Login | In Progress | High | @pedro | Jan 15 |
| #12 Navbar | To Do | Medium | @maria | Jan 20 |

### Roadmap View

Vista de linea de tiempo (timeline).

```
Jan -------- Feb -------- Mar --------
[======= #10 Login =======]
           [==== #15 Auth ====]
                    [=== #20 Deploy ===]
```

---

## Campos (Fields)

### Campos Predeterminados

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| Title | Text | Titulo del item |
| Assignees | People | Responsables |
| Status | Single select | Estado actual |
| Labels | Labels | Etiquetas |
| Repository | Repository | Repo de origen |

### Campos Personalizados

| Tipo | Ejemplo |
|------|---------|
| **Text** | Notas, descripcion |
| **Number** | Story points, estimacion |
| **Date** | Fecha limite, fecha inicio |
| **Single select** | Prioridad, categoria |
| **Iteration** | Sprint, ciclo |

### Crear Campo Personalizado

1. Click **+** en header de tabla
2. Seleccionar tipo de campo
3. Nombrar el campo
4. Configurar opciones (para single select)

---

## Agregar Items

### Desde el Project

1. Click **+ Add item** en columna o tabla
2. Buscar Issue/PR existente
3. O crear **Draft** (nota)

### Desde un Issue/PR

1. Abrir el Issue o PR
2. En sidebar, seccion **Projects**
3. Seleccionar el proyecto
4. Opcionalmente asignar status

### Convertir Draft a Issue

1. Click en el draft
2. Click **Convert to issue**
3. Seleccionar repositorio
4. Confirmar

---

## Filtros

### Sintaxis de Filtros

```
status:Todo                    # Por status
assignee:@me                   # Asignados a mi
label:bug                      # Con label
is:issue                       # Solo Issues
is:pr                          # Solo PRs
is:open                        # Abiertos
is:closed                      # Cerrados
-status:Done                   # Excluir Done
priority:High,Medium           # Multiples valores
```

### Guardar Vistas Filtradas

1. Aplicar filtro
2. Click nombre de la vista
3. Click **Save changes** o **Save as new view**

---

## Automatizaciones

### Workflows Integrados

| Workflow | Accion |
|----------|--------|
| Item added | Cuando se agrega item |
| Item reopened | Cuando se reabre |
| Item closed | Cuando se cierra |
| Code changes requested | Cuando se solicitan cambios |
| Code review approved | Cuando se aprueba PR |
| Pull request merged | Cuando se hace merge |

### Configurar Automatizacion

1. Click **...** menu del proyecto
2. Click **Workflows**
3. Activar workflows deseados
4. Configurar acciones

### Ejemplo: Auto-mover Items

```yaml
When: Pull request merged
Then: Set Status to "Done"

When: Issue opened
Then: Add to project, Set Status to "Backlog"

When: Code review approved
Then: Set Status to "Ready to merge"
```

---

## Integracion con GitHub CLI

```bash
# Listar proyectos
gh project list

# Ver proyecto
gh project view 1

# Agregar Issue a proyecto
gh project item-add 1 --owner @me --url https://github.com/user/repo/issues/42

# Crear draft
gh project item-create 1 --owner @me --title "New task"

# Editar item
gh project item-edit --id ITEM_ID --field-id FIELD_ID --text "value"
```

---

## Mejores Practicas

### Estructura de Columnas

**Basico:**
- Backlog
- To Do
- In Progress
- Done

**Avanzado:**
- Backlog
- Ready
- In Progress
- In Review
- QA
- Done

### Limites WIP (Work In Progress)

Limitar items por columna para evitar sobrecarga:

- In Progress: Max 3 items por persona
- In Review: Max 5 items total

### Reviews Regulares

- **Daily standup**: Revisar In Progress
- **Weekly planning**: Mover de Backlog a To Do
- **Sprint review**: Revisar Done, mover a Backlog

---

## Project Insights

### Metricas Disponibles

- Items por status
- Burndown chart
- Velocity
- Cycle time

### Acceder a Insights

1. Abrir proyecto
2. Click **Insights** en menu
3. Ver graficos y metricas

---

## Templates de Proyecto

### Crear Template

1. Configurar proyecto ideal
2. Guardar como template de organizacion

### Usar Template

1. Al crear nuevo proyecto
2. Seleccionar template guardado
3. Personalizar segun necesidad

---

## Ejercicio Practico

### Crear Project Board Completo

1. **Crear proyecto:**
   - Ir a tu perfil > Projects > New project
   - Usar template "Kanban"
   - Nombre: "Mi Proyecto Web"

2. **Configurar columnas:**
   - Backlog
   - To Do
   - In Progress
   - In Review
   - Done

3. **Agregar campos personalizados:**
   - Priority (Single select): Low, Medium, High
   - Story Points (Number)
   - Due Date (Date)

4. **Agregar items:**
   - 3 Issues de tu repositorio
   - 2 Drafts (notas)

5. **Configurar automatizaciones:**
   - Issue closed → Done
   - PR merged → Done

6. **Crear vista adicional:**
   - Nueva vista tipo Table
   - Filtrar por `assignee:@me`

---

## Resumen

| Concepto | Descripcion |
|----------|-------------|
| Project | Herramienta de gestion integrada |
| Views | Board, Table, Roadmap |
| Fields | Campos de datos personalizables |
| Workflows | Automatizaciones de estado |
| Filters | Filtrar y agrupar items |

---

## Recursos Adicionales

- [GitHub Docs: Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Project Quickstart](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/quickstart-for-projects)
- [Project Best Practices](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/best-practices-for-projects)

---

[Volver al README de la semana](../README.md)
