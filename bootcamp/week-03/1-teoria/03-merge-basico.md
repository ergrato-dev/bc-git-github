# 🔀 Lección 03: Merge Básico

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- ✅ Comprender el concepto de merge y cuándo usarlo
- ✅ Realizar merge fast-forward
- ✅ Realizar merge con commit (three-way merge)
- ✅ Entender las diferencias entre ambos tipos
- ✅ Abortar un merge si es necesario

---

## 📖 ¿Qué es un Merge?

Un **merge** es la operación de Git que combina el trabajo de dos branches diferentes. Es la forma más común de integrar cambios de un branch a otro.

![Tipos de Merge](../0-assets/02-tipos-merge.svg)

### ¿Cuándo hacer merge?

- ✅ Cuando una feature está completa y probada
- ✅ Al integrar cambios de develop a main
- ✅ Al sincronizar tu branch con cambios del equipo
- ✅ Al finalizar un hotfix

---

## ⚡ Merge Fast-Forward

### ¿Qué es?

Un **fast-forward merge** ocurre cuando el branch destino no tiene commits nuevos desde que se creó el branch origen. Git simplemente "avanza" el puntero.

### Visualización

```
ANTES del merge:                DESPUÉS del merge:
                               
    C1---C2---C3 (feature)         C1---C2---C3 (main, feature)
        /                         
   main                           
```

### ¿Cómo ejecutarlo?

```bash
# ¿Qué hace?: Integra los commits de feature en main
# ¿Por qué?: Para incorporar una feature terminada
# ¿Para qué sirve?: Mantener main actualizado con nuevas features

# 1. Primero, ir al branch destino (main)
git switch main

# 2. Ejecutar el merge
git merge feature/login

# Salida típica:
# Updating abc1234..def5678
# Fast-forward
#  src/login.js | 50 +++++++++++++++++
#  1 file changed, 50 insertions(+)
```

### Forzar Fast-Forward Only

```bash
# ¿Qué hace?: Solo permite merge si es fast-forward
# ¿Por qué?: Para garantizar un historial lineal
# ¿Para qué sirve?: Cuando quieres asegurarte de no crear commits de merge

git merge --ff-only feature/login

# Si no es posible fast-forward:
# fatal: Not possible to fast-forward, aborting.
```

---

## 🔄 Three-Way Merge (Merge con Commit)

### ¿Qué es?

Un **three-way merge** (o merge recursivo) ocurre cuando ambos branches tienen commits nuevos. Git crea un **commit de merge** que tiene dos padres.

### Visualización

```
ANTES del merge:                DESPUÉS del merge:

    C1---C2---C5 (main)             C1---C2---C5---M (main)
          \                              \       /
           C3---C4 (feature)              C3---C4 (feature)
```

### ¿Cómo ejecutarlo?

```bash
# ¿Qué hace?: Crea un commit de merge combinando ambos branches
# ¿Por qué?: Cuando hay divergencia entre branches
# ¿Para qué sirve?: Integrar trabajo paralelo

# 1. Ir al branch destino
git switch main

# 2. Ejecutar el merge
git merge feature/dashboard

# Git abre el editor para el mensaje de merge:
# Merge branch 'feature/dashboard' into main
#
# Por favor ingrese un mensaje de commit...

# Salida típica:
# Merge made by the 'ort' strategy.
#  src/dashboard.js | 100 ++++++++++++++++
#  2 files changed, 100 insertions(+)
```

### Forzar Merge con Commit

```bash
# ¿Qué hace?: Crea un commit de merge aunque sea posible fast-forward
# ¿Por qué?: Para preservar el historial de la feature
# ¿Para qué sirve?: Documentar claramente qué commits pertenecían a qué feature

git merge --no-ff feature/login

# Esto SIEMPRE crea un commit de merge, incluso si fast-forward era posible
```

---

## 📊 Comparación: FF vs No-FF

| Aspecto | Fast-Forward | Three-Way (No-FF) |
|---------|--------------|-------------------|
| **Historial** | Lineal | Ramificado |
| **Commit de merge** | No | Sí |
| **Preserva contexto** | No | Sí |
| **Fácil de revertir** | Commit por commit | Un solo revert |
| **Cuándo ocurre** | Sin divergencia | Con divergencia |
| **Forzar** | `--ff-only` | `--no-ff` |

### ¿Cuál usar?

```bash
# Para features pequeñas o commits individuales:
git merge --ff-only feature/quick-fix

# Para features completas (preservar contexto):
git merge --no-ff feature/user-auth

# Dejar que Git decida (default):
git merge feature/something
```

---

## 🛠️ El Proceso de Merge Paso a Paso

### 1. Preparación

```bash
# Verificar que estás en el branch correcto
git branch
# * main
#   feature/login

# Verificar estado limpio
git status
# On branch main
# nothing to commit, working tree clean
```

