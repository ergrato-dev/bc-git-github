# Leccion 03: Code Reviews

## Objetivos de Aprendizaje

Al finalizar esta leccion seras capaz de:

- Realizar code reviews efectivos
- Usar las diferentes acciones de review
- Escribir comentarios constructivos
- Aplicar sugerencias de codigo
- Seguir mejores practicas de review

---

## Que es Code Review?

**Code Review** es el proceso de revisar codigo propuesto por otros desarrolladores antes de integrarlo al proyecto.

### Beneficios

- Detectar bugs temprano
- Mantener calidad de codigo
- Compartir conocimiento
- Estandarizar practicas
- Documentar decisiones

![Code Review Process](../0-assets/03-code-review-process.svg)

---

## Acciones de Review

### 1. Comment

- Solo dejar comentarios
- No aprueba ni rechaza
- Ideal para preguntas o discusion

### 2. Approve

- Aprobar los cambios
- PR listo para merge
- Indica "codigo correcto"

### 3. Request Changes

- Solicitar modificaciones
- Bloquea el merge
- Requiere cambios antes de aprobar

---

## Iniciar un Review

### Desde GitHub UI

1. Ir al PR
2. Click pestaña **Files changed**
3. Hacer comentarios en lineas
4. Click **Review changes**
5. Escribir resumen
6. Seleccionar accion (Comment/Approve/Request changes)
7. **Submit review**

### Desde GitHub CLI

```bash
# Aprobar
gh pr review 42 --approve

# Aprobar con comentario
gh pr review 42 --approve --body "LGTM! Great work"

# Solicitar cambios
gh pr review 42 --request-changes --body "Need to add validation"

# Solo comentar
gh pr review 42 --comment --body "Have you considered..."
```

---

## Tipos de Comentarios

### Line Comments

Comentarios en lineas especificas de codigo.

```
Click en el + junto al numero de linea
Escribir comentario
"Add single comment" o "Start a review"
```

### Sugerencias (Suggestions)

Proponer cambio de codigo especifico que el autor puede aplicar directamente.

````markdown
```suggestion
const isValid = email.includes('@') && email.includes('.');
```
````

El autor puede hacer click en **Apply suggestion** para aceptar.

### Batch Suggestions

Agrupar multiples sugerencias en un solo commit:

1. Marcar cada sugerencia a aplicar
2. Click **Commit suggestions**
3. Escribir mensaje de commit
4. Confirmar

---

## Anatomia de un Buen Comentario

### Estructura

```markdown
[Tipo] Descripcion clara

Explicacion del por que.

[Ejemplo o sugerencia si aplica]
```

### Tipos de Prefijos

| Prefijo | Significado |
|---------|-------------|
| `nit:` | Nitpick, menor, opcional |
| `suggestion:` | Sugerencia, no bloqueante |
| `question:` | Pregunta, necesito entender |
| `issue:` | Problema que debe arreglarse |
| `praise:` | Elogio, buen trabajo |

### Ejemplos

```markdown
# Malo
"This is wrong"

# Bueno
"issue: This validation doesn't handle empty strings.

Consider adding a check:
```suggestion
if (!email || !email.includes('@')) {
  return false;
}
```"

# Malo
"Change this"

# Bueno
"suggestion: Using `const` here would prevent accidental reassignment.

Since `userId` never changes after initialization, `const` 
communicates intent better than `let`."

# Elogio
"praise: Great use of early returns here! 
Makes the code much more readable."
```

---

## Mejores Practicas para Reviewers

### DO (Hacer)

- **Ser constructivo**: Enfocarse en el codigo, no la persona
- **Explicar el por que**: Dar contexto de los comentarios
- **Sugerir alternativas**: No solo senalar problemas
- **Reconocer lo bueno**: Elogiar buen codigo
- **Responder rapido**: Idealmente en 24 horas
- **Usar sugerencias**: Facilitar aplicar cambios

### DON'T (No Hacer)

- **Criticar sin solucion**: "Esto esta mal"
- **Ser condescendiente**: "Obviamente..."
- **Ignorar contexto**: No entender limitaciones
- **Demorar reviews**: Bloquear al equipo
- **Pedir cambios cosmeticos excesivos**
- **Tomar decisiones de arquitectura en review**

---

## Mejores Practicas para Autores

