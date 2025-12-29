# 🧪 Ejercicio 03: Artifacts entre Jobs

## 🎯 Objetivo

Aprender a compartir archivos entre jobs usando artifacts para pasar builds, reportes de coverage y logs de un job a otro.

---

## 📋 Información del Ejercicio

| Aspecto | Detalle |
|---------|---------|
| **Duración** | 40 minutos |
| **Dificultad** | Intermedia-Avanzada |
| **Requisitos** | Ejercicios 01-02 completados |
| **Temas** | upload-artifact, download-artifact, retention, paths |

---

## 📚 Conceptos Previos

- [x] Cada job se ejecuta en un runner limpio
- [x] Los archivos generados en un job NO persisten al siguiente
- [x] Artifacts permiten compartir archivos entre jobs
- [x] Artifacts también sirven para descargar resultados

---

## 🎬 Escenario

Tienes un pipeline donde:

1. **Job Build**: Compila la aplicación y genera `dist/`
2. **Job Test**: Necesita los archivos de `dist/` para test E2E
3. **Job Report**: Genera un reporte consolidado de coverage

**Problema:** Los archivos de `dist/` no existen en los jobs 2 y 3.

**Solución:** Usar artifacts para transferir archivos.

---

## 📊 Flujo de Artifacts

```
┌─────────────┐    artifact: build     ┌─────────────┐
│    BUILD    │ ──────────────────────▶│    TEST     │
│ genera dist │    (upload 10MB)       │ usa dist/   │
└─────────────┘                        └──────┬──────┘
                                              │
                                       artifact: coverage
                                       (upload 2MB)
                                              │
                                              ▼
                                       ┌─────────────┐
                                       │   REPORT    │
                                       │ consolida   │
                                       └─────────────┘
```

---

## 🚀 Instrucciones

### Paso 1: Entender el Problema (5 min)

Sin artifacts, esto **NO funciona**:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: npm run build  # Crea dist/
  
  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: npm test  # ❌ ERROR: dist/ no existe
```

**¿Por qué falla?**
- Cada job usa un runner **diferente**
- El runner de `test` es una máquina limpia
- Los archivos de `build` NO se transfieren automáticamente

### Paso 2: Crear Proyecto de Práctica (5 min)

```bash
# Crear estructura del proyecto
mkdir ejercicio-03-artifacts && cd ejercicio-03-artifacts
git init && npm init -y

# Instalar dependencias
npm install --save-dev jest

# Crear estructura
mkdir -p src tests .github/workflows
```

**Archivo: `src/app.js`**
```javascript
// Aplicación simple para demostrar artifacts
module.exports = {
  name: 'MyApp',
  version: '1.0.0',
  greet: (name) => `Hello, ${name}!`
};
```

**Archivo: `tests/app.test.js`**
```javascript
const app = require('../src/app');

describe('App', () => {
  test('should have correct name', () => {
    expect(app.name).toBe('MyApp');
  });

  test('should greet correctly', () => {
    expect(app.greet('World')).toBe('Hello, World!');
  });
});
```

**Actualizar `package.json`:**
```json
{
  "scripts": {
    "build": "mkdir -p dist && cp src/*.js dist/ && echo 'Build info' > dist/build-info.txt",
    "test": "jest --coverage"
  }
}
```

### Paso 3: Workflow con Upload Artifact (10 min)

**Archivo: `.github/workflows/artifacts.yml`**

```yaml
# =============================================================================
# Pipeline con Artifacts
# =============================================================================
# ¿QUÉ HACE?: Demuestra cómo compartir archivos entre jobs
# ¿POR QUÉ?: Los jobs corren en runners independientes
# ¿PARA QUÉ?: Pasar builds, reportes, logs entre jobs
# =============================================================================

name: Pipeline with Artifacts

on:
  push:
    branches: [main]
  pull_request:

