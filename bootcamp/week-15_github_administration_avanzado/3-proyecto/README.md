# 🚀 Proyecto Semanal: Enterprise Automation Suite

## 📋 Descripción

Desarrollar un conjunto de herramientas de automatización para administración enterprise de GitHub que integre audit logging, API automation, y backup management.

**Duración**: 120 minutos (2 horas)  
**Puntos**: 25 (25% de la evaluación semanal)

---

## 🎯 Objetivos

Al completar este proyecto serás capaz de:

- ✅ Crear scripts de administración production-ready
- ✅ Implementar monitoreo de seguridad automatizado
- ✅ Desarrollar soluciones de backup completas
- ✅ Documentar herramientas para uso enterprise

---

## 📦 Entregables

```
enterprise-automation-suite/
├── README.md                    # Documentación del proyecto
├── scripts/
│   ├── security-monitor.sh      # Monitor de eventos de seguridad
│   ├── compliance-report.sh     # Generador de reportes
│   ├── backup-orchestrator.sh   # Orquestador de backups
│   └── utils.sh                 # Funciones comunes
├── config/
│   ├── config.yaml              # Configuración principal
│   └── alerts.yaml              # Reglas de alertas
├── docs/
│   ├── SETUP.md                 # Guía de instalación
│   ├── USAGE.md                 # Manual de uso
│   └── RUNBOOK.md               # Procedimientos operativos
└── tests/
    └── test-suite.sh            # Tests automatizados
```

---

## 🔧 Requisitos Técnicos

### Parte 1: Security Monitor (40 min)

Crear `scripts/security-monitor.sh`:

```bash
#!/bin/bash
# Security Monitor - Detecta eventos críticos de seguridad

# Requisitos:
# 1. Consultar audit log cada X minutos
# 2. Filtrar eventos de seguridad críticos:
#    - Cambios en branch protection
#    - Nuevos admins agregados
#    - Repos públicos creados
#    - Secrets expuestos
# 3. Enviar alertas (log, email, o webhook)
# 4. Mantener estado para evitar alertas duplicadas

# Eventos a monitorear:
SECURITY_EVENTS=(
  "protected_branch.policy_override"
  "org.add_member"
  "repo.access"
  "team.add_member"
  "org.update_member"
)
```

**Criterios de evaluación:**
- [ ] Detecta al menos 5 tipos de eventos
- [ ] No genera alertas duplicadas
- [ ] Logs con timestamps
- [ ] Manejo de errores

### Parte 2: Compliance Report (40 min)

Crear `scripts/compliance-report.sh`:

```bash
#!/bin/bash
# Compliance Report Generator

# Requisitos:
# 1. Generar reporte en formato Markdown
# 2. Incluir secciones:
#    - Resumen ejecutivo
#    - Repos sin branch protection
#    - Usuarios con permisos admin
#    - Actividad de últimos 30 días
#    - Repos públicos (si aplica)
# 3. Exportar también en CSV
# 4. Calcular métricas de compliance
```

**Criterios de evaluación:**
- [ ] Reporte Markdown bien formateado
- [ ] CSV con datos exportables
- [ ] Métricas calculadas correctamente
- [ ] Identificación de problemas

### Parte 3: Backup Orchestrator (40 min)

Crear `scripts/backup-orchestrator.sh`:

```bash
#!/bin/bash
# Backup Orchestrator - Gestión completa de backups

# Requisitos:
# 1. Backup incremental de mirrors
# 2. Export de metadata
# 3. Compresión y rotación
# 4. Validación de integridad
# 5. Notificación de resultados
# 6. Soporte para múltiples destinos (local, S3)
```

**Criterios de evaluación:**
- [ ] Backups incrementales funcionan
- [ ] Metadata exportada completamente
- [ ] Validación de integridad
- [ ] Rotación automática

---

## 📝 Documentación Requerida

### README.md del proyecto

```markdown
# Enterprise Automation Suite

## Overview
[Descripción del proyecto]

## Features
- Security monitoring
- Compliance reporting  
- Automated backups

## Quick Start
[Pasos para comenzar]

## Configuration
[Variables de entorno requeridas]

## Architecture
[Diagrama o descripción]
```

### RUNBOOK.md

```markdown
# Operations Runbook

## Daily Operations
- [ ] Verificar logs de security monitor
- [ ] Revisar alertas pendientes

## Weekly Operations
- [ ] Generar compliance report
- [ ] Revisar métricas

## Monthly Operations
- [ ] Test de restore de backups
- [ ] Actualizar documentación

## Incident Response
### Security Alert
1. [Pasos a seguir]

### Backup Failure
1. [Pasos a seguir]
```

---

## ✅ Rúbrica de Evaluación

| Criterio | Puntos |
|----------|--------|
| Security Monitor funcional | 8 |
| Compliance Report completo | 7 |
| Backup Orchestrator | 5 |
| Documentación | 3 |
| Tests automatizados | 2 |
| **Total** | **25** |

---

## 💡 Consejos

1. **Empieza simple**: Haz que funcione primero, luego mejora
2. **Reutiliza código**: Crea `utils.sh` con funciones comunes
3. **Testea incrementalmente**: Prueba cada parte antes de integrar
4. **Documenta mientras desarrollas**: No dejes la documentación para el final

---

## 🔗 Recursos

- [Bash Best Practices](https://google.github.io/styleguide/shellguide.html)
- [GitHub API Reference](https://docs.github.com/en/rest)
- [jq Manual](https://stedolan.github.io/jq/manual/)

---

## 📤 Entrega

1. Crear repositorio `enterprise-automation-suite`
2. Implementar todos los scripts
3. Documentar en README.md
4. Agregar tests básicos
5. Compartir URL del repositorio

---

**Fecha límite**: Fin de la semana 15
