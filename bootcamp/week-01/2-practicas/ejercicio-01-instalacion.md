# 🛠️ Ejercicio 1.1: Instalación de Git

## 🎯 Objetivo del Ejercicio

Al completar este ejercicio serás capaz de:

- ✅ Instalar Git en tu sistema operativo específico
- ✅ Verificar que la instalación fue exitosa
- ✅ Acceder a Git desde la terminal/línea de comandos
- ✅ Identificar la versión instalada de Git

**⏱️ Tiempo estimado**: 15-20 minutos

---

## 📋 Prerrequisitos

- ✅ Acceso administrativo a tu computadora
- ✅ Conexión a internet para descargas
- ✅ Terminal/Símbolo del sistema accesible

---

## 🖥️ Instalación por Sistema Operativo

### 🐧 **Linux (Ubuntu/Debian)**

#### **Método 1: Gestor de Paquetes (Recomendado)**

```bash
# EJERCICIO PASO A PASO:

# ¿QUÉ VAMOS A HACER?: Actualizar la lista de paquetes disponibles
# ¿POR QUÉ LO HACEMOS?: Asegurar que tenemos las versiones más recientes
# ¿PARA QUÉ SIRVE?: Evitar instalar versiones obsoletas de Git

sudo apt update
```

```bash
# ¿QUÉ VAMOS A HACER?: Instalar Git usando el gestor de paquetes
# ¿POR QUÉ LO HACEMOS?: Es el método más simple y confiable
# ¿PARA QUÉ SIRVE?: Tener Git disponible en todo el sistema

sudo apt install git
```

#### **Verificación en Linux**

```bash
# ¿QUÉ VAMOS A HACER?: Verificar que Git se instaló correctamente
# ¿POR QUÉ LO HACEMOS?: Confirmar que el comando está disponible
# ¿PARA QUÉ SIRVE?: Asegurar que podemos usar Git desde cualquier directorio

git --version

# Salida esperada: git version 2.34.1 (o similar)
```

### 🍎 **macOS**

#### **Método 1: Homebrew (Recomendado para desarrolladores)**

```bash
# EJERCICIO PASO A PASO:

# Paso 1: Instalar Homebrew si no lo tienes
# ¿QUÉ VAMOS A HACER?: Instalar el gestor de paquetes Homebrew
# ¿POR QUÉ LO HACEMOS?: Facilita la gestión de herramientas de desarrollo
# ¿PARA QUÉ SIRVE?: Mantener Git y otras herramientas actualizadas fácilmente

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
# Paso 2: Instalar Git con Homebrew
# ¿QUÉ VAMOS A HACER?: Instalar la versión más reciente de Git
# ¿POR QUÉ LO HACEMOS?: Homebrew mantiene versiones más actualizadas que macOS
# ¿PARA QUÉ SIRVE?: Acceder a las características más recientes de Git

brew install git
```

#### **Método 2: Xcode Command Line Tools**

```bash
# ¿QUÉ VAMOS A HACER?: Instalar herramientas de desarrollo de Apple
# ¿POR QUÉ LO HACEMOS?: Incluye Git precompilado para macOS
# ¿PARA QUÉ SIRVE?: Instalación rápida sin gestores de paquetes externos

xcode-select --install

# Esto abrirá un diálogo para instalar las herramientas
```

#### **Verificación en macOS**

```bash
# Verificar instalación
git --version

# Verificar ubicación del ejecutable
which git

# Salida esperada: /usr/local/bin/git (Homebrew) o /usr/bin/git (Xcode)
```

### 🪟 **Windows**

#### **Método 1: Git for Windows (Recomendado)**

**Pasos de instalación visual:**

1. **Descargar**:

   - 🌐 Ir a: https://git-scm.com/download/win
   - ⬇️ Descargar el instalador (.exe)

2. **Ejecutar instalador**:

   ```text
   Configuraciones recomendadas:

   ✅ Seleccionar componentes:
   - Git Bash Here
   - Git GUI Here
   - Git LFS (Large File Support)

   ✅ Editor por defecto:
   - Use Visual Studio Code as Git's default editor

   ✅ Nombre de branch inicial:
   - Override the default branch name for new repositories: main

   ✅ Ajustar PATH:
   - Git from the command line and also from 3rd-party software

   ✅ Configurar terminaciones de línea:
   - Checkout Windows-style, commit Unix-style line endings
   ```

3. **Completar instalación**:
   - ➡️ Next en todas las opciones restantes
   - 🏁 Install
   - ✅ Finish

#### **Verificación en Windows**

```bash
# Abrir Command Prompt, PowerShell, o Git Bash
# ¿QUÉ VAMOS A HACER?: Verificar que Git está en el PATH del sistema
# ¿POR QUÉ LO HACEMOS?: Confirmar que podemos usar Git desde cualquier terminal
# ¿PARA QUÉ SIRVE?: Asegurar integración completa con el sistema

git --version

# Salida esperada: git version 2.40.0.windows.1 (o similar)
```

---

## ✅ Verificación Completa de la Instalación

### 🔍 **Comandos de Verificación**

```bash
# EJERCICIO DE VERIFICACIÓN COMPLETA:

# 1. Verificar versión
# ¿QUÉ VAMOS A HACER?: Mostrar la versión instalada de Git
# ¿POR QUÉ LO HACEMOS?: Confirmar que Git está funcionando
# ¿PARA QUÉ SIRVE?: Identificar la versión para troubleshooting futuro

git --version
```

```bash
# 2. Verificar ayuda básica
# ¿QUÉ VAMOS A HACER?: Mostrar la ayuda general de Git
# ¿POR QUÉ LO HACEMOS?: Probar que Git responde a comandos
# ¿PARA QUÉ SIRVE?: Familiarizarse con la estructura de ayuda

git --help
```

