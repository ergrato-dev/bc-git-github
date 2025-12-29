# Ejercicio 03: Code Review Workflow

## Descripcion

Practicar el proceso completo de code review incluyendo comentarios, sugerencias y aprobacion.

**Duracion estimada:** 35 minutos

---

## Objetivos

- Revisar codigo de otros
- Escribir comentarios constructivos
- Usar sugerencias de codigo (suggestions)
- Aprobar o solicitar cambios
- Resolver conversaciones

---

## Requisitos Previos

- Completar ejercicios anteriores
- Repositorio con al menos 1 PR abierto
- (Ideal) Un companero para hacer review cruzado

---

## Parte 1: Setup para Review Cruzado (5 min)

### Opcion A: Con companero (recomendado)

1. Intercambiar URLs de repositorios con un companero
2. Agregar como colaborador:
   - Settings > Collaborators > Add people
3. Cada uno crea un PR en su repo para que el otro lo revise

### Opcion B: Self-review (individual)

1. Crear un nuevo PR con cambios para revisar
2. Practicar el proceso de review en tu propio codigo

### Paso 1.1: Crear PR para review

```bash
cd issue-practice
git checkout main
git pull

# Crear branch con codigo para revisar
git checkout -b feat/add-utils

# Crear archivo con algunos issues intencionales
cat > src/utils.js << 'EOF'
// Utility functions

function formatDate(date) {
    var d = new Date(date);
    var month = d.getMonth() + 1;
    var day = d.getDate();
    var year = d.getFullYear();
    return month + '/' + day + '/' + year;
}

function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

function truncate(str, length) {
    if (str.length > length) {
        return str.substring(0, length) + '...';
    }
    return str;
}

// TODO: Add more utility functions
var DEBUG = true;

module.exports = { formatDate, capitalize, truncate };
EOF

git add src/utils.js
git commit -m "feat: add utility functions"
git push -u origin feat/add-utils

# Crear PR
gh pr create --title "feat: add utility functions" --body "Adds date formatting and string utilities"
```

---

## Parte 2: Iniciar Review (10 min)

### Paso 2.1: Abrir el PR a revisar

1. Ir al PR (tuyo o de companero)
2. Click pestaña **Files changed**
3. Revisar cada archivo linea por linea

### Paso 2.2: Agregar comentarios de linea

#### Comentario 1: Pregunta

En la linea de `var d = new Date(date);`:

```markdown
question: What happens if `date` is null or invalid? Should we add validation?
```

Click **Start a review** (no "Add single comment")

#### Comentario 2: Sugerencia de mejora

En la linea de `var month = ...`:

```markdown
suggestion: Consider using `const` instead of `var` for better scoping and to prevent accidental reassignment.

```suggestion
    const d = new Date(date);
    const month = d.getMonth() + 1;
    const day = d.getDate();
    const year = d.getFullYear();
```
```

#### Comentario 3: Issue (problema)

En la linea de `var DEBUG = true;`:

```markdown
issue: Debug flag should not be committed to production code. Consider using environment variables.

```suggestion
const DEBUG = process.env.NODE_ENV === 'development';
```
```

#### Comentario 4: Elogio

En la funcion `truncate`:

```markdown
praise: Nice implementation! Clean and handles edge cases well.
```

#### Comentario 5: Nitpick

En el `// TODO`:

```markdown
nit: TODO comments should include author and date:
`// TODO(@username 2025-01-15): Add more utility functions`
```

---

## Parte 3: Enviar Review (5 min)

### Paso 3.1: Completar review

1. Click **Review changes** (boton verde arriba a la derecha)
2. Escribir resumen:

```markdown
## Review Summary

Good start on the utility functions! A few suggestions:

1. **Use const/let instead of var** - Better scoping
2. **Add input validation** - Handle edge cases
3. **Remove DEBUG flag** - Use environment variables

