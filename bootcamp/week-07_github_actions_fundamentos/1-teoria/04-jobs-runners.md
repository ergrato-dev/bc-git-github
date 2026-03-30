# Lección 04: Jobs y Runners

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- Configurar jobs con dependencias y condiciones
- Elegir el runner apropiado para cada tarea
- Implementar matrix strategy para tests paralelos
- Compartir datos entre jobs

---

## 📖 ¿Qué son los Jobs?

Los **jobs** son conjuntos de steps que se ejecutan en el mismo runner. Por defecto, los jobs corren en paralelo.

![Runners y Ejecución](../0-assets/04-runners-execution.svg)

---

## 🔧 Configuración de Jobs

### Estructura Básica

```yaml
jobs:
  # Identificador del job (snake_case o kebab-case)
  build:
    # Nombre visible en UI (opcional)
    name: Build Application
    
    # Runner donde ejecutar
    runs-on: ubuntu-latest
    
    # Steps a ejecutar
    steps:
      - uses: actions/checkout@v4
      - run: npm run build
```

### Propiedades de Jobs

```yaml
jobs:
  build:
    name: Build Application
    runs-on: ubuntu-latest
    
    # Timeout en minutos (default: 360)
    timeout-minutes: 30
    
    # Continuar aunque falle (default: false)
    continue-on-error: false
    
    # Condicional
    if: github.event_name == 'push'
    
    # Permisos específicos
    permissions:
      contents: read
      packages: write
    
    # Concurrencia
    concurrency:
      group: ${{ github.workflow }}-${{ github.ref }}
      cancel-in-progress: true
    
    # Variables de entorno del job
    env:
      NODE_ENV: production
    
    # Defaults para steps
    defaults:
      run:
        working-directory: ./app
        shell: bash
    
    steps:
      - run: echo "Building..."
```

---

## 🔗 Dependencias entre Jobs

### `needs` - Ejecución Secuencial

```yaml
jobs:
  # Job 1: Sin dependencias (corre primero)
  lint:
    runs-on: ubuntu-latest
    steps:
      - run: npm run lint

  # Job 2: Sin dependencias (corre en paralelo con lint)
  security:
    runs-on: ubuntu-latest
    steps:
      - run: npm audit

  # Job 3: Depende de lint
  build:
    needs: lint
    runs-on: ubuntu-latest
    steps:
      - run: npm run build

  # Job 4: Depende de múltiples jobs
  test:
    needs: [lint, build]
    runs-on: ubuntu-latest
    steps:
      - run: npm test

  # Job 5: Depende de todos los anteriores
  deploy:
    needs: [lint, security, build, test]
    runs-on: ubuntu-latest
    steps:
      - run: ./deploy.sh
```

**Diagrama de ejecución:**

```
    lint ────────┐
                 ├──► build ──► test ──┐
    security ───────────────────────────┼──► deploy
```

### Condicionales basadas en Jobs Previos

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: npm run build

  deploy:
    needs: build
    # Solo si build fue exitoso
    if: needs.build.result == 'success'
    runs-on: ubuntu-latest
    steps:
      - run: ./deploy.sh

  notify-failure:
    needs: build
    # Solo si build falló
    if: failure()
    runs-on: ubuntu-latest
    steps:
      - run: echo "Build failed!"

  cleanup:
    needs: [build, deploy]
    # Siempre ejecutar (para limpieza)
    if: always()
    runs-on: ubuntu-latest
    steps:
      - run: ./cleanup.sh
```

---

## 🖥️ Runners

### GitHub-hosted Runners

Máquinas virtuales mantenidas por GitHub.

| Runner | OS | Arquitectura | Specs |
|--------|-----|--------------|-------|
| `ubuntu-latest` | Ubuntu 22.04 | x64 | 2-core, 7 GB RAM |
| `ubuntu-22.04` | Ubuntu 22.04 | x64 | 2-core, 7 GB RAM |
| `ubuntu-20.04` | Ubuntu 20.04 | x64 | 2-core, 7 GB RAM |
| `windows-latest` | Windows Server 2022 | x64 | 2-core, 7 GB RAM |
| `windows-2022` | Windows Server 2022 | x64 | 2-core, 7 GB RAM |
| `macos-latest` | macOS 14 (Sonoma) | ARM64 | 3-core, 7 GB RAM |
| `macos-14` | macOS 14 (Sonoma) | ARM64 | 3-core, 7 GB RAM |
| `macos-13` | macOS 13 (Ventura) | x64 | 3-core, 14 GB RAM |

```yaml
jobs:
  linux:
    runs-on: ubuntu-latest
    steps:
      - run: uname -a

  windows:
    runs-on: windows-latest
    steps:
      - run: systeminfo

  macos:
    runs-on: macos-latest
    steps:
      - run: sw_vers
```

### Larger Runners (GitHub Team/Enterprise)

```yaml
jobs:
  build:
    # 4 cores, 16 GB RAM
    runs-on: ubuntu-latest-4-cores
    
  heavy-build:
    # 8 cores, 32 GB RAM
    runs-on: ubuntu-latest-8-cores
```

### Self-hosted Runners

```yaml
jobs:
  build:
    # Runner con label específico
    runs-on: self-hosted
    
  gpu-task:
    # Múltiples labels
    runs-on: [self-hosted, linux, x64, gpu]
