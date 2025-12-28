# 🛠️ Ejercicio 01: Instalación de Git

## 🎯 Objetivo

Instalar Git en tu sistema operativo y verificar que funciona correctamente.

**⏱️ Tiempo estimado**: 45 minutos  
**Dificultad**: ⭐ (Principiante)

---

## 📋 Prerrequisitos

- ✅ Acceso administrativo a tu computadora
- ✅ Conexión a internet
- ✅ Terminal/línea de comandos disponible

---

## 🖥️ Instrucciones por Sistema Operativo

### 🐧 Linux (Ubuntu/Debian)

```bash
# ¿QUÉ VAMOS A HACER?: Actualizar lista de paquetes e instalar Git
# ¿POR QUÉ LO HACEMOS?: Asegurar versión actualizada desde repositorios
# ¿PARA QUÉ SIRVE?: Tener Git disponible en todo el sistema

sudo apt update && sudo apt install git -y
```

### 🍎 macOS

**Opción A - Homebrew (Recomendado):**
```bash
# Instalar Homebrew si no lo tienes
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar Git
brew install git
```

**Opción B - Xcode Command Line Tools:**
```bash
xcode-select --install
```

### 🪟 Windows

1. Descargar de: https://git-scm.com/download/win
2. Ejecutar instalador con estas opciones recomendadas:
   - ✅ Git Bash Here
   - ✅ Use Visual Studio Code as Git's default editor
   - ✅ Override branch name: `main`
   - ✅ Git from command line and 3rd-party software

> 💡 **Recomendación**: Usa **Git Bash** en lugar de PowerShell para mejor compatibilidad con comandos Unix.

---

## ✅ Verificación

Ejecuta estos comandos para confirmar la instalación:

```bash
# ¿QUÉ VAMOS A HACER?: Verificar versión instalada
# ¿POR QUÉ LO HACEMOS?: Confirmar que Git está en el PATH
# ¿PARA QUÉ SIRVE?: Asegurar que podemos usar Git

git --version
# Esperado: git version 2.x.x

# Verificar que responde a comandos
git --help
```

---

## 📝 Entregable

Captura de pantalla o texto mostrando:
1. Salida de `git --version`
2. Sistema operativo usado
3. Método de instalación elegido

---

## 🚨 Troubleshooting

| Problema | Solución |
|----------|----------|
| `git: command not found` | Reinstalar o agregar al PATH |
| Versión muy antigua | Usar PPA (Linux) o Homebrew (macOS) |
| No funciona en Windows CMD | Usar Git Bash o reinstalar con opción PATH |

---

## 🔗 Siguiente Ejercicio

➡️ [Ejercicio 02: Configuración Inicial](../ejercicio-02-configuracion/)

---

[⬅️ Volver a Prácticas](../README.md)