jobs:
  # ===========================================================================
  # JOB 1: BUILD
  # ===========================================================================
  build:
    name: 🏗️ Build Application
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Build application
        run: npm run build
      
      # =========================================
      # UPLOAD ARTIFACT - Build Output
      # =========================================
      # ¿QUÉ?: Sube los archivos de dist/ como artifact
      # ¿POR QUÉ?: Para que otros jobs puedan usarlos
      # ¿PARA QUÉ?: Test E2E, deploy, etc.
      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          # Nombre del artifact (para referenciarlo luego)
          name: build-output
          # Qué archivos subir
          path: dist/
          # Días que permanece disponible (default: 90)
          retention-days: 7
          # Falla si no hay archivos
          if-no-files-found: error
      
      - name: Build summary
        run: |
          echo "## 🏗️ Build Artifact Created" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "**Artifact name:** build-output" >> $GITHUB_STEP_SUMMARY
          echo "**Files included:**" >> $GITHUB_STEP_SUMMARY
          echo "\`\`\`" >> $GITHUB_STEP_SUMMARY
          ls -la dist/ >> $GITHUB_STEP_SUMMARY
          echo "\`\`\`" >> $GITHUB_STEP_SUMMARY

  # ===========================================================================
  # JOB 2: TEST
  # ===========================================================================
  test:
    name: 🧪 Test with Coverage
    runs-on: ubuntu-latest
    needs: build  # Espera al build
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      # =========================================
      # DOWNLOAD ARTIFACT - Build Output
      # =========================================
      # ¿QUÉ?: Descarga el artifact del job build
      # ¿POR QUÉ?: Necesitamos dist/ para tests E2E
      # ¿PARA QUÉ?: Probar el código compilado real
      - name: Download build artifact
        uses: actions/download-artifact@v4
        with:
          # Mismo nombre que usamos en upload
          name: build-output
          # Dónde guardar los archivos
          path: dist/
      
      - name: Verify build files exist
        run: |
          echo "📂 Downloaded build files:"
          ls -la dist/
      
      - name: Run tests with coverage
        run: npm test
      
      # =========================================
      # UPLOAD ARTIFACT - Coverage Report
      # =========================================
      # ¿QUÉ?: Sube el reporte de coverage
      # ¿POR QUÉ?: Para consolidar en job report
      # ¿PARA QUÉ?: Análisis de calidad y métricas
      - name: Upload coverage artifact
        uses: actions/upload-artifact@v4
        with:
          name: coverage-report
          path: coverage/
          retention-days: 30

  # ===========================================================================
  # JOB 3: REPORT
  # ===========================================================================
  report:
    name: 📊 Generate Report
    runs-on: ubuntu-latest
    needs: test  # Espera a test
    
    steps:
      # =========================================
      # DOWNLOAD MÚLTIPLES ARTIFACTS
      # =========================================
      # ¿QUÉ?: Descarga todos los artifacts generados
      # ¿POR QUÉ?: Consolidar información de todos los jobs
      # ¿PARA QUÉ?: Generar reporte final unificado
      - name: Download all artifacts
        uses: actions/download-artifact@v4
        with:
          # Sin 'name' descarga TODOS los artifacts
          path: artifacts/
      
      - name: List all artifacts
        run: |
          echo "📦 All downloaded artifacts:"
          ls -laR artifacts/
      
      - name: Generate consolidated report
        run: |
          echo "## 📊 Pipeline Report" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "### Build Output" >> $GITHUB_STEP_SUMMARY
          echo "\`\`\`" >> $GITHUB_STEP_SUMMARY
          cat artifacts/build-output/build-info.txt >> $GITHUB_STEP_SUMMARY
          echo "\`\`\`" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "### Coverage Files" >> $GITHUB_STEP_SUMMARY
          ls artifacts/coverage-report/ >> $GITHUB_STEP_SUMMARY
      
      # =========================================
      # UPLOAD ARTIFACT - Final Report
      # =========================================
      - name: Create final report
        run: |
          mkdir -p final-report
          echo "Pipeline completed at $(date)" > final-report/summary.txt
          cp -r artifacts/* final-report/
      
      - name: Upload final report
        uses: actions/upload-artifact@v4
        with:
          name: final-report
          path: final-report/
          retention-days: 90
```

### Paso 4: Opciones Avanzadas de Artifacts (10 min)

#### Excluir archivos del artifact:

```yaml
- uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: |
      dist/
      !dist/**/*.map
      !dist/**/*.test.js
    # Sube dist/ pero excluye .map y .test.js
