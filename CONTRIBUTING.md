# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al **Bootcamp Git & GitHub**! Este es un proyecto open source y las contribuciones de la comunidad son bienvenidas.

---

## 📋 Tabla de Contenidos

- [Código de Conducta](#-código-de-conducta)
- [Cómo Contribuir](#-cómo-contribuir)
- [Estándares de Contenido](#-estándares-de-contenido)
- [Proceso de Pull Request](#-proceso-de-pull-request)
- [Estructura del Proyecto](#-estructura-del-proyecto)

---

## 📜 Código de Conducta

Este proyecto se adhiere a un [Código de Conducta](CODE_OF_CONDUCT.md). Al participar, se espera que respetes este código.

---

## 🚀 Cómo Contribuir

### 1. Reportar Bugs

Si encuentras un error en el contenido:

1. Verifica que no exista un [issue similar](../../issues)
2. Crea un nuevo issue usando la plantilla de **Bug Report**
3. Proporciona toda la información solicitada

### 2. Sugerir Contenido

Para proponer nuevo contenido o mejoras:

1. Revisa los [issues existentes](../../issues)
2. Crea un issue usando la plantilla de **Feature Request**
3. Describe claramente tu sugerencia

### 3. Contribuir Código/Contenido

```bash
# 1. Fork del repositorio
# 2. Clona tu fork
git clone https://github.com/TU-USUARIO/bc-git-github.git

# 3. Crea una branch para tu contribución
git checkout -b feature/nombre-descriptivo

# 4. Realiza tus cambios
# 5. Commit con mensaje descriptivo
git commit -m "feat(week-XX): añadir ejercicio de branching"

# 6. Push a tu fork
git push origin feature/nombre-descriptivo

# 7. Crea un Pull Request
```

---

## 📝 Estándares de Contenido

### Idioma

- **Documentación**: Español
- **Términos técnicos**: Inglés (repository, branch, commit, merge, etc.)

### Formato de Archivos

| Tipo | Formato | Ejemplo |
|------|---------|---------|
| Teoría | `01-nombre-tema.md` | `01-control-versiones.md` |
| Ejercicios | `ejercicio-XX-nombre/` | `ejercicio-01-instalacion/` |
| Assets | `XX-nombre.svg` | `01-flujo-git.svg` |

### Estilo de Comandos Git

```bash
# ¿Qué hace?: Descripción técnica
# ¿Por qué?: Contexto y razón
# ¿Para qué sirve?: Beneficio práctico

# Comando completo primero
git commit --message "feat: descripción"

# Atajo después
git commit -m "feat: descripción"
```

### Estándares Gráficos (SVG)

- **Formato**: SVG únicamente (NO ASCII art)
- **Tema**: Dark mode
- **Colores**: Sólidos, sin degradados
- **Tipografía**: Sans-serif
- **Paleta**:
  - Fondo: `#0d1117`
  - Texto: `#e6e6e6`
  - Azul: `#58a6ff`
  - Verde: `#3fb950`
  - Rojo: `#f85149`

---

## 🔄 Proceso de Pull Request

### 1. Antes de Crear el PR

- [ ] Fork actualizado con `main`
- [ ] Contenido revisado sin errores ortográficos
- [ ] Comandos probados y funcionando
- [ ] Assets SVG siguiendo estándares

### 2. Mensaje de Commit

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

```
tipo(scope): descripción

Tipos:
- feat: nuevo contenido
- fix: corrección de errores
- docs: documentación
- style: formato
- refactor: reestructuración
```

**Ejemplos:**

```bash
feat(week-03): añadir ejercicio de merge conflicts
fix(week-01): corregir comando de configuración
docs(readme): actualizar tabla de contenidos
```

### 3. Revisión

- Un maintainer revisará tu PR
- Puede haber comentarios o sugerencias
- Una vez aprobado, será mergeado

---

## 📁 Estructura del Proyecto

```
bc-git-github/
├── _assets/                  # Assets generales del proyecto
├── _docs/                    # Documentación adicional
├── .github/                  # Configuración de GitHub
│   ├── ISSUE_TEMPLATE/       # Plantillas de issues
│   └── copilot-instructions.md
├── bootcamp/                 # Contenido del bootcamp
│   └── week-XX/              # Semanas 01-14
│       ├── 0-assets/         # Diagramas SVG
│       ├── 1-teoria/         # Material teórico
│       ├── 2-practicas/      # Ejercicios guiados
│       ├── 3-proyecto/       # Proyecto semanal
│       ├── 4-recursos/       # Material adicional
│       └── 5-glosario/       # Términos clave
├── CONTRIBUTING.md           # Esta guía
├── CODE_OF_CONDUCT.md        # Código de conducta
├── LICENSE                   # Licencia MIT
└── README.md                 # Página principal
```

---

## ❓ ¿Preguntas?

Si tienes dudas sobre cómo contribuir, crea un [issue con la plantilla de pregunta](../../issues/new?template=question.md).

---

**¡Gracias por contribuir al aprendizaje de Git y GitHub!** 🚀
