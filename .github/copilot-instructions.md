# GitHub Copilot Instructions - Bootcamp Git/GitHub

## Contexto del Proyecto

Este repositorio contiene el material educativo para un bootcamp intensivo de **16 semanas** (96 horas, 6h/semana) enfocado en Git y GitHub. El objetivo es formar desarrolladores con dominio completo de control de versiones, colaboración en equipos de desarrollo, y preparación completa para las **4 certificaciones oficiales de GitHub**: Foundations, Actions, Advanced Security y Administration.

## Estructura del Proyecto

- `bootcamp/` - Todo el contenido del bootcamp organizado por semanas
- `_assets/` - Recursos gráficos globales (banner, logos)
- `_scripts/` - Scripts de automatización
- `.github/` - Configuraciones de GitHub y este archivo de instrucciones
- Cada semana tiene su propia carpeta con material teórico y práctico

## Instrucciones para GitHub Copilot

### Estilo y Mejores Prácticas

1. **Documentación en Español**: Todo el contenido debe estar en español, usando un lenguaje claro y profesional
2. **Nomenclatura Técnica en Inglés**: Todos los términos técnicos deben mantenerse en inglés (repository, branch, commit, merge, pull request, etc.)
3. **Markdown Estructurado**: Usar headers apropiados, listas, código con syntax highlighting
4. **Ejemplos Prácticos**: Siempre incluir ejemplos de comandos Git reales y casos de uso
5. **Progresión Didáctica**: El contenido debe seguir una progresión lógica de básico a avanzado
6. **Ejercicios Detallados**: Todos los ejercicios deben incluir comentarios explicativos con: qué se hace, por qué se hace, y para qué sirve

### Estructura de Contenido

Cuando generes contenido para el bootcamp, sigue esta estructura:

````
bootcamp/
├── README.md                     # Índice principal del bootcamp
├── week-01/                      # Git Foundations
├── week-02/                      # Repositories y commits
├── week-03/                      # Branching básico
├── week-04/                      # Merge conflicts
├── week-05/                      # Remote repositories
├── week-06/                      # GitHub features
├── week-07/                      # GitHub Actions fundamentos
├── week-08/                      # CI/CD pipelines
├── week-09/                      # Actions avanzadas
├── week-10/                      # Deployment strategies
├── week-11/                      # Security features
├── week-12/                      # Vulnerability management
├── week-13/                      # Security policies
├── week-14/                      # Enterprise administration
├── week-15/                      # Administration avanzado
└── week-16/                      # Proyecto final + certificaciones
````

### Estructura Interna de Cada Semana

Cada carpeta week-XX/ debe tener esta estructura estandarizada:

```text
week-XX/
├── README.md                     # Descripción general de la semana
├── rubrica-evaluacion.md         # Criterios de evaluación
├── 0-assets/                     # Diagramas y recursos visuales (SVG)
│   └── README.md
├── 1-teoria/                     # Material teórico
│   ├── 01-tema-principal.md
│   ├── 02-segundo-tema.md
│   └── ...
├── 2-practicas/                  # Ejercicios guiados (sin soluciones)
│   ├── README.md
│   ├── ejercicio-01-nombre/
│   │   └── README.md             # Instrucciones paso a paso
│   └── ...
├── 3-proyecto/                   # Proyecto semanal
│   ├── README.md                 # Instrucciones del proyecto
│   ├── starter/                  # Código/archivos iniciales (opcional)
│   └── solution/                 # Solución de referencia (en .gitignore)
├── 4-recursos/                   # Material adicional
│   ├── README.md
│   ├── ebooks-free/              # Libros electrónicos gratuitos
│   ├── videografia/              # Videos y tutoriales
│   └── webgrafia/                # Enlaces y documentación
└── 5-glosario/                   # Términos clave de la semana
    └── README.md
```

### Formato de Lecciones

Cada lección debe incluir:

1. **Objetivos de Aprendizaje**: Qué se espera que el estudiante aprenda
2. **Conceptos Teóricos**: Explicación clara de los conceptos
3. **Comandos y Sintaxis**: Ejemplos prácticos con explicaciones
4. **Ejercicios Guiados**: Paso a paso para practicar
5. **Desafíos**: Ejercicios independientes
6. **Recursos Adicionales**: Enlaces y referencias

