# Lección 04: Policies & Rulesets

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- Crear Repository Rulesets organizacionales
- Implementar Branch Protection Rules
- Configurar Tag Protection
- Aplicar políticas de deployment

---

## 📚 Conceptos Teóricos

### Rulesets vs Branch Protection

```yaml
Branch Protection Rules (Legacy):
  - Configuración por repositorio
  - Aplica a branches específicos
  - Configuración manual en cada repo
  
Repository Rulesets (Moderno):
  - Configuración a nivel org o repo
  - Targeting flexible (patterns)
  - Bypass con audit trail
  - Recomendado para nuevas implementaciones
```

---

## 🛡️ Repository Rulesets

### Crear Ruleset

```yaml
# Organization → Settings → Rules → Rulesets → New ruleset

Ruleset Configuration:

  Name: "production-protection"
  Enforcement: Active  # or Evaluate (dry run)
  
  Target: Branches
  
  Targeting:
    - Include default branch
    - Include: refs/heads/release/*
    - Exclude: refs/heads/feature/*
```

### Branch Targeting Patterns

```yaml
Patterns:
  ~DEFAULT_BRANCH:
    - Matches: main (o default configurado)
  
  refs/heads/main:
    - Exact match: solo "main"
  
  refs/heads/release/*:
    - Matches: release/1.0, release/2.0, etc.
  
  refs/heads/feature/**:
    - Matches: feature/x, feature/a/b/c
  
  refs/heads/*:
    - Matches: todas las branches

Exclusions:
  # Puedes excluir patterns específicos
  Exclude: refs/heads/sandbox/*
```

### Rules Disponibles

```yaml
# Restrict creations
Restrict creations: true
  # No se pueden crear branches que matcheen

# Restrict updates  
Restrict updates: true
  # No se puede push directamente

# Restrict deletions
Restrict deletions: true
  # No se pueden eliminar branches protegidas

# Require linear history
Require linear history: true
  # Solo fast-forward merges
  # No merge commits

# Require deployments to succeed
Require deployments to succeed:
  Environments:
    - staging
    - production

# Require signed commits
Require signed commits: true
  # Solo commits firmados con GPG/SSH

# Require a pull request
Require a pull request before merging:
  Required approvals: 2
  Dismiss stale reviews: true
  Require review from code owners: true
  Require approval of most recent push: true
  Require conversation resolution: true

# Require status checks
Require status checks to pass:
  Strict: true  # Branch must be up to date
  Required checks:
    - "CI / build"
    - "CI / test"
    - "security / scan"

# Block force pushes
Block force pushes: true
  # Evita reescribir historia
```

### Ejemplo: Ruleset de Producción

```yaml
Name: main-branch-protection
Enforcement: Active

Bypass List:
  - Roles: Organization admin
  - Teams: @acme-corp/release-managers
  # Con: "Always" o "Pull request only"

Target: Branches
Include: ~DEFAULT_BRANCH

Rules:
  ✅ Restrict deletions
  ✅ Require linear history
  ✅ Require a pull request:
      - Required approvals: 2
      - Dismiss stale reviews: true
      - Require code owner review: true
      - Require last push approval: true
  ✅ Require status checks:
      - Strict mode: true
      - Checks: build, test, security-scan
  ✅ Block force pushes
  ✅ Require signed commits
```

### Bypass Configuration

```yaml
Bypass List:
  # Quién puede bypass las reglas
  
  Actors:
    - Organization admins
    - Repository admins
    - Team: @org/release-managers
    - GitHub App: release-bot
  
  Bypass Mode:
    Always:
      - Pueden hacer push directo
      - Sin PR ni approvals
      - Audit logged
    
    Pull request only:
      - Deben crear PR
      - Pero no necesitan approvals
      - Audit logged

# ⚠️ Best Practice: Minimizar bypass list
```

---

## 📋 Branch Protection Rules (Legacy)

### Cuándo Usar

```yaml
Usar Branch Protection cuando:
  - GitHub Free/Team (sin org rulesets)
  - Configuración específica por repo
  - Features no disponibles en rulesets

Migrar a Rulesets cuando:
  - GitHub Enterprise
  - Necesitas consistencia org-wide
  - Necesitas bypass granular
  - Audit trail de bypasses
```

### Configuración

```yaml
# Repository → Settings → Branches → Add rule

Branch name pattern: main

Protection Options:
  ✅ Require a pull request before merging
     - Required approving reviews: 2
     - Dismiss stale pull request approvals
     - Require review from Code Owners
     - Require approval of most recent reviewable push
  
  ✅ Require status checks to pass before merging
     - Require branches to be up to date
     - Status checks: build, test
  
  ✅ Require conversation resolution before merging
  
  ✅ Require signed commits
  
  ✅ Require linear history
  
  ✅ Do not allow bypassing the above settings
  
  ✅ Restrict who can push to matching branches
     - Teams: @org/release-team
  
  ❌ Allow force pushes (nunca para main)
  
  ❌ Allow deletions (nunca para main)
```

### Via API

