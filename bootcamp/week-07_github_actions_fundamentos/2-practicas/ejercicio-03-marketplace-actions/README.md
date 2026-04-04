# Ejercicio 03: Actions del Marketplace

## 🎯 Objetivo

Usar actions populares del GitHub Marketplace para crear un workflow de CI completo.

**Duración estimada:** 40 minutos

---

## 📋 Requisitos Previos

- Completar Ejercicios 01 y 02
- Repositorio actions-lab
- Node.js conocimiento básico

---

## 📝 Descripción

En este ejercicio usarás:

1. `actions/checkout` - Checkout del código
2. `actions/setup-node` - Setup de Node.js
3. `actions/cache` - Caché de dependencias
4. `actions/upload-artifact` / `download-artifact` - Artifacts
5. Actions de terceros del marketplace

---

## 🚀 Instrucciones

### Paso 1: Crear Proyecto Node.js

```bash
cd actions-lab

# Inicializar proyecto Node.js
cat > package.json << 'EOF'
{
  "name": "actions-lab",
  "version": "1.0.0",
  "description": "GitHub Actions Lab",
  "main": "src/index.js",
  "scripts": {
    "test": "node tests/test.js",
    "lint": "echo 'Linting...' && exit 0",
    "build": "echo 'Building...' && mkdir -p dist && cp src/*.js dist/"
  },
  "keywords": ["github-actions"],
  "license": "MIT"
}
EOF

# Crear código fuente
mkdir -p src tests

cat > src/index.js << 'EOF'
// Main application
function greet(name) {
  return `Hello, ${name}!`;
}

function add(a, b) {
  return a + b;
}

module.exports = { greet, add };
EOF

cat > tests/test.js << 'EOF'
const { greet, add } = require('../src/index.js');

// Simple test runner
let passed = 0;
let failed = 0;

function test(name, fn) {
  try {
    fn();
    console.log(`✅ ${name}`);
    passed++;
  } catch (error) {
    console.log(`❌ ${name}: ${error.message}`);
    failed++;
  }
}

function assertEqual(actual, expected) {
  if (actual !== expected) {
    throw new Error(`Expected ${expected}, got ${actual}`);
  }
}

// Tests
test('greet returns greeting', () => {
  assertEqual(greet('World'), 'Hello, World!');
});

test('add returns sum', () => {
  assertEqual(add(2, 3), 5);
});

test('add handles negative numbers', () => {
  assertEqual(add(-1, 1), 0);
});

// Summary
console.log(`\n📊 Results: ${passed} passed, ${failed} failed`);
process.exit(failed > 0 ? 1 : 0);
EOF
```

### Paso 2: Crear Workflow con Marketplace Actions

```bash
cat > .github/workflows/ci-marketplace.yml << 'EOF'
# ============================================
# WORKFLOW: CI con Marketplace Actions
# ============================================
name: CI Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:

# Variables de entorno globales
env:
  NODE_VERSION: '20'

jobs:
  # ------------------------------------
  # Job 1: Lint
  # ------------------------------------
  lint:
    name: 🔍 Lint Code
    runs-on: ubuntu-latest

    steps:
      # ================================
      # ACTION: actions/checkout
      # ================================
      # ¿QUÉ HACE?: Clona el repositorio en el runner
      # ¿POR QUÉ?: Necesitamos el código para analizarlo
      # ¿PARA QUÉ?: Sin checkout, el runner está vacío
      - name: Checkout code
        uses: actions/checkout@v4

      # ================================
      # ACTION: actions/setup-node
      # ================================
      # ¿QUÉ HACE?: Instala Node.js en el runner
      # ¿POR QUÉ?: Necesitamos Node.js para npm
      # ¿PARA QUÉ?: Ejecutar linting y otros scripts
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}

      - name: Run linter
        run: npm run lint

  # ------------------------------------
  # Job 2: Test
  # ------------------------------------
  test:
    name: 🧪 Run Tests
    runs-on: ubuntu-latest
    needs: lint

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}

      - name: Run tests
        run: npm test

  # ------------------------------------
  # Job 3: Build con Cache
  # ------------------------------------
  build:
    name: 🏗️ Build
    runs-on: ubuntu-latest
    needs: test

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js with cache
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          # Cache automático de npm
          cache: 'npm'

      # ================================
      # ACTION: actions/cache (manual)
      # ================================
      # ¿QUÉ HACE?: Guarda/restaura archivos entre ejecuciones
      # ¿POR QUÉ?: Acelera builds evitando trabajo repetido
      # ¿PARA QUÉ?: Reducir tiempo de CI significativamente
      - name: Cache node modules
        uses: actions/cache@v4
        id: cache-npm
        with:
          # Qué cachear
          path: node_modules
          # Clave del cache (invalida si cambia package-lock)
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
          # Claves alternativas si no hay match exacto
          restore-keys: |
            ${{ runner.os }}-node-

      - name: Install dependencies
        # Solo instalar si el cache no fue encontrado
        if: steps.cache-npm.outputs.cache-hit != 'true'
        run: npm ci || npm install

      - name: Build application
        run: npm run build

      # ================================
      # ACTION: actions/upload-artifact
      # ================================
      # ¿QUÉ HACE?: Guarda archivos para otros jobs o descarga
      # ¿POR QUÉ?: Compartir build entre jobs
      # ¿PARA QUÉ?: Deploy job necesita los archivos compilados
      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: build-output
          path: dist/
          retention-days: 7

  # ------------------------------------
  # Job 4: Deploy (simulated)
  # ------------------------------------
  deploy:
    name: 🚀 Deploy
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'

    steps:
      # ================================
      # ACTION: actions/download-artifact
      # ================================
      # ¿QUÉ HACE?: Descarga artifacts de jobs anteriores
      # ¿POR QUÉ?: Necesitamos el build del job anterior
      # ¿PARA QUÉ?: Desplegar los archivos compilados
      - name: Download build artifact
        uses: actions/download-artifact@v4
        with:
          name: build-output
          path: dist/

      - name: Show downloaded files
        run: |
          echo "📦 Downloaded artifacts:"
          ls -la dist/

      - name: Deploy (simulated)
        run: |
          echo "🚀 Deploying to production..."
          echo "Files to deploy:"
          cat dist/*.js
          echo "✅ Deployment complete!"

  # ------------------------------------
  # Job 5: Notifications (terceros)
  # ------------------------------------
  notify:
    name: 📢 Notify
    runs-on: ubuntu-latest
    needs: [lint, test, build]
    if: always()

    steps:
      - name: Check job results
        run: |
          echo "📊 Job Results Summary"
          echo "======================"
          echo "Lint: ${{ needs.lint.result }}"
          echo "Test: ${{ needs.test.result }}"
          echo "Build: ${{ needs.build.result }}"

      # Ejemplo de action de terceros (comentado)
      # - name: Slack Notification
      #   uses: slackapi/slack-github-action@v1
      #   with:
      #     payload: |
      #       {
      #         "text": "CI completed: ${{ job.status }}"
      #       }
      #   env:
      #     SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
EOF
```

