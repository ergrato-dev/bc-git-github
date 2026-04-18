#!/bin/bash

# SCRIPT: Remover Auto-commits Cron Job
# ¿QUÉ HACE?: Remueve el cron job de auto-commits del sistema
# ¿POR QUÉ?: Para detener los commits automáticos cuando no sean necesarios
# ¿PARA QUÉ SIRVE?: Limpiar la configuración de cron al finalizar el desarrollo

echo "🛑 Remover Auto-commits del Bootcamp Git/GitHub"
echo "=============================================="
echo ""

# Mostrar crontab actual
echo "📅 Cron jobs actuales:"
if crontab -l 2>/dev/null | grep -q auto-commit.sh; then
    crontab -l | grep -n auto-commit.sh
    echo ""
    
    read -p "¿Deseas remover el cron job de auto-commits? (y/N): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Crear backup antes de modificar
        BACKUP_FILE="/tmp/crontab_backup_removal_$(date +%Y%m%d_%H%M%S)"
        echo "💾 Creando backup en: $BACKUP_FILE"
        crontab -l > "$BACKUP_FILE"
        
        # Remover líneas que contengan auto-commit.sh
        crontab -l | grep -v auto-commit.sh | crontab -
        
        echo "✅ Cron job removido exitosamente!"
        echo ""
        echo "📋 Crontab actualizado:"
        crontab -l 2>/dev/null || echo "   (No hay cron jobs configurados)"
        
    else
        echo "❌ Operación cancelada"
    fi
    
else
    echo "   (No se encontró cron job de auto-commits)"
    echo ""
    echo "ℹ️  Si hay otros cron jobs configurados:"
    crontab -l 2>/dev/null || echo "   (No hay cron jobs configurados)"
fi

echo ""
echo "🛠️  Comandos útiles:"
echo "   • Ver todos los cron jobs: crontab -l"
echo "   • Editar cron jobs: crontab -e" 
echo "   • Remover todos los cron jobs: crontab -r"
