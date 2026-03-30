# 📖 Ebooks y Guías Gratuitas - GitHub Actions

## 🎯 Recursos de Lectura para la Semana 07

Colección de libros electrónicos, guías y documentación en PDF sobre GitHub Actions y CI/CD.

---

## 📚 Ebooks Gratuitos

### 1. GitHub Actions Documentation (PDF)
- **Fuente:** GitHub Docs
- **Idioma:** Inglés / Español
- **Nivel:** Todos
- **Enlace:** [docs.github.com/en/actions](https://docs.github.com/en/actions) (exportable a PDF)
- **Descripción:** Documentación oficial completa, siempre actualizada. Cubre desde conceptos básicos hasta features avanzados.

### 2. CI/CD with GitHub Actions - O'Reilly Report
- **Autor:** Varios
- **Páginas:** ~50
- **Nivel:** Intermedio
- **Enlace:** Disponible con cuenta gratuita en O'Reilly
- **Descripción:** Reporte técnico sobre implementación de CI/CD pipelines modernos.

### 3. The DevOps Handbook (Extractos)
- **Autores:** Gene Kim, Jez Humble, Patrick Debois
- **Nivel:** Intermedio-Avanzado
- **Enlace:** Extractos gratuitos en [itrevolution.com](https://itrevolution.com/)
- **Descripción:** Fundamentos de DevOps y automatización de pipelines.

### 4. GitHub Actions - Automate Your Workflow
- **Fuente:** GitHub Official Guide
- **Nivel:** Principiante
- **Enlace:** [resources.github.com](https://resources.github.com/)
- **Descripción:** Guía oficial para comenzar con GitHub Actions.

### 5. YAML Specification
- **Fuente:** yaml.org
- **Nivel:** Referencia
- **Enlace:** [yaml.org/spec](https://yaml.org/spec/)
- **Descripción:** Especificación oficial de YAML, útil para entender la sintaxis profundamente.

---

## 📋 Guías y Cheatsheets

### GitHub Actions Cheatsheet
```yaml
# Quick Reference - GitHub Actions

# Triggers básicos
on: push | pull_request | workflow_dispatch | schedule

# Job básico
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "Hello"

# Matrix
strategy:
  matrix:
    node: [18, 20, 22]

# Secrets
${{ secrets.MY_SECRET }}

# Contextos
${{ github.event_name }}
${{ github.ref }}
${{ github.sha }}
```

### Actions Comunes del Marketplace

| Action | Uso | Versión |
|--------|-----|---------|
| `actions/checkout` | Clonar repo | v4 |
| `actions/setup-node` | Configurar Node.js | v4 |
| `actions/setup-python` | Configurar Python | v5 |
| `actions/cache` | Cachear dependencias | v4 |
| `actions/upload-artifact` | Subir artifacts | v4 |
| `actions/download-artifact` | Descargar artifacts | v4 |

---

## 📘 Libros de Pago Recomendados

> 💡 Estos libros son de pago pero ofrecen contenido de alta calidad

| Libro | Autor | Editorial | Nivel |
|-------|-------|-----------|-------|
| Learning GitHub Actions | Brent Laster | O'Reilly | Intermedio |
| GitHub Actions in Action | Michael Kaufmann | Manning | Intermedio-Avanzado |
| Continuous Delivery | Jez Humble | Addison-Wesley | Avanzado |
| The Phoenix Project | Gene Kim | IT Revolution | Todos |

---

## 🎓 Certificación GitHub Actions

### Guías de Estudio Oficiales

1. **GitHub Actions Certification Study Guide**
   - Fuente: GitHub Skills
   - Enlace: [skills.github.com](https://skills.github.com/)
   - Contenido: Temas del examen, ejemplos, práctica

2. **Sample Questions**
   - Disponibles en la página de certificación
   - Enlace: [examregistration.github.com](https://examregistration.github.com/)

---

## 📥 Cómo Descargar

### Documentación Oficial como PDF

1. Ir a [docs.github.com/en/actions](https://docs.github.com/en/actions)
2. Seleccionar tema específico
3. Usar función de impresión del navegador
4. Guardar como PDF

### Recursos de O'Reilly

1. Crear cuenta gratuita en [oreilly.com](https://www.oreilly.com/)
2. Acceso limitado pero incluye varios reportes
3. Prueba gratuita de 7 días para contenido completo

---

## 🔗 Navegación

| ⬅️ Anterior | 📂 Recursos | ➡️ Siguiente |
|:-----------:|:-----------:|:------------:|
| [Recursos](../README.md) | [Videografía](../videografia/README.md) | [Webgrafía](../webgrafia/README.md) |
