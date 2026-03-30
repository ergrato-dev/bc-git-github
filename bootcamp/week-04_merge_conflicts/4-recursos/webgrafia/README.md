# Webgrafia - Merge Conflicts

Enlaces, articulos y documentacion oficial sobre resolucion de conflictos.

---

## Documentacion Oficial

### Git SCM

| Recurso | Enlace | Descripcion |
|---------|--------|-------------|
| git-merge | [git-scm.com/docs/git-merge](https://git-scm.com/docs/git-merge) | Documentacion completa del comando |
| git-mergetool | [git-scm.com/docs/git-mergetool](https://git-scm.com/docs/git-mergetool) | Configurar herramientas de merge |
| gitattributes | [git-scm.com/docs/gitattributes](https://git-scm.com/docs/gitattributes) | Estrategias de merge por archivo |
| Pro Git Book | [git-scm.com/book/en/v2](https://git-scm.com/book/en/v2) | Libro oficial gratuito |

### GitHub Docs

| Recurso | Enlace | Descripcion |
|---------|--------|-------------|
| Resolving Conflicts | [docs.github.com](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line) | Guia oficial de GitHub |
| About Merge Conflicts | [docs.github.com](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/about-merge-conflicts) | Conceptos basicos |
| Web Editor Conflicts | [docs.github.com](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-on-github) | Resolver en interfaz web |

### VS Code

| Recurso | Enlace | Descripcion |
|---------|--------|-------------|
| Source Control | [code.visualstudio.com](https://code.visualstudio.com/docs/sourcecontrol/overview) | Control de versiones en VS Code |
| Git Support | [code.visualstudio.com](https://code.visualstudio.com/docs/sourcecontrol/overview#_merge-conflicts) | Seccion de merge conflicts |

---

## Articulos Recomendados

### Conceptos Fundamentales

1. **How Git Merge Works**
   - Fuente: Atlassian
   - Enlace: [atlassian.com/git/tutorials/using-branches/git-merge](https://www.atlassian.com/git/tutorials/using-branches/git-merge)
   - Nivel: Principiante

2. **Git Merge Conflicts**
   - Fuente: Atlassian
   - Enlace: [atlassian.com/git/tutorials/using-branches/merge-conflicts](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts)
   - Nivel: Principiante-Intermedio

3. **Advanced Merging**
   - Fuente: Git Book
   - Enlace: [git-scm.com/book/en/v2/Git-Tools-Advanced-Merging](https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging)
   - Nivel: Avanzado

### Herramientas y Configuracion

4. **Setting Up a Merge Tool**
   - Buscar: "git config merge.tool"
   - Herramientas: meld, kdiff3, vimdiff, opendiff

5. **VS Code as Git Diff Tool**
   - Configuracion para usar VS Code como difftool

### Estrategias y Best Practices

6. **Merge vs Rebase**
   - Fuente: Atlassian
   - Enlace: [atlassian.com/git/tutorials/merging-vs-rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

7. **Git Branching Strategies**
   - Fuente: GitKraken
   - Temas: Git Flow, GitHub Flow, GitLab Flow

---

## Herramientas Online

### Visualizadores de Git

| Herramienta | Enlace | Uso |
|-------------|--------|-----|
| Learn Git Branching | [learngitbranching.js.org](https://learngitbranching.js.org/) | Practica interactiva |
| Git Visualizer | [git-school.github.io/visualizing-git](https://git-school.github.io/visualizing-git/) | Ver operaciones |
| Explain Git with D3 | [onlywei.github.io/explain-git-with-d3](https://onlywei.github.io/explain-git-with-d3/) | Visualizacion animada |

### Playgrounds

| Herramienta | Enlace | Uso |
|-------------|--------|-----|
| GitHub Dev | github.dev | Editor en navegador |
| Gitpod | gitpod.io | Entorno cloud |
| Replit | replit.com | Terminal con Git |

---

## Foros y Comunidad

### Stack Overflow

Tags relevantes:
- `[git-merge]`
- `[merge-conflict-resolution]`
- `[git-merge-conflict]`

Preguntas frecuentes:
- "How to resolve merge conflict in Git"
- "Abort merge and start over"
- "Accept theirs or ours during merge"

### Reddit

- r/git
- r/github
- r/learnprogramming

---

## Cheatsheets Online

| Recurso | Enlace | Formato |
|---------|--------|---------|
| GitHub Cheat Sheet | [github.github.com/training-kit](https://github.github.com/training-kit/) | PDF |
| Atlassian Git Cheat Sheet | [atlassian.com](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet) | PDF |
| GitLab Git Cheat Sheet | [about.gitlab.com](https://about.gitlab.com/images/press/git-cheat-sheet.pdf) | PDF |

---

## Comandos Rapidos - Referencia Web

```bash
# Referencia rapida para conflictos

# Ver estado de conflictos
git status

# Ver archivos en conflicto
git diff --name-only --diff-filter=U

# Aceptar version actual (HEAD)
git checkout --ours <archivo>

# Aceptar version entrante
git checkout --theirs <archivo>

# Abrir herramienta de merge
git mergetool

# Abortar merge
git merge --abort

# Marcar como resuelto
git add <archivo>

# Completar merge
git commit
```

---

## Navegacion

- [Volver a recursos](../README.md)
- [Volver a la semana](../../README.md)

---

*Week 04 | Bootcamp Git/GitHub*
