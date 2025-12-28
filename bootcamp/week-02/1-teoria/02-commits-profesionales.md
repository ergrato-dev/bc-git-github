# 📝 Lección 02: Commits Profesionales

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- [ ] Crear commits con mensajes profesionales
- [ ] Aplicar la convención Conventional Commits
- [ ] Entender la anatomía interna de un commit
- [ ] Escribir mensajes descriptivos y útiles
- [ ] Mantener un historial limpio y legible

---

## 📚 Conceptos Teóricos

### ¿Qué es un Commit?

Un **commit** es una fotografía (snapshot) del estado de tu proyecto en un momento específico. Es la unidad fundamental del historial en Git.

> 💡 **Analogía**: Un commit es como guardar tu partida en un videojuego. Puedes volver a ese punto exacto cuando quieras.

### Anatomía de un Commit

Cada commit contiene:

![Anatomía de un Commit](../0-assets/03-anatomia-commit.svg)

| Componente | Descripción |
|------------|-------------|
| **SHA-1 Hash** | Identificador único de 40 caracteres |
| **Tree** | Snapshot del estado de todos los archivos |
| **Parent** | Referencia al commit anterior |
| **Author** | Quién escribió los cambios |
| **Committer** | Quién hizo el commit |
| **Timestamp** | Fecha y hora del commit |
| **Message** | Descripción de los cambios |

---

## 🏆 Conventional Commits

### ¿Qué son los Conventional Commits?

Es una **especificación** para escribir mensajes de commit de forma estructurada y consistente. Es un estándar de la industria usado por equipos profesionales.

### Formato

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Tipos Principales

| Tipo | Cuándo usar | Ejemplo |
|------|-------------|---------|
| `feat` | Nueva funcionalidad | `feat: agregar botón de logout` |
| `fix` | Corrección de bug | `fix: corregir error en validación` |
| `docs` | Solo documentación | `docs: actualizar README` |
| `style` | Formato, sin cambio de lógica | `style: corregir indentación` |
| `refactor` | Mejora de código sin cambiar funcionalidad | `refactor: simplificar función login` |
| `test` | Agregar o corregir tests | `test: agregar tests para auth` |
| `chore` | Mantenimiento, builds | `chore: actualizar dependencias` |
| `perf` | Mejora de rendimiento | `perf: optimizar consulta SQL` |
| `ci` | Configuración de CI/CD | `ci: agregar workflow de deploy` |
| `build` | Sistema de build | `build: configurar webpack` |
| `revert` | Revertir commit anterior | `revert: revertir "feat: x"` |

### Scope (Opcional)

El scope indica qué parte del proyecto se afecta:

```bash
feat(auth): agregar validación de password
fix(ui): corregir alineación del header
docs(api): documentar endpoints REST
```

### Breaking Changes

Si el cambio rompe compatibilidad:

```bash
# Opción 1: Con ! después del tipo
feat!: cambiar formato de API response

# Opción 2: En el footer
feat: cambiar formato de API response

BREAKING CHANGE: el campo 'data' ahora es un array
```

---

## ⌨️ Comandos Principales

### 1. `git commit` - Crear un commit

```bash
# ¿Qué hace?: Crea un commit con los cambios en staging
# ¿Por qué?: Para guardar un punto en el historial
# ¿Para qué sirve?: Trackear el progreso y colaborar

# Forma básica (abre editor)
git commit

# Con mensaje inline (recomendado para mensajes cortos)
git commit -m "feat: agregar sistema de login"

# Con mensaje multilínea
git commit -m "feat: agregar sistema de login" -m "- Implementa validación de usuario" -m "- Agrega encriptación de password"
```

### 2. `git commit -a` - Commit de archivos tracked

```bash
# ¿Qué hace?: Agrega automáticamente archivos modificados (no nuevos) y commitea
# ¿Por qué?: Atajo para archivos ya tracked
# ¿Para qué sirve?: Velocidad cuando todos los cambios van al mismo commit

# Agregar archivos modificados y commitear
git commit -a -m "fix: corregir typo en header"

# Forma abreviada
git commit -am "fix: corregir typo en header"

# ⚠️ NOTA: No incluye archivos nuevos (untracked)
```

### 3. `git commit --amend` - Modificar último commit

```bash
# ¿Qué hace?: Modifica el último commit (mensaje o contenido)
# ¿Por qué?: Para corregir errores sin crear commits adicionales
# ¿Para qué sirve?: Mantener un historial limpio

# Cambiar solo el mensaje
git commit --amend -m "docs: corregir typo en README"

# Agregar cambios olvidados al último commit
git add archivo_olvidado.txt
git commit --amend --no-edit

# ⚠️ CUIDADO: No usar en commits ya pusheados
```

---

## 🎯 Buenas Prácticas para Mensajes

### ✅ Reglas de Oro

1. **Usar modo imperativo** - "Agregar feature" no "Agregando feature"
2. **Primera línea ≤ 50 caracteres** - Conciso y directo
3. **Capitalizar el mensaje** - "Add" no "add" (en inglés)
4. **No terminar con punto** - `feat: agregar login` no `feat: agregar login.`
5. **Separar subject del body** - Línea en blanco entre ellos

