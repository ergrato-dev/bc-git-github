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

1. Descargar Git desde: <https://git-scm.com/download/win>
2. Ejecutar el instalador descargado
3. Seguir el asistente (usar configuraciones por defecto)
4. Abrir Git Bash o Command Prompt
5. Verificar instalación:

```cmd
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

## 🏆 Criterios de Evaluación

- **Instalación correcta** (40%): Git instalado y funcionando
- **Configuración básica** (40%): Nombre y email configurados
- **Configuración avanzada** (20%): Alias y preferencias adicionales

---

**¿Completaste el ejercicio?** 👉 Continúa con [Ejercicio 2: Primera Configuración](./ejercicio-02-configuracion.md)
