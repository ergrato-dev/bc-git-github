# Ejercicio 03: Branch Protection & Rulesets

## 🎯 Objetivo

Implementar reglas de protección de branches y rulesets organizacionales para asegurar la calidad y seguridad del código.

**Duración**: 35 minutos

---

## 📋 Escenario

TechStartup Inc. necesita implementar las siguientes políticas:

1. **main branch**: Protección máxima - 2 approvals, status checks, no force push
2. **release branches**: Similar a main, más deployment gates
3. **feature branches**: Sin restricciones (para desarrollo rápido)

---

## 🛡️ Parte 1: Branch Protection para Main (10 min)

### Paso 1.1: Configurar via UI

```yaml
# Repository → Settings → Branches → Add branch protection rule

Branch name pattern: main

Protection options:
  ✅ Require a pull request before merging
     Required approving reviews: 2
     ✅ Dismiss stale pull request approvals when new commits are pushed
     ✅ Require review from Code Owners
     ✅ Require approval of the most recent reviewable push
  
  ✅ Require status checks to pass before merging
     ✅ Require branches to be up to date before merging
     Status checks: (agregar después de crear workflow)
  
  ✅ Require conversation resolution before merging
  
  ✅ Require signed commits
  
  ✅ Require linear history
  
  ❌ Allow force pushes
  
  ❌ Allow deletions
  
  ✅ Do not allow bypassing the above settings
```

### Paso 1.2: Configurar via API

```bash
# ¿QUÉ VAMOS A HACER?: Configurar branch protection via API
# ¿POR QUÉ?: Automatizar configuración reproducible
# ¿PARA QUÉ SIRVE?: Infrastructure as Code para policies

gh api \
  --method PUT \
  repos/techstartup-bootcamp-TUNOMBRE/webapp/branches/main/protection \
  -f required_status_checks='{"strict":true,"contexts":[]}' \
  -f enforce_admins=true \
  -f required_pull_request_reviews='{"required_approving_review_count":2,"dismiss_stale_reviews":true,"require_code_owner_reviews":true,"require_last_push_approval":true}' \
  -f restrictions=null \
  -F required_linear_history=true \
  -F allow_force_pushes=false \
  -F allow_deletions=false \
  -F required_conversation_resolution=true
```

### Paso 1.3: Verificar protección

```bash
# ¿QUÉ VAMOS A HACER?: Verificar que la protección se aplicó
# ¿POR QUÉ?: Confirmar configuración correcta
# ¿PARA QUÉ SIRVE?: Auditoría de políticas

gh api repos/techstartup-bootcamp-TUNOMBRE/webapp/branches/main/protection \
  --jq '{
    required_reviews: .required_pull_request_reviews.required_approving_review_count,
    dismiss_stale: .required_pull_request_reviews.dismiss_stale_reviews,
    code_owners: .required_pull_request_reviews.require_code_owner_reviews,
    linear_history: .required_linear_history.enabled,
    force_push: .allow_force_pushes.enabled,
    deletions: .allow_deletions.enabled
  }'

# Resultado esperado:
# {
#   "required_reviews": 2,
#   "dismiss_stale": true,
#   "code_owners": true,
#   "linear_history": true,
#   "force_push": false,
#   "deletions": false
# }
```

---

## 📋 Parte 2: Crear Workflow para Status Checks (10 min)

### Paso 2.1: Crear workflow de CI

```bash
# ¿QUÉ VAMOS A HACER?: Crear workflow que sirva como status check
# ¿POR QUÉ?: Sin status checks, la protección no tiene sentido
# ¿PARA QUÉ SIRVE?: Validar código antes de merge

cd webapp  # Si no estás ya en el directorio

mkdir -p .github/workflows

cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Build check
        run: echo "Build successful"

  test:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run tests
        run: echo "All tests passed"

  lint:
    name: Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run linter
        run: echo "Linting passed"

  security:
    name: Security Scan
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Security scan
        run: echo "No vulnerabilities found"
EOF

git add .github/workflows/ci.yml
git commit -m "ci: add CI workflow for branch protection"
git push origin main
```

### Paso 2.2: Agregar status checks a protección

```bash
# ¿QUÉ VAMOS A HACER?: Agregar los jobs como required checks
# ¿POR QUÉ?: Ahora que el workflow existe, podemos requerirlo
# ¿PARA QUÉ SIRVE?: Bloquear merges si CI falla

# Esperar a que el workflow corra al menos una vez
# Luego actualizar la protección:

gh api \
  --method PUT \
  repos/techstartup-bootcamp-TUNOMBRE/webapp/branches/main/protection \
  -f required_status_checks='{"strict":true,"contexts":["Build","Test","Lint","Security Scan"]}' \
  -f enforce_admins=true \
  -f required_pull_request_reviews='{"required_approving_review_count":2,"dismiss_stale_reviews":true,"require_code_owner_reviews":true}' \
  -f restrictions=null
```

---

## 🏷️ Parte 3: Tag Protection (5 min)

### Paso 3.1: Proteger tags de releases

```yaml
# Repository → Settings → Tags → New rule

Tag name pattern: v*

# Esta regla:
# - Previene eliminación de tags v*
# - Requiere permisos para crear tags
```

### Paso 3.2: Via API (si disponible)

