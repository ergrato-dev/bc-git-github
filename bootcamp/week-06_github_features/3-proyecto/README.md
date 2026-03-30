# Proyecto: Open Source Simulation

## Descripcion

Simular el flujo completo de contribucion a un proyecto open source, aplicando todos los conceptos de GitHub Features aprendidos esta semana.

**Duracion estimada:** 2 horas

---

## Objetivos de Aprendizaje

Al completar este proyecto seras capaz de:

- Contribuir a proyectos open source siguiendo buenas practicas
- Crear Issues bien documentados en proyectos externos
- Fork, branch, y Pull Request workflow completo
- Participar en code reviews como autor y reviewer
- Usar GitHub Projects para organizar trabajo

---

## Escenario

Eres un desarrollador que quiere contribuir a un proyecto open source. El proyecto es una libreria de utilidades JavaScript mantenida por la comunidad.

Simularas todo el proceso:
1. Encontrar un Issue o proponer mejora
2. Fork del repositorio
3. Implementar cambios
4. Crear Pull Request
5. Participar en code review
6. Ver tu contribucion mergeada

---

## Requisitos

- Cuenta de GitHub
- Git instalado y configurado
- Completar ejercicios de la semana
- (Opcional) Un companero para code review cruzado

---

## Parte 1: Setup del Proyecto "Upstream" (20 min)

### 1.1 Crear el proyecto "open source"

Simularemos el proyecto upstream creando un repositorio base:

```bash
# Crear directorio
mkdir oss-utils-library && cd oss-utils-library

# Inicializar
git init
```

### 1.2 Crear estructura inicial

```bash
# Crear archivos base
cat > README.md << 'EOF'
# OSS Utils Library

A collection of JavaScript utility functions for common tasks.

## Installation

```bash
npm install oss-utils-library
```

## Usage

```javascript
const { formatDate, capitalize } = require('oss-utils-library');

console.log(formatDate(new Date())); // "2025-01-15"
console.log(capitalize('hello'));    // "Hello"
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT
EOF
```

### 1.3 Crear CONTRIBUTING.md

```bash
cat > CONTRIBUTING.md << 'EOF'
# Contributing to OSS Utils Library

Thank you for your interest in contributing!

## How to Contribute

### Reporting Bugs

1. Check if the issue already exists
2. Use the Bug Report template
3. Include reproduction steps

### Suggesting Features

1. Open a Feature Request issue
2. Describe the use case
3. Provide examples if possible

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Make your changes
4. Write/update tests
5. Follow commit conventions
6. Open a Pull Request

### Commit Convention

We use Conventional Commits:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `test:` Tests
- `refactor:` Refactoring

### Code Style

- Use ES6+ syntax
- Add JSDoc comments
- Run tests before submitting

## Code of Conduct

Be respectful and inclusive. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
EOF
```

### 1.4 Crear codigo fuente

```bash
mkdir src

cat > src/index.js << 'EOF'
/**
 * OSS Utils Library
 * A collection of utility functions
 */

const strings = require('./strings');
const dates = require('./dates');
const arrays = require('./arrays');

module.exports = {
    ...strings,
    ...dates,
    ...arrays
};
EOF

cat > src/strings.js << 'EOF'
/**
 * String utility functions
 */

/**
 * Capitalize first letter of string
 * @param {string} str - Input string
 * @returns {string} Capitalized string
 */
function capitalize(str) {
    if (!str) return '';
    return str.charAt(0).toUpperCase() + str.slice(1);
}

/**
 * Truncate string to specified length
 * @param {string} str - Input string
 * @param {number} length - Max length
 * @returns {string} Truncated string
 */
function truncate(str, length) {
    if (!str || str.length <= length) return str;
    return str.substring(0, length) + '...';
}

module.exports = { capitalize, truncate };
EOF

cat > src/dates.js << 'EOF'
/**
 * Date utility functions
 */

/**
 * Format date as YYYY-MM-DD
 * @param {Date} date - Date object
 * @returns {string} Formatted date
 */
