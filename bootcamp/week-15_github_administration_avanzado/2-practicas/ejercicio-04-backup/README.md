# Ejercicio 04: Backup Strategy

## 🎯 Objetivo

Implementar una estrategia de backup completa para una organización de GitHub, incluyendo código, metadata y automatización.

**Duración**: 35 minutos

---

## 📋 Contexto

Como administrador, necesitas implementar:
- Backup automático de repos
- Export de metadata (issues, PRs)
- Almacenamiento seguro
- Proceso de restauración

---

## 🔧 Parte 1: Backup de Código (15 min)

### Paso 1.1: Configurar Directorio

```bash
# ¿QUÉ VAMOS A HACER?: Crear estructura de backup
# ¿POR QUÉ?: Organización facilita recuperación
# ¿PARA QUÉ SIRVE?: Estructura consistente

# Crear estructura
BACKUP_ROOT="${HOME}/github-backups"
TODAY=$(date +%Y-%m-%d)

mkdir -p "${BACKUP_ROOT}/${TODAY}"/{mirrors,metadata,logs}

echo "Backup structure created:"
tree "${BACKUP_ROOT}/${TODAY}"
```

### Paso 1.2: Script de Mirror

```bash
# ¿QUÉ VAMOS A HACER?: Crear mirrors de repos
# ¿POR QUÉ?: Mirror captura toda la historia
# ¿PARA QUÉ SIRVE?: Backup completo del código

cat > backup-mirrors.sh << 'EOF'
#!/bin/bash
# Backup Git Mirrors

set -e

ORG="${1:-TU-ORG}"
BACKUP_DIR="${HOME}/github-backups/$(date +%Y-%m-%d)/mirrors"
LOG="${HOME}/github-backups/$(date +%Y-%m-%d)/logs/mirrors.log"

log() {
  echo "[$(date +%H:%M:%S)] $1" | tee -a "$LOG"
}

mkdir -p "$BACKUP_DIR"

log "Starting mirror backup for ${ORG}"

# Obtener lista de repos
REPOS=$(gh api "orgs/${ORG}/repos" --paginate --jq '.[].name')
TOTAL=$(echo "$REPOS" | wc -l)
COUNT=0

for repo in $REPOS; do
  COUNT=$((COUNT + 1))
  log "[$COUNT/$TOTAL] Backing up: $repo"
  
  MIRROR_PATH="${BACKUP_DIR}/${repo}.git"
  
  if [ -d "$MIRROR_PATH" ]; then
    # Update existing mirror
    cd "$MIRROR_PATH"
    git fetch --all --prune 2>&1 | tee -a "$LOG"
  else
    # Clone new mirror
    git clone --mirror "https://github.com/${ORG}/${repo}.git" "$MIRROR_PATH" 2>&1 | tee -a "$LOG"
  fi
done

log "Mirror backup complete: $COUNT repos"

# Calcular tamaño
SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
log "Total size: $SIZE"
EOF

chmod +x backup-mirrors.sh
echo "Created: backup-mirrors.sh"
```

### Paso 1.3: Ejecutar Backup

```bash
# ¿QUÉ VAMOS A HACER?: Ejecutar backup de prueba
# ¿POR QUÉ?: Verificar que el script funciona
# ¿PARA QUÉ SIRVE?: Validación antes de automatizar

# Ejecutar (usa tu org o una pública para prueba)
./backup-mirrors.sh TU-ORG

# Verificar resultado
ls -la "${HOME}/github-backups/$(date +%Y-%m-%d)/mirrors/"
```

---

## 📊 Parte 2: Backup de Metadata (10 min)

### Paso 2.1: Script de Metadata

