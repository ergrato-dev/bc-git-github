# Ejercicio 02: Pull Request Completo

## Descripcion

Crear un Pull Request completo con descripcion detallada, vinculacion a Issues, y proceso de revision.

**Duracion estimada:** 40 minutos

---

## Objetivos

- Crear branch y hacer cambios
- Abrir PR bien documentado
- Vincular PR con Issues
- Configurar reviewers
- Manejar el ciclo de vida del PR

---

## Requisitos Previos

- Completar Ejercicio 01 (Issues)
- Repositorio `issue-practice` de ejercicio anterior
- Al menos 1 Issue abierto en el repositorio

---

## Parte 1: Preparar Branch (5 min)

### Paso 1.1: Actualizar main

```bash
cd issue-practice
git checkout main
git pull origin main
```

### Paso 1.2: Crear feature branch

```bash
# Crear branch para el fix del Issue #1 (validacion email)
git checkout -b fix/email-validation

# Verificar branch
git branch
```

---

## Parte 2: Implementar Cambios (10 min)

### Paso 2.1: Crear archivo de validacion

```bash
# Crear directorio src
mkdir -p src

# Crear archivo de validacion
cat > src/validation.js << 'EOF'
/**
 * Validacion de formularios
 * @module validation
 */

/**
 * Valida formato de email
 * @param {string} email - Email a validar
 * @returns {boolean} - true si es valido
 */
function validateEmail(email) {
    if (!email || typeof email !== 'string') {
        return false;
    }
    
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email.trim());
}

/**
 * Valida que un campo no este vacio
 * @param {string} value - Valor a validar
 * @returns {boolean} - true si no esta vacio
 */
function validateRequired(value) {
    return value !== null && value !== undefined && value.trim() !== '';
}

/**
 * Valida longitud minima
 * @param {string} value - Valor a validar
 * @param {number} minLength - Longitud minima
 * @returns {boolean} - true si cumple longitud
 */
function validateMinLength(value, minLength) {
    return value && value.length >= minLength;
}

module.exports = {
    validateEmail,
    validateRequired,
    validateMinLength
};
EOF
```

### Paso 2.2: Crear tests

```bash
# Crear directorio de tests
mkdir -p tests

# Crear archivo de tests
cat > tests/validation.test.js << 'EOF'
const { validateEmail, validateRequired, validateMinLength } = require('../src/validation');

// Tests para validateEmail
console.log('Testing validateEmail...');

// Casos validos
console.assert(validateEmail('test@example.com') === true, 'Should accept valid email');
console.assert(validateEmail('user.name@domain.co.uk') === true, 'Should accept email with dots');

// Casos invalidos
console.assert(validateEmail('invalid') === false, 'Should reject email without @');
console.assert(validateEmail('test@') === false, 'Should reject email without domain');
console.assert(validateEmail('@domain.com') === false, 'Should reject email without local part');
console.assert(validateEmail('') === false, 'Should reject empty string');
console.assert(validateEmail(null) === false, 'Should reject null');
console.assert(validateEmail(undefined) === false, 'Should reject undefined');

// Tests para validateRequired
console.log('Testing validateRequired...');
console.assert(validateRequired('value') === true, 'Should accept non-empty string');
console.assert(validateRequired('') === false, 'Should reject empty string');
console.assert(validateRequired('   ') === false, 'Should reject whitespace only');

// Tests para validateMinLength
console.log('Testing validateMinLength...');
console.assert(validateMinLength('hello', 3) === true, 'Should accept if length >= min');
console.assert(validateMinLength('hi', 3) === false, 'Should reject if length < min');

console.log('All tests passed!');
EOF
```

### Paso 2.3: Actualizar README

```bash
cat >> README.md << 'EOF'

## Estructura

```
src/
  validation.js    # Funciones de validacion
tests/
  validation.test.js  # Tests unitarios
```

## Uso

```javascript
const { validateEmail } = require('./src/validation');

if (validateEmail(userInput)) {
    // Email valido
}
```

## Tests

```bash
node tests/validation.test.js
```
EOF
```

### Paso 2.4: Ejecutar tests

```bash
node tests/validation.test.js
# Deberia mostrar: "All tests passed!"
```

---

## Parte 3: Commit con Conventional Commits (5 min)

### Paso 3.1: Stage y commit

```bash
# Ver cambios
git status

# Agregar archivos
git add src/validation.js
git commit -m "feat: add email validation function

- Add validateEmail with regex pattern
- Add validateRequired for empty check
- Add validateMinLength for min length check"

# Agregar tests
git add tests/validation.test.js
git commit -m "test: add unit tests for validation functions

- Test valid and invalid email formats
- Test required field validation
- Test minimum length validation"

# Agregar docs
git add README.md
git commit -m "docs: update README with usage instructions"
```