Overall the code is readable and well-structured. Please address the issues before merge.
```

3. Seleccionar **Request changes**
4. Click **Submit review**

---

## Parte 4: Responder a Review (10 min)

### Paso 4.1: Ver feedback recibido

1. Como autor, ir al PR
2. Ver los comentarios en **Conversation**
3. Ver las sugerencias en **Files changed**

### Paso 4.2: Aplicar sugerencias

1. En cada sugerencia (suggestion), click **Apply suggestion**
2. O agrupar varias: Marcar checkboxes y **Commit suggestions**
3. GitHub crea commits automaticos

### Paso 4.3: Responder comentarios

Para cada comentario:

1. Escribir respuesta explicando la accion tomada
2. Si no estas de acuerdo, explicar por que
3. Click **Reply**

Ejemplo de respuestas:

```markdown
# Para la pregunta sobre validacion
"Good point! Added validation in the next commit."

# Para el DEBUG flag
"Agreed, using env variable now. Applied the suggestion."

# Para el nitpick
"Updated the TODO format. Thanks for the tip!"
```

### Paso 4.4: Marcar como resueltos

1. Despues de aplicar cada cambio
2. Click **Resolve conversation** en cada hilo

---

## Parte 5: Re-review y Aprobar (5 min)

### Paso 5.1: Solicitar nueva revision

Como autor:
1. Ir a la seccion de reviewers
2. Click en el icono de refresh junto al reviewer
3. O crear nuevo commit que trigger notificacion

### Paso 5.2: Segunda revision (como reviewer)

1. Ver los nuevos commits
2. Verificar que los cambios fueron aplicados
3. Click **Review changes**
4. Escribir:

```markdown
All issues addressed. LGTM! 🚀
```

5. Seleccionar **Approve**
6. Click **Submit review**

### Paso 5.3: Merge

```bash
# Como autor, despues de aprobacion
gh pr merge --squash
```

---

## Parte 6: Review con GitHub CLI (opcional)

### Comandos utiles

```bash
# Ver PRs pendientes de tu review
gh pr list --reviewer @me

# Checkout del PR para probar localmente
gh pr checkout 2

# Agregar review desde CLI
gh pr review 2 --approve --body "LGTM!"

# Solicitar cambios desde CLI
gh pr review 2 --request-changes --body "Please fix the validation issue"

# Solo comentar
gh pr review 2 --comment --body "Looking good, just a few suggestions"
```

---

## Verificacion Final

### Checklist

- [ ] PR revisado completamente
- [ ] Al menos 5 comentarios agregados (diferentes tipos)
- [ ] Al menos 1 sugerencia de codigo usada
- [ ] Review enviado con "Request changes"
- [ ] Sugerencias aplicadas por el autor
- [ ] Conversaciones resueltas
- [ ] Segunda revision con "Approve"
- [ ] PR mergeado

### Tipos de Comentarios Usados

- [ ] `question:` - Pregunta
- [ ] `suggestion:` - Sugerencia
- [ ] `issue:` - Problema
- [ ] `praise:` - Elogio
- [ ] `nit:` - Nitpick

---

## Reto Extra

### 1. Batch Suggestions

Crear 3 sugerencias y aplicarlas en un solo commit:

1. Agregar 3 comentarios con bloques `suggestion`
2. En cada uno, marcar el checkbox "Add to batch"
3. Click "Commit suggestions"
4. Escribir mensaje: "refactor: apply review suggestions"

### 2. Review Checklist

Crear archivo `.github/PULL_REQUEST_TEMPLATE.md` con checklist para reviewers:

```markdown
## For Reviewers

- [ ] Code follows project style guidelines
- [ ] No security vulnerabilities introduced
- [ ] Tests cover new functionality
- [ ] Documentation is updated
- [ ] No unnecessary console.log or debug code
```

---

## Mejores Practicas Aprendidas

### Como Reviewer

1. Ser constructivo y respetuoso
2. Explicar el "por que" de cada comentario
3. Usar prefijos para claridad (nit, suggestion, issue)
4. Reconocer el buen trabajo
5. Responder en menos de 24 horas

### Como Autor

1. Hacer self-review antes de solicitar
2. Mantener PRs pequenos
3. Responder a todos los comentarios
4. Agradecer el feedback
5. No tomar los comentarios de forma personal

---

## Recursos

- [GitHub Code Review Docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests)
- [Conventional Comments](https://conventionalcomments.org/)
- [Google Code Review Guide](https://google.github.io/eng-practices/review/)

---

[Anterior: Pull Requests](../ejercicio-02-pull-requests/README.md) | [Siguiente: Projects + Templates](../ejercicio-04-projects-templates/README.md)
