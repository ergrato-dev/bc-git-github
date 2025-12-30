# Ejercicio 02: API Automation

## 🎯 Objetivo

Automatizar tareas administrativas de GitHub usando REST API y GraphQL para gestión eficiente de organizaciones.

**Duración**: 40 minutos

---

## 📋 Contexto

Como administrador, necesitas automatizar:
- Reportes de actividad de repos
- Gestión masiva de permisos
- Aplicación de políticas de seguridad
- Limpieza de recursos inactivos

---

## 🔧 Parte 1: REST API Básico (15 min)

### Paso 1.1: Listar Repos de la Organización

```bash
# ¿QUÉ VAMOS A HACER?: Obtener lista de todos los repos
# ¿POR QUÉ?: Base para cualquier automatización
# ¿PARA QUÉ SIRVE?: Inventario de assets

ORG="TU-ORG"

# Listar repos con info básica
gh api "orgs/${ORG}/repos" \
  --paginate \
  --jq '.[] | {name, visibility, updated_at, size}' | head -20

# Guardar lista completa
gh api "orgs/${ORG}/repos" --paginate > repos.json
echo "Total repos: $(jq length repos.json)"
```

### Paso 1.2: Encontrar Repos Inactivos

```bash
# ¿QUÉ VAMOS A HACER?: Identificar repos sin actividad
# ¿POR QUÉ?: Repos abandonados consumen recursos
# ¿PARA QUÉ SIRVE?: Limpieza y organización

ORG="TU-ORG"
INACTIVE_DAYS=180
CUTOFF_DATE=$(date -d "${INACTIVE_DAYS} days ago" +%Y-%m-%dT%H:%M:%SZ)

echo "# Repos inactivos (>${INACTIVE_DAYS} días)"
echo ""

gh api "orgs/${ORG}/repos" --paginate --jq --arg cutoff "$CUTOFF_DATE" '
  .[] | select(.pushed_at < $cutoff) | 
  {name, pushed_at, visibility, size}
' | jq -s 'sort_by(.pushed_at)'

# Resultado esperado: Lista de repos sin push en 180+ días
```

### Paso 1.3: Reporte de Tamaño

```bash
# ¿QUÉ VAMOS A HACER?: Calcular uso de storage
# ¿POR QUÉ?: Monitorear costos y límites
# ¿PARA QUÉ SIRVE?: Capacity planning

ORG="TU-ORG"

echo "# Storage Report"
echo ""

# Top 10 repos por tamaño
gh api "orgs/${ORG}/repos" --paginate --jq '
  sort_by(.size) | reverse | .[0:10] | 
  .[] | "\(.size/1024 | floor) MB - \(.name)"
'

# Total
TOTAL_KB=$(gh api "orgs/${ORG}/repos" --paginate --jq '[.[].size] | add')
echo ""
echo "Total: $((TOTAL_KB/1024)) MB ($((TOTAL_KB/1024/1024)) GB)"
```

---

## 🔄 Parte 2: GraphQL Avanzado (15 min)

### Paso 2.1: Query de Branch Protection

```bash
# ¿QUÉ VAMOS A HACER?: Auditar branch protection rules
# ¿POR QUÉ?: Verificar cumplimiento de políticas
# ¿PARA QUÉ SIRVE?: Security compliance

# Crear archivo de query
cat > query-protection.graphql << 'EOF'
query($org: String!, $cursor: String) {
  organization(login: $org) {
    repositories(first: 20, after: $cursor) {
      pageInfo {
        hasNextPage
        endCursor
      }
      nodes {
        name
        branchProtectionRules(first: 5) {
          nodes {
            pattern
            requiresApprovingReviews
            requiredApprovingReviewCount
            requiresStatusChecks
            isAdminEnforced
          }
        }
      }
    }
  }
}
EOF

# Ejecutar query
gh api graphql -F org="TU-ORG" -f query="$(cat query-protection.graphql)" \
  --jq '.data.organization.repositories.nodes[] | 
    select(.branchProtectionRules.nodes | length > 0) | 
    {name, rules: .branchProtectionRules.nodes}'
```

### Paso 2.2: Mutation - Actualizar Descripción

