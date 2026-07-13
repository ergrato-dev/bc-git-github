# 🔧 Ejercicio 1: Instalación y Configuración de Git

## 📋 Objetivo

Instalar Git en tu sistema operativo y realizar la configuración inicial necesaria para comenzar a trabajar.

## 📚 Pre-requisitos

- Acceso administrativo en tu sistema operativo
- Conexión a internet
- Terminal/línea de comandos básica

## ⏱️ Tiempo Estimado: 30 minutos

## 📝 Instrucciones

### Paso 1: Instalación de Git

#### En Linux (Ubuntu/Debian)

```bash
# EJERCICIO: Instalación de Git en Linux
# ¿QUÉ VAMOS A HACER?: Instalar Git usando el package manager de Ubuntu/Debian
# ¿POR QUÉ LO HACEMOS?: Git no viene preinstalado en todas las distribuciones de Linux
# ¿PARA QUÉ SIRVE?: Tener Git disponible para crear y manejar repositories

# Paso 1: Actualizar la lista de packages disponibles
sudo apt update
# Explicación: Esto asegura que tengamos la versión más reciente de Git disponible

# Paso 2: Instalar Git desde los repositorios oficiales
sudo apt install git
# Explicación: Descarga e instala Git y todas sus dependencias necesarias

# Paso 3: Verificar que la instalación fue exitosa
git --version
# Explicación: Debe mostrar la versión instalada de Git (ej: git version 2.34.1)
```

#### En macOS

```bash
# EJERCICIO: Instalación de Git en macOS
# ¿QUÉ VAMOS A HACER?: Instalar Git usando Homebrew (package manager para macOS)
# ¿POR QUÉ LO HACEMOS?: Para tener la versión más actualizada de Git y facilitar futuras actualizaciones
# ¿PARA QUÉ SIRVE?: Gestionar código fuente y colaborar en proyectos de desarrollo

# Opción 1: Usando Homebrew (recomendado)
brew install git
# Explicación: Homebrew descarga, compila e instala Git automáticamente

# Opción 2: Descargar desde https://git-scm.com/download/mac
# (Seguir el instalador gráfico si prefieres esta opción)

# Verificar que la instalación fue exitosa
git --version
# Explicación: Debe mostrar la versión de Git instalada
```

#### En Windows