```bash
# ¿QUÉ VAMOS A HACER?: Crear tag protection rule
# ¿POR QUÉ?: Proteger releases publicados
# ¿PARA QUÉ SIRVE?: Evitar eliminación accidental de releases

# Nota: Tag protection via API es feature de Enterprise
# Para free/team, usar UI

# Verificar tags existentes
git tag -l

# Crear tag de ejemplo
git tag -a v0.1.0 -m "Initial release"
git push origin v0.1.0
```

---

## 🔧 Parte 4: Repository Ruleset (Org level) (10 min)

### Paso 4.1: Crear Ruleset organizacional

```yaml
# Organization → Settings → Rules → Rulesets → New ruleset

# Esta es la forma moderna y recomendada (Enterprise/Team)

Ruleset name: production-branch-protection
Enforcement status: Active

Bypass list:
  - @techstartup-bootcamp-TUNOMBRE/devops
  Mode: Pull request only

Target repositories: All repositories

Target branches:
  Include: ~DEFAULT_BRANCH

Rules:
  ✅ Restrict deletions
  ✅ Require linear history
  ✅ Require a pull request before merging
     Required approvals: 1
     ✅ Dismiss stale reviews
     ✅ Require code owner review
  ✅ Block force pushes
```

### Paso 4.2: Crear Ruleset via API

```bash
# ¿QUÉ VAMOS A HACER?: Crear ruleset organizacional via API
# ¿POR QUÉ?: Aplicar políticas consistentes a todos los repos
# ¿PARA QUÉ SIRVE?: Governance centralizada

# Nota: Rulesets API requiere GitHub Enterprise

# Ejemplo de payload (para referencia):
cat << 'EOF'
{
  "name": "production-protection",
  "target": "branch",
  "enforcement": "active",
  "conditions": {
    "ref_name": {
      "include": ["~DEFAULT_BRANCH"],
      "exclude": []
    }
  },
  "rules": [
    {"type": "deletion"},
    {"type": "non_fast_forward"},
    {"type": "pull_request", 
     "parameters": {
       "required_approving_review_count": 1,
       "dismiss_stale_reviews_on_push": true,
       "require_code_owner_review": true
     }
    }
  ]
}
EOF
```

---

## ✅ Checklist de Verificación

```markdown
## Branch Protection - Verificación

### Main Branch Protection
- [ ] 2 approvals requeridos
- [ ] Dismiss stale reviews: enabled
- [ ] Code owner review: required
- [ ] Linear history: required
- [ ] Force push: blocked
- [ ] Deletions: blocked

### Status Checks
- [ ] CI workflow creado
- [ ] Build, Test, Lint, Security como required checks
- [ ] Strict mode habilitado

### Tag Protection
- [ ] Pattern v* protegido
- [ ] Tag de ejemplo creado (v0.1.0)

### Verificación Práctica
- [ ] Intentar push directo a main → DEBE FALLAR
- [ ] Intentar force push → DEBE FALLAR
- [ ] PR sin approvals → NO PUEDE HACER MERGE
```

---

## 🧪 Pruebas de Verificación

### Test 1: Push directo debe fallar

```bash
# ¿QUÉ VAMOS A HACER?: Intentar push directo a main
# ¿POR QUÉ?: Verificar que la protección funciona
# ¿PARA QUÉ SIRVE?: Validar configuración

echo "test" > test-file.txt
git add test-file.txt
git commit -m "test: direct push should fail"
git push origin main

# Resultado esperado: ERROR
# remote: error: GH006: Protected branch update failed
```

### Test 2: Force push debe fallar

```bash
# ¿QUÉ VAMOS A HACER?: Intentar force push
# ¿POR QUÉ?: Verificar bloqueo de force push
# ¿PARA QUÉ SIRVE?: Proteger historia del repositorio

git push --force origin main

# Resultado esperado: ERROR
# remote: error: Cannot force-push to protected branch
```

### Test 3: Crear PR correctamente

```bash
# ¿QUÉ VAMOS A HACER?: Crear PR siguiendo el proceso correcto
# ¿POR QUÉ?: Verificar flujo de trabajo
# ¿PARA QUÉ SIRVE?: Confirmar que el proceso funciona

git checkout -b feature/test-protection
echo "feature content" > feature.txt
git add feature.txt
git commit -m "feat: test branch protection"
git push origin feature/test-protection

# Crear PR
gh pr create \
  --title "Test: Branch Protection" \
  --body "Testing that branch protection works correctly"

# El PR debe:
# 1. Ejecutar CI workflow
# 2. Requerir 2 approvals
# 3. Requerir code owner review
```

---

## 🔧 Troubleshooting

### Error: "Status check not found"

```bash
# Problema: El workflow nunca ha corrido
# Solución: Ejecutar workflow manualmente primero

gh workflow run ci.yml

# O hacer un push para triggerearlo
```

### Error: "Cannot merge - required checks failing"

```bash
# Problema: CI está fallando
# Solución: Revisar logs del workflow

gh run list --workflow=ci.yml
gh run view RUN_ID --log
```

---

## 📚 Recursos

- [Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)
- [Repository Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)
- [Tag Protection](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/configuring-tag-protection-rules)

---

## ➡️ Siguiente Ejercicio

Continúa con [Ejercicio 04 - Security Policies](../ejercicio-04-security-policies/README.md)
