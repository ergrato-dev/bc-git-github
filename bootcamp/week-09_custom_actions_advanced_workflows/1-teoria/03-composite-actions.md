# 📚 Lección 03: Composite Actions

> **Duración estimada**: 25 minutos  
> **Nivel**: Intermedio  
> **Prerequisitos**: Lecciones 01-02, experiencia con workflows YAML

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- [ ] Crear Composite Actions usando solo YAML
- [ ] Reutilizar steps y otras actions dentro de una composite
- [ ] Definir inputs, outputs y valores calculados
- [ ] Aplicar best practices para mantenibilidad

---

## 📖 Contenido Teórico

### 1. ¿Qué son las Composite Actions?

Las **Composite Actions** permiten agrupar múltiples steps en una sola action reutilizable, usando únicamente YAML (sin necesidad de código JavaScript o Docker).

**Ventajas principales**:
- ✅ Sin compilación ni runtime especial
- ✅ Pueden incluir otras actions (`uses:`)
- ✅ Soportan múltiples shells (bash, pwsh, python, etc.)
- ✅ Fácil de mantener y debuggear
- ✅ Ideales para setups y configuraciones repetitivas

---

### 2. Estructura Básica

```yaml
# action.yml
name: 'My Composite Action'
description: 'Does multiple things in sequence'
author: 'your-username'

inputs:
  node-version:
    description: 'Node.js version to use'
    required: false
    default: '20'

outputs:
  cache-hit:
    description: 'Whether cache was hit'
    value: ${{ steps.cache.outputs.cache-hit }}

runs:
  using: 'composite'           # <-- Indica que es composite
  steps:
    - name: Step 1
      run: echo "Hello"
      shell: bash              # <-- OBLIGATORIO en composite
    
    - name: Step 2
      uses: actions/setup-node@v4
      with:
        node-version: ${{ inputs.node-version }}
    
    - name: Step 3
      id: cache
      uses: actions/cache@v4
      with:
        path: node_modules
        key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
```

> **⚠️ Importante**: En composite actions, el atributo `shell` es **obligatorio** para cada step que use `run`.

---

### 3. Ejemplo Práctico: Setup de Node.js

Una composite action común es configurar el ambiente de desarrollo:

```yaml
# .github/actions/setup-node-env/action.yml
name: 'Setup Node Environment'
description: 'Install Node.js, cache dependencies, and run npm install'
author: 'DevOps Team'

inputs:
  node-version:
    description: 'Node.js version'
    required: false
    default: '20'
  
  install-command:
    description: 'Command to install dependencies'
    required: false
    default: 'npm ci'
  
  working-directory:
    description: 'Directory with package.json'
    required: false
    default: '.'

outputs:
  cache-hit:
    description: 'Was npm cache hit?'
    value: ${{ steps.npm-cache.outputs.cache-hit }}
  
  node-version:
    description: 'Actual Node.js version installed'
    value: ${{ steps.setup-node.outputs.node-version }}

runs:
  using: 'composite'
  steps:
    # ========================================
    # PASO 1: Instalar Node.js
    # ========================================
    # ¿Qué hace?: Configura la versión específica de Node.js
    # ¿Por qué?: Garantiza consistencia entre entornos
    # ¿Para qué sirve?: El proyecto necesita una versión específica
    
    - name: Setup Node.js ${{ inputs.node-version }}
      id: setup-node
      uses: actions/setup-node@v4
      with:
        node-version: ${{ inputs.node-version }}
    
    # ========================================
    # PASO 2: Cache de dependencias
    # ========================================
    # ¿Qué hace?: Cachea node_modules para acelerar builds
    # ¿Por qué?: npm install es lento, el cache lo acelera
    # ¿Para qué sirve?: Reducir tiempo de CI de minutos a segundos
    
    - name: Cache npm dependencies
      id: npm-cache
      uses: actions/cache@v4
      with:
        path: |
          ~/.npm
          ${{ inputs.working-directory }}/node_modules
        key: ${{ runner.os }}-node-${{ inputs.node-version }}-${{ hashFiles(format('{0}/package-lock.json', inputs.working-directory)) }}
        restore-keys: |
          ${{ runner.os }}-node-${{ inputs.node-version }}-
    
    # ========================================
    # PASO 3: Instalar dependencias
    # ========================================
    # ¿Qué hace?: Ejecuta npm ci (o comando personalizado)
    # ¿Por qué?: Solo si el cache no estaba disponible
    # ¿Para qué sirve?: Tener las dependencias listas
    
    - name: Install dependencies
      if: steps.npm-cache.outputs.cache-hit != 'true'
      run: ${{ inputs.install-command }}
      shell: bash
      working-directory: ${{ inputs.working-directory }}
    
    # ========================================
    # PASO 4: Mostrar versiones
    # ========================================
    # ¿Qué hace?: Log informativo de versiones
    # ¿Por qué?: Útil para debugging
    # ¿Para qué sirve?: Verificar que todo está correcto
    
    - name: Show environment info
      run: |
        echo "Node.js: $(node --version)"
        echo "npm: $(npm --version)"
        echo "Cache hit: ${{ steps.npm-cache.outputs.cache-hit }}"
      shell: bash
```