### 2. Actualizar el branch destino

```bash
# Si trabajas con remotos, actualiza primero
git pull origin main
```

### 3. Ejecutar el merge

```bash
git merge feature/login
```

### 4. Verificar el resultado

```bash
# Ver el historial
git log --oneline --graph -10

# Verificar el estado
git status
```

### 5. (Opcional) Eliminar el branch fuente

```bash
# Si la feature está completa
git branch -d feature/login
```

---

## ❌ Abortar un Merge

### ¿Cuándo abortar?

- Cuando te das cuenta que estás en el branch equivocado
- Si hay conflictos que no puedes resolver ahora
- Si el merge fue un error

### Cómo abortar

```bash
# ¿Qué hace?: Cancela el merge en progreso
# ¿Por qué?: Para volver al estado anterior al merge
# ¿Para qué sirve?: Deshacer un merge problemático

git merge --abort

# Nota: Solo funciona si el merge aún no se completó
```

### Si el merge ya se completó

```bash
# Revertir el último commit (el merge commit)
git revert -m 1 HEAD

# O hacer reset (si no has pusheado)
git reset --hard HEAD~1
```

---

## 📋 Ver el Resultado del Merge

### Historial con gráfico

```bash
# ¿Qué hace?: Muestra el historial con estructura de branches
# ¿Por qué?: Para visualizar cómo se integraron los branches
# ¿Para qué sirve?: Entender el flujo de trabajo

git log --oneline --graph --all

# Ejemplo de salida:
# *   abc1234 (HEAD -> main) Merge branch 'feature/login'
# |\
# | * def5678 feat: add login validation
# | * ghi9012 feat: add login form
# |/
# * jkl3456 Initial commit
```

### Ver qué commits se integraron

```bash
# Ver commits del merge
git log main..feature/login --oneline
# (antes del merge, muestra commits pendientes)

# Ver diferencias
git diff main...feature/login
# (three-dot diff: cambios en feature desde que divergió)
```

---

## ⚠️ Merge y Conflictos

> **Nota**: Los conflictos de merge se cubrirán en detalle en **Week 04**.

### Vista previa rápida

```bash
# Si hay conflicto durante merge:
git merge feature/conflictiva

# Auto-merging archivo.txt
# CONFLICT (content): Merge conflict in archivo.txt
# Automatic merge failed; fix conflicts and then commit the result.

# Opciones:
# 1. Resolver conflictos manualmente
# 2. git merge --abort (cancelar)
```

---

## 💡 Best Practices

### 1. Siempre hacer merge desde el branch destino

```bash
# ✅ CORRECTO: Ir a main, luego merge
git switch main
git merge feature/login

# ❌ INCORRECTO: No hacer merge "hacia arriba"
git switch feature/login
git merge main  # Esto funciona pero no es el flujo correcto
```

### 2. Verificar el branch antes del merge

```bash
# Antes de mergear, confirma dónde estás
git branch
git status
```

### 3. Actualizar antes de mergear

```bash
# Si trabajas en equipo
git pull origin main
git merge feature/login
```

### 4. Usar `--no-ff` para features importantes

```bash
# Preserva el contexto de la feature
git merge --no-ff feature/user-authentication
```

---

## 📝 Ejercicio Práctico

```bash
# 1. Crear repositorio de prueba
mkdir practica-merge && cd practica-merge
git init

# 2. Primer commit en main
echo "# Proyecto" > README.md
git add README.md
git commit -m "chore: initial commit"

# 3. Crear branch y hacer commits
git switch -c feature/about
echo "## About" >> README.md
git commit -am "feat: add about section"
echo "More info" >> README.md
git commit -am "feat: expand about"

# 4. Volver a main y hacer merge fast-forward
git switch main
git merge feature/about
git log --oneline --graph

# 5. Crear otro branch con divergencia
git switch -c feature/contact
echo "## Contact" >> README.md
git commit -am "feat: add contact"

# 6. Volver a main y añadir cambio
git switch main
echo "## Footer" >> README.md
git commit -am "feat: add footer"

# 7. Merge con commit (three-way)
git merge feature/contact
# (Abre editor para mensaje de merge)
git log --oneline --graph
```

---

## 🎯 Resumen

| Comando | Descripción |
|---------|-------------|
| `git merge <branch>` | Merge básico (Git decide FF o no) |
| `git merge --ff-only <branch>` | Solo permite fast-forward |
| `git merge --no-ff <branch>` | Fuerza commit de merge |
| `git merge --abort` | Abortar merge en progreso |
| `git log --graph` | Visualizar historial |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Índice | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [02 - Navegación](02-navegacion-branches.md) | [Teoría](.) | [04 - Estrategias](04-estrategias-branching.md) |

---

<div align="center">

**Lección 03** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