### Estándares de Código

- **Comandos Git**: Siempre usar la sintaxis completa antes de mostrar atajos
- **Convenciones**: Seguir Git Flow y Conventional Commits
- **Nomenclatura Técnica**: Mantener términos en inglés (branch, commit, repository, merge, etc.)
- **Comentarios Detallados**: Explicar cada comando con tres niveles:
  - **¿Qué hace?**: Descripción técnica del comando
  - **¿Por qué?**: Razón o contexto para usarlo
  - **¿Para qué sirve?**: Beneficio o resultado esperado
- **Casos de Error**: Incluir cómo manejar errores comunes

### 🔒 Regla de Oro de Versiones (OBLIGATORIA)

**NUNCA generar ejemplos de dependencias con rangos flotantes.** Esta regla aplica sin excepción a todo el contenido del bootcamp.

#### npm / pnpm
```json
// ✅ OBLIGATORIO — versión exacta pinneada
{
  "dependencies": { "express": "4.21.2" },
  "devDependencies": { "eslint": "8.57.1", "jest": "29.7.0" }
}

// ❌ PROHIBIDO — ^ ~ >= y variantes
{
  "dependencies": { "express": "^4.18.0" }
}
```

#### Python
```
# ✅ OBLIGATORIO
requests==2.31.0

# ❌ PROHIBIDO
requests>=2.0
requests~=2.30
```

#### GitHub Actions (uses:)
```yaml
# ✅ PRODUCCIÓN — SHA inmutable con tag anotado como comentario
- uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683  # v4.2.2

# ⚠️ EDUCATIVO — aceptable en ejemplos didácticos de primeras semanas
- uses: actions/checkout@v4

# ❌ PROHIBIDO SIEMPRE
- uses: actions/checkout@main
- uses: actions/checkout@latest
- uses: some-third-party/action@v1    # terceros sin SHA = supply-chain risk
```

**Razón**: un `^` o `>=` en npm, o un `@v1` en Actions de terceros, permite que una
versión comprometida reemplaze silenciosamente a la revisada. Las versiones exactas /
SHA pins garantizan builds reproducibles y CVE-trazables.

### Estándares Gráficos (0-assets/)

Los diagramas y recursos visuales deben seguir estas especificaciones:

- **Formato**: SVG (Scalable Vector Graphics) - NO usar ASCII art
- **Tema**: Dark mode (fondo oscuro)
- **Colores**: Sólidos, sin degradados ni gradientes
- **Tipografía**: Sans-serif (ej: Arial, Helvetica, Inter, Roboto)
- **Paleta de colores recomendada**:
  - Fondo: `#1a1a2e` o `#0d1117`
  - Texto principal: `#e6e6e6` o `#c9d1d9`
  - Acentos: `#58a6ff` (azul), `#3fb950` (verde), `#f85149` (rojo)
  - Bordes: `#30363d`

#### Nomenclatura de archivos SVG:

```
0-assets/
├── 01-nombre-diagrama.svg
├── 02-flujo-trabajo.svg
├── 03-comparativa.svg
└── README.md
```

#### Vinculación de Assets:

Los archivos SVG deben estar **vinculados desde los archivos de teoría** u otros documentos donde corresponda:

```markdown
<!-- En 1-teoria/01-control-versiones.md -->

## Flujo de Trabajo en Git

El siguiente diagrama muestra el flujo básico:

![Flujo de trabajo Git](../0-assets/01-flujo-trabajo-git.svg)

> **Nota**: Ver [diagrama completo](../0-assets/01-flujo-trabajo-git.svg)
```

**Reglas de vinculación:**
- Cada asset debe estar referenciado en al menos un archivo de teoría o práctica
- Usar rutas relativas (`../0-assets/nombre.svg`)
- Incluir texto alternativo descriptivo en las imágenes
- El README de `0-assets/` debe listar todos los assets y dónde se usan

### Ejemplos de Formato

#### Para comandos Git:

```bash
# ¿Qué hace?: Crea un commit con un mensaje descriptivo
# ¿Por qué?: Necesitamos guardar los cambios en el historial del repository
# ¿Para qué sirve?: Permite trackear el progreso y colaborar en equipo

# Comando completo con explicación
git commit --message "feat: añadir función de login"

# Atajo (mostrar después del comando completo)
git commit -m "feat: añadir función de login"
```

