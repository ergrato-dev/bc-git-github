# Week 06: GitHub Features

Semana final de la Fase 1 - Dominando la colaboracion en GitHub.

---

## Objetivos de Aprendizaje

Al finalizar esta semana seras capaz de:

- Crear y gestionar Issues con labels, milestones y assignees
- Dominar el flujo completo de Pull Requests
- Realizar Code Reviews profesionales
- Usar GitHub Projects para gestion de proyectos
- Configurar templates de Issue y PR

---

## Requisitos Previos

- Completar Week 01 a Week 05
- Cuenta de GitHub activa
- Experiencia con remote repositories, push, pull, fork

---

## Estructura de la Semana

```
week-06/
├── README.md                 # Este archivo
├── rubrica-evaluacion.md     # Criterios de evaluacion
├── 0-assets/                 # Diagramas SVG
├── 1-teoria/                 # 4 lecciones teoricas
├── 2-practicas/              # 4 ejercicios guiados
├── 3-proyecto/               # Open Source Simulation
├── 4-recursos/               # Material adicional
└── 5-glosario/               # Terminos clave
```

---

## Contenidos

### Teoria (4 lecciones)

| Leccion | Tema | Duracion |
|---------|------|----------|
| 01 | GitHub Issues | 25 min |
| 02 | Pull Requests | 25 min |
| 03 | Code Reviews | 20 min |
| 04 | GitHub Projects | 20 min |

### Practicas (4 ejercicios)

| Ejercicio | Descripcion | Duracion |
|-----------|-------------|----------|
| 01 | Gestion de Issues | 35 min |
| 02 | Pull Request completo | 40 min |
| 03 | Code Review workflow | 35 min |
| 04 | Project board + Templates | 40 min |

### Proyecto

**Open Source Simulation** - Simular contribucion a proyecto open source con Issues, Fork, Pull Request y Code Review.

---

## Distribucion del Tiempo (6 horas)

| Actividad | Tiempo | Porcentaje |
|-----------|--------|------------|
| Teoria | 1.5 horas | 25% |
| Practicas | 2.5 horas | 42% |
| Proyecto | 2 horas | 33% |

---

## Entregables

1. Repository con minimo 5 Issues documentados
2. Pull Request con code review completado
3. Project board configurado con columnas
4. Templates de Issue y PR implementados
5. Proyecto open source simulation completado

---

## Referencia Rapida

### Issues

```markdown
# Crear Issue desde CLI (GitHub CLI)
gh issue create --title "Bug: login fails" --body "Description" --label "bug"

# Listar Issues
gh issue list

# Ver Issue especifico
gh issue view 123
```

### Pull Requests

```bash
# Crear PR desde CLI
gh pr create --title "feat: add login" --body "Description"

# Listar PRs
gh pr list

# Revisar PR
gh pr checkout 123
gh pr review --approve
```

### Projects

```markdown
# Acceso: Repository > Projects > New project

Columnas tipicas:
- Backlog
- To Do
- In Progress
- In Review
- Done
```

---

## Certificacion Asociada

**GitHub Foundations** - Esta semana completa la Fase 1 del bootcamp:

| Dominio | Temas Week 06 |
|---------|---------------|
| Domain 2: Working with GitHub Repositories | Issues, Projects |
| Domain 3: Collaboration Features | Pull Requests, Code Reviews |
| Domain 6: GitHub Community | Discussions, Templates |

---

## Navegacion

| Anterior | Inicio | Siguiente |
|:---------|:------:|----------:|
| [Week 05](../week-05/README.md) | [Bootcamp](../README.md) | [Week 07](../week-07/README.md) |

---

*Week 06 | Bootcamp Git/GitHub*
