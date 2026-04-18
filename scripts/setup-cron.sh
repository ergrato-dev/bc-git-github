#!/bin/bash

# SCRIPT: Configurador de Cron Job para Auto-commits
# ¿QUÉ HACE?: Configura un cron job para ejecutar commits automáticos cada 5 minutos
# ¿POR QUÉ?: Automatizar el proceso de commits durante el desarrollo del bootcamp
# ¿PARA QUÉ SIRVE?: Mantener un historial constante sin intervención manual

SCRIPT_PATH="/home/epti/Documents/epti-dev/bc-channel/bc-git-github/scripts/auto-commit.sh"
CRON_ENTRY="*/5 * * * * $SCRIPT_PATH >> /home/epti/Documents/epti-dev/bc-channel/bc-git-github/scripts/cron.log 2>&1"

echo "🚀 Configurando Auto-commits para Bootcamp Git/GitHub"
echo "=================================================="
echo ""
echo "📋 Configuración:"
echo "   • Frecuencia: Cada 5 minutos"
echo "   • Script: $SCRIPT_PATH"
echo "   • Formato: Conventional Commits en inglés"
echo ""

# Verificar si el script existe
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "❌ Error: Script auto-commit.sh no encontrado en $SCRIPT_PATH"
    exit 1
fi

# Verificar si el script es ejecutable
if [ ! -x "$SCRIPT_PATH" ]; then
    echo "🔧 Haciendo el script ejecutable..."
    chmod +x "$SCRIPT_PATH"
fi

# Mostrar crontab actual
echo "📅 Crontab actual:"
crontab -l 2>/dev/null || echo "   (No hay cron jobs configurados)"
echo ""

# Preguntar al usuario si quiere continuar
read -p "¿Deseas añadir el cron job para auto-commits cada 5 minutos? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Backup del crontab actual
    echo "💾 Creando backup del crontab actual..."
    BACKUP_FILE="/tmp/crontab_backup_$(date +%Y%m%d_%H%M%S)"
    crontab -l > "$BACKUP_FILE" 2>/dev/null || touch "$BACKUP_FILE"
    
    # Añadir nueva entrada al crontab
    (crontab -l 2>/dev/null; echo "$CRON_ENTRY") | crontab -
    
    echo "✅ Cron job añadido exitosamente!"
    echo ""
    echo "📋 Nueva configuración de crontab:"
    crontab -l
    echo ""
    echo "📝 El auto-commit iniciará en los próximos 5 minutos"
    echo "📄 Los logs se guardarán en: scripts/cron.log y scripts/auto-commit.log"
    
else
    echo "❌ Configuración cancelada"
    echo ""
    echo "📖 Para configurar manualmente, ejecuta:"
    echo "   crontab -e"
    echo ""
    echo "📝 Y añade esta línea:"
    echo "   $CRON_ENTRY"
fi

echo ""
echo "🛠️  Comandos útiles:"
echo "   • Ver cron jobs: crontab -l"
echo "   • Editar cron jobs: crontab -e"
echo "   • Remover todos los cron jobs: crontab -r"
echo "   • Ver logs: tail -f scripts/auto-commit.log"
echo "   • Testear script manualmente: ./scripts/auto-commit.sh"
