# Week 05: Remote Repositories

## Descripcion General

Semana dedicada a dominar el trabajo con repositories remotos. Aprenderemos la arquitectura distribuida de Git, como sincronizar cambios entre local y remoto, y las mejores practicas para colaboracion en equipo.

**Duracion:** 6 horas

---

## Objetivos de Aprendizaje

Al finalizar esta semana seras capaz de:

- Comprender la arquitectura distribuida de Git (local vs remoto)
- Configurar y gestionar multiples remotes (origin, upstream)
- Dominar los comandos push, pull y fetch
- Entender la diferencia entre pull y fetch + merge
- Trabajar con tracking branches
- Sincronizar branches locales con remotos
- Colaborar efectivamente usando fork workflow

---

## Requisitos Previos

- Completar Weeks 01-04 del bootcamp
- Cuenta de GitHub activa y configurada
- SSH keys configuradas con GitHub
- Git instalado y configurado localmente

---

## Contenidos

### Teoria (1.5 horas - 25%)

| Leccion | Tema | Archivo |
|---------|------|---------|
| 01 | Arquitectura Distribuida | [01-arquitectura-distribuida.md](1-teoria/01-arquitectura-distribuida.md) |
| 02 | Git Remote y Clone | [02-remote-clone.md](1-teoria/02-remote-clone.md) |
| 03 | Push - Enviar Cambios | [03-git-push.md](1-teoria/03-git-push.md) |
| 04 | Pull vs Fetch | [04-pull-vs-fetch.md](1-teoria/04-pull-vs-fetch.md) |

### Practicas (2.5 horas - 42%)

| Ejercicio | Tema | Duracion |
|-----------|------|----------|
| 01 | Clonar y Configurar Remotes | 35 min |
| 02 | Push y Pull Basico | 35 min |
| 03 | Fetch y Merge Manual | 40 min |
| 04 | Fork Workflow (origin + upstream) | 40 min |

### Proyecto (2 horas - 33%)

**Team Sync Simulation**: Simular trabajo en equipo con repository compartido, sincronizacion de cambios entre multiples "desarrolladores" y resolucion de divergencias.

---

## Distribucion del Tiempo

```
Semana 05: Remote Repositories (6 horas)
============================================

Teoria          [======]           1.5h (25%)
Practicas       [==========]       2.5h (42%)
Proyecto        [========]         2.0h (33%)

Total: 6 horas
```

---

## Estructura de Carpetas

```
week-05/
├── README.md                      # Este archivo
├── rubrica-evaluacion.md          # Criterios de evaluacion
├── 0-assets/                      # Diagramas SVG
│   ├── 01-arquitectura-local-remote.svg
│   ├── 02-flujo-push-pull-fetch.svg
│   ├── 03-tracking-branches.svg
│   └── 04-fork-workflow.svg
├── 1-teoria/                      # Lecciones teoricas
│   ├── 01-arquitectura-distribuida.md
│   ├── 02-remote-clone.md
│   ├── 03-git-push.md
│   └── 04-pull-vs-fetch.md
├── 2-practicas/                   # Ejercicios guiados
│   ├── ejercicio-01-clonar-remotes/
│   ├── ejercicio-02-push-pull/
│   ├── ejercicio-03-fetch-merge/
│   └── ejercicio-04-fork-workflow/
├── 3-proyecto/                    # Proyecto semanal
├── 4-recursos/                    # Material adicional
└── 5-glosario/                    # Terminos clave
```

---

## Entregables

| Entregable | Descripcion | Puntos |
|------------|-------------|--------|
| Ejercicios | 4 ejercicios completados | 30 |
| Proyecto | Team Sync Simulation | 40 |
| Documentacion | README con comandos usados | 15 |
| Configuracion | Remotes configurados correctamente | 15 |

---

## Comandos Clave de la Semana

```bash
# Remotes
git remote -v                    # Ver remotes configurados
git remote add origin <url>      # Agregar remote
git remote remove <name>         # Eliminar remote

# Clonar
git clone <url>                  # Clonar repository
git clone <url> <folder>         # Clonar en carpeta especifica

# Push
git push origin main             # Enviar a origin/main
git push -u origin main          # Establecer upstream
git push --force                 # Forzar (PELIGROSO)

# Pull y Fetch
git pull origin main             # Traer y merge
git fetch origin                 # Solo traer
git fetch --all                  # Traer de todos los remotes

# Tracking
git branch -vv                   # Ver tracking branches
git branch -u origin/main        # Establecer upstream
```

---

## Certificacion Asociada

**GitHub Foundations Certification**

Esta semana cubre los siguientes temas del examen:
- Domain 3: Collaboration Features
- Remote repositories
- Push, pull, fetch operations
- Fork and clone workflows

---

## Navegacion

| Seccion | Enlace |
|---------|--------|
| Anterior | [Week 04: Merge Conflicts](../week-04/README.md) |
| Siguiente | [Week 06: GitHub Features](../week-06/README.md) |
| Indice | [Bootcamp](../README.md) |

---

*Week 05 | Bootcamp Git/GitHub*