### Paso 3: Commit y Verificar

```bash
git add .
git commit -m "feat: add CI pipeline with marketplace actions"
git push
```

### Paso 4: Observar Cache en Acción

```bash
# Primera ejecución - sin cache
gh run watch

# Hacer otro cambio pequeño
echo "// Comment" >> src/index.js
git add .
git commit -m "chore: minor update"
git push

# Segunda ejecución - con cache (más rápida)
gh run watch
```

### Paso 5: Descargar Artifacts

```bash
# Listar artifacts
gh run view --log

# Descargar artifact
gh run download -n build-output
ls -la build-output/
```

---

## 📋 Actions Populares del Marketplace

| Action                               | Descripción         | Uso                  |
| ------------------------------------ | ------------------- | -------------------- |
| `actions/checkout@v4`                | Checkout código     | Siempre necesario    |
| `actions/setup-node@v4`              | Setup Node.js       | Proyectos JS/TS      |
| `actions/setup-python@v5`            | Setup Python        | Proyectos Python     |
| `actions/cache@v4`                   | Cache de archivos   | Acelerar builds      |
| `actions/upload-artifact@v4`         | Subir artifacts     | Compartir entre jobs |
| `actions/download-artifact@v4`       | Descargar artifacts | Recibir de jobs      |
| `actions/github-script@v7`           | Ejecutar JS con API | Automatización       |
| `peter-evans/create-pull-request@v6` | Crear PRs           | Automación de PRs    |
| `softprops/action-gh-release@v1`     | Crear releases      | Publicaciones        |

---

## ✅ Verificación

- [ ] Workflow tiene 5 jobs
- [ ] Actions de checkout y setup-node funcionan
- [ ] Cache se crea en primera ejecución
- [ ] Cache se restaura en segunda ejecución
- [ ] Artifact se sube correctamente
- [ ] Deploy job descarga el artifact
- [ ] Notify job muestra resultados

---

## 🎯 Desafío Extra

1. Agregar `actions/setup-python` para linting con Python
2. Usar `peaceiris/actions-gh-pages` para deploy a GitHub Pages
3. Implementar `github/codeql-action` para análisis de seguridad

```yaml
# Hint: GitHub Pages deploy
- name: Deploy to GitHub Pages
  # ⚠️ PRODUCCIÓN: pinar a commit SHA completo, nunca a @v3 (floating tag)
  # Ejemplo seguro: peaceiris/actions-gh-pages@4f9cc648dd3e9a5ee88de0428a23c37be3a1380a
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./dist
```

---

## 📚 Conceptos Aprendidos

| Concepto      | Descripción                           |
| ------------- | ------------------------------------- |
| `uses`        | Usar una action del marketplace       |
| `with`        | Parámetros de entrada para actions    |
| `@v4`         | Versión de la action                  |
| `cache`       | Persistir archivos entre ejecuciones  |
| `artifacts`   | Compartir archivos entre jobs         |
| `hashFiles()` | Función para generar hash de archivos |

---

[⬅️ Anterior: Múltiples Triggers](../ejercicio-02-multiple-triggers/) | [➡️ Siguiente: Matrix Strategy](../ejercicio-04-matrix-strategy/)

---

_Ejercicio 03 | Week 07 | GitHub Actions Fundamentos_
