# Mock Exam 01: GitHub Foundations

## 📋 Información

- **Certificación**: GitHub Foundations
- **Preguntas**: 10
- **Tiempo**: 30 minutos
- **Aprobación**: 70% (7/10)

---

## 📝 Instrucciones

1. Lee cada pregunta completamente
2. Selecciona la mejor respuesta
3. No uses referencias externas
4. Anota tus respuestas
5. Verifica al final con las soluciones

---

## Pregunta 1

¿Cuál es el comando para crear un nuevo repositorio Git en un directorio existente?

- A) `git create`
- B) `git new`
- C) `git init`
- D) `git start`

---

## Pregunta 2

¿Qué comando mueve cambios del staging area al repositorio local?

- A) `git add`
- B) `git push`
- C) `git commit`
- D) `git stage`

---

## Pregunta 3

¿Cuál es la diferencia entre `git fetch` y `git pull`?

- A) No hay diferencia, son sinónimos
- B) `fetch` descarga cambios sin merge, `pull` descarga y hace merge
- C) `fetch` sube cambios, `pull` los descarga
- D) `pull` solo funciona con branches remotos

---

## Pregunta 4

¿Qué archivo se usa para especificar archivos que Git debe ignorar?

- A) `.gitconfig`
- B) `.gitignore`
- C) `.gitexclude`
- D) `ignore.git`

---

## Pregunta 5

En un Pull Request, ¿quién puede aprobar los cambios por defecto?

- A) Solo el autor del PR
- B) Cualquier colaborador con acceso de escritura
- C) Solo los administradores del repositorio
- D) Cualquier usuario de GitHub

---

## Pregunta 6

¿Qué comando crea una nueva branch Y te cambia a ella?

- A) `git branch new-feature`
- B) `git checkout new-feature`
- C) `git checkout -b new-feature`
- D) `git switch --create new-feature` (ambas C y D son correctas)

---

## Pregunta 7

¿Cuál es el propósito de GitHub Issues?

- A) Solo reportar bugs
- B) Trackear tareas, bugs, features y discusiones
- C) Gestionar releases
- D) Configurar CI/CD

---

## Pregunta 8

¿Qué indica el archivo `CODEOWNERS`?

- A) Quién creó el repositorio
- B) Quién debe revisar cambios en archivos específicos
- C) Quién tiene acceso admin
- D) Quién puede hacer merge

---

## Pregunta 9

¿Cuál es la forma correcta de deshacer el último commit manteniendo los cambios?

- A) `git reset --hard HEAD~1`
- B) `git reset --soft HEAD~1`
- C) `git revert HEAD`
- D) `git undo`

---

## Pregunta 10

¿Qué protege una branch protection rule típica?

- A) Solo el código fuente
- B) Requiere PRs, reviews, y/o status checks antes de merge
- C) Encripta los archivos
- D) Previene que se cree la branch

---

## ✅ Respuestas

<details>
<summary>Click para ver respuestas</summary>

| # | Respuesta | Explicación |
|---|-----------|-------------|
| 1 | **C** | `git init` inicializa un nuevo repositorio |
| 2 | **C** | `git commit` guarda los cambios staged |
| 3 | **B** | `fetch` descarga sin merge, `pull` = fetch + merge |
| 4 | **B** | `.gitignore` lista archivos a ignorar |
| 5 | **B** | Colaboradores con write access pueden aprobar |
| 6 | **C/D** | Ambos crean y cambian a la branch |
| 7 | **B** | Issues trackean tareas, bugs, features |
| 8 | **B** | CODEOWNERS define reviewers automáticos |
| 9 | **B** | `--soft` mantiene cambios en staging |
| 10 | **B** | Requiere PRs/reviews antes de merge |

### Puntuación

- **9-10**: ¡Excelente! Listo para certificación
- **7-8**: Bien, repasa temas específicos
- **<7**: Revisa semanas 1-6

</details>

---

**Siguiente**: [Mock Exam 02 - Actions](../mock-exam-02-actions/README.md)
