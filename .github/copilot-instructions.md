# GitHub Copilot Instructions - Bootcamp Git/GitHub

## Contexto del Proyecto

Este repositorio contiene el material educativo para un bootcamp intensivo de **14 semanas** enfocado en Git y GitHub. El objetivo es formar desarrolladores con dominio completo de control de versiones, colaboración en equipos de desarrollo, y preparación completa para las **4 certificaciones oficiales de GitHub**: Foundations, Actions, Advanced Security y Administration.

## Estructura del Proyecto

- `_docs/` - Toda la documentación del bootcamp está organizada aquí
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

```
_docs/
├── README.md (índice principal)
├── semana-01/ (Git Foundations)
├── semana-02/ (Repositories y commits)
├── semana-03/ (Branching básico)
├── semana-04/ (Merge conflicts)
├── semana-05/ (Remote repositories)
├── semana-06/ (GitHub features)
├── semana-07/ (GitHub Actions fundamentos)
├── semana-08/ (CI/CD pipelines)
├── semana-09/ (Actions avanzadas)
├── semana-10/ (Deployment strategies)
├── semana-11/ (Security features)
├── semana-12/ (Vulnerability management)
├── semana-13/ (Enterprise administration)
├── semana-14/ (Proyecto final + exámenes)
├── recursos/
├── ejercicios/
└── evaluaciones/
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

**Fase 3: GitHub Advanced Security (Semanas 11-12)**
11. **Semana 11**: Security features, code scanning, dependency review
12. **Semana 12**: Vulnerability management, secret scanning, security advisories

**Fase 4: GitHub Administration + Proyecto Final (Semanas 13-14)**
13. **Semana 13**: Enterprise administration, organizations, teams, permissions
14. **Semana 14**: Proyecto final integrador, preparación certificaciones

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

- **Archivos de lección**: `leccion-XX-titulo.md`
- **Ejercicios**: `ejercicio-XX-descripcion.md`
- **Evaluaciones**: `evaluacion-semana-XX.md`
- **Recursos**: Organizar por tipo (cheatsheets, enlaces, videos)

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
