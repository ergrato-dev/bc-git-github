# 📋 Lección 04: Estrategias de Branching

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- ✅ Comprender la importancia de las estrategias de branching
- ✅ Implementar el flujo Feature Branch
- ✅ Conocer Git Flow y sus componentes
- ✅ Elegir la estrategia adecuada para tu proyecto

---

## 📖 ¿Por Qué Necesitamos Estrategias?

Sin una estrategia clara de branching:

- ❌ Caos en el repositorio
- ❌ Conflictos constantes
- ❌ Dificultad para rastrear features
- ❌ Problemas en releases
- ❌ Código roto en producción

Con una estrategia definida:

- ✅ Flujo de trabajo predecible
- ✅ Menos conflictos
- ✅ Releases controladas
- ✅ Fácil rollback
- ✅ Colaboración efectiva

---

## 🌿 Feature Branch Workflow

### Concepto

El **Feature Branch Workflow** es la estrategia más básica y ampliamente utilizada. Cada feature se desarrolla en su propio branch.

![Git Flow Básico](../0-assets/04-git-flow-basico.svg)

### Principios

1. **main** siempre está estable y listo para producción
2. Cada feature se desarrolla en un branch separado
3. Los branches se nombran descriptivamente (`feature/nombre`)
4. Se hace merge a main cuando la feature está completa

### Flujo de Trabajo

```bash
# 1. CREAR branch para la feature
# ¿Qué hace?: Inicia el desarrollo aislado
# ¿Por qué?: Para no afectar main mientras trabajas
# ¿Para qué sirve?: Desarrollo seguro y paralelo

git switch main
git pull origin main  # Actualizar primero
git switch -c feature/user-login

# 2. DESARROLLAR la feature
# Hacer commits atómicos con mensajes descriptivos
git add .
git commit -m "feat: add login form component"
git add .
git commit -m "feat: add login validation"
git add .
git commit -m "feat: connect login to API"

# 3. ACTUALIZAR con cambios de main (opcional pero recomendado)
git switch main
git pull origin main
git switch feature/user-login
git merge main  # Traer cambios de main a tu feature

# 4. INTEGRAR la feature a main
git switch main
git merge --no-ff feature/user-login

# 5. LIMPIAR el branch
git branch -d feature/user-login
```

---

## 🔄 Git Flow

### ¿Qué es Git Flow?

**Git Flow** es una estrategia más estructurada, ideal para proyectos con releases planificadas. Define roles específicos para diferentes tipos de branches.

### Branches Principales

| Branch | Propósito | Duración |
|--------|-----------|----------|
| `main` | Código en producción | Permanente |
| `develop` | Integración de features | Permanente |

### Branches de Soporte

| Branch | Propósito | Origen | Destino |
|--------|-----------|--------|---------|
| `feature/*` | Nuevas features | develop | develop |
| `release/*` | Preparar release | develop | main + develop |
| `hotfix/*` | Fixes urgentes | main | main + develop |

### Diagrama de Git Flow

```
main:     ●─────────────────────●──────────●────────────●
           \                   /          /            /
release:    \       ●────────●          /            /
             \     /                   /            /
develop:      ●───●───●───●───●───●───●───●───●───●
               \     /       \   /         \     /
feature:        ●───●         ●─●           ●───●
```

### Ejemplo Práctico

```bash
# ══════════════════════════════════════════════
# SETUP INICIAL
# ══════════════════════════════════════════════

# Crear branch develop desde main
git switch main
git switch -c develop

# ══════════════════════════════════════════════
# DESARROLLO DE FEATURE
# ══════════════════════════════════════════════

# 1. Crear feature branch desde develop
git switch develop
git switch -c feature/shopping-cart

# 2. Desarrollar
echo "Shopping cart implementation" > cart.js
git add cart.js
git commit -m "feat: add shopping cart"

# 3. Terminar feature (merge a develop)
git switch develop
git merge --no-ff feature/shopping-cart
git branch -d feature/shopping-cart

# ══════════════════════════════════════════════
# CREAR RELEASE
# ══════════════════════════════════════════════

# 1. Crear release branch
git switch develop
git switch -c release/1.0.0

# 2. Preparar release (version bump, docs, etc.)
echo "v1.0.0" > VERSION
git commit -am "chore: bump version to 1.0.0"

# 3. Finalizar release
# Merge a main
git switch main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"

# Merge a develop
git switch develop
git merge --no-ff release/1.0.0

# Limpiar
git branch -d release/1.0.0

# ══════════════════════════════════════════════
# HOTFIX (fix urgente en producción)
# ══════════════════════════════════════════════

# 1. Crear hotfix desde main
git switch main
git switch -c hotfix/security-patch

# 2. Aplicar fix
echo "Security fix" > security.patch
git add security.patch
git commit -m "fix: patch security vulnerability"

# 3. Finalizar hotfix
# Merge a main
git switch main
git merge --no-ff hotfix/security-patch
git tag -a v1.0.1 -m "Hotfix 1.0.1"

# Merge a develop
git switch develop
git merge --no-ff hotfix/security-patch

# Limpiar
git branch -d hotfix/security-patch
```

---

## 🚀 GitHub Flow

### ¿Qué es?

**GitHub Flow** es una estrategia simplificada, ideal para deployment continuo. Solo usa `main` y feature branches.

### Principios

1. `main` siempre es deployable
2. Crear branches descriptivos para cualquier cambio
3. Hacer Pull Requests para revisión
4. Merge después de aprobación
5. Deploy inmediatamente después del merge

### Flujo

