# 📚 Lección 02: JavaScript Actions

> **Duración estimada**: 25 minutos  
> **Nivel**: Intermedio  
> **Prerequisitos**: Lección 01, conocimientos básicos de JavaScript/Node.js

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- [ ] Crear una JavaScript Action desde cero
- [ ] Usar `@actions/core` para inputs, outputs y logging
- [ ] Usar `@actions/github` para interactuar con la API
- [ ] Compilar y distribuir la action con `@vercel/ncc`

---

## 📖 Contenido Teórico

### 1. Anatomía de una JavaScript Action

Una JavaScript Action típica tiene esta estructura:

```
my-js-action/
├── action.yml          # Definición de la action
├── package.json        # Dependencias npm
├── src/
│   └── index.js        # Código fuente
├── dist/
│   └── index.js        # Código compilado (generado)
├── README.md           # Documentación
└── .gitignore
```

---

### 2. Actions Toolkit

GitHub proporciona librerías oficiales para facilitar el desarrollo:

| Paquete | Descripción |
|---------|-------------|
| `@actions/core` | Inputs, outputs, logging, secrets |
| `@actions/github` | Cliente autenticado para GitHub API |
| `@actions/exec` | Ejecutar comandos del sistema |
| `@actions/io` | Operaciones de archivos |
| `@actions/tool-cache` | Descargar y cachear herramientas |
| `@actions/artifact` | Upload/download de artifacts |
| `@actions/cache` | Caching de dependencias |

---

### 3. @actions/core - Funciones Principales

#### 3.1 Obtener Inputs

```javascript
const core = require('@actions/core');

// ¿Qué hace?: Obtiene el valor de un input definido en action.yml
// ¿Por qué?: Los inputs son la forma de pasar parámetros a la action
// ¿Para qué sirve?: Configurar el comportamiento de la action

// Input obligatorio - falla si no existe
const token = core.getInput('github-token', { required: true });

// Input opcional con valor por defecto
const environment = core.getInput('environment') || 'staging';

// Input booleano
const dryRun = core.getBooleanInput('dry-run');

// Input multilínea (cada línea como elemento)
const labels = core.getMultilineInput('labels');
```

#### 3.2 Establecer Outputs

```javascript
// ¿Qué hace?: Define un valor de salida que otros steps pueden usar
// ¿Por qué?: Permite comunicación entre actions/steps
// ¿Para qué sirve?: Pasar resultados al workflow

core.setOutput('result', 'success');
core.setOutput('deployment-url', 'https://app.example.com');
core.setOutput('version', '1.2.3');

// Uso en workflow:
// ${{ steps.mi-step.outputs.result }}
```

#### 3.3 Logging y Mensajes

```javascript
// ¿Qué hace?: Escribe mensajes en el log del workflow
// ¿Por qué?: Para debugging y visibilidad del progreso
// ¿Para qué sirve?: El usuario ve el progreso en GitHub Actions UI

// Niveles de log
core.debug('Mensaje de debug (solo si ACTIONS_STEP_DEBUG=true)');
core.info('Mensaje informativo normal');
core.notice('Aviso importante - aparece como anotación');
core.warning('Advertencia - aparece como anotación amarilla');
core.error('Error - aparece como anotación roja');

// Agrupar logs
core.startGroup('Instalando dependencias');
console.log('npm install...');
console.log('npm run build...');
core.endGroup();
```

#### 3.4 Manejo de Errores y Estado

```javascript
// ¿Qué hace?: Marca la action como fallida
// ¿Por qué?: Indica al workflow que algo salió mal
// ¿Para qué sirve?: El workflow puede reaccionar al fallo

try {
  // ... lógica de la action
} catch (error) {
  // Marcar como fallo y mostrar mensaje
  core.setFailed(`Action failed: ${error.message}`);
}
```

#### 3.5 Secrets y Variables de Entorno

