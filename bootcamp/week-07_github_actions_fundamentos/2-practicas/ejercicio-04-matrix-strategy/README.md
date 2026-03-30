# Ejercicio 04: Matrix Strategy

## 🎯 Objetivo

Implementar matrix strategy para ejecutar tests en múltiples versiones de Node.js y sistemas operativos.

**Duración estimada:** 45 minutos

---

## 📋 Requisitos Previos

- Completar Ejercicios 01-03
- Repositorio actions-lab con proyecto Node.js

---

## 📝 Descripción

En este ejercicio implementarás:
1. Matrix básica con múltiples versiones
2. Matrix multi-dimensional (OS + versión)
3. Include/exclude para casos especiales
4. Fail-fast y max-parallel
5. Outputs condicionales por matrix

---

## 🚀 Instrucciones

### Paso 1: Matrix Básica

```bash
cd actions-lab

cat > .github/workflows/matrix-basic.yml << 'EOF'
# ============================================
# WORKFLOW: Matrix Strategy Básica
# ============================================
name: Matrix - Node Versions

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  test:
    name: Test Node ${{ matrix.node-version }}
    runs-on: ubuntu-latest
    
    # ================================
    # MATRIX STRATEGY
    # ================================
    # ¿QUÉ HACE?: Ejecuta el job múltiples veces con diferentes configuraciones
    # ¿POR QUÉ?: Probar compatibilidad con diferentes versiones
    # ¿PARA QUÉ?: Asegurar que el código funciona en múltiples entornos
    strategy:
      matrix:
        node-version: [18, 20, 22]
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      
      - name: Show Node version
        run: |
          echo "🟢 Node.js version:"
          node --version
          npm --version
      
      - name: Run tests
        run: npm test
      
      - name: Test result
        run: |
          echo "✅ Tests passed on Node ${{ matrix.node-version }}"
EOF
```

### Paso 2: Matrix Multi-dimensional

```bash
cat > .github/workflows/matrix-multi.yml << 'EOF'
# ============================================
# WORKFLOW: Matrix Multi-dimensional
# ============================================
name: Matrix - OS and Node

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  test:
    name: ${{ matrix.os }} / Node ${{ matrix.node }}
    
    # ================================
    # MATRIX MULTI-DIMENSIONAL
    # ================================
    strategy:
      # Continuar con otros jobs si uno falla
      fail-fast: false
      
      # Máximo de jobs paralelos
      max-parallel: 4
      
      matrix:
        # 3 sistemas operativos
        os: [ubuntu-latest, windows-latest, macos-latest]
        # 3 versiones de Node
        node: [18, 20, 22]
    
    # El runner cambia según la matrix
    runs-on: ${{ matrix.os }}
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      
      - name: Show environment
        run: |
          echo "🖥️ OS: ${{ matrix.os }}"
          echo "🟢 Node: ${{ matrix.node }}"
          node --version
        shell: bash
      
      - name: Run tests
        run: npm test
        shell: bash
EOF
```

### Paso 3: Matrix con Include/Exclude

```bash
cat > .github/workflows/matrix-advanced.yml << 'EOF'
# ============================================
# WORKFLOW: Matrix Avanzada
# ============================================
name: Matrix - Advanced

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  test:
    name: ${{ matrix.os }} / Node ${{ matrix.node }}${{ matrix.experimental && ' (experimental)' || '' }}
    
    strategy:
      fail-fast: false
      
      matrix:
        os: [ubuntu-latest, windows-latest]
        node: [18, 20]
        
        # ================================
        # EXCLUDE: Quitar combinaciones
        # ================================
        exclude:
          # No probar Node 18 en Windows
          - os: windows-latest
            node: 18
        
        # ================================
        # INCLUDE: Añadir configuraciones
        # ================================
        include:
          # Añadir Node 22 solo en Ubuntu (experimental)
          - os: ubuntu-latest
            node: 22
            experimental: true
          
          # Añadir macOS con Node 20
          - os: macos-latest
            node: 20
            experimental: false
          
          # Configuración especial con variables extra
          - os: ubuntu-latest
            node: 20
            npm-version: 10
            coverage: true
    
    runs-on: ${{ matrix.os }}
    
    # Permitir fallo en experimentales
    continue-on-error: ${{ matrix.experimental || false }}
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      
      # Actualizar npm si se especifica
      - name: Update npm
        if: matrix.npm-version
        run: npm install -g npm@${{ matrix.npm-version }}
        shell: bash
      
      - name: Show configuration
        run: |
          echo "📋 Matrix Configuration"
          echo "======================"
          echo "OS: ${{ matrix.os }}"
          echo "Node: ${{ matrix.node }}"
          echo "Experimental: ${{ matrix.experimental || 'false' }}"
          echo "Coverage: ${{ matrix.coverage || 'false' }}"
          echo ""
          echo "Versions:"
          node --version
          npm --version
        shell: bash
      
      - name: Run tests
        run: npm test
        shell: bash
      
      # Step condicional por matrix
      - name: Run coverage
        if: matrix.coverage == true
        run: |
          echo "📊 Running coverage report..."
          echo "Coverage would be generated here"
        shell: bash
      
      - name: Experimental notice
        if: matrix.experimental == true
        run: |
          echo "⚠️ This is an experimental configuration"
          echo "Failures are allowed but logged"
        shell: bash
EOF
```

