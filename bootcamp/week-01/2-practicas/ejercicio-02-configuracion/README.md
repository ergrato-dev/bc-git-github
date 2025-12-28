# ⚙️ Ejercicio 02: Configuración Inicial

## 🎯 Objetivo

Configurar tu identidad en Git y establecer preferencias esenciales.

**⏱️ Tiempo estimado**: 45 minutos  
**Dificultad**: ⭐ (Principiante)

---

## ⚠️ IMPORTANTE: Equipos Compartidos

> **🚨 Si usas un equipo compartido (laboratorio, coworking, bootcamp), LEE ESTA SECCIÓN PRIMERO.**

### El Problema

En equipos compartidos por múltiples usuarios, la configuración **global** de Git puede causar que:
- Tus commits aparezcan con el nombre/email de otro estudiante
- Los commits de otros aparezcan con TU identidad
- Se pierda la trazabilidad del trabajo individual

```text
❌ ESCENARIO PROBLEMÁTICO:
┌─────────────────────────────────────────────────────────────┐
│  Estudiante A configura: git config --global user.name     │
│                          "María García"                     │
│                                                             │
│  Estudiante B usa el mismo equipo después...               │
│  Hace commits que aparecen como "María García" 😱          │
└─────────────────────────────────────────────────────────────┘
```

### La Solución: Configuración LOCAL

En equipos compartidos, **SIEMPRE** usa configuración **local** (por proyecto):

```bash
# ⚠️ NO usar --global en equipos compartidos
# ❌ git config --global user.name "Tu Nombre"

# ✅ USAR configuración local (dentro de cada proyecto)
git config --local user.name "Tu Nombre"
git config --local user.email "tu.email@ejemplo.com"
```

### Checklist Antes de Trabajar (Equipos Compartidos)

Ejecuta estos comandos **cada vez** que inicies sesión en un equipo compartido:

```bash
# 1️⃣ VERIFICAR: ¿Quién está configurado actualmente?
git config user.name
git config user.email

# 2️⃣ Si NO eres tú, navega a tu proyecto y configura LOCAL:
cd tu-proyecto/
git config --local user.name "Tu Nombre Real"
git config --local user.email "tu.email@real.com"

# 3️⃣ CONFIRMAR que quedó correctamente:
git config user.name   # Debe mostrar TU nombre
git config user.email  # Debe mostrar TU email
```

### Script de Verificación Rápida

Copia y pega este comando para verificar tu identidad:

```bash
echo "=== VERIFICACIÓN DE IDENTIDAD GIT ===" && \
echo "Usuario actual: $(git config user.name)" && \
echo "Email actual: $(git config user.email)" && \
echo "======================================"
```

---

## 📋 Prerrequisitos

- ✅ Git instalado (Ejercicio 01 completado)
- ✅ Terminal disponible

---

## 🆔 Parte 1: Configurar Identidad

Tu identidad aparece en cada commit. Es **obligatorio** configurarla.

### Para Equipos PERSONALES (tu propia laptop)

```bash
# ¿QUÉ VAMOS A HACER?: Establecer tu nombre para todos los repositories
# ¿POR QUÉ LO HACEMOS?: Git necesita saber quién hace cada commit
# ¿PARA QUÉ SIRVE?: Identificación y trazabilidad en proyectos

git config --global user.name "Tu Nombre Completo"
git config --global user.email "tu.email@ejemplo.com"
```

### Para Equipos COMPARTIDOS (laboratorio, bootcamp)

```bash
# ⚠️ PRIMERO: Navega a tu proyecto
cd ~/mi-proyecto/

# ¿QUÉ VAMOS A HACER?: Establecer tu nombre SOLO para este proyecto
# ¿POR QUÉ LO HACEMOS?: Evitar conflictos con otros usuarios del equipo
# ¿PARA QUÉ SIRVE?: Cada estudiante mantiene su propia identidad

git config --local user.name "Tu Nombre Completo"
git config --local user.email "tu.email@ejemplo.com"
```

### Ejemplo Real

```bash
# Equipo personal:
git config --global user.name "María García López"
git config --global user.email "maria.garcia@gmail.com"

# Equipo compartido (dentro del proyecto):
git config --local user.name "María García López"
git config --local user.email "maria.garcia@gmail.com"
```

---

## 📝 Parte 2: Configurar Editor

Git necesita un editor para mensajes de commit largos.

