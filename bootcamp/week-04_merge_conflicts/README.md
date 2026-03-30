# Week 04: Merge Conflicts

## Objetivos de Aprendizaje

Al finalizar esta semana seras capaz de:

- Entender por que ocurren los merge conflicts y cuando aparecen
- Identificar la anatomia de un conflicto (marcadores, secciones)
- Resolver conflictos manualmente editando archivos
- Usar herramientas visuales de resolucion (VS Code, mergetool)
- Aplicar estrategias para prevenir y minimizar conflictos
- Manejar conflictos complejos con multiples archivos
- Abortar merges y recuperar estado anterior

---

## Requisitos Previos

- Completar Week 01 a Week 03
- Dominio de branches, merge y git switch/checkout
- Entender fast-forward vs three-way merge

---

## Estructura de la Semana

```
week-04/
├── README.md                 # Este archivo
├── rubrica-evaluacion.md     # Criterios de evaluacion
├── 0-assets/                 # Diagramas SVG
│   ├── 01-anatomia-conflicto.svg
│   ├── 02-tipos-conflictos.svg
│   ├── 03-proceso-resolucion.svg
│   └── 04-herramientas-merge.svg
├── 1-teoria/                 # Material teorico
│   ├── 01-que-son-conflictos.md
│   ├── 02-anatomia-marcadores.md
│   ├── 03-resolucion-manual.md
│   └── 04-herramientas-prevencion.md
├── 2-practicas/              # Ejercicios guiados
│   ├── ejercicio-01-conflicto-simple/
│   ├── ejercicio-02-multiples-archivos/
│   ├── ejercicio-03-vscode-mergetool/
│   └── ejercicio-04-abortar-reintentar/
├── 3-proyecto/               # Proyecto semanal
│   └── solution/             # Solucion (oculta en .gitignore)
├── 4-recursos/               # Material adicional
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/               # Terminos clave
```

---

## Contenidos

### Teoria

| Leccion | Tema | Duracion |
|---------|------|----------|
| [01-que-son-conflictos](1-teoria/01-que-son-conflictos.md) | Por que y cuando ocurren conflictos | 20 min |
| [02-anatomia-marcadores](1-teoria/02-anatomia-marcadores.md) | Estructura de marcadores de conflicto | 25 min |
| [03-resolucion-manual](1-teoria/03-resolucion-manual.md) | Editar y resolver conflictos manualmente | 25 min |
| [04-herramientas-prevencion](1-teoria/04-herramientas-prevencion.md) | Mergetool, VS Code y prevencion | 20 min |

### Practicas

| Ejercicio | Descripcion | Duracion |
|-----------|-------------|----------|
| [ejercicio-01](2-practicas/ejercicio-01-conflicto-simple/) | Provocar y resolver conflicto simple | 35 min |
| [ejercicio-02](2-practicas/ejercicio-02-multiples-archivos/) | Conflictos en multiples archivos | 40 min |
| [ejercicio-03](2-practicas/ejercicio-03-vscode-mergetool/) | Resolver con VS Code y mergetool | 40 min |
| [ejercicio-04](2-practicas/ejercicio-04-abortar-reintentar/) | Abortar merge y reintentar | 35 min |

### Proyecto

**Collaborative Conflict Resolution**: Simular trabajo en equipo donde multiples "desarrolladores" modifican los mismos archivos y practican resolucion de conflictos en un escenario realista.

---

## Distribucion del Tiempo

| Actividad | Tiempo | Porcentaje |
|-----------|--------|------------|
| Teoria | 1.5 horas | 25% |
| Practicas | 2.5 horas | 42% |
| Proyecto | 2 horas | 33% |
| **Total** | **6 horas** | 100% |

---

## Entregables

1. Repository con historial de merges con conflictos resueltos
2. Documentacion de al menos 5 conflictos resueltos (proceso y decision)
3. Configuracion de mergetool en Git local
4. Proyecto Collaborative Conflict completado

---

## Certificacion Asociada

| Certificacion | Temas Cubiertos |
|---------------|-----------------|
| **GitHub Foundations** | Merge conflicts, Conflict resolution, Collaboration workflows |

---

## Recursos de la Semana

- [Diagramas y assets](0-assets/)
- [Material teorico](1-teoria/)
- [Ejercicios practicos](2-practicas/)
- [Proyecto semanal](3-proyecto/)
- [Recursos adicionales](4-recursos/)
- [Glosario](5-glosario/)

---

## Navegacion

| Anterior | Inicio | Siguiente |
|:---------|:------:|----------:|
| [Week 03: Branching Basico](../week-03/) | [Bootcamp](../) | [Week 05: Remote Repositories](../week-05/) |

---

*Week 04 de 16 | Bootcamp Git/GitHub | Fase 1: GitHub Foundations*