**Uso en workflow**:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup environment
        id: setup
        uses: ./.github/actions/setup-node-env
        with:
          node-version: '20'
      
      - name: Check setup
        run: |
          echo "Cache was hit: ${{ steps.setup.outputs.cache-hit }}"
          echo "Node version: ${{ steps.setup.outputs.node-version }}"
```

---

### 4. Paso de Outputs Entre Steps

En composite actions, los outputs se definen usando `${{ steps.ID.outputs.NOMBRE }}`:

```yaml
runs:
  using: 'composite'
  steps:
    # Step que genera un output
    - name: Calculate version
      id: version
      run: |
        VERSION=$(cat package.json | jq -r '.version')
        echo "version=$VERSION" >> $GITHUB_OUTPUT
      shell: bash
    
    # Step que usa el output anterior
    - name: Use version
      run: echo "Version is ${{ steps.version.outputs.version }}"
      shell: bash

outputs:
  version:
    description: 'Package version'
    value: ${{ steps.version.outputs.version }}
```

---

### 5. Shells Disponibles

Las composite actions soportan múltiples shells:

| Shell | Plataformas | Ejemplo |
|-------|-------------|---------|
| `bash` | Linux, macOS, Windows (con Git Bash) | Default recomendado |
| `pwsh` | Todas (PowerShell Core) | Scripts Windows |
| `python` | Todas (si está instalado) | Scripts Python inline |
| `sh` | Linux, macOS | POSIX shell |
| `cmd` | Windows | Batch scripts |
| `powershell` | Windows | PowerShell 5.1 |

**Ejemplo con múltiples shells**:

```yaml
runs:
  using: 'composite'
  steps:
    - name: Bash script
      run: echo "Running in bash"
      shell: bash
    
    - name: Python script
      run: |
        import os
        print(f"Python version: {os.sys.version}")
      shell: python
    
    - name: PowerShell script
      run: Write-Host "Running in PowerShell"
      shell: pwsh
```

---

### 6. Condicionales en Composite Actions

```yaml
runs:
  using: 'composite'
  steps:
    # Condicional basado en input
    - name: Run tests
      if: ${{ inputs.run-tests == 'true' }}
      run: npm test
      shell: bash
    
    # Condicional basado en OS
    - name: Windows-specific setup
      if: runner.os == 'Windows'
      run: echo "Windows detected"
      shell: bash
    
    # Condicional basado en output de step anterior
    - name: Only on cache miss
      if: steps.cache.outputs.cache-hit != 'true'
      run: npm ci
      shell: bash
```

---

### 7. Ejemplo Avanzado: Linter Multi-Lenguaje

```yaml
# .github/actions/lint-code/action.yml
name: 'Multi-Language Linter'
description: 'Run linters for JS, Python, and Markdown'

inputs:
  lint-js:
    description: 'Run ESLint'
    default: 'true'
  lint-python:
    description: 'Run flake8'
    default: 'false'
  lint-markdown:
    description: 'Run markdownlint'
    default: 'true'
  fail-on-error:
    description: 'Fail workflow on lint errors'
    default: 'true'