### Antes del Review

- **Self-review**: Revisar tu propio codigo primero
- **PR pequenos**: Maximo 200-400 lineas
- **Descripcion clara**: Contexto suficiente
- **Tests incluidos**: Demostrar que funciona
- **CI pasando**: No pedir review con errores

### Durante el Review

- **Responder a todos**: No ignorar comentarios
- **Agradecer feedback**: Ser receptivo
- **Explicar decisiones**: Si no estas de acuerdo
- **Resolver conversaciones**: Marcar como resuelto

### Despues del Review

- **Aplicar sugerencias**: O explicar por que no
- **Re-request review**: Si hiciste cambios
- **Agradecer**: Al reviewer por su tiempo

---

## Review Checklist

### Funcionalidad

- [ ] El codigo hace lo que dice hacer?
- [ ] Maneja edge cases?
- [ ] Maneja errores apropiadamente?

### Codigo

- [ ] Es legible y entendible?
- [ ] Sigue convenciones del proyecto?
- [ ] No hay codigo duplicado?
- [ ] Variables y funciones bien nombradas?

### Seguridad

- [ ] No hay vulnerabilidades obvias?
- [ ] Input es validado?
- [ ] No hay secrets en el codigo?

### Performance

- [ ] No hay problemas obvios de performance?
- [ ] Queries optimizadas?
- [ ] No hay loops innecesarios?

### Tests

- [ ] Hay tests para los cambios?
- [ ] Tests son significativos?
- [ ] Tests pasan?

### Documentacion

- [ ] Codigo esta comentado donde necesario?
- [ ] README actualizado si aplica?
- [ ] API documentada si aplica?

---

## Resolver Comentarios

### Marcar como Resuelto

1. Hacer el cambio solicitado
2. Responder al comentario
3. Click **Resolve conversation**

### Responder sin Resolver

Si no estas de acuerdo o necesitas discutir:

1. Responder con tu perspectiva
2. NO marcar como resuelto
3. Continuar discusion

---

## Re-request Review

Despues de hacer cambios:

1. Responder a comentarios
2. Push nuevos commits
3. Click icono de refresh junto al reviewer
4. O usar CLI:

```bash
gh pr ready
```

---

## Configuracion de Required Reviews

En Branch Protection Rules:

| Opcion | Descripcion |
|--------|-------------|
| Require approvals | Numero minimo de aprobaciones |
| Dismiss stale reviews | Invalidar si hay nuevos commits |
| Require review from CODEOWNERS | Owners deben aprobar |
| Restrict who can dismiss | Limitar quien descarta reviews |

---

## Metricas de Review

### Tiempo de Review

- **Ideal**: < 24 horas
- **Aceptable**: < 48 horas
- **Problematico**: > 1 semana

### Tamano del PR

- **Ideal**: < 200 lineas
- **Aceptable**: 200-400 lineas
- **Problematico**: > 500 lineas

### Iteraciones

- **Ideal**: 1-2 ciclos de review
- **Normal**: 2-3 ciclos
- **Problematico**: > 4 ciclos

---

## Ejercicio Practico

### Hacer un Code Review

1. Ve a un PR de un companero (o crea uno de practica)

2. Revisar **Files changed**

3. Agregar comentarios:
   - 1 comentario tipo `nit:`
   - 1 comentario tipo `suggestion:` con codigo
   - 1 comentario tipo `praise:`

4. Ejemplo de suggestion:
   ````markdown
   suggestion: Consider using template literals for cleaner string concatenation.
   
   ```suggestion
   const greeting = `Hello, ${name}!`;
   ```
   ````

5. Hacer **Submit review** con "Approve" o "Request changes"

---

## Resumen

| Concepto | Descripcion |
|----------|-------------|
| Comment | Solo comentar, sin decision |
| Approve | Aprobar cambios |
| Request Changes | Solicitar modificaciones |
| Suggestion | Proponer codigo especifico |
| Resolve | Marcar comentario como resuelto |
| Re-request | Pedir nueva revision |

---

## Recursos Adicionales

- [GitHub Docs: Reviewing PRs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests)
- [How to do a code review](https://google.github.io/eng-practices/review/reviewer/)
- [Conventional Comments](https://conventionalcomments.org/)

---

[Siguiente leccion: GitHub Projects](04-github-projects.md)
