# 📖 Glosario - Semana 07: GitHub Actions Fundamentos

Términos clave y definiciones sobre GitHub Actions, CI/CD y automatización de workflows.

---

## 🔤 Índice Alfabético

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [E](#e) | [F](#f) | [G](#g) | [H](#h) | [I](#i) | [J](#j) | [K](#k) | [L](#l) | [M](#m) | [N](#n) | [O](#o) | [P](#p) | [R](#r) | [S](#s) | [T](#t) | [U](#u) | [V](#v) | [W](#w) | [Y](#y)

---

## A

### Action
**Definición:** Unidad de código reutilizable que realiza una tarea específica dentro de un workflow. Puede ser creada por GitHub, la comunidad, o personalizada.

**Ejemplo:**
```yaml
- uses: actions/checkout@v4  # Action del marketplace
```

**Tipos:** JavaScript actions, Docker actions, Composite actions

---

### Artifact
**Definición:** Archivo o conjunto de archivos generados durante la ejecución de un workflow que pueden ser almacenados y descargados posteriormente.

**Ejemplo:**
```yaml
- uses: actions/upload-artifact@v4
  with:
    name: my-artifact
    path: dist/
```

**Uso común:** Reports de tests, builds compilados, logs

---

## B

### Badge
**Definición:** Imagen dinámica que muestra el estado actual de un workflow. Se incluye en el README para mostrar si el CI está pasando o fallando.

**Sintaxis:**
```markdown
![CI](https://github.com/user/repo/actions/workflows/ci.yml/badge.svg)
```

---

### Build
**Definición:** Proceso de compilar, transpilar o empaquetar código fuente en un formato ejecutable o distribuible.

**Contexto CI/CD:** El job de build típicamente transforma código en artifacts listos para deployment.

---

## C

### Cache
**Definición:** Mecanismo para almacenar dependencias entre ejecuciones de workflows, reduciendo el tiempo de instalación.

**Ejemplo:**
```yaml
- uses: actions/cache@v4
  with:
    path: node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

---

### CD (Continuous Deployment/Delivery)
**Definición:** Práctica de automatizar el proceso de despliegue de aplicaciones a producción (Deployment) o preparar releases para despliegue manual (Delivery).

**Relación:** Extiende CI agregando automatización post-testing.

---

### CI (Continuous Integration)
**Definición:** Práctica de desarrollo donde los cambios de código se integran frecuentemente al repositorio principal, ejecutando builds y tests automatizados.

**Beneficios:** Detección temprana de errores, integración constante, feedback rápido.

---

### Composite Action
**Definición:** Tipo de action que combina múltiples steps en una sola action reutilizable, definida en YAML.

**Archivo:** `action.yml` en el repositorio de la action

---

### Concurrency
**Definición:** Control que permite limitar ejecuciones simultáneas de workflows o jobs, útil para evitar deployments paralelos.

**Ejemplo:**
```yaml
concurrency:
  group: ${{ github.ref }}
  cancel-in-progress: true
```

---

### Context
**Definición:** Objeto que contiene información sobre la ejecución del workflow, como datos del evento, repositorio, runner, etc.

**Contextos disponibles:**
- `github` - información del evento y repo
- `env` - variables de entorno
- `job` - información del job actual
- `steps` - outputs de steps anteriores
- `runner` - información del runner
- `secrets` - secretos configurados
- `matrix` - valores de matrix strategy

---

## D

### Default Shell
**Definición:** El shell utilizado por defecto para ejecutar comandos `run`. Varía según el sistema operativo del runner.

**Valores:**
- Linux/macOS: `bash`
- Windows: `pwsh` (PowerShell Core)

---

### Dependent Job
**Definición:** Job que requiere la finalización exitosa de otro(s) job(s) antes de ejecutarse.

**Ejemplo:**
```yaml
deploy:
  needs: [build, test]  # Espera a build Y test
```

---

## E

### Environment
**Definición:** Contexto de despliegue con reglas de protección, secretos específicos y URLs asociadas.

**Uso:**
```yaml
jobs:
  deploy:
    environment: production
```

---

### Event
**Definición:** Actividad específica que dispara la ejecución de un workflow.

**Ejemplos:** `push`, `pull_request`, `schedule`, `workflow_dispatch`

---

### Expression
**Definición:** Sintaxis especial para evaluar valores dinámicamente dentro de workflows.

**Sintaxis:** `${{ <expression> }}`

**Ejemplos:**
```yaml
${{ github.actor }}
${{ secrets.TOKEN }}
${{ matrix.node-version }}
```

---

## F

### Fail-fast
**Definición:** Estrategia de matrix que cancela todos los jobs restantes cuando uno falla. Por defecto está activada.

**Ejemplo:**
```yaml
strategy:
  fail-fast: false  # Continuar aunque falle un job
```

---

### Filter
**Definición:** Mecanismo para limitar cuándo se ejecuta un workflow basándose en branches, paths, o tags.

**Ejemplo:**
```yaml
on:
  push:
    branches: [main, develop]
    paths: ['src/**', 'tests/**']
```

---

## G

### GitHub-hosted Runner
**Definición:** Máquina virtual proporcionada y mantenida por GitHub para ejecutar workflows.

**Disponibles:**
- `ubuntu-latest`, `ubuntu-22.04`, `ubuntu-20.04`
- `windows-latest`, `windows-2022`
- `macos-latest`, `macos-14`, `macos-13`

---

## H

### Hook
**Definición:** Punto de integración donde GitHub puede ejecutar código en respuesta a eventos. En Actions, los hooks son los events que disparan workflows.

---

## I

### If (Conditional)
**Definición:** Expresión condicional que determina si un step o job debe ejecutarse.

**Ejemplo:**
```yaml
- run: echo "Solo en main"
  if: github.ref == 'refs/heads/main'
```

---

### Input
**Definición:** Parámetro que una action o workflow acepta para personalizar su comportamiento.

**En workflow_dispatch:**
```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        required: true
        type: choice
```

---

## J

### Job
**Definición:** Conjunto de steps que se ejecutan en el mismo runner. Los jobs pueden ejecutarse en paralelo o secuencialmente.

**Estructura:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: npm build
```

---

### Job Matrix
**Definición:** Ver [Matrix Strategy](#matrix-strategy)

---

## K

### Key (Cache)
**Definición:** Identificador único usado para guardar y recuperar elementos del cache.

**Best practice:** Incluir hash de archivos de lock
```yaml
key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}
```

---

## L

### Label (Runner)
**Definición:** Etiqueta asociada a un runner que permite seleccionarlo en `runs-on`.

**Ejemplo:** `ubuntu-latest`, `self-hosted`, `gpu`

---

## M

### Marketplace
**Definición:** Repositorio central de GitHub donde se publican y descubren actions creadas por la comunidad y GitHub.

**URL:** [github.com/marketplace?type=actions](https://github.com/marketplace?type=actions)

---

### Matrix Strategy
**Definición:** Configuración que permite ejecutar un job múltiples veces con diferentes combinaciones de variables.

**Ejemplo:**
```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node: [18, 20, 22]
```

---

## N

### Needs
**Definición:** Palabra clave que define dependencias entre jobs, estableciendo orden de ejecución.

**Sintaxis:**
```yaml
deploy:
  needs: build  # o needs: [build, test]
```

---

## O

### Output
**Definición:** Valor producido por un step o job que puede ser consumido por steps o jobs posteriores.

**Definir output:**
```yaml
- id: my-step
  run: echo "result=value" >> $GITHUB_OUTPUT
```

**Usar output:**
```yaml
- run: echo "${{ steps.my-step.outputs.result }}"
```

---

## P

### Path Filter
**Definición:** Filtro que limita la ejecución del workflow solo cuando archivos en rutas específicas cambian.

**Ejemplo:**
```yaml
on:
  push:
    paths:
      - 'src/**'
      - '!src/docs/**'  # Excluir docs
```

---

### Permissions
**Definición:** Configuración que define qué acceso tiene el `GITHUB_TOKEN` durante la ejecución del workflow.

**Ejemplo:**
```yaml
permissions:
  contents: read
  pull-requests: write
```

---

### Pipeline
**Definición:** Secuencia completa de jobs que procesan código desde commit hasta deployment. Término general para el flujo CI/CD.

---

## R

### Reusable Workflow
**Definición:** Workflow diseñado para ser llamado desde otros workflows, promoviendo reutilización.

**Trigger:** `workflow_call`

**Llamar:**
```yaml
jobs:
  call-workflow:
    uses: org/repo/.github/workflows/reusable.yml@main
```

---

### Runner
**Definición:** Servidor que ejecuta los workflows. Puede ser hospedado por GitHub o self-hosted.

**Especificar:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
```

---

### Runs-on
**Definición:** Palabra clave que especifica el tipo de runner donde ejecutar un job.

---

## S

### Schedule
**Definición:** Trigger que ejecuta workflows automáticamente según una expresión cron.

**Ejemplo:**
```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # Diario a medianoche UTC
```

---

### Secret
**Definición:** Valor sensible encriptado que se almacena en GitHub y se accede en workflows.

**Acceso:**
```yaml
${{ secrets.API_KEY }}
```

---

### Self-hosted Runner
**Definición:** Runner que configuras y mantienes en tu propia infraestructura.

**Ventajas:** Hardware personalizado, acceso a red privada, sin límites de minutos.

---

### Service Container
**Definición:** Contenedor Docker que proporciona servicios adicionales al job (bases de datos, caches, etc.).

**Ejemplo:**
```yaml
services:
  postgres:
    image: postgres:15
    ports:
      - 5432:5432
```

---

### Step
**Definición:** Tarea individual dentro de un job. Puede ser un comando (`run`) o una action (`uses`).

---

### Strategy
**Definición:** Configuración a nivel de job que define matrix, fail-fast, y max-parallel.

---

## T

### Timeout
**Definición:** Límite de tiempo para la ejecución de un job o step.

**Ejemplo:**
```yaml
jobs:
  build:
    timeout-minutes: 30
```

---

### Token (GITHUB_TOKEN)
**Definición:** Token de autenticación generado automáticamente para cada ejecución de workflow.

**Uso:**
```yaml
${{ secrets.GITHUB_TOKEN }}
```

---

### Trigger
**Definición:** Mecanismo que inicia la ejecución de un workflow. Sinónimo de "event" en contexto de activación.

---

## U

### Uses
**Definición:** Palabra clave que especifica una action a ejecutar en un step.

**Sintaxis:**
```yaml
- uses: owner/repo@version
- uses: ./path/to/local/action
```

---

## V

### Variable
**Definición:** Valor configurable almacenado a nivel de repositorio, organización o environment.

**Acceso:**
```yaml
${{ vars.MY_VARIABLE }}
```

---

## W

### Workflow
**Definición:** Proceso automatizado configurable compuesto por uno o más jobs, definido en un archivo YAML.

**Ubicación:** `.github/workflows/*.yml`

---

### Workflow_call
**Definición:** Event que permite que un workflow sea llamado desde otro workflow (reusable workflow).

---

### Workflow_dispatch
**Definición:** Event que permite ejecutar un workflow manualmente desde la UI de GitHub o API.

**Ejemplo:**
```yaml
on:
  workflow_dispatch:
    inputs:
      deploy_env:
        type: choice
        options: [dev, staging, prod]
```

---

### Workflow_run
**Definición:** Event que dispara un workflow cuando otro workflow se completa.

---

## Y

### YAML
**Definición:** "YAML Ain't Markup Language" - Formato de serialización de datos usado para definir workflows de GitHub Actions.

**Características:**
- Indentación con espacios (no tabs)
- Sensible a mayúsculas
- Soporta listas, mapas y strings multilínea

---

## 📊 Resumen de Términos por Categoría

### Estructura de Workflow
| Término | Descripción |
|---------|-------------|
| Workflow | Archivo YAML completo |
| Job | Conjunto de steps |
| Step | Tarea individual |
| Action | Código reutilizable |

### Triggers y Events
| Término | Descripción |
|---------|-------------|
| Event | Actividad que dispara workflow |
| Trigger | Sinónimo de event |
| Schedule | Ejecución programada |
| Dispatch | Ejecución manual |

### Ejecución
| Término | Descripción |
|---------|-------------|
| Runner | Servidor de ejecución |
| Matrix | Múltiples configuraciones |
| Needs | Dependencias entre jobs |
| Timeout | Límite de tiempo |

### Datos y Storage
| Término | Descripción |
|---------|-------------|
| Secret | Valor encriptado |
| Variable | Valor configurable |
| Artifact | Archivos generados |
| Cache | Almacenamiento temporal |

---

## 📚 Recursos Adicionales

- [Documentación oficial de GitHub Actions](https://docs.github.com/en/actions)
- [Workflow syntax reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana |
|:-----------:|:---------:|
| [Recursos](../4-recursos/README.md) | [README](../README.md) |
