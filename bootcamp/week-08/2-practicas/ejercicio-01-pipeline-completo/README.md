# 🧪 Ejercicio 01: Pipeline CI Completo

## 🎯 Objetivo

Crear un pipeline de Integración Continua completo con jobs secuenciales para lint, test y build usando GitHub Actions.

---

## 📋 Información del Ejercicio

| Aspecto | Detalle |
|---------|---------|
| **Duración** | 35 minutos |
| **Dificultad** | Intermedia |
| **Requisitos** | Semana 07 completada, conocimientos de YAML |
| **Temas** | Jobs, needs, steps, triggers, fail-fast |

---

## 📚 Conceptos Previos

Antes de comenzar, asegúrate de entender:

- [x] Estructura básica de workflows (name, on, jobs)
- [x] Steps con `run` y `uses`
- [x] Dependencias entre jobs con `needs`
- [x] Triggers `push` y `pull_request`

---

## 🎬 Escenario

Eres desarrollador en un equipo que trabaja en una aplicación Node.js. Tu tarea es configurar un pipeline CI que:

1. **Valide el código** con ESLint
2. **Ejecute tests** unitarios con Jest
3. **Compile la aplicación** solo si los tests pasan

El pipeline debe ejecutarse en cada push y pull request a main.

---

## 📁 Estructura del Proyecto

```text
mi-proyecto/
├── .github/
│   └── workflows/
│       └── ci.yml          # 👈 Crearás este archivo
├── src/
│   └── calculator.js
├── tests/
│   └── calculator.test.js
├── package.json
├── .eslintrc.json
└── README.md
```

---

## 🚀 Instrucciones

### Paso 1: Preparar el Repositorio (5 min)

```bash
# ¿QUÉ HACER?: Crear estructura del proyecto
# ¿POR QUÉ?: Necesitamos código fuente para validar en el pipeline
# ¿PARA QUÉ?: Simular un proyecto real con lint, tests y build

# Crear directorio del proyecto
mkdir ejercicio-01-pipeline && cd ejercicio-01-pipeline

# Inicializar git y npm
git init
npm init -y

# Instalar dependencias de desarrollo
npm install --save-dev eslint jest

# Crear estructura de carpetas
mkdir -p src tests .github/workflows
```

### Paso 2: Crear el Código Fuente (5 min)

**Archivo: `src/calculator.js`**
```javascript
// Calculator module para demostrar el pipeline CI

class Calculator {
  add(a, b) {
    return a + b;
  }

  subtract(a, b) {
    return a - b;
  }

  multiply(a, b) {
    return a * b;
  }

  divide(a, b) {
    if (b === 0) {
      throw new Error('Cannot divide by zero');
    }
    return a / b;
  }
}

module.exports = Calculator;
```

**Archivo: `tests/calculator.test.js`**
```javascript
const Calculator = require('../src/calculator');

describe('Calculator', () => {
  let calc;

  beforeEach(() => {
    calc = new Calculator();
  });

  test('add: suma dos números', () => {
    expect(calc.add(2, 3)).toBe(5);
  });

  test('subtract: resta dos números', () => {
    expect(calc.subtract(5, 3)).toBe(2);
  });

  test('multiply: multiplica dos números', () => {
    expect(calc.multiply(4, 3)).toBe(12);
  });

  test('divide: divide dos números', () => {
    expect(calc.divide(10, 2)).toBe(5);
  });

  test('divide: lanza error al dividir por cero', () => {
    expect(() => calc.divide(10, 0)).toThrow('Cannot divide by zero');
  });
});
```

### Paso 3: Configurar ESLint y Package.json (3 min)

**Archivo: `.eslintrc.json`**
```json
{
  "env": {
    "node": true,
    "jest": true,
    "es2021": true
  },
  "extends": "eslint:recommended",
  "rules": {
    "semi": ["error", "always"],
    "quotes": ["error", "single"]
  }
}
```

**Actualizar `package.json`** - agregar scripts:
```json
{
  "scripts": {
    "lint": "eslint src/ tests/",
    "test": "jest --coverage",
    "build": "echo 'Build completed' && mkdir -p dist && cp src/*.js dist/"
  }
}
```

### Paso 4: Crear el Workflow CI (15 min)

**Archivo: `.github/workflows/ci.yml`**

