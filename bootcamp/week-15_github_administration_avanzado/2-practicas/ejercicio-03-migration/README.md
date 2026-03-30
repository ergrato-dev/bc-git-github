# Ejercicio 03: Migration Planning

## 🎯 Objetivo

Planificar y ejecutar una migración de repositorios usando GitHub Enterprise Importer (GEI) y herramientas de migración.

**Duración**: 35 minutos

---

## 📋 Contexto

Tu empresa está consolidando múltiples fuentes de código en GitHub Enterprise. Necesitas:
- Inventariar repos existentes
- Planificar la migración
- Ejecutar dry-run
- Validar resultados

---

## 🔧 Parte 1: Inventario (10 min)

### Paso 1.1: Crear Inventario de Origen

```bash
# ¿QUÉ VAMOS A HACER?: Documentar repos a migrar
# ¿POR QUÉ?: Planificación requiere conocer el alcance
# ¿PARA QUÉ SIRVE?: Base para estimación de tiempo y recursos

# Crear directorio de trabajo
mkdir -p migration-project && cd migration-project

# Crear inventario (simulado - adaptar a tu origen)
cat > inventory.csv << 'EOF'
source,repo_name,size_mb,branches,issues,prs,priority
github.com/old-org,api-backend,250,12,45,23,high
github.com/old-org,web-frontend,180,8,32,15,high
github.com/old-org,mobile-app,320,15,67,28,medium
github.com/old-org,docs,45,3,12,5,low
github.com/old-org,legacy-tool,890,25,0,0,low
EOF

echo "Inventario creado:"
cat inventory.csv | column -t -s,
```

### Paso 1.2: Analizar Origen via API

```bash
# ¿QUÉ VAMOS A HACER?: Obtener datos reales del origen
# ¿POR QUÉ?: Validar y completar el inventario
# ¿PARA QUÉ SIRVE?: Datos precisos para planificación

SOURCE_ORG="old-org"

echo "repo,size_kb,branches,open_issues,visibility" > inventory-real.csv

gh api "orgs/${SOURCE_ORG}/repos" --paginate --jq -r '
  .[] | [.name, .size, (.default_branch // "main"), .open_issues_count, .visibility] | @csv
' >> inventory-real.csv

echo "Repos encontrados: $(wc -l < inventory-real.csv)"
cat inventory-real.csv | column -t -s,
```

---

## 📋 Parte 2: Plan de Migración (15 min)

### Paso 2.1: Crear Checklist

```bash
# ¿QUÉ VAMOS A HACER?: Documentar plan de migración
# ¿POR QUÉ?: Proceso estructurado reduce errores
# ¿PARA QUÉ SIRVE?: Guía durante la ejecución

cat > migration-plan.md << 'EOF'
# Migration Plan

## Overview
- **Source**: github.com/old-org
- **Target**: github.com/new-org
- **Total Repos**: 5
- **Estimated Time**: 4 hours
- **Migration Window**: Saturday 2:00 AM - 6:00 AM

## Pre-Migration Checklist

### Week Before
- [ ] Notify all developers about migration window
- [ ] Create target organization
- [ ] Configure SSO/SAML if needed
- [ ] Create teams structure
- [ ] Test with non-critical repo

### Day Before
- [ ] Verify all tokens have correct permissions
- [ ] Test GEI installation
- [ ] Prepare rollback plan
- [ ] Confirm communication channels

### Migration Day
- [ ] Announce code freeze
- [ ] Disable CI/CD in source
- [ ] Take final backup of source
- [ ] Execute migration scripts
- [ ] Validate each repo
- [ ] Update CI/CD configurations
- [ ] Announce completion

## Repos by Priority

### High Priority (First)
1. api-backend - Core service
2. web-frontend - Customer facing

### Medium Priority
3. mobile-app - Native apps

### Low Priority (Last)
4. docs - Documentation
5. legacy-tool - Archive candidate

## Rollback Plan
1. Keep source repos read-only for 30 days
2. Maintain backup of metadata exports
3. Document issues during migration
EOF

cat migration-plan.md
```

### Paso 2.2: Generar Script de Migración

```bash
# ¿QUÉ VAMOS A HACER?: Crear script automatizado
# ¿POR QUÉ?: Reducir errores manuales
# ¿PARA QUÉ SIRVE?: Migración reproducible

cat > migrate.sh << 'EOF'
#!/bin/bash
# GitHub Migration Script
set -e

SOURCE_ORG="old-org"
TARGET_ORG="new-org"
LOG_FILE="migration-$(date +%Y%m%d-%H%M%S).log"

log() {
  echo "[$(date +%H:%M:%S)] $1" | tee -a "$LOG_FILE"
}

migrate_repo() {
  local repo=$1
  log "Starting migration: $repo"
  
  # Usando GEI
  gh gei migrate-repo \
    --github-source-org "$SOURCE_ORG" \
    --source-repo "$repo" \
    --github-target-org "$TARGET_ORG" \
    --target-repo "$repo" \
    --github-source-pat "$GH_SOURCE_PAT" \
    --github-target-pat "$GH_TARGET_PAT" \
    2>&1 | tee -a "$LOG_FILE"
  
  log "Completed: $repo"
}

# Verificar tokens
if [ -z "$GH_SOURCE_PAT" ] || [ -z "$GH_TARGET_PAT" ]; then
  echo "Error: Set GH_SOURCE_PAT and GH_TARGET_PAT"
  exit 1
fi

log "=== Migration Started ==="

# Migrar en orden de prioridad
for repo in api-backend web-frontend mobile-app docs legacy-tool; do
  migrate_repo "$repo"
  sleep 10  # Pausa entre repos
done

log "=== Migration Complete ==="
EOF

chmod +x migrate.sh
echo "Script created: migrate.sh"
```

