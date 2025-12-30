# Lección 02: Project Showcase

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- Presentar tu proyecto de forma profesional
- Crear documentación efectiva
- Demostrar tus habilidades técnicas
- Recibir y dar feedback constructivo

---

## 📚 Anatomía de un Proyecto Showcase

![Project Architecture](../0-assets/02-project-architecture.svg)

### Componentes Esenciales

```yaml
Repositorio Profesional:
  README.md:
    - Descripción clara del proyecto
    - Screenshots/demos
    - Instalación y uso
    - Tecnologías usadas
    - Badges de status
  
  Documentación:
    - CONTRIBUTING.md
    - CODE_OF_CONDUCT.md
    - LICENSE
    - CHANGELOG.md
  
  Estructura:
    - Código organizado
    - Tests incluidos
    - CI/CD configurado
    - Security implementado
```

---

## 📋 README Profesional

### Template

```markdown
# 🚀 Nombre del Proyecto

[![CI](https://github.com/user/repo/actions/workflows/ci.yml/badge.svg)](...)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

> Descripción breve y atractiva del proyecto.

## ✨ Features

- 🔥 Feature 1
- 🎯 Feature 2
- 🚀 Feature 3

## 📦 Instalación

\`\`\`bash
git clone https://github.com/user/repo.git
cd repo
npm install
\`\`\`

## 🚀 Uso

\`\`\`bash
npm start
\`\`\`

## 🛠️ Tech Stack

- **Frontend**: React, TypeScript
- **Backend**: Node.js, Express
- **CI/CD**: GitHub Actions
- **Security**: CodeQL, Dependabot

## 📊 Screenshots

![Demo](docs/demo.gif)

## 🤝 Contributing

Ver [CONTRIBUTING.md](CONTRIBUTING.md)

## 📄 License

MIT - ver [LICENSE](LICENSE)
```

---

## 🎤 Estructura de la Presentación

### Formato (10-15 minutos)

```yaml
1. Introducción (2 min):
   - Nombre y contexto
   - Problema que resuelve
   - Por qué lo elegiste

2. Demo en Vivo (5 min):
   - Mostrar funcionalidad principal
   - Flujo de usuario típico
   - Features destacados

3. Arquitectura Técnica (3 min):
   - Estructura del código
   - CI/CD pipeline
   - Medidas de seguridad

4. Aprendizajes (2 min):
   - Desafíos enfrentados
   - Cómo los resolviste
   - Qué harías diferente

5. Q&A (3 min):
   - Preguntas del público
   - Feedback
```

### Tips de Presentación

```markdown
## DO ✅
- Practica antes (al menos 2 veces)
- Ten backup si la demo falla
- Habla de tu proceso, no solo del resultado
- Muestra código real
- Sé honesto sobre limitaciones

## DON'T ❌
- No leas las diapositivas
- No te disculpes excesivamente
- No intentes mostrar TODO
- No ignores el tiempo
- No te pongas nervioso por errores
```

---

## 💡 Demostración Efectiva

### Checklist Pre-Demo

```bash
# Antes de presentar
- [ ] Proyecto corriendo localmente
- [ ] Datos de prueba preparados
- [ ] Terminal limpia y legible
- [ ] Fuente grande (16pt+)
- [ ] Notificaciones silenciadas
- [ ] Backup en screenshots/video
```

### Flujo de Demo

```yaml
1. Estado Inicial:
   - Mostrar repo en GitHub
   - README visible
   - Actions/Security tabs

2. Código:
   - Estructura de carpetas
   - Archivo principal
   - Tests (correrlos en vivo)

3. CI/CD:
   - Hacer un pequeño cambio
   - Push y ver pipeline
   - Deploy automático

4. Resultado:
   - Aplicación funcionando
   - Feature principal en acción
```

---

## 📊 Criterios de Evaluación

### Lo que los Evaluadores Buscan

| Criterio | Peso | Señales Positivas |
|----------|------|-------------------|
| **Claridad** | 25% | Explicación concisa, bien estructurada |
| **Técnica** | 30% | Código limpio, buenas prácticas |
| **Completitud** | 20% | Proyecto funcional, documentado |
| **Presentación** | 15% | Comunicación clara, timing |
| **Q&A** | 10% | Respuestas informadas |

### Rúbrica Simplificada

```yaml
Excelente (90-100%):
  - Demo sin problemas
  - Explica decisiones técnicas
  - Código ejemplar
  - Documentación completa

Bueno (70-89%):
  - Demo funciona con mínimos issues
  - Entiende su código
  - Documentación clara

Básico (50-69%):
  - Proyecto funciona
  - Puede explicar lo básico
  - Documentación existe

Insuficiente (<50%):
  - No funciona o incompleto
  - No puede explicar
  - Sin documentación
```

---

## 🔄 Dar y Recibir Feedback

### Como Dar Feedback

```markdown
## Modelo SBI (Situation-Behavior-Impact)

"Cuando [SITUACIÓN], hiciste [COMPORTAMIENTO], 
lo cual causó [IMPACTO]"

## Ejemplos:
✅ "En la demo, cuando mostraste el CI pipeline, 
    fue muy claro ver cómo los tests corren 
    automáticamente. Eso demostró dominio de Actions."

✅ "En el README, la sección de instalación podría 
    incluir requisitos previos para que sea más 
    fácil de seguir."
```

### Como Recibir Feedback

```yaml
1. Escucha sin interrumpir
2. Toma notas
3. Agradece (aunque no estés de acuerdo)
4. Pide clarificación si es necesario
5. Reflexiona después
6. Implementa lo que tenga sentido
```

---

## 📝 Resumen

| Elemento | Clave |
|----------|-------|
| **README** | Claro, completo, con badges |
| **Demo** | Practicada, con backup |
| **Presentación** | 10-15 min, estructurada |
| **Feedback** | Dar SBI, recibir con apertura |

---

**Siguiente**: [Lección 03 - Career Path](03-career-path.md)
