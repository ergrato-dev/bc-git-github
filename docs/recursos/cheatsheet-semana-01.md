# 📋 Cheatsheet Git - Semana 1

## Comandos Básicos

### Configuración Inicial

```bash
# Configurar nombre de usuario (obligatorio)
git config --global user.name "Tu Nombre"

# Configurar email (obligatorio)
git config --global user.email "tu@email.com"

# Ver toda la configuración
git config --list

# Ver configuración específica
git config user.name
git config user.email
```

### Inicializar Repositorio

```bash
# Crear nuevo repositorio en carpeta actual
git init

# Crear nuevo repositorio en carpeta específica
git init nombre-proyecto
```

### Estados y Seguimiento

```bash
# Ver estado de archivos
git status

# Ver estado resumido
git status --short
git status -s
```

### Añadir Archivos al Staging

```bash
# Añadir archivo específico
git add archivo.txt

# Añadir todos los archivos
git add .

# Añadir todos los archivos (incluyendo eliminados)
git add --all
git add -A
```

### Realizar Commits

```bash
# Commit con mensaje
git commit --message "Descripción del cambio"
git commit -m "Descripción del cambio"

# Commit añadiendo archivos modificados automáticamente
git commit --all --message "Descripción"
git commit -am "Descripción"
```

### Ver Historial

```bash
# Ver historial completo
git log

# Ver historial resumido (una línea por commit)
git log --oneline

# Ver últimos N commits
git log -n 5

# Ver historial con gráfico
git log --graph --oneline
```

## Archivos Especiales

### .gitignore

```bash
# Ejemplos comunes para .gitignore

# Archivos del sistema
.DS_Store
Thumbs.db

# Dependencias de Node.js
node_modules/
npm-debug.log

# Archivos de Python
__pycache__/
*.pyc
*.pyo
*.egg-info/

# Archivos de build
dist/
build/
*.jar
*.war

# Variables de entorno
.env
.env.local

# IDEs
.vscode/
.idea/
*.swp
*.swo

# Logs
*.log
logs/
```

## Estados de Archivos en Git

```text
Untracked → add → Staged → commit → Committed
    ↑                         ↓
    ← ← ← ← ← modify ← ← ← ← ←
```

### Descripción de Estados

- **Untracked**: Archivo nuevo, Git no lo está siguiendo
- **Staged**: Archivo preparado para el próximo commit
- **Modified**: Archivo modificado pero no preparado
- **Committed**: Archivo guardado en el repositorio

## Convenciones de Mensajes de Commit

```bash
# Estructura básica
tipo: descripción breve

# Ejemplos
git commit -m "feat: añadir función de login"
git commit -m "fix: corregir error en validación"
git commit -m "docs: actualizar README"
git commit -m "style: corregir indentación"
git commit -m "refactor: reorganizar funciones"
git commit -m "test: añadir pruebas unitarias"
```

### Tipos Comunes

- `feat`: Nueva funcionalidad
- `fix`: Corrección de errores
- `docs`: Documentación
- `style`: Formato, espacios en blanco
- `refactor`: Refactorización de código
- `test`: Añadir o modificar tests
- `chore`: Tareas de mantenimiento

## Comandos de Ayuda

```bash
# Ayuda general
git help

# Ayuda para comando específico
git help config
git help commit
git help log

# Versión de Git
git --version
```

---

💡 **Tip**: Usa `git status` frecuentemente para ver el estado actual de tu repositorio.