```bash
# 3. Verificar comandos disponibles
# ¿QUÉ VAMOS A HACER?: Listar todos los comandos de Git disponibles
# ¿POR QUÉ LO HACEMOS?: Confirmar instalación completa
# ¿PARA QUÉ SIRVE?: Ver el ecosistema completo de comandos Git

git help -a
```

### 📊 **Salida Esperada**

**git --version**:

```text
git version 2.40.0 (o superior)
```

**git --help** (primeras líneas):

```text
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]
```

---

## 🚨 Troubleshooting Común

### ❌ **"git: command not found" (Linux/macOS)**

**Problema**: Git no se instaló correctamente o no está en el PATH.

**Soluciones**:

```bash
# Verificar si Git está instalado en ubicación no estándar
whereis git

# Verificar PATH actual
echo $PATH

# Reinstalar Git
# Linux:
sudo apt install --reinstall git

# macOS:
brew reinstall git
```

### ❌ **Git no funciona en Windows Command Prompt**

**Problema**: PATH no se configuró durante la instalación.

**Soluciones**:

1. **Reinstalar Git** seleccionando "Git from the command line and also from 3rd-party software"
2. **Usar Git Bash** como alternativa
3. **Agregar manualmente al PATH**:
   ```text
   Ubicación típica: C:\Program Files\Git\cmd
   ```

### ❌ **Versión muy antigua de Git**

**Problema**: Repositorio del sistema tiene versión obsoleta.

**Soluciones Linux**:

```bash
# Agregar repositorio oficial de Git
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
```

**Solución macOS**:

```bash
# Actualizar con Homebrew
brew upgrade git
```

---

## 🎯 Ejercicio Práctico: Primera Exploración

### 📝 **Tarea Práctica**

Una vez instalado Git, explora estos comandos para familiarizarte:

```bash
# EJERCICIO: EXPLORACIÓN BÁSICA

# 1. Ver información de Git
# ¿QUÉ VAMOS A HACER?: Mostrar información detallada de la instalación
# ¿POR QUÉ LO HACEMOS?: Conocer las capacidades de nuestra instalación
# ¿PARA QUÉ SIRVE?: Debugging avanzado si hay problemas

git version --build-options
```

```bash
# 2. Ver ayuda de un comando específico
# ¿QUÉ VAMOS A HACER?: Mostrar ayuda detallada del comando config
# ¿POR QUÉ LO HACEMOS?: Preparación para el siguiente ejercicio
# ¿PARA QUÉ SIRVE?: Entender opciones disponibles antes de usar comandos

git help config
```

```bash
# 3. Verificar configuración actual (estará vacía por ahora)
# ¿QUÉ VAMOS A HACER?: Mostrar configuraciones actuales de Git
# ¿POR QUÉ LO HACEMOS?: Ver el estado inicial antes de configurar
# ¿PARA QUÉ SIRVE?: Punto de referencia para comparar después

git config --list
```

### ✅ **Criterios de Éxito**

Tu instalación es exitosa si:

- [ ] `git --version` muestra una versión 2.20+
- [ ] `git --help` muestra la ayuda sin errores
- [ ] Puedes ejecutar Git desde cualquier directorio en terminal
- [ ] (Windows) Git funciona tanto en Command Prompt como en Git Bash

---

## 📋 Entregables del Ejercicio

### 🏁 **Qué Entregar**

Crea un documento de texto con:

1. **Screenshot o texto** de la salida de `git --version`
2. **Sistema operativo** utilizado
3. **Método de instalación** elegido
4. **Problemas encontrados** (si los hubo) y cómo los resolviste

### 📝 **Template de Entrega**

```text
=== EJERCICIO 1.1: INSTALACIÓN DE GIT ===

Nombre: [Tu nombre]
Fecha: [Fecha de realización]

1. SISTEMA OPERATIVO:
   - OS: [Windows/macOS/Linux]
   - Versión: [Versión específica]

2. MÉTODO DE INSTALACIÓN:
   - Método usado: [Homebrew/apt/Git for Windows/etc.]

3. VERIFICACIÓN:
   - Comando ejecutado: git --version
   - Salida obtenida: [copiar aquí la salida]

4. PROBLEMAS Y SOLUCIONES:
   - Problema: [descripción o "Ninguno"]
   - Solución: [cómo lo resolviste o "N/A"]

5. CONFIRMACIÓN:
   - [ ] Git responde correctamente
   - [ ] Puedo ejecutar comandos Git
   - [ ] Listo para siguiente ejercicio
```

---

## 🔗 Próximo Ejercicio

Una vez que Git esté instalado correctamente, procederemos a configurar tu identidad y preferencias.

### 📖 **Siguiente**: [Ejercicio 1.2: Primera Configuración](./ejercicio-02-configuracion.md)

---

## 📚 Recursos Adicionales

### 🔗 **Enlaces Oficiales**

- [Git Downloads](https://git-scm.com/downloads)
- [Git for Windows](https://gitforwindows.org/)
- [Homebrew](https://brew.sh/)

### 📹 **Videos de Apoyo**

- "Installing Git on Windows/Mac/Linux" (GitHub)
- "Git Installation Tutorial" (Programming with Mosh)

### 💡 **Tips Pro**

- **Linux**: Considera compilar desde código fuente para la versión más reciente
- **macOS**: Homebrew facilita actualizaciones futuras
- **Windows**: Git Bash proporciona un entorno Unix-like excelente

---

**📝 Nota del Instructor**: La instalación correcta es crítica. Si tienes problemas, solicita ayuda antes de continuar. Una mala instalación puede causar confusión en ejercicios posteriores.
