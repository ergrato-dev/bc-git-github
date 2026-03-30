# Lección 01: Introducción a GitHub Actions

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- Explicar qué es GitHub Actions y para qué se usa
- Identificar los componentes principales de la arquitectura
- Comprender los beneficios de la automatización con Actions
- Conocer los casos de uso más comunes

---

## 📖 ¿Qué es GitHub Actions?

**GitHub Actions** es una plataforma de automatización integrada en GitHub que permite crear flujos de trabajo (workflows) personalizados directamente en tu repositorio.

### Definición

> GitHub Actions es una plataforma de integración continua y entrega continua (CI/CD) que permite automatizar pipelines de build, test y deployment.

### Características Principales

| Característica | Descripción |
|----------------|-------------|
| **Integrado** | Nativo en GitHub, sin configuración externa |
| **YAML-based** | Definición declarativa de workflows |
| **Event-driven** | Se activa por eventos del repositorio |
| **Marketplace** | Miles de actions reutilizables |
| **Matrix builds** | Ejecutar en múltiples configuraciones |
| **Secretos** | Gestión segura de credenciales |

---

## 🏗️ Arquitectura de GitHub Actions

![Arquitectura de GitHub Actions](../0-assets/01-actions-architecture.svg)

### Componentes Principales

#### 1. Workflows

```yaml
# ¿Qué es?: Archivo YAML que define la automatización
# ¿Dónde vive?: .github/workflows/nombre.yml
# ¿Cuándo se ejecuta?: Cuando ocurre un evento configurado

name: CI Pipeline
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm test
```

**Características de Workflows:**
- Ubicados en `.github/workflows/`
- Formato YAML
- Pueden tener múltiples triggers
- Contienen uno o más jobs

#### 2. Events (Eventos)

Los eventos son actividades que disparan un workflow:

```yaml
# Eventos más comunes
on:
  push:                    # Push a cualquier branch
  pull_request:            # Actividad en PR
  schedule:                # Cron programado
  workflow_dispatch:       # Ejecución manual
  release:                 # Publicación de release
```

#### 3. Jobs

Los jobs son conjuntos de steps que se ejecutan en el mismo runner:

```yaml
jobs:
  build:                   # Nombre del job
    runs-on: ubuntu-latest # Runner a usar
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
  test:
    needs: build           # Dependencia entre jobs
    runs-on: ubuntu-latest
    steps:
      - run: npm test
```

**Comportamiento de Jobs:**
- Por defecto ejecutan en **paralelo**
- `needs:` define dependencias secuenciales
- Cada job corre en un **runner limpio**

#### 4. Steps

Los steps son las tareas individuales dentro de un job:

```yaml
steps:
  # Step usando una action
  - name: Checkout code
    uses: actions/checkout@v4
  
  # Step ejecutando comandos
  - name: Install dependencies
    run: npm ci
  
  # Step con múltiples comandos
  - name: Build and test
    run: |
      npm run build
      npm test
```

#### 5. Actions

Las actions son unidades reutilizables de código:

```yaml
# Action del marketplace
- uses: actions/checkout@v4

# Action con parámetros
- uses: actions/setup-node@v4
  with:
    node-version: '20'

# Action de otro repositorio
- uses: owner/repo@v1
```

#### 6. Runners

Los runners son las máquinas que ejecutan los jobs:

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| **GitHub-hosted** | Máquinas virtuales de GitHub | `ubuntu-latest` |
| **Self-hosted** | Tu propia infraestructura | `[self-hosted, linux]` |

```yaml
jobs:
  build:
    # GitHub-hosted runner
    runs-on: ubuntu-latest
  
  deploy:
    # Self-hosted runner
    runs-on: [self-hosted, linux, x64]
```

---

## 💡 Beneficios de GitHub Actions

### 1. Integración Nativa

```
Repository + Actions = Workflow completo
         ↓
   Sin herramientas externas
   Sin configuración de servidores
   Sin mantenimiento adicional
```

### 2. Automatización Completa

| Tarea | Automatización |
|-------|----------------|
| Tests | Ejecutar en cada push |
| Linting | Verificar estilo de código |
| Build | Compilar aplicación |
| Deploy | Desplegar a producción |
| Releases | Publicar versiones |
| Issues | Respuestas automáticas |

### 3. Ecosistema Rico

- **10,000+** actions en el marketplace
- Comunidad activa
- Actions oficiales de GitHub
- Fácil crear actions propias

### 4. Gratuito para Open Source

| Tipo de Repo | Minutos/mes | Almacenamiento |
|--------------|-------------|----------------|
| Público | ∞ Ilimitado | 500 MB |
| Privado (Free) | 2,000 min | 500 MB |
| Privado (Team) | 3,000 min | 2 GB |
| Privado (Enterprise) | 50,000 min | 50 GB |

---

## 🔧 Casos de Uso Comunes

### CI/CD Pipeline

```yaml
name: CI/CD
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm test
  
  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: ./deploy.sh
```

### Scheduled Tasks

```yaml
name: Daily Cleanup
on:
  schedule:
    - cron: '0 2 * * *'  # Cada día a las 2 AM

jobs:
  cleanup:
    runs-on: ubuntu-latest
    steps:
      - run: ./cleanup-old-data.sh
```

### Issue/PR Automation

```yaml
name: Auto Label
on:
  issues:
    types: [opened]

jobs:
  label:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/labeler@v4
```

### Multi-platform Testing

```yaml
name: Cross-platform Tests
on: push

jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node: [18, 20, 22]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      - run: npm test
```

---

## 📂 Estructura de Archivos

```
my-project/
├── .github/
│   └── workflows/
│       ├── ci.yml          # Pipeline de CI
│       ├── deploy.yml      # Deployment
│       ├── release.yml     # Releases
│       └── cron.yml        # Tareas programadas
├── src/
├── tests/
└── package.json
```

---

## 🎯 Tu Primer Workflow

```yaml
# .github/workflows/hello.yml
name: Hello World

on:
  push:
    branches: [main]
  workflow_dispatch:  # Permite ejecución manual

jobs:
  greet:
    runs-on: ubuntu-latest
    
    steps:
      - name: Say Hello
        run: echo "Hello, GitHub Actions!"
      
      - name: Show environment
        run: |
          echo "Repository: ${{ github.repository }}"
          echo "Branch: ${{ github.ref_name }}"
          echo "Actor: ${{ github.actor }}"
```

---

## ✅ Verificación de Conocimientos

1. ¿Dónde se almacenan los workflows?
2. ¿Cuál es la diferencia entre jobs y steps?
3. ¿Qué es un runner?
4. ¿Cómo se define la dependencia entre jobs?
5. ¿Qué son las actions del marketplace?

---

## 📚 Recursos

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)

---

[➡️ Siguiente: Sintaxis YAML](02-sintaxis-yaml.md)

---

_Lección 01 | Week 07 | GitHub Actions Fundamentos_
