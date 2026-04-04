# 🏋️ Ejercicio 01: Mi Primera JavaScript Action

> **Duración estimada**: 40 minutos  
> **Dificultad**: Intermedia  
> **Prerequisitos**: Lección 02 - JavaScript Actions

---

## 🎯 Objetivo

Crear una JavaScript Action completa que salude al usuario, registre el timestamp y demuestre el uso de inputs, outputs y el Actions Toolkit.

---

## 📋 Lo que aprenderás

- [ ] Estructura de archivos de una JavaScript Action
- [ ] Uso de `@actions/core` para inputs/outputs
- [ ] Uso de `@actions/github` para contexto
- [ ] Compilación con `@vercel/ncc`
- [ ] Testing local de la action

---

## 📁 Estructura Final

```
ejercicio-01-javascript-action/
├── action.yml
├── package.json
├── src/
│   └── index.js
├── dist/
│   └── index.js (generado)
└── .gitignore
```

---

## 🚀 Pasos del Ejercicio

### Paso 1: Crear la estructura del proyecto

```bash
# ¿Qué hace?: Crea el directorio para nuestra action
# ¿Por qué?: Necesitamos una carpeta dedicada para el código
# ¿Para qué sirve?: Organizar los archivos de la action

mkdir -p mi-primera-action/src
cd mi-primera-action
```

---

### Paso 2: Inicializar el proyecto npm

```bash
# ¿Qué hace?: Crea el archivo package.json
# ¿Por qué?: Necesitamos gestionar dependencias npm
# ¿Para qué sirve?: Definir el proyecto y sus dependencias

npm init -y
```

---

### Paso 3: Instalar dependencias

```bash
# ¿Qué hace?: Instala el Actions Toolkit y el compilador
# ¿Por qué?: Son las librerías necesarias para crear la action
# ¿Para qué sirve?: Acceder a inputs, outputs y compilar el código

# Dependencias de producción
npm install @actions/core @actions/github

# Dependencias de desarrollo
npm install --save-dev @vercel/ncc
```

---

### Paso 4: Crear el archivo action.yml

Crea el archivo `action.yml` en la raíz:

```yaml
# action.yml
# ========================================
# METADATA DE LA ACTION
# ========================================
# ¿Qué hace?: Define la interfaz pública de la action
# ¿Por qué?: GitHub necesita saber cómo ejecutar la action
# ¿Para qué sirve?: Otros workflows pueden usar esta action

name: "Hello World Greeter"
description: "Una action que saluda y registra información del evento"
author: "Tu Nombre"

# ========================================
# INPUTS - Parámetros de entrada
# ========================================
inputs:
  who-to-greet:
    description: "Nombre de la persona a saludar"
    required: true
    default: "World"

  include-emoji:
    description: "Incluir emoji en el saludo"
    required: false
    default: "true"

# ========================================
# OUTPUTS - Valores de salida
# ========================================
outputs:
  greeting:
    description: "El mensaje de saludo generado"

  timestamp:
    description: "Momento en que se ejecutó el saludo"

  event-info:
    description: "Información del evento que triggereó la action"

# ========================================
# RUNS - Configuración de ejecución
# ========================================
runs:
  using: "node20"
  main: "dist/index.js"

# ========================================
# BRANDING - Para GitHub Marketplace
# ========================================
branding:
  icon: "message-circle"
  color: "blue"
```

---

### Paso 5: Crear el código fuente

Crea el archivo `src/index.js`:

```javascript
// src/index.js
// ========================================
// IMPORTS
// ========================================
const core = require("@actions/core");
const github = require("@actions/github");

// ========================================
// FUNCIÓN PRINCIPAL
// ========================================
async function run() {
  try {
    // ========================================
    // PASO 1: Obtener inputs
    // ========================================
    // ¿Qué hace?: Lee los parámetros pasados a la action
    // ¿Por qué?: Necesitamos personalizar el comportamiento
    // ¿Para qué sirve?: El usuario puede configurar el saludo

    const nameToGreet = core.getInput("who-to-greet", { required: true });
    const includeEmoji = core.getBooleanInput("include-emoji");

    core.info(`📥 Input recibido: ${nameToGreet}`);
    core.info(`😀 Incluir emoji: ${includeEmoji}`);

    // ========================================
    // PASO 2: Generar el saludo
    // ========================================
    // ¿Qué hace?: Crea el mensaje de saludo personalizado
    // ¿Por qué?: Es la funcionalidad principal de la action
    // ¿Para qué sirve?: Producir el output esperado

    const emoji = includeEmoji ? "👋 " : "";
    const greeting = `${emoji}Hello, ${nameToGreet}!`;
    const timestamp = new Date().toISOString();

    // Mostrar en logs con formato
    core.startGroup("🎉 Saludo Generado");
    console.log(greeting);
    console.log(`Timestamp: ${timestamp}`);
    core.endGroup();

    // ========================================
    // PASO 3: Obtener información del contexto
    // ========================================
    // ¿Qué hace?: Extrae datos del evento de GitHub
    // ¿Por qué?: Útil para debugging y logging
    // ¿Para qué sirve?: Saber quién/qué triggereó la action

    const { context } = github;
    const eventInfo = {
      eventName: context.eventName,
      actor: context.actor,
      repo: `${context.repo.owner}/${context.repo.repo}`,
      ref: context.ref,
      sha: context.sha.substring(0, 7),
    };

    core.startGroup("📊 Información del Evento");
    core.info(`Event: ${eventInfo.eventName}`);
    core.info(`Actor: ${eventInfo.actor}`);
    core.info(`Repo: ${eventInfo.repo}`);
    core.info(`Ref: ${eventInfo.ref}`);
    core.info(`SHA: ${eventInfo.sha}`);
    core.endGroup();

    // ========================================
    // PASO 4: Establecer outputs
    // ========================================
    // ¿Qué hace?: Expone valores para otros steps
    // ¿Por qué?: Permite encadenar actions en el workflow
    // ¿Para qué sirve?: Otros steps pueden usar estos valores

    core.setOutput("greeting", greeting);
    core.setOutput("timestamp", timestamp);
    core.setOutput("event-info", JSON.stringify(eventInfo));

    // ========================================
    // PASO 5: Crear Job Summary
    // ========================================
    // ¿Qué hace?: Genera un resumen visual en la UI de GitHub
    // ¿Por qué?: Mejora la experiencia de usuario
    // ¿Para qué sirve?: Ver resultados sin revisar logs

    await core.summary
      .addHeading("Hello World Action Results")
      .addTable([
        [
          { data: "Campo", header: true },
          { data: "Valor", header: true },
        ],
        ["Saludo", greeting],
        ["Timestamp", timestamp],
        ["Evento", eventInfo.eventName],
        ["Actor", eventInfo.actor],
        ["Repositorio", eventInfo.repo],
      ])
      .write();

    core.info("✅ Action completada exitosamente");
  } catch (error) {
    // ========================================
    // MANEJO DE ERRORES
    // ========================================
    // ¿Qué hace?: Captura errores y marca la action como fallida
    // ¿Por qué?: El workflow debe saber si algo falló
    // ¿Para qué sirve?: Debugging y control de flujo

    core.error(`❌ Error en la action: ${error.message}`);
    core.setFailed(error.message);
  }
}

// Ejecutar la función principal
run();
```

---

### Paso 6: Configurar package.json

Actualiza `package.json` con los scripts:

```json
{
  "name": "hello-world-action",
  "version": "1.0.0",
  "description": "Mi primera JavaScript Action para GitHub Actions",
  "main": "dist/index.js",
  "scripts": {
    "build": "ncc build src/index.js -o dist --source-map --license licenses.txt",
    "test": "node src/index.js"
  },
  "keywords": ["github-actions", "hello-world"],
  "author": "Tu Nombre",
  "license": "MIT",
  "dependencies": {
    "@actions/core": "1.10.1",
    "@actions/github": "6.0.0"
  },
  "devDependencies": {
    "@vercel/ncc": "0.38.1"
  }
}
```

---

### Paso 7: Crear .gitignore

```bash
# .gitignore
node_modules/
*.log

# NO ignorar dist/ - es necesario para la action
# dist/
```

---

### Paso 8: Compilar la action

```bash
# ¿Qué hace?: Compila src/index.js y dependencias en un solo archivo
# ¿Por qué?: GitHub Actions requiere un archivo autocontenido
# ¿Para qué sirve?: La action funciona sin npm install en el runner

npm run build
```

**Resultado esperado**: Se crea `dist/index.js` con todo el código bundleado.

---

### Paso 9: Crear workflow de prueba

Crea `.github/workflows/test-action.yml`:

```yaml
name: Test Hello Action

on:
  push:
    branches: [main]
  pull_request:
  workflow_dispatch:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      # ========================================
      # TEST 1: Uso básico
      # ========================================
      - name: Test básico
        id: hello1
        uses: ./mi-primera-action
        with:
          who-to-greet: "GitHub Actions"

      - name: Verificar outputs básico
        run: |
          echo "Greeting: ${{ steps.hello1.outputs.greeting }}"
          echo "Timestamp: ${{ steps.hello1.outputs.timestamp }}"

      # ========================================
      # TEST 2: Sin emoji
      # ========================================
      - name: Test sin emoji
        id: hello2
        uses: ./mi-primera-action
        with:
          who-to-greet: "Developer"
          include-emoji: "false"

      - name: Verificar sin emoji
        run: |
          GREETING="${{ steps.hello2.outputs.greeting }}"
          if [[ "$GREETING" == *"👋"* ]]; then
            echo "ERROR: No debería tener emoji"
            exit 1
          fi
          echo "✅ Correcto: $GREETING"
```

---

## ✅ Verificación

Tu ejercicio está completo si:

- [ ] `npm run build` ejecuta sin errores
- [ ] Existe `dist/index.js` con el código compilado
- [ ] El workflow de prueba pasa correctamente
- [ ] Los outputs se muestran en los logs

---

## 🎯 Desafíos Extra (Opcional)

1. **Añadir un input `language`** que cambie el idioma del saludo (es/en)
2. **Crear un output `uppercase-greeting`** con el saludo en mayúsculas
3. **Añadir validación** para que el nombre no esté vacío

---

## 📚 Recursos

- [Actions Toolkit - core](https://github.com/actions/toolkit/tree/main/packages/core)
- [Actions Toolkit - github](https://github.com/actions/toolkit/tree/main/packages/github)
- [@vercel/ncc](https://github.com/vercel/ncc)

---

[⬅️ Volver a Ejercicios](../README.md) · [Siguiente: Ejercicio 02 →](../ejercicio-02-composite-action/README.md)