```bash
# 1. Crear branch
git switch -c feature/new-dashboard

# 2. Desarrollar y hacer commits
git commit -m "feat: add dashboard layout"
git commit -m "feat: add charts"

# 3. Push y crear Pull Request
git push origin feature/new-dashboard
# → Crear PR en GitHub

# 4. Code Review y discusión
# (en GitHub)

# 5. Merge PR
# (en GitHub o localmente)

# 6. Deploy
# (automático via CI/CD)
```

---

## 📊 Comparación de Estrategias

| Aspecto | Feature Branch | Git Flow | GitHub Flow |
|---------|---------------|----------|-------------|
| **Complejidad** | Baja | Alta | Baja |
| **Branches** | main + features | 5 tipos | main + features |
| **Releases** | Continuas | Planificadas | Continuas |
| **Ideal para** | Equipos pequeños | Releases versiones | CI/CD, SaaS |
| **Curva aprendizaje** | Fácil | Media | Fácil |

### ¿Cuál elegir?

```
┌─────────────────────────────────────────────────────────┐
│                  ¿Qué estrategia usar?                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ¿Releases planificadas con versiones?                  │
│        │                                                │
│        ├─── SÍ ──→ Git Flow                             │
│        │                                                │
│        └─── NO ──→ ¿Deploy continuo a producción?       │
│                          │                              │
│                          ├─── SÍ ──→ GitHub Flow        │
│                          │                              │
│                          └─── NO ──→ Feature Branch     │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 📏 Convenciones de Nombres

### Feature Branches

```bash
# Formato: tipo/descripcion-corta

# Features
feature/user-authentication
feature/shopping-cart
feature/email-notifications

# Fixes
fix/login-validation
fix/memory-leak
fix/typo-in-header

# Hotfixes
hotfix/security-vulnerability
hotfix/database-connection

# Releases
release/1.0.0
release/2.1.0
```

### Reglas

| Regla | Ejemplo Correcto | Ejemplo Incorrecto |
|-------|-----------------|-------------------|
| Usar guiones | `feature/user-login` | `feature/user_login` |
| Minúsculas | `fix/navbar` | `Fix/NavBar` |
| Descriptivo | `feature/add-search` | `feature/f1` |
| Sin espacios | `fix/form-validation` | `fix/form validation` |

---

## 💡 Tips y Best Practices

### 1. Mantén branches cortos

```bash
# ✅ Buena práctica: branches de 1-3 días
feature/add-login-button  # 1 día de trabajo

# ❌ Mala práctica: branches de semanas
feature/complete-redesign  # 3 semanas de trabajo
# → Dividir en branches más pequeños
```

### 2. Sincroniza frecuentemente

```bash
# Mantén tu feature actualizada con develop/main
git switch feature/mi-feature
git merge develop  # O rebase si prefieres

# Evita sorpresas al momento del merge final
```

### 3. Elimina branches después del merge

```bash
# Después del merge exitoso
git branch -d feature/completed-feature

# Limpia branches remotos
git push origin --delete feature/completed-feature
```

### 4. Usa tags para releases

```bash
# Marcar versiones importantes
git tag -a v1.0.0 -m "Primera versión estable"
git push origin v1.0.0
```

---

## 📝 Ejercicio Práctico: Feature Branch Workflow

```bash
# ══════════════════════════════════════════════
# SIMULACIÓN DE FLUJO DE TRABAJO EN EQUIPO
# ══════════════════════════════════════════════

# Setup inicial
mkdir proyecto-equipo && cd proyecto-equipo
git init
echo "# Proyecto Equipo" > README.md
git add README.md
git commit -m "chore: initial commit"

# ──────────────────────────────────────────────
# DESARROLLADOR 1: Feature Login
# ──────────────────────────────────────────────
git switch -c feature/login
echo "Login form" > login.html
git add login.html
git commit -m "feat: add login form"
echo "Login validation" > login.js
git add login.js
git commit -m "feat: add login validation"

# Merge a main
git switch main
git merge --no-ff feature/login -m "feat: integrate login feature"
git branch -d feature/login

# ──────────────────────────────────────────────
# DESARROLLADOR 2: Feature Dashboard
# ──────────────────────────────────────────────
git switch -c feature/dashboard
echo "Dashboard" > dashboard.html
git add dashboard.html
git commit -m "feat: add dashboard layout"

# Mientras tanto, main recibió cambios...
# Actualizar feature con main
git switch main
# (simular que alguien más hizo cambios)
echo "Footer" >> README.md
git commit -am "docs: add footer info"

# Volver a feature y sincronizar
git switch feature/dashboard
git merge main -m "chore: sync with main"

# Continuar desarrollo
echo "Charts" > charts.js
git add charts.js
git commit -m "feat: add dashboard charts"

# Merge final
git switch main
git merge --no-ff feature/dashboard -m "feat: integrate dashboard feature"
git branch -d feature/dashboard

# Ver resultado
git log --oneline --graph --all
```

---

## 🎯 Resumen

| Estrategia | Cuándo Usar | Branches |
|------------|-------------|----------|
| **Feature Branch** | Proyectos simples, equipos pequeños | main + feature/* |
| **Git Flow** | Releases versionadas, productos con soporte | main, develop, feature/*, release/*, hotfix/* |
| **GitHub Flow** | CI/CD, deploy continuo, SaaS | main + feature/* + PRs |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Índice | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [03 - Merge](03-merge-basico.md) | [Teoría](.) | [Prácticas](../2-practicas/README.md) |

---

<div align="center">

**Lección 04** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
