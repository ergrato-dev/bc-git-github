# 🏋️ Ejercicio 02: Composite Action - Setup Environment

> **Duración estimada**: 35 minutos  
> **Dificultad**: Intermedia  
> **Prerequisitos**: Lección 03 - Composite Actions

---

## 🎯 Objetivo

Crear una Composite Action que configure un ambiente de desarrollo Node.js completo: instala Node.js, configura cache de npm, instala dependencias y verifica la instalación.

---

## 📋 Lo que aprenderás

- [ ] Crear una Composite Action con múltiples steps
- [ ] Reutilizar otras actions dentro de una composite
- [ ] Manejar inputs y outputs en YAML
- [ ] Implementar lógica condicional
- [ ] Usar diferentes shells

---

## 📁 Estructura Final

```
ejercicio-02-composite-action/
└── setup-node-env/
    └── action.yml
```

---

## 🚀 Pasos del Ejercicio

### Paso 1: Crear la estructura

```bash
# ¿Qué hace?: Crea el directorio para la composite action
# ¿Por qué?: Las actions locales necesitan su propia carpeta
# ¿Para qué sirve?: Organizar el código de la action

mkdir -p .github/actions/setup-node-env
```

---

### Paso 2: Crear action.yml

Crea `.github/actions/setup-node-env/action.yml`:

