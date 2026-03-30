# 🌿 Lección 01: Branches en Git

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- ✅ Comprender qué es un branch y por qué es importante
- ✅ Crear branches con `git branch`
- ✅ Listar y visualizar branches existentes
- ✅ Eliminar branches de forma segura

---

## 📖 ¿Qué es un Branch?

Un **branch** (rama) en Git es simplemente un **puntero móvil** que apunta a un commit específico. Es una de las características más poderosas de Git porque permite:

- 🔀 **Desarrollo paralelo**: Trabajar en múltiples features simultáneamente
- 🛡️ **Aislamiento**: Los cambios en un branch no afectan a otros
- 🧪 **Experimentación**: Probar ideas sin riesgo de romper el código principal
- 👥 **Colaboración**: Cada desarrollador puede trabajar en su propio branch

### Visualización de Branches

![Concepto de Branches](../0-assets/01-branches-concepto.svg)

> **Importante**: Un branch NO es una copia del código. Es solo un puntero que se mueve con cada nuevo commit.

---

## 🔧 Comandos Básicos de Branches

### Listar Branches

```bash
# ¿Qué hace?: Muestra todos los branches locales
# ¿Por qué?: Para ver en qué branches estamos trabajando
# ¿Para qué sirve?: Identificar el branch actual (marcado con *)

git branch

# Salida ejemplo:
#   develop
# * main
#   feature/login
```

```bash
# ¿Qué hace?: Muestra branches locales y remotos
# ¿Por qué?: Para ver todos los branches disponibles
# ¿Para qué sirve?: Sincronizar trabajo con el equipo

git branch --all
# Atajo: git branch -a
```

### Crear un Branch

```bash
# ¿Qué hace?: Crea un nuevo branch apuntando al commit actual
# ¿Por qué?: Para iniciar trabajo en una nueva feature
# ¿Para qué sirve?: Aislar el desarrollo de cambios específicos

# Sintaxis completa
git branch <nombre-del-branch>

# Ejemplo práctico
git branch feature/login
```

> ⚠️ **Nota**: `git branch` solo CREA el branch, NO te mueve a él.

### Ver Información del Branch

```bash
# ¿Qué hace?: Muestra branches con su último commit
# ¿Por qué?: Para ver el estado de cada branch
# ¿Para qué sirve?: Identificar qué cambios tiene cada branch

git branch -v

# Salida ejemplo:
#   develop     abc1234 feat: add user model
# * main        def5678 Initial commit
#   feature/login ghi9012 feat: login form
```

```bash
# ¿Qué hace?: Muestra branches que ya fueron merged
# ¿Por qué?: Para identificar branches que se pueden eliminar
# ¿Para qué sirve?: Mantener el repositorio limpio

git branch --merged
```

---

## 🗑️ Eliminar Branches

### Eliminar Branch Local (Seguro)

```bash
# ¿Qué hace?: Elimina un branch que ya fue merged
# ¿Por qué?: Para limpiar branches obsoletos
# ¿Para qué sirve?: Mantener el repositorio organizado

git branch --delete feature/login
# Atajo: git branch -d feature/login

# Si el branch NO fue merged, Git te protege:
# error: The branch 'feature/login' is not fully merged.
```

### Eliminar Branch Local (Forzado)

```bash
# ¿Qué hace?: Elimina un branch aunque no haya sido merged
# ¿Por qué?: Para descartar trabajo experimental
# ¿Para qué sirve?: Eliminar branches con cambios que ya no necesitas

git branch -D feature/experimento

# ⚠️ CUIDADO: Esto puede causar pérdida de commits
```

---

## 📏 Convenciones de Nombres

### Buenas Prácticas

| Tipo | Prefijo | Ejemplo |
|------|---------|---------|
| Nueva feature | `feature/` | `feature/login` |
| Corrección de bug | `fix/` | `fix/navbar-responsive` |
| Hotfix urgente | `hotfix/` | `hotfix/security-patch` |
| Refactorización | `refactor/` | `refactor/api-client` |
| Documentación | `docs/` | `docs/readme-update` |
| Release | `release/` | `release/v1.2.0` |

### Reglas de Nomenclatura

```bash
# ✅ CORRECTO
feature/user-authentication
fix/login-validation
hotfix/sql-injection

# ❌ INCORRECTO
Feature Login          # Espacios no permitidos
feature_login          # Preferir guiones sobre guiones bajos
mi-branch              # Sin prefijo descriptivo
FEATURE/LOGIN          # Evitar mayúsculas
```

---

## 💡 Estructura Interna de Branches

### ¿Dónde se almacenan los branches?

```bash
# Los branches son archivos de texto en:
.git/refs/heads/

# Contenido de un archivo branch:
cat .git/refs/heads/main
# abc123def456...  (SHA-1 del commit)
```

### Branches como Punteros

```
Commit History:
    A---B---C---D  (main apunta aquí)
             \
              E---F  (feature apunta aquí)
```

Cada branch es literalmente un archivo que contiene el hash SHA-1 de un commit.

---

## 📝 Ejercicio Rápido

```bash
# 1. Crear un repositorio de prueba
mkdir practica-branches && cd practica-branches
git init

# 2. Hacer el primer commit
echo "# Mi Proyecto" > README.md
git add README.md
git commit -m "chore: initial commit"

# 3. Crear branches
git branch develop
git branch feature/login
git branch feature/dashboard

# 4. Ver los branches creados
git branch -v

# 5. Ver branches que apuntan al mismo commit
git log --oneline --decorate
```

---

## ⚠️ Errores Comunes

### Error: No puedo eliminar el branch actual

```bash
# ❌ Esto falla:
git branch -d main  # Si estás en main

# ✅ Solución: Cambiar a otro branch primero
git switch develop
git branch -d main
```

### Error: Branch ya existe

```bash
# ❌ Esto falla:
git branch feature/login  # Si ya existe

# ✅ Solución: Usar otro nombre o eliminar el existente
git branch feature/login-v2
# o
git branch -d feature/login && git branch feature/login
```

---

## 🎯 Resumen

| Comando | Descripción |
|---------|-------------|
| `git branch` | Listar branches locales |
| `git branch -a` | Listar todos (locales + remotos) |
| `git branch <nombre>` | Crear nuevo branch |
| `git branch -v` | Branches con último commit |
| `git branch -d <nombre>` | Eliminar branch (seguro) |
| `git branch -D <nombre>` | Eliminar branch (forzado) |
| `git branch --merged` | Branches ya integrados |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Índice | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 03 README](../README.md) | [Teoría](.) | [02 - Navegación](02-navegacion-branches.md) |

---

<div align="center">

**Lección 01** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
