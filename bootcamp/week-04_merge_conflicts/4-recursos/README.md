# Recursos - Week 04: Merge Conflicts

Material adicional para profundizar en la resolucion de conflictos de merge.

---

## Contenido

| Carpeta | Descripcion |
|---------|-------------|
| [ebooks-free/](ebooks-free/) | Libros electronicos gratuitos sobre Git |
| [videografia/](videografia/) | Videos y tutoriales sobre conflictos |
| [webgrafia/](webgrafia/) | Documentacion oficial y articulos |

---

## Recursos Destacados de la Semana

### Documentacion Oficial

- [Git - Basic Merge Conflicts](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging#_basic_merge_conflicts)
- [GitHub - Resolving Merge Conflicts](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts)
- [VS Code - Source Control](https://code.visualstudio.com/docs/sourcecontrol/overview)

### Herramientas Recomendadas

| Herramienta | Tipo | Descripcion |
|-------------|------|-------------|
| VS Code | Editor | Interfaz visual integrada para conflictos |
| Meld | GUI | Herramienta grafica de 3 paneles |
| kdiff3 | GUI | Comparador con auto-merge |
| vimdiff | CLI | Para usuarios de Vim |
| IntelliJ | IDE | Excelente resolucion visual |

### Comandos Clave

```bash
# Ver conflictos pendientes
git diff --name-only --diff-filter=U

# Configurar mergetool
git config --global merge.tool meld

# Usar nuestra version
git checkout --ours archivo.txt

# Usar su version
git checkout --theirs archivo.txt

# Abortar merge
git merge --abort
```

---

## Como Usar Estos Recursos

1. **Primero**: Completa teoria y practicas de la semana
2. **Despues**: Consulta los videos para ver ejemplos visuales
3. **Finalmente**: Lee articulos avanzados para casos especiales

---

## Navegacion

| Seccion | Enlace |
|---------|--------|
| Semana | [README](../README.md) |
| Teoria | [1-teoria/](../1-teoria/) |
| Practicas | [2-practicas/](../2-practicas/) |

---

*Week 04 | Bootcamp Git/GitHub*