```yaml
# .github/actions/setup-node-env/action.yml
# ========================================
# COMPOSITE ACTION: Setup Node Environment
# ========================================
# ¿Qué hace?: Configura un ambiente completo de Node.js
# ¿Por qué?: Evita repetir los mismos steps en cada workflow
# ¿Para qué sirve?: Un solo step reemplaza 4-5 steps repetitivos

name: 'Setup Node.js Environment'
description: 'Configura Node.js, cache de npm e instala dependencias'
author: 'Tu Equipo DevOps'

# ========================================
# INPUTS
# ========================================
inputs:
  node-version:
    description: 'Versión de Node.js a instalar'
    required: false
    default: '20'
  
  package-manager:
    description: 'Gestor de paquetes (npm, yarn, pnpm)'
    required: false
    default: 'npm'
  
  working-directory:
    description: 'Directorio con package.json'
    required: false
    default: '.'
  
  install-dependencies:
    description: 'Instalar dependencias automáticamente'
    required: false
    default: 'true'
  
  cache-dependency-path:
    description: 'Ruta al lockfile para cache key'
    required: false
    default: ''

# ========================================
# OUTPUTS
# ========================================
outputs:
  node-version:
    description: 'Versión de Node.js instalada'
    value: ${{ steps.setup-node.outputs.node-version }}
  
  cache-hit:
    description: 'Si el cache fue encontrado'
    value: ${{ steps.cache-deps.outputs.cache-hit }}
  
  install-time:
    description: 'Tiempo de instalación en segundos'
    value: ${{ steps.install.outputs.duration }}

# ========================================
# RUNS - Tipo Composite
# ========================================
runs:
  using: 'composite'
  steps:
    # ========================================
    # STEP 1: Detectar lockfile
    # ========================================
    # ¿Qué hace?: Determina qué package manager usar
    # ¿Por qué?: Cada PM tiene su propio lockfile
    # ¿Para qué sirve?: Usar el comando correcto de instalación
    
    - name: Detect package manager
      id: detect-pm
      shell: bash
      working-directory: ${{ inputs.working-directory }}
      run: |
        echo "🔍 Detectando package manager..."
        
        if [ -f "pnpm-lock.yaml" ]; then
          echo "manager=pnpm" >> $GITHUB_OUTPUT
          echo "lockfile=pnpm-lock.yaml" >> $GITHUB_OUTPUT
          echo "install-cmd=pnpm install --frozen-lockfile" >> $GITHUB_OUTPUT
          echo "📦 Detectado: pnpm"
        elif [ -f "yarn.lock" ]; then
          echo "manager=yarn" >> $GITHUB_OUTPUT
          echo "lockfile=yarn.lock" >> $GITHUB_OUTPUT
          echo "install-cmd=yarn install --frozen-lockfile" >> $GITHUB_OUTPUT
          echo "📦 Detectado: yarn"
        else
          echo "manager=npm" >> $GITHUB_OUTPUT
          echo "lockfile=package-lock.json" >> $GITHUB_OUTPUT
          echo "install-cmd=npm ci" >> $GITHUB_OUTPUT
          echo "📦 Detectado: npm"
        fi
    
    # ========================================
    # STEP 2: Setup Node.js
    # ========================================
    # ¿Qué hace?: Instala la versión especificada de Node.js
    # ¿Por qué?: El runner puede tener otra versión
    # ¿Para qué sirve?: Garantizar consistencia entre builds
    
    - name: Setup Node.js ${{ inputs.node-version }}
      id: setup-node
      uses: actions/setup-node@v4
      with:
        node-version: ${{ inputs.node-version }}
    
    # ========================================
    # STEP 3: Setup pnpm (si es necesario)
    # ========================================
    - name: Setup pnpm
      if: steps.detect-pm.outputs.manager == 'pnpm'
      uses: pnpm/action-setup@v2
      with:
        version: 8
    
    # ========================================
    # STEP 4: Cache de dependencias
    # ========================================
    # ¿Qué hace?: Cachea node_modules entre runs
    # ¿Por qué?: npm install es lento
    # ¿Para qué sirve?: Reducir tiempo de CI significativamente
    
    - name: Cache dependencies
      id: cache-deps
      uses: actions/cache@v4
      with:
        path: |
          ~/.npm
          ~/.pnpm-store
          ${{ inputs.working-directory }}/node_modules
        key: ${{ runner.os }}-${{ steps.detect-pm.outputs.manager }}-${{ inputs.node-version }}-${{ hashFiles(format('{0}/{1}', inputs.working-directory, steps.detect-pm.outputs.lockfile)) }}
        restore-keys: |
          ${{ runner.os }}-${{ steps.detect-pm.outputs.manager }}-${{ inputs.node-version }}-
    
    # ========================================
    # STEP 5: Instalar dependencias
    # ========================================
    # ¿Qué hace?: Ejecuta npm ci / yarn install / pnpm install
    # ¿Por qué?: Necesitamos las dependencias para build/test
    # ¿Para qué sirve?: Preparar el proyecto para ejecución
    
    - name: Install dependencies
      id: install
      if: inputs.install-dependencies == 'true'
      shell: bash
      working-directory: ${{ inputs.working-directory }}
      run: |
        echo "📥 Instalando dependencias..."
        START_TIME=$(date +%s)
        
        if [ "${{ steps.cache-deps.outputs.cache-hit }}" == "true" ]; then
          echo "✅ Cache encontrado, verificando integridad..."
          # Verificar que node_modules existe y tiene contenido
          if [ -d "node_modules" ] && [ "$(ls -A node_modules 2>/dev/null)" ]; then
            echo "✅ node_modules válido desde cache"
          else
            echo "⚠️ Cache corrupto, reinstalando..."
            ${{ steps.detect-pm.outputs.install-cmd }}
          fi
        else
          echo "📦 Sin cache, instalando desde cero..."
          ${{ steps.detect-pm.outputs.install-cmd }}
        fi
        
        END_TIME=$(date +%s)
        DURATION=$((END_TIME - START_TIME))
        echo "duration=$DURATION" >> $GITHUB_OUTPUT
        echo "⏱️ Instalación completada en ${DURATION}s"
    
    # ========================================
    # STEP 6: Verificar instalación
    # ========================================
    # ¿Qué hace?: Muestra versiones instaladas
    # ¿Por qué?: Para debugging y verificación
    # ¿Para qué sirve?: Confirmar que todo está correcto
    
    - name: Verify installation
      shell: bash
      run: |
        echo "📊 Ambiente configurado:"
        echo "========================"
        echo "Node.js: $(node --version)"
        echo "npm: $(npm --version)"
        
        if command -v yarn &> /dev/null; then
          echo "Yarn: $(yarn --version)"
        fi
        
        if command -v pnpm &> /dev/null; then
          echo "pnpm: $(pnpm --version)"
        fi
        
        echo "========================"
        echo "Cache hit: ${{ steps.cache-deps.outputs.cache-hit }}"
        echo "Working dir: ${{ inputs.working-directory }}"
    
    # ========================================
    # STEP 7: Summary
    # ========================================
    - name: Create summary
      shell: bash
      run: |
        echo "## 🟢 Node.js Environment Ready" >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "| Setting | Value |" >> $GITHUB_STEP_SUMMARY
        echo "|---------|-------|" >> $GITHUB_STEP_SUMMARY
        echo "| Node.js | $(node --version) |" >> $GITHUB_STEP_SUMMARY
        echo "| Package Manager | ${{ steps.detect-pm.outputs.manager }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Cache Hit | ${{ steps.cache-deps.outputs.cache-hit }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Install Time | ${{ steps.install.outputs.duration }}s |" >> $GITHUB_STEP_SUMMARY
```