```bash
# ¿QUÉ VAMOS A HACER?: Exportar issues, PRs, releases
# ¿POR QUÉ?: Metadata no está en git mirror
# ¿PARA QUÉ SIRVE?: Backup completo del proyecto

cat > backup-metadata.sh << 'EOF'
#!/bin/bash
# Backup Repository Metadata

set -e

ORG="${1:-TU-ORG}"
BACKUP_DIR="${HOME}/github-backups/$(date +%Y-%m-%d)/metadata"
LOG="${HOME}/github-backups/$(date +%Y-%m-%d)/logs/metadata.log"

log() {
  echo "[$(date +%H:%M:%S)] $1" | tee -a "$LOG"
}

mkdir -p "$BACKUP_DIR"

log "Starting metadata backup for ${ORG}"

# Backup org-level data
log "Exporting organization data..."
mkdir -p "${BACKUP_DIR}/_organization"

gh api "orgs/${ORG}" > "${BACKUP_DIR}/_organization/settings.json"
gh api "orgs/${ORG}/members" --paginate > "${BACKUP_DIR}/_organization/members.json"
gh api "orgs/${ORG}/teams" --paginate > "${BACKUP_DIR}/_organization/teams.json"

# Backup per-repo data
REPOS=$(gh api "orgs/${ORG}/repos" --paginate --jq '.[].name')

for repo in $REPOS; do
  log "Exporting metadata: $repo"
  REPO_DIR="${BACKUP_DIR}/${repo}"
  mkdir -p "$REPO_DIR"
  
  # Repository settings
  gh api "repos/${ORG}/${repo}" > "${REPO_DIR}/settings.json" 2>/dev/null || true
  
  # Issues (all states)
  gh api "repos/${ORG}/${repo}/issues?state=all" --paginate > "${REPO_DIR}/issues.json" 2>/dev/null || true
  
  # Pull requests
  gh api "repos/${ORG}/${repo}/pulls?state=all" --paginate > "${REPO_DIR}/pulls.json" 2>/dev/null || true
  
  # Releases
  gh api "repos/${ORG}/${repo}/releases" --paginate > "${REPO_DIR}/releases.json" 2>/dev/null || true
  
  # Branch protection (main)
  gh api "repos/${ORG}/${repo}/branches/main/protection" > "${REPO_DIR}/protection.json" 2>/dev/null || true
done

log "Metadata backup complete"

# Count files
FILES=$(find "$BACKUP_DIR" -name "*.json" | wc -l)
log "Total files: $FILES"
EOF

chmod +x backup-metadata.sh
echo "Created: backup-metadata.sh"
```

---

## ⏰ Parte 3: Automatización (10 min)

### Paso 3.1: Script Principal

```bash
# ¿QUÉ VAMOS A HACER?: Unificar backups en un script
# ¿POR QUÉ?: Simplificar ejecución
# ¿PARA QUÉ SIRVE?: Automatización con cron

cat > github-backup.sh << 'EOF'
#!/bin/bash
# Complete GitHub Backup Script

set -e

ORG="${1:-TU-ORG}"
BACKUP_ROOT="${HOME}/github-backups"
TODAY=$(date +%Y-%m-%d)
BACKUP_DIR="${BACKUP_ROOT}/${TODAY}"
RETENTION_DAYS=30

# Setup
mkdir -p "${BACKUP_DIR}"/{mirrors,metadata,logs}
LOG="${BACKUP_DIR}/logs/backup.log"

log() {
  echo "[$(date +%H:%M:%S)] $1" | tee -a "$LOG"
}

log "=========================================="
log "GitHub Backup Started"
log "Organization: ${ORG}"
log "Destination: ${BACKUP_DIR}"
log "=========================================="

# Phase 1: Mirrors
log ""
log "=== Phase 1: Git Mirrors ==="
./backup-mirrors.sh "$ORG"

# Phase 2: Metadata
log ""
log "=== Phase 2: Metadata ==="
./backup-metadata.sh "$ORG"

# Phase 3: Compress
log ""
log "=== Phase 3: Compression ==="
cd "$BACKUP_ROOT"
ARCHIVE="backup-${ORG}-${TODAY}.tar.gz"
tar -czf "$ARCHIVE" "$TODAY"
log "Created: $ARCHIVE ($(du -h $ARCHIVE | cut -f1))"

# Phase 4: Cleanup old backups
log ""
log "=== Phase 4: Cleanup ==="
find "$BACKUP_ROOT" -maxdepth 1 -type d -mtime +${RETENTION_DAYS} -exec rm -rf {} \;
find "$BACKUP_ROOT" -maxdepth 1 -name "*.tar.gz" -mtime +${RETENTION_DAYS} -delete
log "Removed backups older than ${RETENTION_DAYS} days"

# Summary
log ""
log "=========================================="
log "Backup Complete!"
log "Archive: ${BACKUP_ROOT}/${ARCHIVE}"
log "=========================================="
EOF

chmod +x github-backup.sh
echo "Created: github-backup.sh"
```

