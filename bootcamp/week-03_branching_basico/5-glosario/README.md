# 📖 Glosario - Week 03: Branching Básico

Términos clave sobre **branches, merge y workflows** en Git.

---

## 🔤 Índice Alfabético

[B](#b) | [C](#c) | [D](#d) | [F](#f) | [G](#g) | [H](#h) | [M](#m) | [R](#r) | [S](#s) | [T](#t)

---

## B

### Branch
**Definición**: Puntero móvil que apunta a un commit específico. Permite desarrollo paralelo sin afectar otras líneas de trabajo.

```bash
git branch           # Listar branches
git branch <nombre>  # Crear branch
```

### Branch (eliminar)
**Definición**: Acción de remover un branch del repositorio. Puede ser segura (`-d`) o forzada (`-D`).

```bash
git branch -d feature/login  # Seguro (requiere merge previo)
git branch -D feature/login  # Forzado (elimina aunque no esté merged)
```

---

## C

### Checkout
**Definición**: Comando tradicional para cambiar de branch o restaurar archivos. Reemplazado parcialmente por `git switch` y `git restore`.

```bash
git checkout develop      # Cambiar a branch
git checkout -b feature   # Crear y cambiar
```

### Commit de Merge
**Definición**: Commit especial creado durante un three-way merge. Tiene dos commits padre y representa la unión de dos branches.

---

## D

### Detached HEAD
**Definición**: Estado donde HEAD apunta directamente a un commit en lugar de a un branch. Ocurre al hacer checkout a un commit específico o tag.

```bash
git checkout abc1234  # Causa detached HEAD
git switch main       # Vuelve al estado normal
```

### Develop
**Definición**: Branch de integración usado en Git Flow. Agrupa features antes de pasar a producción (main).

### Divergencia
**Definición**: Situación donde dos branches tienen commits diferentes desde su punto de separación. Requiere three-way merge.

---

## F

### Fast-Forward (FF)
**Definición**: Tipo de merge donde el branch destino simplemente avanza al último commit del branch origen. No crea commit de merge.

```bash
git merge feature/login        # FF automático si es posible
git merge --ff-only feature    # Falla si FF no es posible
```

### Feature Branch
**Definición**: Branch dedicado al desarrollo de una funcionalidad específica. Se crea desde develop o main y se elimina después del merge.

```bash
git switch -c feature/login
```

---

## G

### Git Flow
**Definición**: Estrategia de branching estructurada con branches específicos: main, develop, feature/*, release/*, hotfix/*.

### GitHub Flow
**Definición**: Estrategia simplificada con main como único branch permanente. Ideal para deployment continuo.

---

## H

### HEAD
**Definición**: Puntero especial que indica el commit/branch actual donde estás trabajando. Normalmente apunta a un branch.

```bash
cat .git/HEAD  # Ver referencia actual
# ref: refs/heads/main
```

### HEAD~n
**Definición**: Referencia relativa que apunta a n commits antes de HEAD.

```bash
HEAD~1  # Un commit atrás
HEAD~3  # Tres commits atrás
```

### Hotfix
**Definición**: Branch para correcciones urgentes en producción. Se crea desde main y se merge tanto a main como a develop.

---

## M

### Main
**Definición**: Branch principal del repositorio, representa el código en producción. Anteriormente llamado "master".

### Merge
**Definición**: Operación que combina el trabajo de dos branches. Puede ser fast-forward o three-way.

```bash
git merge feature/login
```

### Merge Commit
**Definición**: Ver [Commit de Merge](#commit-de-merge).

### --no-ff
**Definición**: Opción de merge que fuerza la creación de un commit de merge aunque fast-forward sea posible.

```bash
git merge --no-ff feature/login
```

---

## R

### Refs (Referencias)
**Definición**: Nombres simbólicos que apuntan a commits. Incluyen branches, tags y HEAD.

```bash
# Ubicación: .git/refs/
refs/heads/main     # Branch main
refs/tags/v1.0.0    # Tag v1.0.0
```

### Release Branch
**Definición**: Branch en Git Flow para preparar una nueva versión. Se crea desde develop, se mergea a main y develop.

---

## S

### Switch
**Definición**: Comando moderno (Git 2.23+) para cambiar entre branches. Más claro y seguro que checkout.

```bash
git switch develop        # Cambiar a branch
git switch -c feature     # Crear y cambiar
git switch -              # Volver al branch anterior
```

---

## T

### Three-Way Merge
**Definición**: Tipo de merge que crea un commit con dos padres. Ocurre cuando hay divergencia entre branches. También llamado merge recursivo.

### Tracking Branch
**Definición**: Branch local que tiene una conexión directa con un branch remoto. Permite push/pull sin especificar el remoto.

---

## 📊 Comandos Clave de la Semana

| Comando | Descripción |
|---------|-------------|
| `git branch` | Listar branches |
| `git branch <nombre>` | Crear branch |
| `git branch -d <nombre>` | Eliminar branch (seguro) |
| `git branch -D <nombre>` | Eliminar branch (forzado) |
| `git switch <branch>` | Cambiar a branch |
| `git switch -c <nuevo>` | Crear y cambiar |
| `git switch -` | Volver al anterior |
| `git merge <branch>` | Merge básico |
| `git merge --ff-only` | Solo fast-forward |
| `git merge --no-ff` | Forzar commit de merge |
| `git log --graph` | Ver historial gráfico |

---

## 📚 Recursos Adicionales

- [Documentación oficial: git-branch](https://git-scm.com/docs/git-branch)
- [Documentación oficial: git-merge](https://git-scm.com/docs/git-merge)
- [Atlassian: Git Branching](https://www.atlassian.com/git/tutorials/using-branches)

---

## 🔗 Navegación

| ⬅️ Recursos | 🏠 Semana |
|:------------|:---------:|
| [4-recursos](../4-recursos/) | [Week 03](../README.md) |

---

<div align="center">

**Glosario** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