---

### Paso 3: Crear workflow de prueba

Crea `.github/workflows/test-composite.yml`:

```yaml
name: Test Composite Action

on:
  push:
    branches: [main]
  pull_request:
  workflow_dispatch:

jobs:
  # ========================================
  # TEST 1: Configuración por defecto
  # ========================================
  test-default:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup with defaults
        id: setup
        uses: ./.github/actions/setup-node-env
      
      - name: Check outputs
        run: |
          echo "Node version: ${{ steps.setup.outputs.node-version }}"
          echo "Cache hit: ${{ steps.setup.outputs.cache-hit }}"
          echo "Install time: ${{ steps.setup.outputs.install-time }}s"
      
      - name: Verify node works
        run: node --version

  # ========================================
  # TEST 2: Versión específica
  # ========================================
  test-node-18:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node 18
        uses: ./.github/actions/setup-node-env
        with:
          node-version: '18'
      
      - name: Verify version
        run: |
          NODE_VERSION=$(node --version)
          if [[ "$NODE_VERSION" != v18* ]]; then
            echo "ERROR: Expected Node 18, got $NODE_VERSION"
            exit 1
          fi
          echo "✅ Correct: $NODE_VERSION"

  # ========================================
  # TEST 3: Sin instalar dependencias
  # ========================================
  test-no-install:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup without install
        uses: ./.github/actions/setup-node-env
        with:
          install-dependencies: 'false'
      
      - name: Verify no node_modules
        run: |
          if [ -d "node_modules" ]; then
            echo "WARNING: node_modules exists"
          else
            echo "✅ Correct: no node_modules"
          fi
```

---

## ✅ Verificación

Tu ejercicio está completo si:

- [ ] La action se ejecuta sin errores
- [ ] Detecta correctamente el package manager
- [ ] El cache funciona en runs sucesivos
- [ ] Los outputs contienen valores correctos
- [ ] El summary se genera en la UI de GitHub

---

## 🎯 Desafíos Extra (Opcional)

1. **Añadir soporte para Bun** como package manager
2. **Input `audit`** que ejecute `npm audit` después de instalar
3. **Output `vulnerabilities`** con el conteo de vulnerabilidades

---

## 📚 Recursos

- [Composite Actions - GitHub Docs](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action)
- [actions/setup-node](https://github.com/actions/setup-node)
- [actions/cache](https://github.com/actions/cache)

---

[⬅️ Ejercicio anterior](../ejercicio-01-javascript-action/README.md) · [Siguiente: Ejercicio 03 →](../ejercicio-03-reusable-workflow/README.md)