```javascript
// ¿Qué hace?: Oculta un valor en los logs
// ¿Por qué?: Evita exposición accidental de secretos
// ¿Para qué sirve?: Seguridad en los logs

const token = core.getInput('token');
core.setSecret(token);  // Ahora token aparecerá como *** en logs

// Exportar variable de entorno
core.exportVariable('MY_VAR', 'value');

// Añadir al PATH
core.addPath('/custom/bin/path');
```

---

### 4. @actions/github - API de GitHub

```javascript
const github = require('@actions/github');

// ¿Qué hace?: Crea un cliente autenticado de la API de GitHub
// ¿Por qué?: Permite interactuar con repos, issues, PRs, etc.
// ¿Para qué sirve?: Automatizar tareas en GitHub

async function run() {
  const token = core.getInput('github-token', { required: true });
  
  // Cliente Octokit autenticado
  const octokit = github.getOctokit(token);
  
  // Contexto del evento (push, PR, etc.)
  const context = github.context;
  
  console.log(`Repo: ${context.repo.owner}/${context.repo.repo}`);
  console.log(`Event: ${context.eventName}`);
  console.log(`Actor: ${context.actor}`);
  console.log(`SHA: ${context.sha}`);
  
  // Ejemplo: Crear un comentario en un issue
  if (context.eventName === 'issues') {
    await octokit.rest.issues.createComment({
      ...context.repo,
      issue_number: context.issue.number,
      body: '¡Gracias por reportar este issue! 🎉'
    });
  }
  
  // Ejemplo: Obtener info del PR
  if (context.eventName === 'pull_request') {
    const { data: pr } = await octokit.rest.pulls.get({
      ...context.repo,
      pull_number: context.issue.number
    });
    
    core.info(`PR Title: ${pr.title}`);
    core.info(`Changed files: ${pr.changed_files}`);
  }
}
```

---

### 5. Estructura Completa de una Action

#### 5.1 action.yml

```yaml
name: 'Hello World Action'
description: 'Greet someone and record the time'
author: 'Your Name'

inputs:
  who-to-greet:
    description: 'Who to greet'
    required: true
    default: 'World'
  
  github-token:
    description: 'GitHub token for API calls'
    required: false
    default: ${{ github.token }}

outputs:
  time:
    description: 'The time we greeted you'
  
  greeting:
    description: 'The greeting message'

runs:
  using: 'node20'
  main: 'dist/index.js'

branding:
  icon: 'smile'
  color: 'yellow'
```

#### 5.2 package.json

```json
{
  "name": "hello-world-action",
  "version": "1.0.0",
  "description": "A GitHub Action that greets someone",
  "main": "dist/index.js",
  "scripts": {
    "build": "ncc build src/index.js -o dist",
    "test": "jest",
    "lint": "eslint src/"
  },
  "dependencies": {
    "@actions/core": "^1.10.1",
    "@actions/github": "^6.0.0"
  },
  "devDependencies": {
    "@vercel/ncc": "^0.38.1",
    "jest": "^29.7.0",
    "eslint": "^8.56.0"
  }
}
```

#### 5.3 src/index.js