### Paso 3.2: Push branch

```bash
git push -u origin fix/email-validation
```

---

## Parte 4: Crear Pull Request (10 min)

### Paso 4.1: Abrir PR desde CLI

```bash
gh pr create --title "fix: add email validation" \
  --body "## Description

Implements email validation to fix form submission with invalid emails.

## Related Issue

Closes #1

## Type of Change

- [x] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)

## Changes Made

- Added \`validateEmail\` function with regex pattern validation
- Added \`validateRequired\` for empty field checks
- Added \`validateMinLength\` for minimum length validation
- Added unit tests for all validation functions
- Updated README with usage instructions

## How to Test

1. Clone this branch
2. Run \`node tests/validation.test.js\`
3. All tests should pass

## Checklist

- [x] My code follows the project style guidelines
- [x] I have performed a self-review of my own code
- [x] I have commented my code, particularly in hard-to-understand areas
- [x] I have made corresponding changes to the documentation
- [x] My changes generate no new warnings
- [x] I have added tests that prove my fix is effective
- [x] New and existing unit tests pass locally"
```

### Paso 4.2: Alternativa - Crear desde GitHub UI

1. Ve a tu repositorio en GitHub
2. Click en el banner "Compare & pull request"
3. Completar el formulario con la informacion anterior
4. Click **Create pull request**

---

## Parte 5: Configurar PR (5 min)

### Paso 5.1: Agregar labels al PR

En la sidebar del PR:
- Labels: `bug`, `priority: high`

### Paso 5.2: Agregar al milestone

- Milestone: `v1.0 Release`

### Paso 5.3: Verificar vinculacion con Issue

- En la seccion "Development" deberia aparecer el Issue #1 vinculado
- El Issue deberia mostrar referencia al PR

---

## Parte 6: Simular Review (5 min)

### Paso 6.1: Self-review

1. Ir a pestaña **Files changed**
2. Revisar cada archivo
3. Agregar comentario en una linea:
   - Click en el `+` junto a una linea
   - Escribir: "Self-review: This regex pattern covers common email formats"
   - Click **Add single comment**

### Paso 6.2: Ver conversacion

1. Ir a pestaña **Conversation**
2. Ver el comentario agregado
3. Ver la vinculacion con Issue #1

---

## Parte 7: Merge el PR (5 min)

### Paso 7.1: Aprobar (si tienes permisos)

```bash
# Si trabajas solo, puedes aprobar tu propio PR
# En equipos reales, otro miembro lo aprobaria
```

### Paso 7.2: Merge desde CLI

```bash
# Merge con squash (recomendado para mantener historial limpio)
gh pr merge --squash

# O desde UI: Click "Squash and merge"
```

### Paso 7.3: Verificar resultado

```bash
# Actualizar main
git checkout main
git pull origin main

# Ver historial
git log --oneline -5

# Verificar que el Issue #1 se cerro automaticamente
gh issue view 1
```

### Paso 7.4: Limpiar branch

```bash
# Eliminar branch local
git branch -d fix/email-validation

# La branch remota se elimina automaticamente si configuraste
# "Automatically delete head branches" en Settings
```

---

## Verificacion Final

### Checklist

- [ ] Branch creada desde main
- [ ] Cambios implementados con commits claros
- [ ] PR creado con descripcion completa
- [ ] Issue vinculado correctamente
- [ ] Labels y milestone asignados
- [ ] PR mergeado exitosamente
- [ ] Issue cerrado automaticamente

### Comandos de Verificacion

```bash
# Ver PRs cerrados
gh pr list --state closed

# Ver detalle del PR
gh pr view 1

# Ver Issue cerrado
gh issue view 1
```

---

## Reto Extra

1. Crear PR template:
   ```bash
   cat > .github/PULL_REQUEST_TEMPLATE.md << 'EOF'
   ## Description
   
   ## Related Issue
   
   Closes #
   
   ## Type of Change
   
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation
   
   ## Checklist
   
   - [ ] Tests added
   - [ ] Documentation updated
   - [ ] Self-review completed
   EOF
   
   git add .github/PULL_REQUEST_TEMPLATE.md
   git commit -m "docs: add PR template"
   git push
   ```

2. Crear CODEOWNERS:
   ```bash
   echo "* @tu-usuario" > .github/CODEOWNERS
   ```

---

## Recursos

- [GitHub PRs Documentation](https://docs.github.com/en/pull-requests)
- [Linking PR to Issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue)

---

[Anterior: Issues](../ejercicio-01-gestion-issues/README.md) | [Siguiente: Code Review](../ejercicio-03-code-review/README.md)