#### Para conceptos:

```markdown
## 🎯 Concepto: Branches

**Definición**: Un branch en Git es una línea de desarrollo independiente...

**¿Por qué es importante?**: Permite trabajar en diferentes features...

**Ejemplo práctico**:
[código o diagrama aquí]
```

### Temas Obligatorios por Semana

**Fase 1: GitHub Foundations Certification (Semanas 1-6)**

1. **Semana 1**: Instalación, configuración inicial, conceptos básicos Git
2. **Semana 2**: Repositories, staging area, commits, historial
3. **Semana 3**: Branches, checkout, merge básico
4. **Semana 4**: Merge conflicts, estrategias de resolución
5. **Semana 5**: Remote repositories, push, pull, fetch, colaboración
6. **Semana 6**: GitHub features: Issues, Pull Requests, Reviews, Projects

**Fase 2: GitHub Actions Certification (Semanas 7-10)**

7. **Semana 7**: GitHub Actions fundamentos, workflows, YAML syntax
8. **Semana 8**: CI/CD pipelines, build, test, deploy automation
9. **Semana 9**: Custom actions, marketplace, advanced workflows
10. **Semana 10**: Deployment strategies, environments, secrets, approvals

**Fase 3: GitHub Advanced Security (Semanas 11-13)**

11. **Semana 11**: Security features, code scanning, dependency review
12. **Semana 12**: Vulnerability management, secret scanning
13. **Semana 13**: Security policies, compliance, security advisories

**Fase 4: GitHub Administration (Semanas 14-15)**

14. **Semana 14**: Enterprise administration, organizations, teams, permissions
15. **Semana 15**: Administration avanzado, audit logging, automation

**Fase 5: Proyecto Final + Certificaciones (Semana 16)**

16. **Semana 16**: Proyecto final integrador, simulacros de certificación, graduación

### Audiencia Objetivo

- **Nivel**: Principiante a intermedio
- **Experiencia**: Desarrolladores con conocimientos básicos de programación
- **Objetivo**: Preparar para trabajo profesional en equipos

### Consideraciones Especiales

- Incluir comandos para Windows, macOS y Linux cuando sea relevante
- Mostrar tanto línea de comandos como herramientas GUI cuando aplique
- Enfatizar la importancia de la documentación y comunicación en equipos
- Incluir casos reales de la industria
- Preparar para certificaciones Git si es relevante

### Formato de Archivos

- **Archivos de teoría**: `01-nombre-tema.md`, `02-nombre-tema.md` (numerados)
- **Ejercicios**: Carpetas `ejercicio-01-nombre/`, `ejercicio-02-nombre/` con `README.md`, `starter/` y `solution/`
- **Evaluaciones**: `rubrica-evaluacion.md` en cada semana
- **Recursos**: Organizar en subcarpetas `ebooks-free/`, `videografia/`, `webgrafia/`
- **Glosario**: `README.md` en carpeta `5-glosario/`

### Formato de Ejercicios

Cada ejercicio debe seguir esta estructura de comentarios:

```bash
# EJERCICIO: [Nombre del ejercicio]
# ¿QUÉ VAMOS A HACER?: [Descripción técnica de la acción]
# ¿POR QUÉ LO HACEMOS?: [Contexto y razón pedagógica]
# ¿PARA QUÉ SIRVE?: [Beneficio práctico y aplicación real]

# Paso 1: [Descripción del paso]
git [comando completo]

# Explicación del resultado esperado:
# [Qué debería suceder después de ejecutar el comando]
```

### Elementos Interactivos

- Usar diagramas ASCII cuando sea útil
- Incluir checkboxes para seguimiento de progreso
- Crear tablas comparativas para comandos similares
- Incluir ejercicios de auto-evaluación

## Notas Importantes

- Siempre verificar que los comandos funcionen antes de documentarlos
- Incluir advertencias sobre comandos destructivos
- Mostrar cómo deshacer operaciones cuando sea posible
- Mantener consistencia en terminología técnica
- Actualizar contenido basado en las últimas versiones de Git/GitHub
