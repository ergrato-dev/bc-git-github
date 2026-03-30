# Ejercicio 01: Audit Log Analysis

## 🎯 Objetivo

Aprender a consultar, filtrar y analizar audit logs para detectar actividad sospechosa y cumplir con requisitos de compliance.

**Duración**: 40 minutos

---

## 📋 Contexto

Como administrador de GitHub Enterprise, necesitas:
- Monitorear accesos no autorizados
- Generar reportes de compliance
- Detectar patrones de actividad sospechosa
- Configurar alertas de seguridad

---

## 🔧 Parte 1: Consultas Básicas (15 min)

### Paso 1.1: Explorar Audit Log UI

```bash
# EJERCICIO: Navegar al audit log de tu organización
# ¿QUÉ VAMOS A HACER?: Acceder al audit log desde la UI
# ¿POR QUÉ?: Familiarizarse con la interfaz
# ¿PARA QUÉ SIRVE?: Entender qué información está disponible

# Navega a:
# https://github.com/organizations/TU-ORG/settings/audit-log
```

### Paso 1.2: Filtros Básicos UI

```yaml
# Probar estos filtros en la UI:

# Ver eventos de hoy
created:>=2024-01-15

# Ver solo eventos de repos
action:repo.*

# Ver acciones de un usuario específico
actor:username

# Combinar filtros
action:repo.create created:>=2024-01-01
```

### Paso 1.3: Query via API

```bash
# ¿QUÉ VAMOS A HACER?: Consultar audit log via API
# ¿POR QUÉ?: Automatizar análisis
# ¿PARA QUÉ SIRVE?: Integrar con scripts y SIEM

# Obtener eventos recientes (requiere org admin)
gh api \
  -H "Accept: application/vnd.github+json" \
  "orgs/TU-ORG/audit-log?per_page=10" \
  --jq '.[] | {action, actor, created_at}'

# Resultado esperado:
# {
#   "action": "repo.create",
#   "actor": "username",
#   "created_at": "2024-01-15T10:30:00Z"
# }
```

---

## 🔍 Parte 2: Análisis de Seguridad (15 min)

### Paso 2.1: Detectar Accesos Fallidos

```bash
# ¿QUÉ VAMOS A HACER?: Buscar intentos de login fallidos
# ¿POR QUÉ?: Detectar posibles ataques de fuerza bruta
# ¿PARA QUÉ SIRVE?: Seguridad proactiva

# Filtrar eventos de autenticación fallida
gh api "orgs/TU-ORG/audit-log?phrase=action:oauth_authorization.create" \
  --paginate --jq '.[] | select(.action | contains("fail"))'

# Query UI alternativo:
# action:org.oauth_app_access_denied
```

### Paso 2.2: Cambios en Permisos

```bash
# ¿QUÉ VAMOS A HACER?: Detectar cambios de permisos
# ¿POR QUÉ?: Los cambios de permisos pueden indicar compromiso
# ¿PARA QUÉ SIRVE?: Auditoría de accesos

# Buscar cambios en teams
gh api "orgs/TU-ORG/audit-log" \
  --paginate \
  --jq '.[] | select(.action | startswith("team.")) | {action, actor, created_at, team}'

# Buscar cambios en branch protection
gh api "orgs/TU-ORG/audit-log" \
  --paginate \
  --jq '.[] | select(.action | contains("protected_branch")) | {action, actor, repo}'
```

### Paso 2.3: Creación de PATs

```bash
# ¿QUÉ VAMOS A HACER?: Auditar creación de tokens
# ¿POR QUÉ?: PATs son vectores de ataque comunes
# ¿PARA QUÉ SIRVE?: Control de acceso

# Buscar creación de tokens (Enterprise feature)
# Query UI:
# action:personal_access_token.create

# Via API (si disponible):
gh api "orgs/TU-ORG/audit-log?phrase=personal_access_token" \
  --paginate --jq '.[] | {actor, action, created_at}'
```

---

## 📊 Parte 3: Generar Reporte (10 min)

### Paso 3.1: Script de Reporte Semanal

```bash
#!/bin/bash
# audit-report.sh
# ¿QUÉ VAMOS A HACER?: Generar reporte semanal de actividad
# ¿POR QUÉ?: Compliance requiere reportes periódicos
# ¿PARA QUÉ SIRVE?: Documentar actividad para auditorías

ORG="TU-ORG"
WEEK_AGO=$(date -d "7 days ago" +%Y-%m-%d)

echo "# Weekly Audit Report"
echo "Organization: ${ORG}"
echo "Period: ${WEEK_AGO} to $(date +%Y-%m-%d)"
echo ""

# Resumen por tipo de acción
echo "## Activity Summary"
gh api "orgs/${ORG}/audit-log?phrase=created:>=${WEEK_AGO}" \
  --paginate \
  --jq '.[].action' | sort | uniq -c | sort -rn | head -10

# Usuarios más activos
echo ""
echo "## Most Active Users"
gh api "orgs/${ORG}/audit-log?phrase=created:>=${WEEK_AGO}" \
  --paginate \
  --jq '.[].actor' | sort | uniq -c | sort -rn | head -5

# Eventos de seguridad
echo ""
echo "## Security Events"
gh api "orgs/${ORG}/audit-log?phrase=created:>=${WEEK_AGO}" \
  --paginate \
  --jq '.[] | select(.action | test("protected|permission|member|secret")) | {action, actor, created_at}'
```

### Paso 3.2: Exportar a CSV

```bash
# ¿QUÉ VAMOS A HACER?: Exportar audit log a CSV
# ¿POR QUÉ?: Formato común para análisis en Excel/Sheets
# ¿PARA QUÉ SIRVE?: Compartir con equipos de compliance

ORG="TU-ORG"

echo "timestamp,actor,action,repo,ip" > audit-export.csv

gh api "orgs/${ORG}/audit-log?per_page=100" \
  --paginate \
  --jq -r '.[] | [.created_at, .actor, .action, .repo, .actor_ip] | @csv' \
  >> audit-export.csv

echo "Exported to audit-export.csv"
wc -l audit-export.csv
```

---

## ✅ Entregables

1. **Screenshot** del audit log UI con filtros aplicados
2. **Archivo** `audit-report.sh` funcional
3. **CSV** con al menos 50 eventos exportados
4. **Documento** con 3 hallazgos de seguridad identificados

---

## 📝 Preguntas de Reflexión

1. ¿Qué eventos consideras más críticos para monitorear?
2. ¿Con qué frecuencia deberían revisarse los audit logs?
3. ¿Cómo integrarías estos datos con un SIEM?

---

## 🔗 Recursos

- [Audit Log Documentation](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-settings-for-your-organization/reviewing-the-audit-log-for-your-organization)
- [Audit Log Events](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-settings-for-your-organization/audit-log-events-for-your-organization)

---

**Siguiente**: [Ejercicio 02 - API Automation](../ejercicio-02-api-automation/README.md)
