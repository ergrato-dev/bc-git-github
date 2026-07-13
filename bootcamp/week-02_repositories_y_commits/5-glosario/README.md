# 📖 Glosario - Week 02

Términos clave sobre **staging area**, **commits** y **navegación del historial**.

---

## 🔤 Índice Rápido

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [H](#h) | [I](#i) | [L](#l) | [M](#m) | [R](#r) | [S](#s) | [T](#t) | [U](#u) | [W](#w)

---

## A

### Add (git add)
Comando que mueve archivos del working directory al staging area. Prepara los cambios para ser incluidos en el próximo commit.

```bash
git add archivo.txt    # Agregar archivo específico
git add .              # Agregar todos los cambios
git add -p             # Agregar por partes (interactivo)
```

### Amend (--amend)
Opción de `git commit` que permite modificar el último commit. Útil para corregir mensajes o agregar archivos olvidados.

```bash
git commit --amend -m "mensaje corregido"
git commit --amend --no-edit
```

### Atomic Commit
Commit que contiene un solo cambio lógico. Principio de hacer commits pequeños y enfocados en una sola tarea.

---

## B

### Blame (git blame)
Comando que muestra quién modificó cada línea de un archivo y en qué commit.

```bash
git blame archivo.txt
```

### Body (del commit)
Parte opcional del mensaje de commit que proporciona contexto adicional. Va después de una línea en blanco del subject.

---

## C

### Commit
Snapshot (fotografía) del estado del proyecto en un momento específico. Unidad fundamental del historial de Git.

### Commit Message
Mensaje descriptivo que acompaña cada commit. Debe explicar QUÉ se hizo y POR QUÉ.

### Conventional Commits
Especificación para escribir mensajes de commit de forma estructurada. Formato: `tipo(scope): descripción`.

```bash
feat: nueva funcionalidad
fix: corrección de bug
docs: solo documentación
style: formato, sin cambio de lógica
refactor: mejora de código
test: agregar tests
chore: mantenimiento
```

---

## D

### Diff (git diff)
Comando que muestra las diferencias entre versiones. Puede comparar working directory, staging, commits o branches.

```bash
git diff              # Working vs staging
git diff --staged     # Staging vs último commit
git diff HEAD~2..HEAD # Entre commits
```

---

## H

### HEAD
Puntero que indica tu posición actual en el historial. Generalmente apunta al último commit de la branch activa.

### HEAD~n
Referencia al commit n posiciones atrás de HEAD. `HEAD~1` es el commit anterior, `HEAD~2` dos atrás, etc.

### Hash (SHA-1)
Identificador único de 40 caracteres hexadecimales que identifica cada commit. Se puede usar el hash corto (7 caracteres).

```
a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0  # Hash completo
a1b2c3d                                      # Hash corto
```

---

## I

### Index
Otro nombre para el staging area. Archivo interno de Git (`.git/index`) que rastrea los cambios preparados.

---

## L

### Log (git log)
Comando que muestra el historial de commits. Tiene muchas opciones de formato y filtrado.

```bash
git log --oneline           # Formato compacto
git log --graph             # Con gráfico visual
git log -n 5                # Últimos 5 commits
git log --grep="feat"       # Filtrar por mensaje
git log --author="nombre"   # Filtrar por autor
```

---

## M

### Modified
Estado de un archivo que ha sido cambiado desde el último commit pero no está en staging.

---

## R

### Reset (git reset)
Comando que mueve HEAD a un commit anterior. Tiene tres modos:
- `--soft`: mantiene cambios en staging
- `--mixed`: mantiene cambios en working (default)
- `--hard`: borra todo (peligroso)

```bash
git reset --soft HEAD~1   # Deshacer commit, mantener staged
git reset HEAD~1          # Deshacer commit, mantener working
git reset --hard HEAD~1   # Deshacer commit, borrar cambios
```

### Restore (git restore)
Comando moderno para restaurar archivos. Reemplaza algunos usos de `git checkout`.

```bash
git restore archivo.txt           # Descartar cambios en working
git restore --staged archivo.txt  # Quitar del staging
```

### Revert (git revert)
Comando que crea un nuevo commit que deshace los cambios de un commit anterior. Seguro para commits ya pusheados.

```bash
git revert abc1234    # Crear commit que revierte abc1234
```

### Reflog (git reflog)
Registro de todos los movimientos de HEAD. Útil para recuperar commits "perdidos".

```bash
git reflog
```

---

## S

### Scope
Parte opcional del mensaje Conventional Commits que indica qué área del proyecto se afecta.

```bash
feat(auth): implementar login    # scope = auth
fix(ui): corregir alineación     # scope = ui
```

### SHA (Secure Hash Algorithm)
Algoritmo criptográfico usado por Git para generar identificadores únicos de commits.

### Show (git show)
Comando que muestra información detallada de un commit específico.

```bash
git show            # Último commit
git show HEAD~1     # Commit anterior
git show abc1234    # Commit específico
```

### Staged
Estado de un archivo que está en el staging area, listo para ser incluido en el próximo commit.

### Staging Area
Zona intermedia entre working directory y repository. Donde se preparan los cambios antes de hacer commit.

### Subject
Primera línea del mensaje de commit. Debe ser concisa (≤50 caracteres) y descriptiva.

---

## T

### Tree
Estructura de datos que representa el snapshot de archivos en un commit.

### Type (tipo)
Prefijo obligatorio en Conventional Commits que indica el tipo de cambio (feat, fix, docs, etc.).

---

## U

### Unstaged
Cambios en el working directory que no han sido agregados al staging area.

### Untracked
Archivo que Git no conoce. Nunca ha sido agregado al repository.

---

## W

### Working Directory
Tu espacio de trabajo actual. La carpeta donde están tus archivos y donde haces cambios.

---

## 📊 Tabla Resumen de Estados

| Estado | Color en git status | Ubicación |
|--------|---------------------|-----------|
| Untracked | Rojo | Working Directory |
| Modified | Rojo | Working Directory |
| Staged | Verde | Staging Area |
| Committed | No aparece | Repository |

---

## 📊 Tabla de Comandos de la Semana

| Comando | Propósito |
|---------|-----------|
| `git add` | Agregar al staging |
| `git commit` | Crear commit |
| `git status` | Ver estado |
| `git diff` | Ver diferencias |
| `git log` | Ver historial |
| `git show` | Inspeccionar commit |
| `git restore` | Restaurar archivos |
| `git reset` | Mover HEAD |
| `git revert` | Deshacer commit (seguro) |

---

## 🔗 Navegación

| ⬅️ Recursos | 🏠 Semana | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Recursos](../4-recursos/README.md) | [Week 02](../README.md) | [Week 03](../../week-03_branching_basico/README.md) |

---

_Glosario Week 02 | Bootcamp Git/GitHub | 2025_
