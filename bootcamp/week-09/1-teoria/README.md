# 📚 Material Teórico - Semana 09

> Custom Actions y Advanced Workflows - 1.5 horas (25% del tiempo)

---

## 📋 Índice de Lecciones

| # | Lección | Duración | Descripción |
|---|---------|----------|-------------|
| 01 | [Introducción a Custom Actions](01-custom-actions-intro.md) | 20 min | Tipos de actions, cuándo usar cada una, estructura básica |
| 02 | [JavaScript Actions](02-javascript-actions.md) | 25 min | @actions/core, @actions/github, compilación con ncc |
| 03 | [Composite Actions](03-composite-actions.md) | 25 min | Actions en YAML puro, reutilización de steps |
| 04 | [Reusable Workflows y Dispatch Events](04-reusable-workflows.md) | 20 min | workflow_call, workflow_dispatch, repository_dispatch |

---

## 🎯 Objetivos del Módulo Teórico

Al completar estas lecciones podrás:

- [x] Diferenciar los 3 tipos de Custom Actions (JavaScript, Composite, Docker)
- [x] Crear JavaScript Actions con el Actions Toolkit
- [x] Desarrollar Composite Actions sin necesidad de código
- [x] Implementar Reusable Workflows para compartir entre repos
- [x] Configurar triggers manuales y externos

---

## 📊 Mapa de Contenidos

```
Custom Actions
├── JavaScript Actions
│   ├── @actions/core
│   │   ├── getInput() / setOutput()
│   │   ├── info() / warning() / error()
│   │   └── setFailed()
│   ├── @actions/github
│   │   ├── getOctokit()
│   │   └── context
│   └── Compilación (ncc)
│
├── Composite Actions
│   ├── runs.using: composite
│   ├── Steps con shell obligatorio
│   └── Reutilización de actions
│
└── Reusable Workflows
    ├── workflow_call (trigger)
    ├── inputs / outputs / secrets
    └── secrets: inherit
    
Dispatch Events
├── workflow_dispatch
│   ├── Inputs: string, choice, boolean, environment
│   └── UI manual en GitHub
└── repository_dispatch
    ├── types: [custom-events]
    └── client_payload
```

---

## 🔗 Diagramas de Apoyo

Los siguientes diagramas complementan el material teórico:

| Diagrama | Ubicación | Usado en |
|----------|-----------|----------|
| Tipos de Custom Actions | [01-custom-actions-types.svg](../0-assets/01-custom-actions-types.svg) | Lección 01 |
| Arquitectura de una Action | [02-action-architecture.svg](../0-assets/02-action-architecture.svg) | Lecciones 01, 02 |
| Reusable Workflows | [03-reusable-workflows.svg](../0-assets/03-reusable-workflows.svg) | Lección 04 |
| Dispatch Events | [04-dispatch-events.svg](../0-assets/04-dispatch-events.svg) | Lección 04 |

---

## 📖 Orden de Estudio Recomendado

```
1. Leer Lección 01 (Introducción)
   ↓
2. Ver diagrama 01-custom-actions-types.svg
   ↓
3. Leer Lección 02 (JavaScript)
   ↓
4. Ver diagrama 02-action-architecture.svg
   ↓
5. Leer Lección 03 (Composite)
   ↓
6. Leer Lección 04 (Reusable + Dispatch)
   ↓
7. Ver diagramas 03 y 04
   ↓
8. Ir a Ejercicios Prácticos
```

---

## ⏭️ Siguiente Paso

Una vez completada la teoría, practica con los ejercicios guiados:

[🏋️ Ir a Ejercicios →](../2-practicas/README.md)

---

[⬅️ Volver a Semana 09](../README.md) · [📁 Assets](../0-assets/)
