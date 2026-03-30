# Mock Exam 03: GitHub Advanced Security

## 📋 Información

- **Certificación**: GitHub Advanced Security
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

¿Qué herramienta usa GitHub para code scanning por defecto?

- A) SonarQube
- B) CodeQL
- C) Snyk
- D) Checkmarx

---

## Pregunta 2

¿Qué detecta Secret Scanning?

- A) Vulnerabilidades en dependencias
- B) Errores de sintaxis en código
- C) Credenciales y tokens expuestos en el código
- D) Problemas de performance

---

## Pregunta 3

¿Qué archivo configura CodeQL analysis?

- A) `codeql.yml`
- B) `security.yml`
- C) `.github/workflows/codeql-analysis.yml`
- D) `.codeql/config.yml`

---

## Pregunta 4

¿Qué hace Dependabot?

- A) Solo escanea código fuente
- B) Crea PRs automáticos para actualizar dependencias vulnerables
- C) Bloquea commits con vulnerabilidades
- D) Genera reportes de compliance

---

## Pregunta 5

¿Cuál es el propósito del archivo `SECURITY.md`?

- A) Configurar code scanning
- B) Definir políticas de seguridad y cómo reportar vulnerabilidades
- C) Listar todas las vulnerabilidades conocidas
- D) Configurar branch protection

---

## Pregunta 6

¿Qué formato usa GitHub para reportar resultados de code scanning?

- A) JSON
- B) XML
- C) SARIF
- D) CSV

---

## Pregunta 7

¿Qué hace push protection en secret scanning?

- A) Protege branches de push forzado
- B) Bloquea push si contiene secrets detectados
- C) Requiere 2FA para push
- D) Encripta los push automáticamente

---

## Pregunta 8

¿Dónde se configuran las alertas de Dependabot?

- A) Solo en el archivo `dependabot.yml`
- B) En Settings > Security > Dependabot
- C) Solo via API
- D) En el archivo `package.json`

---

## Pregunta 9

¿Qué es un Security Advisory en GitHub?

- A) Un tipo de issue especial
- B) Un documento privado para coordinar la divulgación de vulnerabilidades
- C) Una alerta automática de Dependabot
- D) Un reporte de code scanning

---

## Pregunta 10

¿Qué permite Dependency Review?

- A) Ver el historial de dependencias
- B) Bloquear PRs que introducen vulnerabilidades conocidas
- C) Actualizar dependencias automáticamente
- D) Escanear dependencias en runtime

---

## ✅ Respuestas

<details>
<summary>Click para ver respuestas</summary>

| # | Respuesta | Explicación |
|---|-----------|-------------|
| 1 | **B** | CodeQL es el motor de análisis de GitHub |
| 2 | **C** | Detecta secrets como tokens, API keys, passwords |
| 3 | **C** | Workflow en `.github/workflows/` |
| 4 | **B** | Crea PRs para actualizar dependencias |
| 5 | **B** | Define política de seguridad del proyecto |
| 6 | **C** | SARIF (Static Analysis Results Interchange Format) |
| 7 | **B** | Bloquea push con secrets antes de que lleguen al repo |
| 8 | **B** | Settings > Security > Dependabot |
| 9 | **B** | Coordinar divulgación responsable de vulnerabilidades |
| 10 | **B** | Bloquea PRs con vulnerabilidades en deps |

### Puntuación

- **9-10**: ¡Excelente! Listo para certificación
- **7-8**: Bien, repasa temas específicos
- **<7**: Revisa semanas 11-13

</details>

---

**Siguiente**: [Mock Exam 04 - Administration](../mock-exam-04-admin/README.md)