```javascript
const core = require('@actions/core');
const github = require('@actions/github');

async function run() {
  try {
    // ========================================
    // PASO 1: Obtener inputs
    // ========================================
    // ¿Qué hace?: Lee los parámetros pasados a la action
    // ¿Por qué?: Necesitamos saber a quién saludar
    // ¿Para qué sirve?: Personalizar el comportamiento
    
    const nameToGreet = core.getInput('who-to-greet', { required: true });
    core.info(`Input received: ${nameToGreet}`);
    
    // ========================================
    // PASO 2: Ejecutar lógica principal
    // ========================================
    // ¿Qué hace?: Genera el saludo y timestamp
    // ¿Por qué?: Es la funcionalidad core de la action
    // ¿Para qué sirve?: Producir el resultado esperado
    
    const greeting = `Hello, ${nameToGreet}!`;
    const time = new Date().toISOString();
    
    console.log(greeting);
    console.log(`Time: ${time}`);
    
    // ========================================
    // PASO 3: Establecer outputs
    // ========================================
    // ¿Qué hace?: Expone valores para otros steps
    // ¿Por qué?: Permite encadenar actions
    // ¿Para qué sirve?: El workflow puede usar estos valores
    
    core.setOutput('greeting', greeting);
    core.setOutput('time', time);
    
    // ========================================
    // PASO 4: Información adicional del contexto
    // ========================================
    // ¿Qué hace?: Muestra info del evento que triggereó la action
    // ¿Por qué?: Útil para debugging
    // ¿Para qué sirve?: Entender el contexto de ejecución
    
    const { context } = github;
    core.startGroup('GitHub Context');
    core.info(`Event: ${context.eventName}`);
    core.info(`Repo: ${context.repo.owner}/${context.repo.repo}`);
    core.info(`Actor: ${context.actor}`);
    core.info(`Ref: ${context.ref}`);
    core.endGroup();
    
  } catch (error) {
    // ========================================
    // MANEJO DE ERRORES
    // ========================================
    // ¿Qué hace?: Marca la action como fallida
    // ¿Por qué?: El workflow debe saber si algo falló
    // ¿Para qué sirve?: Permite reaccionar a errores
    
    core.setFailed(`Action failed: ${error.message}`);
  }
}

run();
```

---

### 6. Compilación con @vercel/ncc

Las JavaScript Actions **deben incluir** sus dependencias en el código. Usamos `ncc` para compilar todo en un solo archivo:

```bash
# ¿Qué hace?: Instala ncc como dependencia de desarrollo
# ¿Por qué?: Necesitamos el compilador para empaquetar
# ¿Para qué sirve?: Crear el bundle de distribución

npm install --save-dev @vercel/ncc

# ¿Qué hace?: Compila src/index.js y dependencias en dist/index.js
# ¿Por qué?: GitHub Actions espera un archivo autocontenido
# ¿Para qué sirve?: La action funciona sin npm install en el runner

npm run build
# O directamente:
npx ncc build src/index.js -o dist
```

> **⚠️ Importante**: El directorio `dist/` **debe** estar en el repositorio (no en `.gitignore`). Sin él, la action no funcionará.

---

### 7. Uso en Workflows

```yaml
name: Test My Action

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      # Usar action local (durante desarrollo)
      - name: Run local action
        id: hello
        uses: ./
        with:
          who-to-greet: 'GitHub Actions'
      
      # Usar outputs
      - name: Show outputs
        run: |
          echo "Greeting: ${{ steps.hello.outputs.greeting }}"
          echo "Time: ${{ steps.hello.outputs.time }}"
      
      # Usar action publicada
      - name: Run published action
        uses: owner/hello-action@v1
        with:
          who-to-greet: 'World'
```

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **@actions/core** | Inputs, outputs, logging, manejo de errores |
| **@actions/github** | Cliente API GitHub + contexto del evento |
| **@vercel/ncc** | Compilador para bundle autocontenido |
| **dist/index.js** | Archivo compilado que ejecuta la action |
| **runs.using** | `node16` o `node20` para JavaScript |

---

## 🔗 Recursos Adicionales

- [📖 Actions Toolkit](https://github.com/actions/toolkit)
- [📦 @actions/core API](https://github.com/actions/toolkit/tree/main/packages/core)
- [📦 @actions/github API](https://github.com/actions/toolkit/tree/main/packages/github)
- [🔧 @vercel/ncc](https://github.com/vercel/ncc)

---

## ⏭️ Siguiente Lección

[Lección 03: Composite Actions →](03-composite-actions.md)

---

[⬅️ Lección anterior](01-custom-actions-intro.md) · [📋 Semana 09](../README.md)