> ⚠️ **IMPORTANTE: Usa Git Bash, NO PowerShell ni CMD**
> 
> Lee la sección [¿Por qué Git Bash?](#-por-qué-git-bash-en-windows) más abajo antes de continuar.

1. Descargar Git desde: <https://git-scm.com/download/win>
2. Ejecutar el instalador descargado
3. **Durante la instalación:**
   - ✅ Marcar "Git Bash Here" (muy importante)
   - ✅ Marcar "Add Git Bash Profile to Windows Terminal" (si usas Windows Terminal)
   - Usar configuraciones por defecto para el resto
4. **Abrir Git Bash** (NO PowerShell ni CMD)
5. Verificar instalación:

```bash
# En Git Bash (NO en PowerShell)
git --version
```

### Paso 2: Configuración Inicial

```bash
# EJERCICIO: Configuración inicial de Git
# ¿QUÉ VAMOS A HACER?: Configurar la identidad del usuario en Git
# ¿POR QUÉ LO HACEMOS?: Git necesita saber quién hace cada commit para el historial
# ¿PARA QUÉ SIRVE?: Identificar al autor de cada cambio en el repository

# Paso 1: Configurar tu nombre global (reemplaza con tu nombre real)
git config --global user.name "Juan Pérez"
# Explicación: Este nombre aparecerá en todos los commits que hagas

# Paso 2: Configurar tu email global (reemplaza con tu email real)
git config --global user.email "juan.perez@email.com"
# Explicación: El email se usa para identificar al autor y para notificaciones

# Paso 3: Configurar editor por defecto (opcional - ejemplo con VS Code)
git config --global core.editor "code --wait"
# Explicación: Define qué editor usar para mensajes de commit y merge conflicts

# Paso 4: Verificar que la configuración se guardó correctamente
git config --list
# Explicación: Muestra todas las configuraciones actuales de Git
```

### Paso 3: Configuraciones Adicionales Recomendadas

```bash
# EJERCICIO: Configuraciones avanzadas de Git
# ¿QUÉ VAMOS A HACER?: Optimizar la experiencia de uso de Git con configuraciones adicionales
# ¿POR QUÉ LO HACEMOS?: Para mejorar la legibilidad y eficiencia al trabajar con Git
# ¿PARA QUÉ SIRVE?: Hacer más fácil y visual el trabajo diario con Git

# Paso 1: Activar colores en la output de Git
git config --global color.ui auto
# Explicación: Git usará colores para diferenciar estados (modified, staged, etc.)

# Paso 2a: Configurar line endings para Windows
git config --global core.autocrlf true
# Explicación: Convierte LF a CRLF al hacer checkout, y CRLF a LF al hacer commit

# Paso 2b: Configurar line endings para Linux/Mac (ejecutar solo en estos sistemas)
git config --global core.autocrlf input
# Explicación: Convierte CRLF a LF al hacer commit, pero no modifica al hacer checkout

# Paso 3: Crear aliases para comandos frecuentes
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
# Explicación: Permite usar 'git st' en lugar de 'git status', ahorrando tiempo
```

## ✅ Entregables

### 1. Captura de Pantalla

Toma una captura de pantalla que muestre:

- El resultado del comando `git --version`
- El resultado del comando `git config --list`

### 2. Verificación de Configuración

Ejecuta los siguientes comandos y anota los resultados:

```bash
git config user.name
git config user.email
git config core.editor
```

## 🧪 Verificación

Para verificar que todo está funcionando correctamente:

1. Abre una nueva terminal
2. Ejecuta: `git --version`
3. Ejecuta: `git config --global --list`
4. Deberías ver tu nombre y email configurados

## 🚨 Problemas Comunes

### Git no reconocido como comando

**Problema**: `git: command not found` o `'git' is not recognized`

**Solución**:

- **Linux**: Instalar con el gestor de paquetes de tu distribución
- **macOS**: Instalar Xcode Command Line Tools: `xcode-select --install`
- **Windows**: Reiniciar terminal después de instalar, o verificar PATH

### Configuración no se guarda

**Problema**: Los comandos `git config` no funcionan

**Solución**:

```bash
# Verificar que el directorio home existe
echo $HOME

# Crear archivo de configuración manualmente si es necesario
touch ~/.gitconfig

# Intentar configuración de nuevo
git config --global user.name "Tu Nombre"
```

## 📖 Recursos Adicionales

- [Documentación oficial de instalación](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Instalando-Git)
- [Guía de configuración inicial](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Configurando-Git-por-primera-vez)
- [Pro Git Book (Español)](https://git-scm.com/book/es/v2)

---

## 🐚 ¿Por qué Git Bash en Windows?

### ❌ El problema con PowerShell/CMD

| Aspecto | PowerShell/CMD | Git Bash |
|---------|----------------|----------|
| **Comandos** | Sintaxis Windows exclusiva | Sintaxis Unix (estándar industria) |
| **Tutoriales** | 95% incompatibles | 100% compatibles |
| **Trabajo real** | Aprenderás algo que no usarás | Aprenderás lo que usan los equipos |
| **Servidores** | No existe en Linux | Mismo entorno que producción |

### ✅ Razones para usar Git Bash

#### 1️⃣ **Compatibilidad Universal**

```bash
# Este comando funciona en Git Bash, macOS, Linux, y cualquier servidor
ls -la ~/.ssh

# En PowerShell tendrías que usar:
# Get-ChildItem -Force $env:USERPROFILE\.ssh
# (Y esto NO funciona en ningún otro sistema)
```

#### 2️⃣ **El Mundo Real usa Unix/Linux**

```text
📊 Estadísticas de servidores en producción:
├── 🐧 Linux: 96.3% de servidores web
├── 🪟 Windows: 3.7%
└── 🍎 macOS: ~0% (desarrollo local únicamente)

💡 Conclusión: Aprender comandos Unix es inversión a largo plazo
```

#### 3️⃣ **Toda la Documentación está en Unix**

```bash
# 📚 Stack Overflow, GitHub docs, tutoriales, blogs...
# Todos usan comandos Unix:

cd ~/projects
mkdir -p src/components
touch README.md
cat .gitignore
rm -rf node_modules

# ⚠️ Ninguno de estos funciona en PowerShell nativo
```

#### 4️⃣ **GitHub Actions y CI/CD usan Bash**

```yaml
# .github/workflows/deploy.yml
jobs:
  build:
    runs-on: ubuntu-latest  # 🐧 Linux!
    steps:
      - run: |
          pnpm install --frozen-lockfile
          pnpm run build
          # Todo es bash, no PowerShell
```

#### 5️⃣ **Consistencia en el Equipo**

```text
👥 En un equipo típico:
├── 🍎 Desarrollador 1: macOS (Terminal = bash/zsh)
├── 🐧 Desarrollador 2: Linux (Terminal = bash)
├── 🪟 Desarrollador 3: Windows + Git Bash ✅
└── 🪟 Desarrollador 4: Windows + PowerShell ❌ (el "raro" del equipo)
```

### 🎯 Configurar Git Bash como Terminal por Defecto

#### En VS Code

```json
// settings.json (Ctrl+Shift+P → "Preferences: Open Settings JSON")
{
  "terminal.integrated.defaultProfile.windows": "Git Bash",
  "terminal.integrated.profiles.windows": {
    "Git Bash": {
      "path": "C:\\Program Files\\Git\\bin\\bash.exe",
      "icon": "terminal-bash"
    }
  }
}
```

#### En Windows Terminal

1. Abrir Windows Terminal
2. `Ctrl + ,` (Settings)
3. En "Default profile" seleccionar **Git Bash**
4. Guardar

### 🔄 Tabla de Equivalencias

| Acción | Git Bash (Unix) | PowerShell |
|--------|-----------------|------------|
| Listar archivos | `ls -la` | `Get-ChildItem -Force` |
| Crear carpeta | `mkdir -p folder/sub` | `New-Item -ItemType Directory -Path folder\sub` |
| Eliminar carpeta | `rm -rf folder` | `Remove-Item -Recurse -Force folder` |
| Ver contenido | `cat file.txt` | `Get-Content file.txt` |
| Copiar archivo | `cp file.txt backup.txt` | `Copy-Item file.txt backup.txt` |
| Mover archivo | `mv old.txt new.txt` | `Move-Item old.txt new.txt` |
| Directorio actual | `pwd` | `Get-Location` |
| Ir a home | `cd ~` | `cd $HOME` |
| Variables entorno | `echo $PATH` | `echo $env:PATH` |
| Limpiar pantalla | `clear` | `Clear-Host` |

> 💡 **Nota**: PowerShell tiene aliases como `ls`, `cat`, `pwd`, pero su comportamiento es diferente y causa confusión.

### ⚡ TL;DR (Resumen Ejecutivo)

```text
🏆 USA GIT BASH porque:

1. ✅ Es el estándar de la industria
2. ✅ Todos los tutoriales funcionarán
3. ✅ Prepara para servidores Linux (donde correrá tu código)
4. ✅ Mismo entorno que tus compañeros en macOS/Linux
5. ✅ GitHub Actions usa bash
6. ✅ Docker usa bash
7. ✅ AWS/GCP/Azure CLI usan bash

❌ NO USES PowerShell para Git porque:
- Aprenderás sintaxis que no usarás en el mundo real
- Los tutoriales no funcionarán
- Serás "el raro" del equipo
- Tendrás que re-aprender todo al usar servidores
```

---

## 🏆 Criterios de Evaluación

- **Instalación correcta** (40%): Git instalado y funcionando
- **Configuración básica** (40%): Nombre y email configurados
- **Configuración avanzada** (20%): Alias y preferencias adicionales

---

**¿Completaste el ejercicio?** 👉 Continúa con [Ejercicio 2: Primera Configuración](../../bootcamp/week-01_fundamentos_de_git/2-practicas/ejercicio-02-configuracion/)