### ✅ Buenos Mensajes

```bash
# Descriptivo y claro
git commit -m "feat(auth): implementar autenticación con JWT"

# Específico sobre qué se corrige
git commit -m "fix(cart): corregir cálculo de impuestos en checkout"

# Documentación clara
git commit -m "docs: agregar ejemplos de uso en README"
```

### ❌ Malos Mensajes

```bash
# Vago e inútil
git commit -m "cambios"

# No describe nada
git commit -m "update"

# Sin sentido
git commit -m "."

# Demasiado genérico
git commit -m "fix bugs"

# Múltiples cosas mezcladas
git commit -m "agregar login y corregir bugs y actualizar docs"
```

---

## 🔨 Ejemplo Práctico Completo

### Escenario: Desarrollando una feature de registro

```bash
# 1. Crear el archivo inicial
touch src/auth/register.js
git add src/auth/register.js
git commit -m "feat(auth): crear estructura base de registro"

# 2. Implementar validación de email
# ... editar register.js ...
git add src/auth/register.js
git commit -m "feat(auth): agregar validación de formato de email"

# 3. Agregar tests
touch tests/register.test.js
git add tests/register.test.js
git commit -m "test(auth): agregar tests para validación de registro"

# 4. Actualizar documentación
# ... editar README.md ...
git add README.md
git commit -m "docs: documentar endpoint de registro"

# 5. Corregir un bug encontrado
# ... editar register.js ...
git add src/auth/register.js
git commit -m "fix(auth): corregir validación de password vacío"
```

**Resultado en el historial:**
```
* fix(auth): corregir validación de password vacío
* docs: documentar endpoint de registro
* test(auth): agregar tests para validación de registro
* feat(auth): agregar validación de formato de email
* feat(auth): crear estructura base de registro
```

---

## 🎯 Commits Atómicos

### ¿Qué es un Commit Atómico?

Un commit que contiene **un solo cambio lógico**. Si necesitas usar "y" en tu mensaje, probablemente deberías hacer dos commits.

### ❌ No Atómico

```bash
# Un commit haciendo muchas cosas
git commit -m "feat: agregar login, corregir bug en registro y actualizar README"
```

### ✅ Atómico

```bash
# Tres commits separados
git commit -m "feat(auth): agregar sistema de login"
git commit -m "fix(auth): corregir validación en registro"
git commit -m "docs: actualizar README con instrucciones de auth"
```

### Beneficios de Commits Atómicos

| Beneficio | Descripción |
|-----------|-------------|
| **Revertir fácil** | Puedes deshacer un cambio específico |
| **Bisect eficiente** | Encontrar bugs más rápido |
| **Code review** | Más fácil de revisar |
| **Historial legible** | Entender qué pasó y cuándo |
| **Cherry-pick** | Mover commits específicos a otras branches |

---

## ⚠️ Errores Comunes

### Error 1: Commit vacío

```bash
# Problema: No hay nada en staging
git commit -m "mi mensaje"
# Output: nothing to commit

# Solución: Agregar archivos primero
git add archivo.txt
git commit -m "mi mensaje"
```

### Error 2: Olvidé un archivo

```bash
# Problema: Hiciste commit pero olvidaste un archivo

# Solución: Usar --amend
git add archivo_olvidado.txt
git commit --amend --no-edit
```

### Error 3: Mensaje incorrecto

```bash
# Problema: El mensaje tiene un typo

# Solución: Usar --amend
git commit --amend -m "feat: mensaje corregido"
```

### Error 4: Commit muy grande

```bash
# Problema: Mezclaste muchos cambios en un commit

# Si aún no has pusheado, puedes:
# 1. Reset soft para volver los cambios a staging
git reset --soft HEAD~1

# 2. Ahora hacer commits separados
git add archivo1.txt
git commit -m "feat: primer cambio"
git add archivo2.txt  
git commit -m "fix: segundo cambio"
```

---

## 📝 Resumen de Comandos

| Comando | Acción |
|---------|--------|
| `git commit -m "mensaje"` | Commit con mensaje |
| `git commit -am "mensaje"` | Add + commit (solo tracked) |
| `git commit --amend` | Modificar último commit |
| `git commit --amend --no-edit` | Agregar cambios sin cambiar mensaje |
| `git commit --allow-empty -m "mensaje"` | Commit vacío (para CI/CD) |

---

## 📋 Checklist de un Buen Commit

- [ ] ¿El mensaje sigue Conventional Commits?
- [ ] ¿El mensaje es claro y descriptivo?
- [ ] ¿El commit es atómico (un solo propósito)?
- [ ] ¿Revisé los cambios con `git diff --staged`?
- [ ] ¿El código compila/funciona?

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Staging Area](01-staging-area.md) | [Week 02](../README.md) | [Historial Git](03-historial-git.md) |

---

## 📚 Recursos Adicionales

- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [How to Write a Git Commit Message](https://cbea.ms/git-commit/)
- [Git Documentation - git-commit](https://git-scm.com/docs/git-commit)

---

_Lección 02 Week 02 | Bootcamp Git/GitHub | 2025_
