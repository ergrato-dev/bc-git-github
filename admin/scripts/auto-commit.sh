#!/bin/bash

# SCRIPT: Auto-commit con Conventional Commits
# ¿QUÉ HACE?: Automatiza commits cada 5 minutos usando Conventional Commits
# ¿POR QUÉ?: Para mantener un historial consistente durante el desarrollo del bootcamp
# ¿PARA QUÉ SIRVE?: Guardar progreso automáticamente y demostrar buenas prácticas de commits

# Configuración
REPO_DIR="/home/epti/Documentos/epti-dev/bc-channel/bc-git-github"
LOG_FILE="$REPO_DIR/scripts/auto-commit.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Función para logging
log() {
    echo "[$DATE] $1" >> "$LOG_FILE"
}

# Cambiar al directorio del repository
cd "$REPO_DIR" || exit 1

# Verificar si hay cambios
if [ -z "$(git status --porcelain)" ]; then
    log "No changes detected - skipping commit"
    exit 0
fi

# Detectar tipo de cambios y generar mensaje de commit apropiado
CHANGES=$(git status --porcelain)
COMMIT_TYPE=""
COMMIT_SCOPE=""
COMMIT_MESSAGE=""

# Analizar tipos de cambios
if echo "$CHANGES" | grep -q "^A.*\.md$"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="docs"
    COMMIT_MESSAGE="add new documentation content"
elif echo "$CHANGES" | grep -q "^M.*\.md$"; then
    COMMIT_TYPE="docs"
    COMMIT_SCOPE="content"
    COMMIT_MESSAGE="update documentation content"
elif echo "$CHANGES" | grep -q "^A.*\.\(sh\|js\|py\)$"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="scripts"
    COMMIT_MESSAGE="add automation scripts"
elif echo "$CHANGES" | grep -q "^M.*\.\(sh\|js\|py\)$"; then
    COMMIT_TYPE="fix"
    COMMIT_SCOPE="scripts"
    COMMIT_MESSAGE="update automation scripts"
elif echo "$CHANGES" | grep -q "^A.*exercises/"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="exercises"
    COMMIT_MESSAGE="add new practice exercises"
elif echo "$CHANGES" | grep -q "^M.*exercises/"; then
    COMMIT_TYPE="docs"
    COMMIT_SCOPE="exercises"
    COMMIT_MESSAGE="update practice exercises"
elif echo "$CHANGES" | grep -q "^A.*resources/"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="resources"
    COMMIT_MESSAGE="add educational resources"
elif echo "$CHANGES" | grep -q "^M.*resources/"; then
    COMMIT_TYPE="docs"
    COMMIT_SCOPE="resources"
    COMMIT_MESSAGE="update educational resources"
else
    # Cambios generales
    COMMIT_TYPE="chore"
    COMMIT_SCOPE="content"
    COMMIT_MESSAGE="update bootcamp materials"
fi

# Construir mensaje de commit en formato Conventional Commits
FULL_MESSAGE="${COMMIT_TYPE}(${COMMIT_SCOPE}): ${COMMIT_MESSAGE}"

# Hacer staging de todos los cambios
git add .

# Crear commit con mensaje generado
git commit -m "$FULL_MESSAGE"

# Log del commit realizado
COMMIT_HASH=$(git rev-parse --short HEAD)
log "Commit created: $COMMIT_HASH - $FULL_MESSAGE"

# Opcional: hacer push automático (comentado por seguridad)
# git push origin main

echo "Auto-commit completed: $FULL_MESSAGE"
