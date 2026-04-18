# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al **Bootcamp Git & GitHub**! Este es un proyecto open source y las contribuciones de la comunidad son bienvenidas.

---

## 📋 Tabla de Contenidos

- [Código de Conducta](#-código-de-conducta)
- [Cómo Contribuir](#-cómo-contribuir)
- [Regla de Oro de Versiones](#-regla-de-oro-de-versiones)
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

## � Regla de Oro de Versiones

> **Esta regla aplica a todo ejemplo de código en el bootcamp, sin excepción.**

### npm / pnpm packages

| Patrón                  | Estado       | Descripción                                             |
| ----------------------- | ------------ | ------------------------------------------------------- |
| `"express": "4.21.2"`   | ✅ CORRECTO  | Versión exacta pinneada                                 |
| `"express": "^4.18.0"`  | ❌ PROHIBIDO | Caret `^` permite actualizaciones menores sin control   |
| `"express": ">=4.18.0"` | ❌ PROHIBIDO | Rango abierto — puede instalar cualquier versión futura |
| `"express": "~4.18.0"`  | ❌ PROHIBIDO | Tilde `~` permite patches sin control                   |
| `"express": "latest"`   | ❌ PROHIBIDO | No reproducible, no auditable                           |

**Por qué importa**: un `^` o `>=` permite que al hacer `pnpm install` en CI se instale
una versión diferente a la que probaste localmente. Un paquete comprometido publicado como
patch (ej: supply chain attack) se instalará automáticamente. Las versiones exactas garantizan
**builds reproducibles** y permiten auditar CVEs contra una versión conocida.

```json
// ✅ CORRECTO — todos los ejemplos del bootcamp deben seguir este formato
{
  "dependencies": {
    "express": "4.21.2"
  },
  "devDependencies": {
    "eslint": "8.57.1",
    "jest": "29.7.0"
  }
}

// ❌ PROHIBIDO — nunca usar en ejemplos del bootcamp
{
  "dependencies": {
    "express": "^4.21.2",
    "lodash": ">=4.0.0",
    "axios": "~1.6.0"
  }
}
```

### GitHub Actions (uses:)

| Patrón                                                                | Contexto      | Status                                |
| --------------------------------------------------------------------- | ------------- | ------------------------------------- |
| `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683  # v4.2.2` | Producción    | ✅ SHA pin — inmutable                |
| `actions/checkout@v4`                                                 | Educativo/dev | ⚠️ Aceptable en ejemplos didácticos   |
| `actions/checkout@main`                                               | —             | ❌ PROHIBIDO siempre                  |
| `actions/checkout@latest`                                             | —             | ❌ PROHIBIDO siempre                  |
| `some-third-party/action@v1`                                          | —             | ❌ PROHIBIDO en producción — usar SHA |

**Por qué importa**: un tag como `@v1` es un puntero mutable. El maintainer puede hacer
`git tag -f v1 <new-commit>` y tu pipeline ejecutará código diferente al que revisaste.
Un SHA es inmutable: la ejecución siempre será exactamente el código que auditaste.

### Python (requirements.txt / pyproject.toml)

```
# ✅ CORRECTO
requests==2.31.0
boto3==1.34.0

# ❌ PROHIBIDO
requests>=2.0
boto3~=1.34
```

---

## �📝 Estándares de Contenido

### Idioma

- **Documentación**: Español
- **Términos técnicos**: Inglés (repository, branch, commit, merge, etc.)

### Formato de Archivos

| Tipo       | Formato                | Ejemplo                     |
| ---------- | ---------------------- | --------------------------- |
| Teoría     | `01-nombre-tema.md`    | `01-control-versiones.md`   |
| Ejercicios | `ejercicio-XX-nombre/` | `ejercicio-01-instalacion/` |
| Assets     | `XX-nombre.svg`        | `01-flujo-git.svg`          |

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
├── assets/                  # Assets generales del proyecto
├── docs/                    # Documentación adicional
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
├── LICENSE                   # Licencia CC BY-NC-SA 4.0
└── README.md                 # Página principal
```

---

## ❓ ¿Preguntas?

Si tienes dudas sobre cómo contribuir, crea un [issue con la plantilla de pregunta](../../issues/new?template=question.md).

---

**¡Gracias por contribuir al aprendizaje de Git y GitHub!** 🚀
