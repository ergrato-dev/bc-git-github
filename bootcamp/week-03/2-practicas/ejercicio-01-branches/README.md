# 🌿 Ejercicio 01: Crear y Navegar Branches

## 📋 Información

| Campo | Valor |
|-------|-------|
| **Duración** | 35 minutos |
| **Dificultad** | ⭐ Principiante |
| **Prerrequisitos** | Week 01-02 completadas |
| **Temas** | `git branch`, `git switch`, `git checkout`, HEAD |

---

## 🎯 Objetivos

Al completar este ejercicio serás capaz de:

- ✅ Crear branches nuevos
- ✅ Listar y visualizar branches
- ✅ Cambiar entre branches con `git switch`
- ✅ Entender cómo funciona HEAD
- ✅ Eliminar branches de forma segura

---

## 📝 Instrucciones

### Parte 1: Setup Inicial (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 1: Crear directorio del ejercicio
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea una carpeta para el ejercicio
# ¿Por qué?: Necesitamos un espacio de trabajo limpio
# ¿Para qué sirve?: Practicar sin afectar otros proyectos

mkdir ejercicio-branches && cd ejercicio-branches

# ══════════════════════════════════════════════════════════════
# PASO 2: Inicializar repositorio
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea un nuevo repositorio Git
# ¿Por qué?: Necesitamos Git para trabajar con branches
# ¿Para qué sirve?: Habilitar el control de versiones

git init

# ══════════════════════════════════════════════════════════════
# PASO 3: Crear primer commit
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea el archivo README y hace el primer commit
# ¿Por qué?: Necesitamos al menos un commit para crear branches
# ¿Para qué sirve?: Establecer el punto de partida

echo "# Ejercicio Branches" > README.md
git add README.md
git commit -m "chore: initial commit"
```

**Verificación**: Ejecuta `git log --oneline` y deberías ver un commit.

---

### Parte 2: Crear Branches (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 4: Ver branch actual
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra los branches existentes
# ¿Por qué?: Para conocer el estado actual
# ¿Para qué sirve?: Saber en qué branch estamos (* indica actual)

git branch

# Resultado esperado:
# * main (o master)

# ══════════════════════════════════════════════════════════════
# PASO 5: Crear branch 'develop'
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea un nuevo branch llamado develop
# ¿Por qué?: Para tener un branch de integración
# ¿Para qué sirve?: Separar desarrollo de producción (main)

git branch develop

# Verificar creación
git branch

# Resultado esperado:
#   develop
# * main

# ══════════════════════════════════════════════════════════════
# PASO 6: Crear branches de features
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea branches para features específicas
# ¿Por qué?: Siguiendo convención de nombres
# ¿Para qué sirve?: Organizar el trabajo por funcionalidades

git branch feature/login
git branch feature/dashboard
git branch fix/typo

# Verificar todos los branches
git branch

# Resultado esperado:
#   develop
#   feature/dashboard
#   feature/login
#   fix/typo
# * main
```

**Verificación**: `git branch` debe mostrar 5 branches.

---

### Parte 3: Navegar entre Branches (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 7: Cambiar a develop con git switch
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Mueve HEAD al branch develop
# ¿Por qué?: Para empezar a trabajar en develop
# ¿Para qué sirve?: Cambiar el contexto de trabajo

git switch develop

# Resultado esperado:
# Switched to branch 'develop'

# Verificar
git branch
# * develop  (ahora tiene el asterisco)

# ══════════════════════════════════════════════════════════════
# PASO 8: Ver a qué apunta HEAD
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra la referencia de HEAD
# ¿Por qué?: Para entender cómo funciona internamente
# ¿Para qué sirve?: Debugging y comprensión de Git

cat .git/HEAD

# Resultado esperado:
# ref: refs/heads/develop

# ══════════════════════════════════════════════════════════════
# PASO 9: Cambiar a feature/login
# ══════════════════════════════════════════════════════════════

git switch feature/login

# Verificar HEAD
cat .git/HEAD
# ref: refs/heads/feature/login