### Paso 3.2: Configurar Cron

```bash
# ¿QUÉ VAMOS A HACER?: Programar backup diario
# ¿POR QUÉ?: Backups deben ser automáticos
# ¿PARA QUÉ SIRVE?: Continuidad sin intervención manual

# Ver crontab actual
crontab -l 2>/dev/null || echo "No crontab configured"

# Agregar job de backup (ejecutar manualmente)
echo "# Para agregar a crontab, ejecuta: crontab -e"
echo "# Luego agrega esta línea:"
echo ""
echo "# Daily GitHub backup at 2 AM"
echo "0 2 * * * ${PWD}/github-backup.sh TU-ORG >> ${HOME}/github-backups/cron.log 2>&1"
```

### Paso 3.3: Script de Restauración

```bash
# ¿QUÉ VAMOS A HACER?: Crear script de restore
# ¿POR QUÉ?: Backup sin restore plan es inútil
# ¿PARA QUÉ SIRVE?: Disaster recovery

cat > restore-repo.sh << 'EOF'
#!/bin/bash
# Restore Repository from Backup

BACKUP_DIR=$1
REPO_NAME=$2
TARGET_ORG=$3

if [ -z "$BACKUP_DIR" ] || [ -z "$REPO_NAME" ] || [ -z "$TARGET_ORG" ]; then
  echo "Usage: $0 <backup_dir> <repo_name> <target_org>"
  exit 1
fi

MIRROR="${BACKUP_DIR}/mirrors/${REPO_NAME}.git"

if [ ! -d "$MIRROR" ]; then
  echo "Error: Mirror not found: $MIRROR"
  exit 1
fi

echo "=== Restoring: ${REPO_NAME} ==="

# Create new repo
echo "Creating repository..."
gh repo create "${TARGET_ORG}/${REPO_NAME}" --private || true

# Push from mirror
echo "Pushing code..."
cd "$MIRROR"
git push --mirror "https://github.com/${TARGET_ORG}/${REPO_NAME}.git"

# Verify
echo ""
echo "=== Verification ==="
gh repo view "${TARGET_ORG}/${REPO_NAME}"

echo ""
echo "✅ Restore complete!"
echo "Note: Issues/PRs must be restored separately from metadata JSON"
EOF

chmod +x restore-repo.sh
echo "Created: restore-repo.sh"
```

---

## ✅ Entregables

1. **Script** `backup-mirrors.sh` funcional
2. **Script** `backup-metadata.sh` funcional
3. **Script** `github-backup.sh` unificado
4. **Script** `restore-repo.sh` para recovery
5. **Cron entry** documentado

---

## 📝 Preguntas de Reflexión

1. ¿Dónde almacenarías los backups para máxima seguridad?
2. ¿Cómo verificarías que los backups son válidos?
3. ¿Qué RPO/RTO definirías para tu organización?

---

## 🔗 Recursos

- [Git Mirror Documentation](https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---mirror)
- [GitHub API Reference](https://docs.github.com/en/rest)
- [Backup Best Practices](https://docs.github.com/en/repositories/archiving-a-github-repository)

---

**Siguiente**: [Proyecto Semanal](../../3-proyecto/README.md)