```

#### Comprimir artifact:

```yaml
- uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: dist/
    compression-level: 9  # 0-9, mayor = más compresión
```

#### Múltiples paths en un artifact:

```yaml
- uses: actions/upload-artifact@v4
  with:
    name: test-results
    path: |
      coverage/
      reports/
      screenshots/
```

#### Descargar artifact específico a carpeta específica:

```yaml
- uses: actions/download-artifact@v4
  with:
    name: build-output
    path: downloaded-build/

# Los archivos estarán en: downloaded-build/
```

### Paso 5: Ver Artifacts en GitHub UI (5 min)

1. **Ve a Actions** en tu repositorio
2. **Click en el workflow run**
3. **Scroll hasta "Artifacts"** al final
4. **Click para descargar** cualquier artifact como ZIP

```
Artifacts
├── 📦 build-output (2.3 MB)
├── 📦 coverage-report (1.1 MB)
└── 📦 final-report (3.5 MB)
```

### Paso 6: Probar el Pipeline (5 min)

```bash
# Commit y push
git add .
git commit -m "feat: add artifact sharing between jobs"
git push origin main

# Observar en Actions:
# 1. Job build sube artifact
# 2. Job test descarga artifact
# 3. Job report consolida todo
```

---

## ✅ Verificación

### Checklist

- [ ] Job build sube `build-output` artifact
- [ ] Job test descarga y usa el artifact
- [ ] Job test sube `coverage-report` artifact
- [ ] Job report descarga todos los artifacts
- [ ] Artifacts visibles en GitHub UI para descargar
- [ ] Step Summary muestra información de artifacts

### En los logs debe aparecer:

```
# Job build:
Upload Artifact
  Artifact name: build-output
  Artifact size: 2.3 MB

# Job test:
Download Artifact
  Artifact name: build-output
  Downloading to: dist/
```

---

## 🔧 Solución de Problemas

### Error: "Unable to find artifact"

```yaml
# Verificar que los nombres coinciden exactamente
# Upload:
uses: actions/upload-artifact@v4
with:
  name: build-output  # ← Este nombre

# Download:
uses: actions/download-artifact@v4
with:
  name: build-output  # ← Debe ser idéntico
```

### Error: "No files found"

```yaml
# El path no existe o está vacío
# Verificar que el build genera archivos:
- run: npm run build
- run: ls -la dist/  # Verificar antes de upload
```

### Artifact demasiado grande

```yaml
# GitHub tiene límite de 500MB por artifact
# Soluciones:
# 1. Excluir archivos innecesarios
path: |
  dist/
  !dist/node_modules/
  
# 2. Comprimir más
compression-level: 9

# 3. Dividir en múltiples artifacts
```

---

## 🎯 Desafíos Adicionales

### Desafío 1: Artifact condicional

```yaml
- name: Upload on failure
  if: failure()
  uses: actions/upload-artifact@v4
  with:
    name: debug-logs
    path: |
      logs/
      screenshots/
```

### Desafío 2: Artifact con nombre dinámico

```yaml
- name: Upload with dynamic name
  uses: actions/upload-artifact@v4
  with:
    name: build-${{ github.sha }}-${{ github.run_number }}
    path: dist/
```

### Desafío 3: Merge de artifacts

```yaml
jobs:
  test:
    strategy:
      matrix:
        node: [18, 20]
    steps:
      - uses: actions/upload-artifact@v4
        with:
          name: coverage-${{ matrix.node }}
          path: coverage/

  merge:
    needs: test
    steps:
      - uses: actions/download-artifact@v4
        with:
          pattern: coverage-*
          merge-multiple: true
          path: all-coverage/
```

---

## 📚 Recursos

- [Lección 03: Artifacts y Caching](../../1-teoria/03-artifacts-caching.md)
- [upload-artifact action](https://github.com/actions/upload-artifact)
- [download-artifact action](https://github.com/actions/download-artifact)

---

## 🔗 Navegación

| ⬅️ Anterior | 📚 Prácticas | ➡️ Siguiente |
|:-----------:|:------------:|:------------:|
| [Ejercicio 02](../ejercicio-02-caching-dependencias/README.md) | [README](../README.md) | [Ejercicio 04](../ejercicio-04-secrets-environments/README.md) |