function formatDate(date) {
    const d = new Date(date);
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

module.exports = { formatDate };
EOF

cat > src/arrays.js << 'EOF'
/**
 * Array utility functions
 */

/**
 * Get unique values from array
 * @param {Array} arr - Input array
 * @returns {Array} Array with unique values
 */
function unique(arr) {
    return [...new Set(arr)];
}

module.exports = { unique };
EOF
```

### 1.5 Crear Issue Templates

```bash
mkdir -p .github/ISSUE_TEMPLATE

cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug Report
about: Report a bug
title: '[BUG] '
labels: 'bug'
---

## Description

## Steps to Reproduce

1.
2.
3.

## Expected Behavior

## Actual Behavior

## Environment

- Node version:
- OS:
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature Request
about: Suggest a feature
title: '[FEAT] '
labels: 'enhancement'
---

## Description

## Use Case

## Proposed Solution

## Alternatives Considered
EOF
```

### 1.6 Commit y push

```bash
git add .
git commit -m "feat: initial project setup"

# Crear repo en GitHub
gh repo create oss-utils-library --public --source=. --push
```

---

## Parte 2: Crear Issues como Contributor (15 min)

### 2.1 Crear Issue de Bug

Ve a tu repositorio > Issues > New Issue > Bug Report:

```markdown
Title: [BUG] formatDate returns wrong month for January

## Description

The `formatDate` function returns incorrect month for dates in January.

## Steps to Reproduce

1. Call `formatDate(new Date('2025-01-15'))`
2. Expected: "2025-01-15"
3. Actual: Works correctly, but edge cases fail

## Expected Behavior

Should handle all months correctly including edge cases.

## Actual Behavior

Need to verify timezone handling.

## Environment

- Node version: 18.x
- OS: Linux
```

Labels: `bug`, `good first issue`

### 2.2 Crear Issue de Feature

```markdown
Title: [FEAT] Add slugify function to strings module

## Description

Add a function to convert strings to URL-friendly slugs.

## Use Case

When generating URLs from titles or names, need to convert:
- "Hello World!" -> "hello-world"
- "My Amazing Post" -> "my-amazing-post"

## Proposed Solution

```javascript
function slugify(str) {
    return str
        .toLowerCase()
        .trim()
        .replace(/[^\w\s-]/g, '')
        .replace(/[\s_-]+/g, '-');
}
```

## Alternatives Considered

- Using external library (slug, slugify)
- But prefer keeping dependencies minimal
```

Labels: `enhancement`, `help wanted`

### 2.3 Crear Issue de Documentacion

```markdown
Title: [DOCS] Add examples for all utility functions

## Description

The README needs more comprehensive examples for each function.

## Current State

Only basic usage shown.

## Proposed Changes

- Add example for each function
- Include edge cases
- Add TypeScript types documentation
```

Labels: `documentation`, `good first issue`

---

## Parte 3: Fork y Contribuir (30 min)

### 3.1 Simular Fork

En un escenario real, harias fork de otro repositorio. Aqui simularemos:

```bash
# Ir a directorio padre
cd ..

# Clonar como si fuera fork
git clone oss-utils-library oss-utils-library-fork
cd oss-utils-library-fork

# Agregar upstream
git remote add upstream ../oss-utils-library
git remote -v
```

### 3.2 Crear branch para feature

```bash
# Actualizar desde upstream
git fetch upstream
git checkout main

# Crear feature branch
git checkout -b feat/add-slugify
```

### 3.3 Implementar la feature

```bash
# Editar strings.js - agregar slugify
cat >> src/strings.js << 'EOF'

/**
 * Convert string to URL-friendly slug
 * @param {string} str - Input string
 * @returns {string} Slugified string
 */
function slugify(str) {
    if (!str) return '';
    return str
        .toLowerCase()
        .trim()
        .replace(/[^\w\s-]/g, '')
        .replace(/[\s_-]+/g, '-')
        .replace(/^-+|-+$/g, '');
}

module.exports = { capitalize, truncate, slugify };
EOF
```

### 3.4 Agregar tests

```bash
mkdir -p tests

cat > tests/strings.test.js << 'EOF'
const { capitalize, truncate, slugify } = require('../src/strings');

// Test capitalize
console.log('Testing capitalize...');
console.assert(capitalize('hello') === 'Hello', 'Should capitalize first letter');
console.assert(capitalize('') === '', 'Should handle empty string');
console.assert(capitalize('HELLO') === 'HELLO', 'Should not change already capitalized');

// Test truncate
console.log('Testing truncate...');
console.assert(truncate('hello world', 5) === 'hello...', 'Should truncate with ellipsis');
console.assert(truncate('hi', 5) === 'hi', 'Should not truncate short strings');

// Test slugify
console.log('Testing slugify...');
console.assert(slugify('Hello World') === 'hello-world', 'Should convert to slug');
console.assert(slugify('My Amazing Post!') === 'my-amazing-post', 'Should remove special chars');
console.assert(slugify('  Multiple   Spaces  ') === 'multiple-spaces', 'Should handle multiple spaces');
console.assert(slugify('') === '', 'Should handle empty string');

console.log('All string tests passed!');
EOF
```

### 3.5 Actualizar README

Agregar documentacion para slugify en README.md (seccion Usage).

### 3.6 Commit cambios

```bash
git add src/strings.js
git commit -m "feat(strings): add slugify function

- Convert strings to URL-friendly slugs
- Handle special characters and multiple spaces
- Add JSDoc documentation"

git add tests/strings.test.js
git commit -m "test(strings): add tests for slugify function"

git add README.md
git commit -m "docs: add slugify usage example"
```

### 3.7 Push y crear PR

```bash
git push -u origin feat/add-slugify

# Crear PR (en escenario real, seria hacia upstream)
gh pr create --title "feat(strings): add slugify function" --body "## Description

Adds a new \`slugify\` function to convert strings to URL-friendly slugs.

## Related Issue

Closes #2

## Changes

- Added \`slugify\` function in \`src/strings.js\`
- Added comprehensive tests
- Updated README with usage example

## Checklist

- [x] Code follows project style
- [x] Tests added and passing
- [x] Documentation updated
- [x] Commits follow convention"
```

---

## Parte 4: Code Review Cruzado (20 min)

### 4.1 Opcion A: Con companero

1. Intercambiar URLs de PRs
2. Cada uno revisa el PR del otro
3. Agregar comentarios constructivos
4. Aprobar o solicitar cambios

### 4.2 Opcion B: Self-review

1. Ir a Files changed
2. Agregar comentarios simulando reviewer:

```markdown
# Comentario 1 (praise)
praise: Nice implementation! The regex patterns are well thought out.

# Comentario 2 (suggestion)
suggestion: Consider adding a maxLength parameter to prevent extremely long slugs.

# Comentario 3 (question)
question: Should we handle unicode characters like accents? (cafe -> cafe or café -> cafe?)
```

3. Submit review con "Approve"

---

## Parte 5: Organizar con Project (15 min)

### 5.1 Crear Project Board

1. Ir a Projects > New project
2. Template: Board
3. Nombre: "OSS Utils Roadmap"

### 5.2 Configurar columnas

- Backlog
- To Do
- In Progress
- In Review
- Done

### 5.3 Agregar Issues

1. Agregar los 3 Issues creados
2. Asignar status:
   - Bug: To Do
   - Feature slugify: In Review (PR abierto)
   - Docs: Backlog

### 5.4 Configurar campos

- Priority: Low, Medium, High
- Assignar prioridades a cada Issue

---

## Parte 6: Merge y Documentar (20 min)

### 6.1 Merge el PR

```bash
gh pr merge --squash
```

### 6.2 Actualizar Project

- Mover Issue #2 (slugify) a Done
- Verificar que se cerro automaticamente

### 6.3 Crear CHANGELOG

```bash
cd oss-utils-library

cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- `slugify` function for URL-friendly string conversion (#2)

### Fixed
- (pending)

### Changed
- (pending)

## [1.0.0] - 2025-01-15

### Added
- Initial release
- `capitalize` - Capitalize first letter
- `truncate` - Truncate strings with ellipsis
- `formatDate` - Format dates as YYYY-MM-DD
- `unique` - Get unique array values
EOF

git add CHANGELOG.md
git commit -m "docs: add CHANGELOG"
git push
```

---

## Entregables

1. **Repositorio "upstream"** con:
   - Codigo fuente
   - Issue templates
   - CONTRIBUTING.md
   - 3+ Issues documentados

2. **Fork con contribucion**:
   - Feature implementada
   - Tests
   - PR mergeado

3. **Project board** con:
   - Issues organizados
   - Workflow visible

4. **Documentacion**:
   - CHANGELOG actualizado
   - README con ejemplos

---

## Criterios de Evaluacion

| Criterio | Puntos |
|----------|--------|
| Issues bien documentados | 15 |
| Fork y branch workflow correcto | 15 |
| PR con descripcion completa | 20 |
| Code review realizado | 15 |
| Project board configurado | 15 |
| Documentacion (CONTRIBUTING, CHANGELOG) | 20 |
| **Total** | **100** |

---

## Reflexion Final

Responde en un archivo `REFLECTION.md`:

1. Que aprendiste sobre el flujo de contribucion open source?
2. Cual fue la parte mas desafiante?
3. Como mejoraria tu experiencia como maintainer?
4. Que buenas practicas aplicaras en futuros proyectos?

---

## Limpieza

```bash
cd ~
rm -rf oss-utils-library oss-utils-library-fork
# Eliminar repos en GitHub si deseas
```

---

*Proyecto Week 06 | Bootcamp Git/GitHub*