```

**Configurar self-hosted runner:**

1. Settings > Actions > Runners > New self-hosted runner
2. Descargar y ejecutar el script
3. Configurar como servicio (opcional)

---

## 🎲 Matrix Strategy

Ejecuta el mismo job con diferentes configuraciones.

### Matrix Básica

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20, 22]
    
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test
```

Esto crea **3 jobs paralelos**: Node 18, Node 20, Node 22.

### Matrix Multi-dimensional

```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node: [18, 20, 22]
    
    runs-on: ${{ matrix.os }}
    
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      - run: npm test
```

Esto crea **9 jobs** (3 OS × 3 versiones Node).

### Matrix con Include/Exclude

```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        node: [18, 20]
        
        # Excluir combinaciones
        exclude:
          - os: windows-latest
            node: 18
        
        # Añadir configuraciones específicas
        include:
          - os: ubuntu-latest
            node: 22
            experimental: true
          
          - os: macos-latest
            node: 20
    
    runs-on: ${{ matrix.os }}
    
    # Continuar si experimental falla
    continue-on-error: ${{ matrix.experimental == true }}
    
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
```

### Fail-fast

```yaml
jobs:
  test:
    strategy:
      # Si uno falla, cancelar los demás (default: true)
      fail-fast: true
      
      # Máximo de jobs paralelos (default: sin límite)
      max-parallel: 2
      
      matrix:
        node: [18, 20, 22]
    
    runs-on: ubuntu-latest
    steps:
      - run: npm test
```

---

## 📤 Compartir Datos entre Jobs

### Artifacts

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run build
      
      # Subir artifact
      - uses: actions/upload-artifact@v4
        with:
          name: build-output
          path: dist/
          retention-days: 5

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      # Descargar artifact
      - uses: actions/download-artifact@v4
        with:
          name: build-output
          path: dist/
      
      - run: ls -la dist/
      - run: ./deploy.sh
```

### Outputs de Jobs

```yaml
jobs:
  setup:
    runs-on: ubuntu-latest
    # Declarar outputs del job
    outputs:
      version: ${{ steps.get-version.outputs.version }}
      should-deploy: ${{ steps.check.outputs.deploy }}
    
    steps:
      - name: Get version
        id: get-version
        run: |
          VERSION=$(cat package.json | jq -r .version)
          echo "version=$VERSION" >> $GITHUB_OUTPUT
      
      - name: Check deploy
        id: check
        run: |
          if [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
            echo "deploy=true" >> $GITHUB_OUTPUT
          else
            echo "deploy=false" >> $GITHUB_OUTPUT
          fi

  build:
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - run: |
          echo "Building version: ${{ needs.setup.outputs.version }}"

  deploy:
    needs: [setup, build]
    if: needs.setup.outputs.should-deploy == 'true'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

---

## 🔒 Permissions

Controla los permisos del GITHUB_TOKEN.

```yaml
# Nivel workflow
permissions:
  contents: read
  issues: write
  pull-requests: write

jobs:
  build:
    runs-on: ubuntu-latest
    # Nivel job (override)
    permissions:
      contents: read
      packages: write
    
    steps:
      - uses: actions/checkout@v4
```

**Permisos disponibles:**

| Permiso | Descripción |
|---------|-------------|
| `actions` | Workflows |
| `contents` | Código, releases |
| `issues` | Issues |
| `pull-requests` | Pull Requests |
| `packages` | GitHub Packages |
| `deployments` | Deployments |
| `security-events` | Code scanning |
| `id-token` | OIDC tokens |

---

## 🌍 Environments

```yaml
jobs:
  deploy-staging:
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.example.com
    steps:
      - run: ./deploy.sh staging

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://example.com
    steps:
      - run: ./deploy.sh production
```

Los environments permiten:
- Secrets específicos por ambiente
- Reglas de protección (approvals)
- Límites de deployments

---

## ⚙️ Services (Containers)

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    
    # Servicios como contenedores
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
      
      redis:
        image: redis:7
        ports:
          - 6379:6379
    
    steps:
      - uses: actions/checkout@v4
      - run: npm test
        env:
          DATABASE_URL: postgres://postgres:postgres@localhost:5432/test
          REDIS_URL: redis://localhost:6379
```

---

## ✅ Mejores Prácticas

### 1. Organización de Jobs

```yaml
jobs:
  # Fase 1: Validación rápida
  lint:
    runs-on: ubuntu-latest
    steps: [...]

  # Fase 2: Build
  build:
    needs: lint
    runs-on: ubuntu-latest
    steps: [...]

  # Fase 3: Tests (paralelo)
  unit-tests:
    needs: build
    runs-on: ubuntu-latest
    steps: [...]
  
  integration-tests:
    needs: build
    runs-on: ubuntu-latest
    steps: [...]

  # Fase 4: Deploy
  deploy:
    needs: [unit-tests, integration-tests]
    runs-on: ubuntu-latest
    steps: [...]
```

### 2. Reutilizar con Composite Actions

```yaml
# .github/actions/setup/action.yml
name: Setup
runs:
  using: composite
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-node@v4
      with:
        node-version: '20'
        cache: 'npm'
    - run: npm ci
      shell: bash
```

### 3. Timeouts Apropiados

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 15  # No esperar 6 horas
```

---

## 📚 Recursos

- [Jobs Documentation](https://docs.github.com/en/actions/using-jobs)
- [Using Matrix](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs)
- [About Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)

---

[⬅️ Anterior: Events y Triggers](03-events-triggers.md)

---

_Lección 04 | Week 07 | GitHub Actions Fundamentos_