```bash
# ¿QUÉ VAMOS A HACER?: Actualizar repo via GraphQL mutation
# ¿POR QUÉ?: GraphQL permite updates más precisos
# ¿PARA QUÉ SIRVE?: Automatizar cambios masivos

# Primero obtener el ID del repo
REPO_ID=$(gh api graphql -f query='
  query($owner: String!, $name: String!) {
    repository(owner: $owner, name: $name) {
      id
    }
  }
' -F owner="TU-ORG" -F name="REPO-NAME" --jq '.data.repository.id')

# Ejecutar mutation
gh api graphql -f query='
  mutation($id: ID!, $desc: String!) {
    updateRepository(input: {repositoryId: $id, description: $desc}) {
      repository {
        name
        description
      }
    }
  }
' -F id="$REPO_ID" -F desc="Updated via API automation"
```

---

## 📊 Parte 3: Script de Automatización (10 min)

### Paso 3.1: Bulk Branch Protection

```bash
#!/bin/bash
# bulk-protection.sh
# ¿QUÉ VAMOS A HACER?: Aplicar branch protection a múltiples repos
# ¿POR QUÉ?: Enforcement de políticas de seguridad
# ¿PARA QUÉ SIRVE?: Compliance automatizado

ORG="TU-ORG"
BRANCH="main"

# Configuración de protección estándar
PROTECTION_CONFIG='{
  "required_status_checks": {
    "strict": true,
    "contexts": ["ci/build"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true
  },
  "restrictions": null
}'

# Obtener repos sin protección
echo "Checking repos without branch protection..."

gh api "orgs/${ORG}/repos" --paginate --jq '.[].name' | while read repo; do
  # Verificar si tiene protección
  if ! gh api "repos/${ORG}/${repo}/branches/${BRANCH}/protection" 2>/dev/null; then
    echo "Applying protection to: ${repo}"
    
    gh api \
      --method PUT \
      "repos/${ORG}/${repo}/branches/${BRANCH}/protection" \
      --input - <<< "$PROTECTION_CONFIG"
    
    echo "  ✅ Done"
  else
    echo "  ⏭️ ${repo} already protected"
  fi
done
```

### Paso 3.2: Permission Report

```bash
#!/bin/bash
# permission-report.sh
# ¿QUÉ VAMOS A HACER?: Generar reporte de permisos por usuario
# ¿POR QUÉ?: Auditoría de accesos
# ¿PARA QUÉ SIRVE?: Security review y compliance

ORG="TU-ORG"

echo "# Permission Report for ${ORG}"
echo "Generated: $(date)"
echo ""

# Por cada miembro
gh api "orgs/${ORG}/members" --paginate --jq '.[].login' | while read user; do
  echo "## User: ${user}"
  
  # Teams del usuario
  echo "### Teams:"
  gh api "orgs/${ORG}/teams" --paginate --jq '.[].slug' | while read team; do
    if gh api "orgs/${ORG}/teams/${team}/memberships/${user}" 2>/dev/null | jq -e '.state == "active"' >/dev/null; then
      ROLE=$(gh api "orgs/${ORG}/teams/${team}/memberships/${user}" --jq '.role')
      echo "  - ${team} (${ROLE})"
    fi
  done
  
  # Repos con acceso directo
  echo "### Direct repo access:"
  gh api "orgs/${ORG}/repos" --paginate --jq '.[].name' | head -5 | while read repo; do
    PERM=$(gh api "repos/${ORG}/${repo}/collaborators/${user}/permission" 2>/dev/null --jq '.permission' || echo "none")
    if [ "$PERM" != "none" ]; then
      echo "  - ${repo}: ${PERM}"
    fi
  done
  
  echo ""
done
```

---

## ✅ Entregables

1. **Script** `inactive-repos.sh` que liste repos inactivos
2. **Query GraphQL** para auditar branch protection
3. **Script** `bulk-protection.sh` funcional
4. **Reporte CSV** de permisos de al menos 5 usuarios

---

## 📝 Preguntas de Reflexión

1. ¿Cuándo es mejor usar REST vs GraphQL?
2. ¿Cómo manejarías rate limits en scripts masivos?
3. ¿Qué medidas de seguridad aplicarías a estos scripts?

---

## 🔗 Recursos

- [GitHub REST API](https://docs.github.com/en/rest)
- [GitHub GraphQL API](https://docs.github.com/en/graphql)
- [GraphQL Explorer](https://docs.github.com/en/graphql/overview/explorer)

---

**Siguiente**: [Ejercicio 03 - Migration Planning](../ejercicio-03-migration/README.md)