# ══════════════════════════════════════════════════════════════
# PASO 10: Volver al branch anterior con -
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Cambia al branch donde estabas antes
# ¿Por qué?: Atajo útil para alternar entre dos branches
# ¿Para qué sirve?: Agilizar el flujo de trabajo

git switch -

# Resultado esperado:
# Switched to branch 'develop'

# Volver a feature/login
git switch -
# Switched to branch 'feature/login'
```

**Verificación**: Practica cambiando entre branches varias veces.

---

### Parte 4: Crear Branch y Cambiar en Un Paso (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 11: Crear y cambiar con git switch -c
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea un branch nuevo y cambia a él
# ¿Por qué?: Ahorra escribir dos comandos
# ¿Para qué sirve?: Iniciar trabajo en una feature rápidamente

git switch -c feature/contact

# Resultado esperado:
# Switched to a new branch 'feature/contact'

# Verificar
git branch

# ══════════════════════════════════════════════════════════════
# PASO 12: Alternativa con checkout -b (tradicional)
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Lo mismo que switch -c pero con checkout
# ¿Por qué?: Método tradicional, aún muy usado
# ¿Para qué sirve?: Conocer ambos métodos

git checkout -b feature/about

# Resultado esperado:
# Switched to a new branch 'feature/about'

# Ver todos los branches
git branch
```

---

### Parte 5: Eliminar Branches (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 13: Intentar eliminar branch actual
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Intenta eliminar el branch donde estás
# ¿Por qué?: Para ver el error que Git muestra
# ¿Para qué sirve?: Entender las protecciones de Git

git branch -d feature/about

# Resultado esperado:
# error: Cannot delete branch 'feature/about' checked out at...

# ══════════════════════════════════════════════════════════════
# PASO 14: Cambiar a main y eliminar branches
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Cambia a main y elimina branches no necesarios
# ¿Por qué?: No podemos eliminar el branch actual
# ¿Para qué sirve?: Limpiar branches obsoletos

git switch main

# Eliminar branch que no tiene commits únicos
git branch -d feature/about

# Resultado esperado:
# Deleted branch feature/about (was abc1234).

# Eliminar más branches
git branch -d feature/contact
git branch -d fix/typo

# Verificar
git branch

# ══════════════════════════════════════════════════════════════
# PASO 15: Ver branches con información de commits
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra branches con su último commit
# ¿Por qué?: Para ver el estado de cada branch
# ¿Para qué sirve?: Identificar qué trabajo tiene cada branch

git branch -v

# Resultado esperado (todos apuntan al mismo commit):
#   develop         abc1234 chore: initial commit
#   feature/dashboard abc1234 chore: initial commit
#   feature/login   abc1234 chore: initial commit
# * main            abc1234 chore: initial commit
```

---

## ✅ Checklist de Verificación

Antes de terminar, verifica que puedes:

- [ ] Crear branches con `git branch <nombre>`
- [ ] Listar branches con `git branch` y `git branch -v`
- [ ] Cambiar branches con `git switch <branch>`
- [ ] Usar el atajo `git switch -` para volver al branch anterior
- [ ] Crear y cambiar en un paso con `git switch -c <nuevo>`
- [ ] Eliminar branches con `git branch -d <nombre>`
- [ ] Entender qué es HEAD y ver su contenido

---

## 🧪 Desafío Extra (Opcional)

```bash
# 1. Crea 3 branches más siguiendo la convención de nombres
# 2. Navega entre ellos usando solo git switch -
# 3. Elimina todos excepto main y develop
# 4. Visualiza el historial con:
git log --oneline --decorate --all
```

---

## 🎯 Resultado Esperado

Al finalizar deberías tener:

```
$ git branch
  develop
  feature/dashboard
  feature/login
* main

$ git branch -v
  develop         abc1234 chore: initial commit
  feature/dashboard abc1234 chore: initial commit
  feature/login   abc1234 chore: initial commit
* main            abc1234 chore: initial commit
```

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [Teoría](../../1-teoria/) | [README](../README.md) | [Ejercicio 02](../ejercicio-02-merge-ff/README.md) |

---

<div align="center">

**Ejercicio 01** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