### Paso 4: Matrix Dinámica con Outputs

```bash
cat > .github/workflows/matrix-dynamic.yml << 'EOF'
# ============================================
# WORKFLOW: Matrix Dinámica
# ============================================
name: Matrix - Dynamic

on:
  workflow_dispatch:
    inputs:
      include-experimental:
        description: 'Include experimental versions'
        type: boolean
        default: false

jobs:
  # ------------------------------------
  # Job 1: Generar Matrix
  # ------------------------------------
  setup:
    name: Setup Matrix
    runs-on: ubuntu-latest
    
    outputs:
      matrix: ${{ steps.set-matrix.outputs.matrix }}
    
    steps:
      - name: Set matrix
        id: set-matrix
        run: |
          if [ "${{ inputs.include-experimental }}" == "true" ]; then
            # Matrix con experimental
            echo 'matrix={"node":[18,20,22],"os":["ubuntu-latest","windows-latest","macos-latest"]}' >> $GITHUB_OUTPUT
          else
            # Matrix estándar
            echo 'matrix={"node":[18,20],"os":["ubuntu-latest","windows-latest"]}' >> $GITHUB_OUTPUT
          fi
      
      - name: Show matrix
        run: |
          echo "Generated matrix:"
          echo '${{ steps.set-matrix.outputs.matrix }}'

  # ------------------------------------
  # Job 2: Test con Matrix Dinámica
  # ------------------------------------
  test:
    name: Test ${{ matrix.os }} / Node ${{ matrix.node }}
    needs: setup
    runs-on: ${{ matrix.os }}
    
    strategy:
      fail-fast: false
      matrix: ${{ fromJSON(needs.setup.outputs.matrix) }}
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      
      - name: Run tests
        run: npm test
        shell: bash

  # ------------------------------------
  # Job 3: Resumen
  # ------------------------------------
  summary:
    name: Summary
    needs: test
    runs-on: ubuntu-latest
    if: always()
    
    steps:
      - name: Results
        run: |
          echo "📊 Test Results"
          echo "==============="
          echo "Status: ${{ needs.test.result }}"
          echo "Experimental included: ${{ inputs.include-experimental }}"
EOF
```

### Paso 5: Probar las Matrices

```bash
# Commit todos los workflows
git add .
git commit -m "feat: add matrix strategy workflows"
git push

# Ver las ejecuciones
gh run list

# Ejecutar matrix dinámica sin experimental
gh workflow run matrix-dynamic.yml -f include-experimental=false

# Ejecutar matrix dinámica con experimental
gh workflow run matrix-dynamic.yml -f include-experimental=true
```

---

## 📊 Visualización de Matrix

```
Matrix básica (3 jobs):
┌─────────────────┐
│ Node 18         │
├─────────────────┤
│ Node 20         │
├─────────────────┤
│ Node 22         │
└─────────────────┘

Matrix multi-dimensional (9 jobs):
┌─────────────────┬─────────────────┬─────────────────┐
│ Ubuntu + 18     │ Ubuntu + 20     │ Ubuntu + 22     │
├─────────────────┼─────────────────┼─────────────────┤
│ Windows + 18    │ Windows + 20    │ Windows + 22    │
├─────────────────┼─────────────────┼─────────────────┤
│ macOS + 18      │ macOS + 20      │ macOS + 22      │
└─────────────────┴─────────────────┴─────────────────┘
```

---

## ✅ Verificación

- [ ] Matrix básica crea 3 jobs paralelos
- [ ] Matrix multi genera 9 combinaciones (3x3)
- [ ] `exclude` elimina combinaciones no deseadas
- [ ] `include` añade configuraciones específicas
- [ ] `fail-fast: false` permite que continúen otros jobs
- [ ] `continue-on-error` permite fallo en experimentales
- [ ] Matrix dinámica se genera en runtime

---

## 🎯 Desafío Extra

1. Crear matrix para múltiples bases de datos (postgres, mysql, sqlite)
2. Usar `services` con diferentes versiones en matrix
3. Generar reporte consolidado de todas las combinaciones

```yaml
# Hint: Matrix con services
jobs:
  test:
    strategy:
      matrix:
        db: [postgres:13, postgres:15, mysql:8]
    
    services:
      database:
        image: ${{ matrix.db }}
        # ...
```

---

## 📚 Conceptos Aprendidos

| Concepto | Descripción |
|----------|-------------|
| `strategy.matrix` | Definir combinaciones de configuración |
| `matrix.include` | Añadir configuraciones extra |
| `matrix.exclude` | Excluir combinaciones específicas |
| `fail-fast` | Cancelar todo si uno falla |
| `max-parallel` | Limitar jobs simultáneos |
| `continue-on-error` | Permitir fallos selectivos |
| `fromJSON()` | Parsear JSON para matrix dinámica |

---

## 🧹 Limpieza

```bash
# Los workflows quedarán en el repo
# Puedes eliminar los que no necesites:
rm .github/workflows/matrix-*.yml
git add .
git commit -m "chore: cleanup matrix workflows"
git push
```

---

[⬅️ Anterior: Marketplace Actions](../ejercicio-03-marketplace-actions/)

---

_Ejercicio 04 | Week 07 | GitHub Actions Fundamentos_
