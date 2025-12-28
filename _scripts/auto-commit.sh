#!/bin/bash

# SCRIPT: Auto-commit con Conventional Commits
# ¿QUÉ HACE?: Automatiza commits cada 5 minutos usando Conventional Commits
# ¿POR QUÉ?: Para mantener un historial consistente durante el desarrollo del bootcamp
# ¿PARA QUÉ SIRVE?: Guardar progreso automáticamente y demostrar buenas prácticas de commits
#
# ═══════════════════════════════════════════════════════════════════════════════
# FORMATO DE COMMITS
# ═══════════════════════════════════════════════════════════════════════════════
# 
# ESTÁNDAR: Conventional Commits (https://www.conventionalcommits.org/)
# IDIOMA: Inglés
#
# ESTRUCTURA DEL MENSAJE:
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ type(scope): what - for - impact                                           │
# └─────────────────────────────────────────────────────────────────────────────┘
#
# COMPONENTES:
#   • WHAT?   → ¿Qué se hizo? (acción concreta)
#   • FOR?    → ¿Para qué? (objetivo o propósito)  
#   • IMPACT? → ¿Qué impacto tiene? (beneficio o resultado)
#
# EJEMPLOS:
#   feat(docs): add git branching lesson - for week-03 curriculum - enables hands-on practice
#   fix(exercises): correct typo in exercise-02 - for clarity - improves student experience
#   docs(readme): update installation steps - for linux users - reduces setup friction
#
# ═══════════════════════════════════════════════════════════════════════════════

# Configuración
REPO_DIR="/home/epti/Documents/epti-dev/bc-channel/bc-git-github"
LOG_FILE="$REPO_DIR/_scripts/auto-commit.log"
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

# Analizar tipos de cambios y generar mensaje con formato: what - for - impact
if echo "$CHANGES" | grep -q "^A.*\.md$"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="docs"
    COMMIT_MESSAGE="add new documentation content - for bootcamp curriculum - enhances learning materials"
elif echo "$CHANGES" | grep -q "^M.*\.md$"; then
    COMMIT_TYPE="docs"
    COMMIT_SCOPE="content"
    COMMIT_MESSAGE="update documentation content - for accuracy - ensures correct information"
elif echo "$CHANGES" | grep -q "^A.*\.\(sh\|js\|py\)$"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="scripts"
    COMMIT_MESSAGE="add automation scripts - for workflow optimization - improves development efficiency"
elif echo "$CHANGES" | grep -q "^M.*\.\(sh\|js\|py\)$"; then
    COMMIT_TYPE="fix"
    COMMIT_SCOPE="scripts"
    COMMIT_MESSAGE="update automation scripts - for reliability - ensures stable execution"
elif echo "$CHANGES" | grep -q "^A.*exercises/"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="exercises"
    COMMIT_MESSAGE="add new practice exercises - for hands-on learning - enables skill development"
elif echo "$CHANGES" | grep -q "^M.*exercises/"; then
    COMMIT_TYPE="docs"
    COMMIT_SCOPE="exercises"
    COMMIT_MESSAGE="update practice exercises - for clarity - improves student experience"
elif echo "$CHANGES" | grep -q "^A.*resources/"; then
    COMMIT_TYPE="feat"
    COMMIT_SCOPE="resources"
    COMMIT_MESSAGE="add educational resources - for reference materials - accelerates learning"
elif echo "$CHANGES" | grep -q "^M.*resources/"; then
    COMMIT_TYPE="docs"
    COMMIT_SCOPE="resources"
    COMMIT_MESSAGE="update educational resources - for relevance - maintains content quality"
else
    # Cambios generales
    COMMIT_TYPE="chore"
    COMMIT_SCOPE="content"
    COMMIT_MESSAGE="update bootcamp materials - for maintenance - keeps repository current"
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
