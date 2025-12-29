# 📖 Glosario - Semana 09

> Términos clave sobre Custom Actions y Advanced Workflows

---

## A

### Action
Unidad reutilizable de código que realiza una tarea específica en un workflow de GitHub Actions.

### action.yml
Archivo de metadatos obligatorio que define la interfaz de una Custom Action (inputs, outputs, runs).

### @actions/core
Paquete npm del Actions Toolkit que proporciona funciones para inputs, outputs, logging y manejo de errores.

### @actions/github
Paquete npm que proporciona un cliente Octokit autenticado y el contexto del evento de GitHub.

---

## B

### Branding
Sección de `action.yml` que define el icono y color para mostrar la action en GitHub Marketplace.

---

## C

### Callable Workflow
Workflow que puede ser llamado por otros workflows. Define `on: workflow_call`.

### Caller Workflow
Workflow que llama a un reusable workflow usando la sintaxis `uses:` a nivel de job.

### client_payload
Objeto JSON personalizado enviado con un evento `repository_dispatch` que contiene datos arbitrarios.

### Composite Action
Tipo de action que agrupa múltiples steps en YAML sin necesidad de código JavaScript o Docker.

---

## D

### Docker Action
Tipo de action que ejecuta código dentro de un container Docker. Soporta cualquier lenguaje.

### Dispatch
Evento que permite triggear workflows manualmente (`workflow_dispatch`) o externamente (`repository_dispatch`).

---

## I

### Inputs
Parámetros que una action o workflow recibe. Se acceden con `core.getInput()` o `${{ inputs.name }}`.

---

## J

### JavaScript Action
Tipo de action que ejecuta código Node.js directamente en el runner sin container.

---

## N

### ncc (@vercel/ncc)
Compilador que empaqueta código Node.js y sus dependencias en un solo archivo para distribución.

---

## O

### Octokit
Cliente oficial de GitHub para interactuar con la API REST y GraphQL.

### Outputs
Valores que una action o job expone para ser usados por steps o jobs posteriores.

---

## R

### repository_dispatch
Evento que permite triggear workflows desde sistemas externos via API REST de GitHub.

### Reusable Workflow
Workflow que define `on: workflow_call` y puede ser invocado desde otros workflows.

### runs.using
Campo en `action.yml` que especifica cómo ejecutar la action: `node20`, `composite`, o `docker`.

---

## S

### secrets: inherit
Sintaxis en caller workflows que pasa automáticamente todos los secrets al reusable workflow.

### setFailed()
Función de `@actions/core` que marca la action como fallida y muestra un mensaje de error.

### setOutput()
Función de `@actions/core` que define un valor de output accesible por otros steps.

---

## W

### workflow_call
Trigger que convierte un workflow en reutilizable, permitiendo que otros workflows lo invoquen.

### workflow_dispatch
Trigger que permite ejecutar un workflow manualmente desde la UI de GitHub o via API.

---

## Tabla Resumen

| Término | Tipo | Descripción Corta |
|---------|------|-------------------|
| JavaScript Action | Action | Node.js, más rápida |
| Composite Action | Action | Solo YAML, sin código |
| Docker Action | Action | Container, cualquier lenguaje |
| workflow_call | Trigger | Hace workflow reutilizable |
| workflow_dispatch | Trigger | Ejecución manual |
| repository_dispatch | Trigger | Trigger externo via API |
| @actions/core | Paquete | Inputs, outputs, logging |
| @actions/github | Paquete | Octokit + context |

---

[⬅️ Volver a Semana 09](../README.md)