```bash
# Crear branch protection
gh api \
  --method PUT \
  repos/OWNER/REPO/branches/main/protection \
  -F required_status_checks='{"strict":true,"contexts":["build","test"]}' \
  -F enforce_admins=true \
  -F required_pull_request_reviews='{"required_approving_review_count":2,"dismiss_stale_reviews":true}' \
  -F restrictions=null

# Ver protección actual
gh api repos/OWNER/REPO/branches/main/protection

# Eliminar protección
gh api \
  --method DELETE \
  repos/OWNER/REPO/branches/main/protection
```

---

## 🏷️ Tag Protection

### Proteger Tags de Releases

```yaml
# Repository → Settings → Tags → New rule

Tag name pattern: v*

Protection:
  - Solo usuarios autorizados pueden crear
  - Previene eliminación accidental
  - Protege releases publicados
```

### Via Rulesets

```yaml
# Ruleset para tags
Name: release-tag-protection
Target: Tags

Include patterns:
  - refs/tags/v*
  - refs/tags/release-*

Rules:
  ✅ Restrict creations
  ✅ Restrict deletions
  
Bypass:
  - Team: @org/release-managers
```

---

## 🚀 Deployment Protection

### Environment Protection Rules

```yaml
# Repository → Settings → Environments

Environment: production

Protection rules:
  
  Required reviewers:
    - @org/release-managers
    - @user/tech-lead
    # Hasta 6 reviewers
  
  Wait timer:
    - Minutes: 30
    # Delay antes de deploy
  
  Deployment branches:
    - Selected branches: main, release/*
    # Solo estas branches pueden deployar
    
  Custom rules:
    - GitHub Apps pueden agregar checks
```

### Environment Secrets

```yaml
# Secrets específicos de environment

Environment: production
Secrets:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - DATABASE_URL

# Estos secrets solo disponibles cuando:
# 1. Workflow aprobado por reviewers
# 2. Branch permitido
# 3. Wait timer completado
```

### Workflow con Environments

```yaml
# .github/workflows/deploy.yml

name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy-staging:
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Staging
        run: ./deploy.sh staging
        env:
          API_KEY: ${{ secrets.API_KEY }}

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: 
      name: production
      url: https://app.acme.io
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Production
        run: ./deploy.sh production
        env:
          API_KEY: ${{ secrets.API_KEY }}
```

---

## 📊 Push Rules

### Restricciones de Push

```yaml
# En Rulesets, sección Push rules

Restrict file paths:
  # Bloquear cambios a archivos específicos
  Restricted paths:
    - .github/workflows/**
    - terraform/**
    - Dockerfile
    
Restrict file extensions:
  # Bloquear ciertos tipos de archivo
  Restricted extensions:
    - .exe
    - .dll
    - .zip

Restrict file size:
  # Límite de tamaño
  Max file size: 10 MB
```

---

## 🔄 Políticas de Merge

### Merge Strategies

```yaml
# Repository → Settings → General → Pull Requests

Allow merge commits: ✅
  # Crea commit de merge
  # Preserva historia completa

Allow squash merging: ✅
  # Combina todos los commits en uno
  # Historia más limpia
  Default commit message: PR title and description

Allow rebase merging: ✅
  # Reaplica commits sobre base
  # Historia lineal

# Recomendación común:
Allow squash merging: ✅ (default)
Allow merge commits: ❌
Allow rebase merging: ❌
```

### Auto-merge

```yaml
# Repository → Settings → General

Allow auto-merge: ✅

# Permite a authors habilitar auto-merge
# PR se mergea automáticamente cuando:
# - Todos los checks pasan
# - Approvals requeridos obtenidos
# - No hay conflictos
```

---

## ✅ Best Practices

### Ruleset Strategy

```yaml
Organization Rulesets:

  1. baseline-protection (todos los repos):
     - Require PR for default branch
     - 1 approval mínimo
     - Status checks básicos
     
  2. production-protection (repos críticos):
     - 2 approvals
     - Code owner review
     - Signed commits
     - No force push
     
  3. release-protection (tags):
     - Restrict tag creation
     - Only release team

Repository Rulesets:
  - Para excepciones específicas
  - Override org rules cuando necesario
```

### Enforcement Checklist

```markdown
## Protection Checklist

### Default Branch (main)
- [ ] Require PR before merge
- [ ] Minimum 1-2 approvals
- [ ] Dismiss stale reviews
- [ ] Require status checks
- [ ] Block force pushes
- [ ] Block deletions

### Release Branches
- [ ] Similar a main
- [ ] Require code owner review
- [ ] Deployment gates

### Tags
- [ ] Protect release tags (v*)
- [ ] Restrict creation to release team
- [ ] Block deletions

### Environments
- [ ] Production requires approval
- [ ] Wait timer for production
- [ ] Branch restrictions
```

---

## 🔗 Recursos Adicionales

- [Repository Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)
- [Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)
- [Deployment Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **Rulesets** | Políticas modernas a nivel org/repo |
| **Branch Protection** | Legacy, por repositorio |
| **Tag Protection** | Proteger releases |
| **Environments** | Gates para deployments |
| **Push Rules** | Restricciones de archivos/tamaño |

---

**Siguiente**: [Ejercicio 01 - Organization Setup](../2-practicas/ejercicio-01-org-setup/README.md)
