# Mock Exam 02: GitHub Actions

## 📋 Información

- **Certificación**: GitHub Actions
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

¿En qué directorio deben ubicarse los archivos de workflow?

- A) `.github/actions/`
- B) `.github/workflows/`
- C) `.workflows/`
- D) `actions/`

---

## Pregunta 2

¿Qué trigger ejecuta un workflow cuando se hace push a la branch main?

- A) `on: push`
- B) `on: [push: main]`
- C) `on: push: branches: [main]`
- D) `trigger: push-main`

---

## Pregunta 3

¿Cuál es la sintaxis correcta para usar un secret en un workflow?

- A) `$SECRET_NAME`
- B) `${{ secrets.SECRET_NAME }}`
- C) `${secrets.SECRET_NAME}`
- D) `secrets.SECRET_NAME`

---

## Pregunta 4

¿Qué hace la keyword `needs` en un job?

- A) Instala dependencias
- B) Define que el job necesita ciertos permisos
- C) Especifica que el job depende de otro(s) job(s)
- D) Requiere aprobación manual

---

## Pregunta 5

¿Cuál es el propósito de una matrix strategy?

- A) Encriptar datos sensibles
- B) Ejecutar el mismo job con diferentes configuraciones
- C) Definir el orden de los steps
- D) Crear múltiples workflows

---

## Pregunta 6

¿Qué action se usa comúnmente para checkout del código?

- A) `actions/clone@v4`
- B) `actions/checkout@v4`
- C) `github/checkout@v4`
- D) `actions/git-clone@v4`

---

## Pregunta 7

¿Cómo se define una variable de entorno a nivel de workflow?

```yaml
# ¿Cuál es correcta?
```

- A) `variables: MY_VAR: value`
- B) `env: MY_VAR: value`
- C) `environment: MY_VAR: value`
- D) `vars: MY_VAR: value`

---

## Pregunta 8

¿Qué permite `workflow_dispatch`?

- A) Ejecutar workflow manualmente desde la UI
- B) Dispatch a otro repositorio
- C) Cancelar workflows en ejecución
- D) Debuggear workflows

---

## Pregunta 9

¿Cuál es el runner por defecto para GitHub-hosted runners?

- A) `runs-on: github-latest`
- B) `runs-on: ubuntu-latest`
- C) `runs-on: linux-latest`
- D) `runs-on: default`

---

## Pregunta 10

¿Qué hace `continue-on-error: true` en un step?

- A) Ignora todos los errores del workflow
- B) Permite que el workflow continúe si ese step falla
- C) Reintenta el step automáticamente
- D) Envía notificación de error

---

## ✅ Respuestas

<details>
<summary>Click para ver respuestas</summary>

| # | Respuesta | Explicación |
|---|-----------|-------------|
| 1 | **B** | `.github/workflows/` es el directorio estándar |
| 2 | **C** | Sintaxis correcta con branches filter |
| 3 | **B** | `${{ secrets.NAME }}` es la sintaxis de expresión |
| 4 | **C** | `needs` define dependencias entre jobs |
| 5 | **B** | Matrix ejecuta con múltiples configuraciones |
| 6 | **B** | `actions/checkout@v4` es el action oficial |
| 7 | **B** | `env:` define variables de entorno |
| 8 | **A** | Permite trigger manual desde GitHub UI |
| 9 | **B** | `ubuntu-latest` es el runner común |
| 10 | **B** | El workflow continúa aunque el step falle |

### Puntuación

- **9-10**: ¡Excelente! Listo para certificación
- **7-8**: Bien, repasa temas específicos
- **<7**: Revisa semanas 7-10

</details>

---

**Siguiente**: [Mock Exam 03 - Security](../mock-exam-03-security/README.md)