---

## ✅ Parte 3: Validación (10 min)

### Paso 3.1: Script de Validación

```bash
# ¿QUÉ VAMOS A HACER?: Verificar migración exitosa
# ¿POR QUÉ?: Confirmar integridad de datos
# ¿PARA QUÉ SIRVE?: Detectar problemas antes de anunciar

cat > validate.sh << 'EOF'
#!/bin/bash
# Post-Migration Validation

SOURCE_ORG="old-org"
TARGET_ORG="new-org"
REPO=$1

echo "=== Validating: $REPO ==="

# Comparar commits
echo -n "Commits: "
SRC=$(gh api "repos/${SOURCE_ORG}/${REPO}/commits?per_page=1" -i 2>/dev/null | grep -i "x-total-count" | cut -d: -f2 | tr -d ' ' || echo "0")
TGT=$(gh api "repos/${TARGET_ORG}/${REPO}/commits?per_page=1" -i 2>/dev/null | grep -i "x-total-count" | cut -d: -f2 | tr -d ' ' || echo "0")
[ "$SRC" = "$TGT" ] && echo "✅ Match ($SRC)" || echo "❌ Mismatch (src:$SRC tgt:$TGT)"

# Comparar branches
echo -n "Branches: "
SRC=$(gh api "repos/${SOURCE_ORG}/${REPO}/branches" --jq 'length' 2>/dev/null || echo "0")
TGT=$(gh api "repos/${TARGET_ORG}/${REPO}/branches" --jq 'length' 2>/dev/null || echo "0")
[ "$SRC" = "$TGT" ] && echo "✅ Match ($SRC)" || echo "❌ Mismatch (src:$SRC tgt:$TGT)"

# Comparar issues
echo -n "Issues: "
SRC=$(gh api "repos/${SOURCE_ORG}/${REPO}/issues?state=all" --jq 'length' 2>/dev/null || echo "0")
TGT=$(gh api "repos/${TARGET_ORG}/${REPO}/issues?state=all" --jq 'length' 2>/dev/null || echo "0")
[ "$SRC" = "$TGT" ] && echo "✅ Match ($SRC)" || echo "❌ Mismatch (src:$SRC tgt:$TGT)"

echo ""
EOF

chmod +x validate.sh
echo "Validator created: validate.sh"
echo ""
echo "Usage: ./validate.sh REPO_NAME"
```

### Paso 3.2: Checklist Post-Migración

```bash
# ¿QUÉ VAMOS A HACER?: Crear checklist de verificación
# ¿POR QUÉ?: Asegurar que nada se olvide
# ¿PARA QUÉ SIRVE?: Calidad del proceso

cat > post-migration-checklist.md << 'EOF'
# Post-Migration Checklist

## Per Repository
- [ ] Commits count matches
- [ ] All branches present
- [ ] Tags migrated
- [ ] Issues and PRs present
- [ ] Wiki content (if applicable)
- [ ] Releases with assets

## Organization Level
- [ ] Team permissions configured
- [ ] Branch protection rules applied
- [ ] Secrets migrated (manual)
- [ ] Webhooks reconfigured
- [ ] CI/CD pipelines updated

## Communication
- [ ] Update documentation with new URLs
- [ ] Notify developers
- [ ] Update bookmarks/links
- [ ] Archive source repos (read-only)

## Sign-off
- [ ] QA validation complete
- [ ] Security review complete
- [ ] Management approval
EOF

cat post-migration-checklist.md
```

---

## ✅ Entregables

1. **Archivo** `inventory.csv` con repos a migrar
2. **Documento** `migration-plan.md` completo
3. **Script** `migrate.sh` funcional
4. **Script** `validate.sh` para verificación

---

## 📝 Preguntas de Reflexión

1. ¿Qué harías si la migración falla a mitad del proceso?
2. ¿Cómo manejarías repos con más de 10GB?
3. ¿Cuánto tiempo de freeze de código es aceptable?

---

## 🔗 Recursos

- [GitHub Enterprise Importer](https://docs.github.com/en/migrations/using-github-enterprise-importer)
- [Migration Best Practices](https://docs.github.com/en/migrations/overview/planning-your-migration-to-github)

---

**Siguiente**: [Ejercicio 04 - Backup Strategy](../ejercicio-04-backup/README.md)
