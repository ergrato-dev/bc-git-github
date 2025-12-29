# Glosario - Week 04: Merge Conflicts

Terminos clave y definiciones sobre resolucion de conflictos en Git.

---

## Indice Alfabetico

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [F](#f) | [H](#h) | [I](#i) | [M](#m) | [O](#o) | [R](#r) | [S](#s) | [T](#t)

---

## A

### Abort

**Definicion**: Cancelar una operacion de merge en progreso y volver al estado anterior.

```bash
git merge --abort
```

**Contexto**: Se usa cuando un merge tiene demasiados conflictos o se decidio no continuar.

---

### Auto-merge

**Definicion**: Cuando Git puede combinar cambios automaticamente sin intervencion humana.

**Ejemplo**: Dos desarrolladores modifican archivos diferentes - Git los une sin conflicto.

---

## B

### Base

**Definicion**: El ancestro comun mas reciente entre dos branches que se estan fusionando.

**Importancia**: Git compara ambos branches contra la base para detectar que cambio.

```
      A---B---C  (feature)
     /
D---E---F---G    (main)
    ^
    Base (E es el ancestro comun)
```

---

## C

### Conflict Markers

**Definicion**: Lineas especiales que Git inserta en archivos con conflictos para delimitar las versiones en disputa.

```
<<<<<<< HEAD
Codigo de tu branch actual
=======
Codigo del branch entrante
>>>>>>> feature-branch
```

| Marcador | Significado |
|----------|-------------|
| `<<<<<<<` | Inicio de tu version (current) |
| `=======` | Separador entre versiones |
| `>>>>>>>` | Fin de version entrante (incoming) |

---

### Content Conflict

**Definicion**: Conflicto que ocurre cuando dos branches modifican las mismas lineas de un archivo.

**Es el tipo mas comun de conflicto.**

---

### Current Changes

**Definicion**: Los cambios de tu branch actual (donde tienes el HEAD).

**Sinonimos**: "Ours", "HEAD", "Tu version"

**En VS Code**: Aparece en verde

---

## D

### Delete/Modify Conflict

**Definicion**: Conflicto cuando un branch elimina un archivo que otro branch modifico.

**Resolucion**: Decidir si mantener el archivo (con modificaciones) o eliminarlo.

---

### Diff

**Definicion**: Herramienta que muestra las diferencias entre dos versiones de archivos.

```bash
git diff                    # Cambios no staged
git diff --staged           # Cambios staged
git diff branch1 branch2    # Entre branches
```

---

## F

### Fast-forward Merge

**Definicion**: Tipo de merge donde el branch destino simplemente avanza al commit del branch fuente, sin crear merge commit.

```
Antes:
main:    A---B
feature:     \---C---D

Despues (fast-forward):
main:    A---B---C---D
```

**Nota**: No genera conflictos porque no hay divergencia.

---

## H

### HEAD

**Definicion**: Puntero al commit actual de tu branch activo.

**En conflictos**: `<<<<<<< HEAD` marca tu version actual.

---

## I

### Incoming Changes

**Definicion**: Los cambios del branch que estas intentando fusionar.

**Sinonimos**: "Theirs", "Su version"

**En VS Code**: Aparece en azul

---

## M

### Merge

**Definicion**: Operacion que combina el historial de dos branches en uno.

```bash
git merge feature-branch
```

**Tipos**:
- Fast-forward: Sin conflictos, avance lineal
- Three-way: Crea merge commit, puede tener conflictos

---

### Merge Commit

**Definicion**: Commit especial que tiene dos (o mas) commits padre, creado al completar un merge.

```
A---B---C---F  (main, F es merge commit)
     \     /
      D---E    (feature)
```

---

### Merge Tool / Mergetool

**Definicion**: Herramienta externa para resolver conflictos visualmente.

```bash
git mergetool
```

**Herramientas comunes**: VS Code, Meld, kdiff3, vimdiff, opendiff

---

## O

### Ours

**Definicion**: Estrategia o seleccion que mantiene tu version (current) en un conflicto.

```bash
git checkout --ours archivo.txt
git merge -X ours feature
```

---

## R

### Recursive Strategy

**Definicion**: Estrategia de merge por defecto de Git para two-way merges.

**Funcionamiento**: Encuentra la base comun y aplica three-way merge.

---

### Rename Conflict

**Definicion**: Conflicto cuando dos branches renombran el mismo archivo de manera diferente.

**Ejemplo**: `utils.js` -> `helpers.js` (branch A) vs `utils.js` -> `tools.js` (branch B)

---

### Rerere

**Definicion**: "Reuse Recorded Resolution" - Funcionalidad que recuerda como resolviste conflictos anteriores.

```bash
git config --global rerere.enabled true
```

**Beneficio**: Si el mismo conflicto aparece de nuevo, Git lo resuelve automaticamente.

---

## S

### Stage (en contexto de conflictos)

**Definicion**: Marcar un archivo con conflicto como resuelto.

```bash
git add archivo-resuelto.txt
```

**Importante**: Solo hacer `git add` despues de resolver manualmente el conflicto.

---

## T

### Theirs

**Definicion**: Estrategia o seleccion que mantiene la version entrante (incoming) en un conflicto.

```bash
git checkout --theirs archivo.txt
git merge -X theirs feature
```

---

### Three-way Merge

**Definicion**: Algoritmo de merge que compara tres versiones: base, current, e incoming.

```
Base    Current    Incoming    Resultado
----    -------    --------    ---------
A       A          A           A (sin cambio)
A       B          A           B (current gana)
A       A          B           B (incoming gana)
A       B          C           CONFLICTO
```

---

## Tabla Resumen

| Termino | Ingles | Significado Rapido |
|---------|--------|-------------------|
| Abortar | Abort | Cancelar merge |
| Marcadores | Conflict Markers | `<<<<<<<`, `=======`, `>>>>>>>` |
| Base | Base | Ancestro comun |
| Actual | Current/Ours | Tu version (HEAD) |
| Entrante | Incoming/Theirs | Version a fusionar |
| Herramienta | Mergetool | App visual para resolver |
| Preparar | Stage | Marcar como resuelto |

---

## Recursos Adicionales

- [Documentacion oficial de Git](https://git-scm.com/doc)
- [GitHub Docs - Merge Conflicts](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)

---

## Navegacion

| Seccion | Enlace |
|---------|--------|
| Semana | [README](../README.md) |
| Teoria | [1-teoria/](../1-teoria/) |
| Recursos | [4-recursos/](../4-recursos/) |

---

*Week 04 | Bootcamp Git/GitHub*