```bash
# ¿QUÉ VAMOS A HACER?: Establecer VS Code como editor de Git
# ¿POR QUÉ LO HACEMOS?: Para editar mensajes de commit cómodamente
# ¿PARA QUÉ SIRVE?: Mejor experiencia al escribir mensajes detallados

# VS Code (Recomendado)
git config --global core.editor "code --wait"

# Alternativas:
# git config --global core.editor "nano"
# git config --global core.editor "vim"
```

---

## 🌿 Parte 3: Configurar Branch Principal

Asegurar que el branch por defecto sea `main`:

```bash
# ¿QUÉ VAMOS A HACER?: Establecer 'main' como nombre de branch inicial
# ¿POR QUÉ LO HACEMOS?: Es el estándar moderno (antes era 'master')
# ¿PARA QUÉ SIRVE?: Consistencia con GitHub y mejores prácticas

git config --global init.defaultBranch main
```

---

## 🎨 Parte 4: Configuraciones Útiles (Opcional)

```bash
# Colores en terminal
git config --global color.ui auto

# Alias útiles
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit

# Configurar saltos de línea (según tu OS)
# Windows:
git config --global core.autocrlf true
# Linux/macOS:
git config --global core.autocrlf input
```

---

## ✅ Verificación

```bash
# ¿QUÉ VAMOS A HACER?: Mostrar toda tu configuración
# ¿POR QUÉ LO HACEMOS?: Confirmar que se aplicaron los cambios
# ¿PARA QUÉ SIRVE?: Debugging y verificación de setup

# Ver configuración global (equipos personales)
git config --global --list

# Ver configuración del proyecto actual (equipos compartidos)
git config --local --list
```

### Salida Esperada

```text
user.name=Tu Nombre
user.email=tu.email@ejemplo.com
core.editor=code --wait
init.defaultbranch=main
color.ui=auto
```

---

## 🔧 Solución de Problemas: Commits con Identidad Incorrecta

### ¿Hiciste commits con el nombre de otro estudiante?

Si ya hiciste commits y aparecen con otra identidad, hay soluciones:

### Opción 1: Corregir el ÚLTIMO commit

```bash
# ¿QUÉ VAMOS A HACER?: Cambiar autor del último commit
# ¿POR QUÉ LO HACEMOS?: El commit se hizo con identidad incorrecta
# ¿PARA QUÉ SIRVE?: Corregir la autoría sin perder el trabajo

# Primero, configura tu identidad correcta (local)
git config --local user.name "Tu Nombre Real"
git config --local user.email "tu.email@real.com"

# Luego, corrige el último commit
git commit --amend --reset-author --no-edit
```

### Opción 2: Corregir VARIOS commits recientes

```bash
# ⚠️ SOLO si NO has hecho push todavía

# Corregir los últimos 3 commits (cambia el número según necesites)
git rebase -i HEAD~3

# En el editor que se abre:
# 1. Cambia "pick" por "edit" en los commits a corregir
# 2. Guarda y cierra
# 3. Para cada commit, ejecuta:
git commit --amend --reset-author --no-edit
git rebase --continue
```

### Opción 3: Prevención (LA MEJOR OPCIÓN)

```bash
# Crea un alias para verificar identidad antes de cada commit
git config --global alias.whoami '!echo "Nombre: $(git config user.name)" && echo "Email: $(git config user.email)"'

# Úsalo así:
git whoami
```

---

## 🛡️ Buenas Prácticas para Equipos Compartidos

| Práctica | Por Qué |
|----------|---------|
| **1. Verificar identidad al iniciar** | Evita commits con nombre incorrecto |
| **2. Usar `--local` siempre** | La config queda en el proyecto, no en la máquina |
| **3. Crear alias `git whoami`** | Verificación rápida con un comando |
| **4. Revisar antes de push** | `git log -1` para ver el último commit |
| **5. NO guardar credenciales** | Evitar `credential.helper store` en equipos compartidos |

### Configuración Defensiva

```bash
# Evitar que Git guarde credenciales en equipos compartidos
git config --global credential.helper ""

# Forzar que Git pregunte identidad si no está configurada
git config --global user.useConfigOnly true
```

---

## 📝 Entregable

Captura de pantalla de `git config --list` mostrando:
1. `user.name` configurado **con tu nombre real**
2. `user.email` configurado **con tu email real**
3. `init.defaultBranch=main`

**Para equipos compartidos**: Incluir captura de `git config --local --list`

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [Ejercicio 01](../ejercicio-01-instalacion/) | [README](../README.md) | [Ejercicio 03](../ejercicio-03-primer-repo/) |
