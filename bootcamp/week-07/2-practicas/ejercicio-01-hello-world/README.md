# Ejercicio 01: Hello World Workflow

## 🎯 Objetivo

Crear tu primer workflow de GitHub Actions que se ejecute en cada push y muestre información del repositorio.

**Duración estimada:** 30 minutos

---

## 📋 Requisitos Previos

- Cuenta de GitHub
- Repositorio de pruebas (puede ser nuevo)
- Git instalado y configurado

---

## 📝 Descripción

En este ejercicio crearás un workflow básico que:
1. Se ejecuta en cada push
2. Permite ejecución manual
3. Muestra información del contexto de GitHub
4. Ejecuta comandos shell básicos

---

## 🚀 Instrucciones

### Paso 1: Crear el Repositorio

```bash
# ¿QUÉ HACE?: Crear un nuevo directorio para el proyecto
# ¿POR QUÉ?: Necesitamos un repositorio limpio para practicar
# ¿PARA QUÉ?: Tener un ambiente aislado para experimentos

mkdir actions-lab && cd actions-lab
git init
```

### Paso 2: Crear Estructura de Workflows

```bash
# ¿QUÉ HACE?: Crear el directorio para workflows de GitHub Actions
# ¿POR QUÉ?: GitHub Actions busca workflows en esta ubicación específica
# ¿PARA QUÉ?: Sin esta carpeta, GitHub no detectará los workflows

mkdir -p .github/workflows
```

### Paso 3: Crear el Workflow

```bash
# ¿QUÉ HACE?: Crear el archivo de workflow
# ¿POR QUÉ?: Definimos la automatización en formato YAML
# ¿PARA QUÉ?: GitHub ejecutará este workflow según los triggers definidos

cat > .github/workflows/hello.yml << 'EOF'
# ============================================
# WORKFLOW: Hello World
# ============================================
# ¿QUÉ HACE?: Primer workflow de ejemplo
# ¿POR QUÉ?: Aprender la estructura básica
# ¿PARA QUÉ?: Familiarizarse con GitHub Actions

name: Hello World

# ============================================
# TRIGGERS: Cuándo ejecutar
# ============================================
on:
  # Ejecutar en cada push
  push:
    branches:
      - main
      - master
  
  # Permitir ejecución manual desde GitHub UI
  workflow_dispatch:

# ============================================
# JOBS: Qué ejecutar
# ============================================
jobs:
  # ------------------------------------
  # Job: greet
  # ------------------------------------
  greet:
    # Nombre visible en GitHub UI
    name: Say Hello
    
    # Runner donde ejecutar
    runs-on: ubuntu-latest
    
    # ------------------------------------
    # Steps del job
    # ------------------------------------
    steps:
      # Step 1: Mensaje de bienvenida
      - name: Hello from GitHub Actions
        run: |
          echo "🎉 Hello, GitHub Actions!"
          echo "================================"
          echo "Workflow ejecutado exitosamente"
      
      # Step 2: Información del contexto
      - name: Show GitHub Context
        run: |
          echo "📋 Información del Contexto"
          echo "================================"
          echo "Repository: ${{ github.repository }}"
          echo "Branch: ${{ github.ref_name }}"
          echo "Commit SHA: ${{ github.sha }}"
          echo "Actor: ${{ github.actor }}"
          echo "Event: ${{ github.event_name }}"
          echo "Run ID: ${{ github.run_id }}"
          echo "Run Number: ${{ github.run_number }}"
      
      # Step 3: Información del runner
      - name: Show Runner Info
        run: |
          echo "🖥️ Información del Runner"
          echo "================================"
          echo "OS: ${{ runner.os }}"
          echo "Arch: ${{ runner.arch }}"
          echo "Workspace: ${{ github.workspace }}"
      
      # Step 4: Comandos del sistema
      - name: System Commands
        run: |
          echo "💻 Sistema Operativo"
          echo "================================"
          uname -a
          echo ""
          echo "📁 Directorio actual"
          pwd
          echo ""
          echo "📂 Contenido"
          ls -la
      
      # Step 5: Fecha y hora
      - name: Current Date/Time
        run: |
          echo "🕐 Fecha y Hora"
          echo "================================"
          echo "UTC: $(date -u)"
          echo "Timestamp: $(date +%s)"
EOF
```

### Paso 4: Crear README del Proyecto

```bash
cat > README.md << 'EOF'
# Actions Lab

Repositorio para practicar GitHub Actions.

## Workflows

- **Hello World**: Workflow básico de ejemplo

## Badge

![Hello World](https://github.com/USERNAME/actions-lab/actions/workflows/hello.yml/badge.svg)

## Ejecución Manual

1. Ir a **Actions** tab
2. Seleccionar **Hello World**
3. Click en **Run workflow**
EOF
```

### Paso 5: Commit y Push

```bash
# ¿QUÉ HACE?: Crear commit inicial y subir a GitHub
# ¿POR QUÉ?: El workflow solo se ejecuta en GitHub
# ¿PARA QUÉ?: Ver el workflow en acción

git add .
git commit -m "feat: add hello world workflow"

# Crear repo en GitHub (usando gh CLI)
gh repo create actions-lab --public --source=. --push

# O si ya existe el repo remoto:
# git remote add origin https://github.com/USERNAME/actions-lab.git
# git push -u origin main
```

### Paso 6: Verificar Ejecución

```bash
# ¿QUÉ HACE?: Ver el estado del workflow
# ¿POR QUÉ?: Confirmar que se ejecutó correctamente
# ¿PARA QUÉ?: Validar que todo funciona

# Listar ejecuciones
gh run list --workflow=hello.yml

# Ver detalles de la última ejecución
gh run view --log
```

---

## ✅ Verificación

Tu workflow está correcto si:

- [ ] El archivo está en `.github/workflows/hello.yml`
- [ ] El workflow aparece en la pestaña Actions de GitHub
- [ ] Se ejecutó automáticamente tras el push
- [ ] Todos los steps muestran ✅ verde
- [ ] Puedes ejecutarlo manualmente con "Run workflow"

---

## 🔍 Explorar los Logs

1. Ve a **Actions** en tu repositorio
2. Click en la ejecución más reciente
3. Expande el job **Say Hello**
4. Revisa cada step y sus outputs

---

## 🎯 Desafío Extra

Modifica el workflow para agregar:

1. Un step que muestre las variables de entorno
2. Un step condicional que solo corra en main

```yaml
# Hint para el desafío
- name: Show Environment
  run: env | sort

- name: Only on Main
  if: github.ref == 'refs/heads/main'
  run: echo "This is main branch!"
```

---

## 📚 Conceptos Aprendidos

| Concepto | Descripción |
|----------|-------------|
| `name` | Nombre del workflow visible en UI |
| `on` | Eventos que disparan el workflow |
| `workflow_dispatch` | Permite ejecución manual |
| `jobs` | Contenedor de steps |
| `runs-on` | Runner donde ejecutar |
| `steps` | Tareas individuales |
| `run` | Ejecutar comandos shell |
| `${{ }}` | Expresiones y contextos |

---

## 🔗 Recursos

- [Workflow syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [Contexts](https://docs.github.com/en/actions/learn-github-actions/contexts)

---

[➡️ Siguiente: Múltiples Triggers](../ejercicio-02-multiple-triggers/)

---

_Ejercicio 01 | Week 07 | GitHub Actions Fundamentos_