outputs:
  js-result:
    description: 'ESLint result'
    value: ${{ steps.eslint.outcome }}
  python-result:
    description: 'Flake8 result'
    value: ${{ steps.flake8.outcome }}

runs:
  using: 'composite'
  steps:
    # ========================================
    # JavaScript Linting
    # ========================================
    - name: Run ESLint
      id: eslint
      if: ${{ inputs.lint-js == 'true' }}
      continue-on-error: ${{ inputs.fail-on-error != 'true' }}
      run: |
        echo "🔍 Running ESLint..."
        npx eslint . --ext .js,.ts --format stylish
      shell: bash
    
    # ========================================
    # Python Linting
    # ========================================
    - name: Setup Python
      if: ${{ inputs.lint-python == 'true' }}
      uses: actions/setup-python@v5
      with:
        python-version: '3.11'
    
    - name: Run flake8
      id: flake8
      if: ${{ inputs.lint-python == 'true' }}
      continue-on-error: ${{ inputs.fail-on-error != 'true' }}
      run: |
        echo "🐍 Running flake8..."
        uvx flake8 . --count --show-source --statistics
      shell: bash
    
    # ========================================
    # Markdown Linting
    # ========================================
    - name: Run markdownlint
      id: mdlint
      if: ${{ inputs.lint-markdown == 'true' }}
      continue-on-error: ${{ inputs.fail-on-error != 'true' }}
      run: |
        echo "📝 Running markdownlint..."
        npx markdownlint-cli '**/*.md' --ignore node_modules
      shell: bash
    
    # ========================================
    # Summary
    # ========================================
    - name: Lint Summary
      run: |
        echo "## Lint Results" >> $GITHUB_STEP_SUMMARY
        echo "| Linter | Status |" >> $GITHUB_STEP_SUMMARY
        echo "|--------|--------|" >> $GITHUB_STEP_SUMMARY
        echo "| ESLint | ${{ steps.eslint.outcome || 'skipped' }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Flake8 | ${{ steps.flake8.outcome || 'skipped' }} |" >> $GITHUB_STEP_SUMMARY
        echo "| Markdownlint | ${{ steps.mdlint.outcome || 'skipped' }} |" >> $GITHUB_STEP_SUMMARY
      shell: bash
```

---

### 8. Best Practices

#### ✅ DO (Hacer)

```yaml
# 1. Siempre especificar shell
- run: echo "Hello"
  shell: bash

# 2. Usar inputs con defaults sensatos
inputs:
  cache:
    default: 'true'

# 3. Documentar cada step
- name: Install dependencies  # Nombre descriptivo
  run: npm ci
  shell: bash

# 4. Usar continue-on-error sabiamente
- name: Optional check
  continue-on-error: true
  run: npm audit
  shell: bash
```

#### ❌ DON'T (No hacer)

```yaml
# 1. NO olvidar shell (causa error)
- run: echo "Hello"
  # shell: bash  <-- Error!

# 2. NO usar rutas absolutas hardcodeadas
- run: /home/runner/script.sh
  # Usar: ${{ github.workspace }}/script.sh

# 3. NO asumir herramientas instaladas
- run: jq '.version' package.json
  # Verificar primero o instalar
```

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **Composite Action** | Action definida solo en YAML, agrupa steps |
| **runs.using: composite** | Indica el tipo de action |
| **shell** | Obligatorio en cada step `run` |
| **inputs/outputs** | Igual que JavaScript actions |
| **uses dentro** | Puede llamar otras actions |

---

## 🔗 Recursos Adicionales

- [📖 Composite Actions - GitHub Docs](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action)
- [📦 Ejemplos oficiales](https://github.com/actions/composite-action-example)

---

## ⏭️ Siguiente Lección

[Lección 04: Reusable Workflows y Dispatch Events →](04-reusable-workflows.md)

---

[⬅️ Lección anterior](02-javascript-actions.md) · [📋 Semana 09](../README.md)