```yaml
# =============================================================================
# Pipeline CI Completo - Ejercicio 01
# =============================================================================
# ¿QUÉ HACE?: Pipeline con lint, test y build secuenciales
# ¿POR QUÉ?: Validar código antes de integrarlo a main
# ¿PARA QUÉ?: Detectar errores temprano y mantener calidad
# =============================================================================

name: CI Pipeline

# -----------------------------------------------------------------------------
# TRIGGERS
# -----------------------------------------------------------------------------
on:
  push:
    branches: 
      - main
      - develop
  pull_request:
    branches: 
      - main

# -----------------------------------------------------------------------------
# JOBS
# -----------------------------------------------------------------------------
jobs:
  # ===========================================================================
  # JOB 1: LINT
  # ===========================================================================
  lint:
    name: 🔍 Lint Code
    runs-on: ubuntu-latest
    
    steps:
      # Paso 1: Checkout del código
      # ¿QUÉ?: Descarga el código del repositorio
      # ¿POR QUÉ?: Necesitamos el código para analizarlo
      - name: Checkout repository
        uses: actions/checkout@v4
      
      # Paso 2: Configurar Node.js
      # ¿QUÉ?: Instala Node.js en el runner
      # ¿POR QUÉ?: ESLint requiere Node.js para ejecutar
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      # Paso 3: Instalar dependencias
      # ¿QUÉ?: Ejecuta npm ci para instalar dependencias
      # ¿POR QUÉ?: ESLint está en devDependencies
      - name: Install dependencies
        run: npm ci
      
      # Paso 4: Ejecutar linter
      # ¿QUÉ?: Analiza el código con ESLint
      # ¿POR QUÉ?: Detectar errores de sintaxis y estilo
      - name: Run ESLint
        run: npm run lint

  # ===========================================================================
  # JOB 2: TEST
  # ===========================================================================
  test:
    name: 🧪 Run Tests
    runs-on: ubuntu-latest
    needs: lint  # 👈 Espera a que lint termine exitosamente
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      # Ejecutar tests con coverage
      # ¿QUÉ?: Ejecuta Jest y genera reporte de cobertura
      # ¿POR QUÉ?: Verificar que el código funciona correctamente
      - name: Run tests with coverage
        run: npm test
      
      # Mostrar resumen de coverage
      - name: Coverage summary
        run: |
          echo "## 📊 Test Coverage" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "Tests ejecutados exitosamente ✅" >> $GITHUB_STEP_SUMMARY

  # ===========================================================================
  # JOB 3: BUILD
  # ===========================================================================
  build:
    name: 🏗️ Build Application
    runs-on: ubuntu-latest
    needs: test  # 👈 Espera a que test termine exitosamente
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      # Ejecutar build
      # ¿QUÉ?: Compila/copia archivos a dist/
      # ¿POR QUÉ?: Preparar código para deployment
      - name: Build application
        run: npm run build
      
      # Verificar que el build existe
      - name: Verify build output
        run: |
          ls -la dist/
          echo "## 🏗️ Build Output" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "Build completado exitosamente ✅" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "Archivos generados:" >> $GITHUB_STEP_SUMMARY
          ls -la dist/ >> $GITHUB_STEP_SUMMARY
```

### Paso 5: Probar el Pipeline (7 min)

```bash
# ¿QUÉ HACER?: Commit y push para activar el pipeline
# ¿POR QUÉ?: El trigger está configurado para push a main
# ¿PARA QUÉ?: Verificar que el pipeline funciona correctamente

# Agregar todos los archivos
git add .

# Commit inicial
git commit -m "feat: add CI pipeline with lint, test, and build"

# Crear repositorio en GitHub (si no existe)
# gh repo create ejercicio-01-pipeline --public --push

# Push a main
git push origin main
```

---

## ✅ Verificación

### En la pestaña Actions de GitHub:

1. **Ver el workflow ejecutándose:**
   ```
   CI Pipeline
   ├── 🔍 Lint Code ──────▶ ✅ Success
   │        │
   │        ▼ (needs: lint)
   ├── 🧪 Run Tests ──────▶ ✅ Success
   │        │
   │        ▼ (needs: test)
   └── 🏗️ Build Application ▶ ✅ Success
   ```

2. **Verificar que los jobs son secuenciales** (no paralelos)

3. **Revisar el Step Summary** de cada job

### Checklist de Validación

- [ ] Workflow aparece en Actions
- [ ] Job lint ejecuta ESLint exitosamente
- [ ] Job test ejecuta después de lint
- [ ] Job build ejecuta después de test
- [ ] Step Summary muestra información
- [ ] Badge de CI disponible

---

## 🔧 Solución de Problemas

### Error: "npm ci" fails

```yaml
# Asegúrate de tener package-lock.json
# Si no existe, ejecuta localmente:
npm install
git add package-lock.json
git commit -m "add package-lock.json"
git push
```

### Error: ESLint no encuentra archivos

```yaml
# Verificar que la ruta en package.json es correcta
"lint": "eslint src/ tests/"

# O crear archivos de prueba si no existen
```

### Los jobs se ejecutan en paralelo

```yaml
# Verificar que 'needs' está configurado
test:
  needs: lint  # ← Esto es obligatorio

build:
  needs: test  # ← Esto es obligatorio
```

---

## 🎯 Desafíos Adicionales

### Desafío 1: Agregar timeout
```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    timeout-minutes: 5  # 👈 Agregar timeout
```

### Desafío 2: Agregar job de resumen
```yaml
  summary:
    name: 📋 Pipeline Summary
    needs: [lint, test, build]
    runs-on: ubuntu-latest
    steps:
      - name: Generate summary
        run: |
          echo "## Pipeline Results" >> $GITHUB_STEP_SUMMARY
          echo "- Lint: ✅" >> $GITHUB_STEP_SUMMARY
          echo "- Test: ✅" >> $GITHUB_STEP_SUMMARY
          echo "- Build: ✅" >> $GITHUB_STEP_SUMMARY
```

### Desafío 3: Fallar intencionalmente
Introduce un error en el código y verifica que:
1. El job lint o test falla
2. El job build no se ejecuta
3. GitHub muestra el status ❌

---

## 📚 Recursos

- [Lección 01: Fundamentos CI/CD](../../1-teoria/01-fundamentos-cicd.md)
- [Lección 02: Build y Testing](../../1-teoria/02-build-testing.md)
- [GitHub Actions - Workflow syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

---

## 🔗 Navegación

| ⬅️ Anterior | 📚 Prácticas | ➡️ Siguiente |
|:-----------:|:------------:|:------------:|
| [Teoría 04](../../1-teoria/04-secrets-variables.md) | [README](../README.md) | [Ejercicio 02](../ejercicio-02-caching-dependencias/README.md) |
