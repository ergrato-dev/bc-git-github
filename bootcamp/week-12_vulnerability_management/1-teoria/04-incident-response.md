# 📖 Lección 04: Incident Response

> **Duración**: 20 minutos
>
> **Objetivo**: Establecer un plan de respuesta a incidentes de seguridad.

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- ✅ Implementar las **6 fases** de incident response (NIST)
- ✅ Definir **roles y responsabilidades** del equipo
- ✅ Establecer **SLAs** de respuesta
- ✅ Conducir **post-mortems** efectivos

---

## 📊 Diagrama del Framework

![Incident Response](../0-assets/04-incident-response.svg)

---

## 🔄 NIST Incident Response Framework

El framework NIST SP 800-61 define 6 fases para respuesta a incidentes:

```
┌─────────────────────────────────────────────────────────┐
│                     PREPARATION                          │
│            (Antes de que ocurra el incidente)           │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│                      DETECTION                           │
│              (Identificar el incidente)                 │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│                    CONTAINMENT                           │
│               (Limitar el daño)                         │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│                    ERADICATION                           │
│              (Eliminar la amenaza)                      │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│                      RECOVERY                            │
│             (Restaurar operaciones)                     │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│                  LESSONS LEARNED                         │
│                   (Post-mortem)                         │
└─────────────────────────────────────────────────────────┘
```

---

## 1️⃣ Preparation (Preparación)

**Objetivo**: Estar listo antes de que ocurra un incidente.

### Equipo de Respuesta (CSIRT)

```yaml
# Computer Security Incident Response Team

Roles:
  Incident Commander:
    - Lidera la respuesta
    - Toma decisiones críticas
    - Comunica con stakeholders
  
  Technical Lead:
    - Dirige investigación técnica
    - Coordina el fix
    - Documenta hallazgos
  
  Communications Lead:
    - Comunicación interna
    - Comunicación externa
    - Coordina con legal/PR
  
  Operations:
    - Implementa cambios
    - Monitorea sistemas
    - Ejecuta runbooks
```

### Herramientas y Recursos

```markdown
## Herramientas Preparadas

- [ ] Sistema de alertas (PagerDuty, OpsGenie)
- [ ] Canal de comunicación de emergencia (Slack #security-incident)
- [ ] Acceso a logs centralizados
- [ ] Runbooks documentados
- [ ] Contactos de emergencia actualizados
- [ ] Acceso a ambientes de producción

## Documentación

- [ ] Playbooks por tipo de incidente
- [ ] Diagrama de arquitectura actualizado
- [ ] Inventario de activos críticos
- [ ] Lista de dependencias y proveedores
```

### Clasificación de Severidad

```yaml
# Definir antes de que ocurra

SEV1 - Critical:
  description: "Brecha activa, datos expuestos, servicio caído"
  response_time: "15 minutos"
  escalation: "Inmediata a C-level"
  example: "Exfiltración de datos de usuarios"

SEV2 - High:
  description: "Vulnerabilidad crítica explotable, sin evidencia de breach"
  response_time: "1 hora"
  escalation: "Director de Ingeniería"
  example: "CVE crítico en producción"

SEV3 - Medium:
  description: "Vulnerabilidad con mitigación disponible"
  response_time: "4 horas"
  escalation: "Tech Lead"
  example: "Dependabot alert high severity"

SEV4 - Low:
  description: "Vulnerabilidad de bajo riesgo"
  response_time: "24 horas"
  escalation: "Equipo regular"
  example: "Dependabot alert low severity"
```

---

## 2️⃣ Detection (Detección)

**Objetivo**: Identificar que un incidente está ocurriendo.

### Fuentes de Detección

```markdown
## Automatizadas
- GitHub Code Scanning alerts
- Dependabot security alerts
- Secret Scanning alerts
- Logs de aplicación (errores inusuales)
- Monitoreo de infraestructura
- IDS/IPS alerts
- WAF blocks

## Manuales
- Reportes de usuarios
- Security researchers
- Bug bounty submissions
- Auditorías internas
- Threat intelligence feeds
```

### Triage Inicial

```yaml
# Preguntas a responder inmediatamente

1. ¿Qué está pasando?
   - Descripción del evento

2. ¿Cuál es el impacto?
   - Sistemas afectados
   - Datos comprometidos
   - Usuarios impactados

3. ¿Cuándo empezó?
   - Timeline conocido

4. ¿Sigue activo?
   - ¿Hay explotación en curso?

5. ¿Cuál es la severidad?
   - SEV1/2/3/4
```

### Crear Incident Ticket

```markdown
# Incident: [SEV2] SQL Injection detectada en /api/users

## Status: 🔴 ACTIVE

## Timeline
- 2024-12-15 14:30 UTC: Alert de CodeQL
- 2024-12-15 14:35 UTC: Incident declarado
- 2024-12-15 14:40 UTC: Equipo convocado

## Impacto
- Endpoint afectado: /api/users
- Datos en riesgo: Tabla users

## Equipo
- IC: @alice
- Tech Lead: @bob
- Comms: @carol

## Actions
- [ ] Confirmar vulnerabilidad
- [ ] Revisar logs de acceso
- [ ] Implementar mitigación temporal
```

---

## 3️⃣ Containment (Contención)

**Objetivo**: Limitar el daño y prevenir propagación.

### Contención Inmediata

```bash
# Acciones comunes de contención

# 1. Deshabilitar endpoint vulnerable
# En nginx/Apache/Load Balancer
location /api/vulnerable {
    return 503;
}

# 2. Bloquear IPs sospechosas
iptables -A INPUT -s 192.168.1.100 -j DROP

# 3. Revocar tokens/credenciales comprometidas
# En GitHub
Settings → Developer settings → Revoke all tokens

# 4. Escalar privilegios requeridos temporalmente
# Activar MFA forzado, etc.
```

### Contención a Largo Plazo

```markdown
## Mientras se desarrolla el fix definitivo:

1. **Feature flag**: Deshabilitar feature vulnerable
2. **WAF rule**: Bloquear patrones de ataque
3. **Rate limiting**: Limitar requests al endpoint
4. **Monitoring aumentado**: Alertas adicionales
```

### Preservar Evidencia

```bash
# IMPORTANTE: Preservar evidencia para análisis

# 1. Snapshot de logs
aws logs create-export-task \
  --log-group-name /app/production \
  --from 1702648800000 \
  --to 1702735200000 \
  --destination incident-evidence-bucket

# 2. Snapshot de base de datos (si aplica)
# 3. Captura de memoria (sistemas comprometidos)
# 4. Network captures
```

---

## 4️⃣ Eradication (Erradicación)

**Objetivo**: Eliminar la causa raíz.

### Desarrollo del Fix

```markdown
## Proceso de Fix

1. Crear Security Advisory (draft)
2. Fork privado para desarrollo
3. Implementar fix
4. Code review por segundo ingeniero
5. Testing exhaustivo
   - Unit tests
   - Integration tests
   - Security regression tests
6. Preparar release
```

### Verificar Eliminación

```yaml
# Checklist de verificación

- [ ] Vulnerabilidad parcheada en código
- [ ] Tests de regresión pasan
- [ ] Scan de seguridad no detecta el issue
- [ ] Credenciales comprometidas rotadas
- [ ] Accesos no autorizados revocados
- [ ] Backdoors buscados y eliminados
```

---

## 5️⃣ Recovery (Recuperación)

**Objetivo**: Restaurar operaciones normales.

### Plan de Recuperación

```yaml
# Pasos de recuperación

1. Deploy del fix:
   - Deploy a staging
   - Validación funcional
   - Deploy a producción (gradual si es posible)

2. Restaurar servicios:
   - Re-habilitar endpoints
   - Remover reglas de WAF temporales
   - Restaurar rate limits normales

3. Verificación:
   - Monitoreo intensivo (24-72h)
   - Alertas adicionales activas
   - On-call aware del incidente

4. Comunicación:
   - Notificar que el incidente está resuelto
   - Status page actualizado
```

### Comunicación a Usuarios

```markdown
# Security Update

## Summary
On December 15, 2024, we identified and patched a security 
vulnerability in our user search API.

## What happened
A SQL injection vulnerability was discovered that could allow
unauthorized access to user data.

## What we did
- Immediately disabled the affected endpoint
- Developed and deployed a fix within 4 hours
- Conducted a full security review
- No evidence of exploitation was found

## What you should do
- No action required
- Your data was not accessed

## Questions?
Contact security@example.com
```

---

## 6️⃣ Lessons Learned (Post-Mortem)

**Objetivo**: Aprender y mejorar para el futuro.

### Template de Post-Mortem

```markdown
# Post-Mortem: SQL Injection en /api/users

**Date**: 2024-12-15
**Severity**: SEV2
**Duration**: 4 hours
**Author**: @security-team

---

## Executive Summary
[2-3 oraciones describiendo qué pasó y el impacto]

---

## Timeline (UTC)

| Time | Event |
|------|-------|
| 14:30 | CodeQL alert received |
| 14:35 | Incident declared (SEV2) |
| 14:40 | Team assembled |
| 14:45 | Vulnerability confirmed |
| 15:00 | Endpoint disabled (containment) |
| 16:30 | Fix developed and tested |
| 17:00 | Fix deployed |
| 18:00 | Monitoring confirmed resolution |
| 18:30 | Incident closed |

---

## Root Cause
La función de búsqueda concatenaba input del usuario directamente
en la query SQL sin sanitización.

```python
# Código vulnerable
query = f"SELECT * FROM users WHERE name = '{user_input}'"

# Fix aplicado
cursor.execute("SELECT * FROM users WHERE name = %s", (user_input,))
```

---

## Impact
- Duración: 4 horas
- Usuarios afectados: 0 (no hubo explotación)
- Datos comprometidos: Ninguno
- Revenue impact: $0

---

## What Went Well
- Alert de CodeQL detectó el issue
- Equipo respondió en <15 minutos
- Fix desarrollado rápidamente
- No hubo explotación real

---

## What Could Be Improved
- La vulnerabilidad estuvo en código por 3 meses
- No teníamos CodeQL configurado para este repo
- Falta de tests de seguridad automatizados

---

## Action Items

| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
| Enable CodeQL on all repos | @alice | 2024-12-22 | ⏳ |
| Add SQLi test cases | @bob | 2024-12-29 | ⏳ |
| Security training for team | @carol | 2025-01-15 | ⏳ |
| Update secure coding guide | @david | 2024-12-31 | ⏳ |

---

## Appendix
- [Security Advisory](link)
- [Fix PR](link)
- [Logs](link)
```

### Blameless Culture

```markdown
## Principios del Post-Mortem

✅ DO:
- Enfocarse en sistemas, no personas
- Preguntar "¿qué?" y "¿cómo?", no "¿quién?"
- Identificar mejoras sistémicas
- Compartir aprendizajes con el equipo
- Seguimiento de action items

❌ DON'T:
- Buscar culpables
- Castigar errores honestos
- Ocultar información
- Skip post-mortems "porque fue menor"
```

---

## 📋 Incident Response Checklist

```markdown
## Detection
- [ ] Incidente identificado
- [ ] Severidad asignada (SEV1-4)
- [ ] Incident Commander asignado
- [ ] Canal de comunicación establecido

## Containment
- [ ] Impacto limitado
- [ ] Evidencia preservada
- [ ] Stakeholders notificados

## Eradication
- [ ] Causa raíz identificada
- [ ] Fix desarrollado
- [ ] Fix testeado
- [ ] Fix deployado

## Recovery
- [ ] Servicios restaurados
- [ ] Monitoreo activo
- [ ] Comunicación a usuarios (si aplica)

## Lessons Learned
- [ ] Post-mortem scheduled
- [ ] Post-mortem completed
- [ ] Action items asignados
- [ ] Follow-up programado
```

---

## 🎯 Resumen

| Fase | Objetivo | Output |
|------|----------|--------|
| Preparation | Estar listo | Equipo, herramientas, runbooks |
| Detection | Identificar | Alerta, triage, severidad |
| Containment | Limitar daño | Mitigación temporal |
| Eradication | Eliminar causa | Fix permanente |
| Recovery | Restaurar | Servicio normal |
| Lessons Learned | Mejorar | Post-mortem, actions |

---

## 📚 Recursos Adicionales

- [NIST SP 800-61: Computer Security Incident Handling Guide](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-61r2.pdf)
- [PagerDuty Incident Response Guide](https://response.pagerduty.com/)
- [Google SRE Book - Incident Management](https://sre.google/sre-book/managing-incidents/)

---

## ✅ Checklist de Comprensión

- [ ] Conozco las 6 fases de incident response
- [ ] Puedo definir roles del equipo de respuesta
- [ ] Sé establecer SLAs por severidad
- [ ] Puedo conducir un post-mortem blameless

---

[⬅️ Anterior: CVE Process](03-cve-process.md) | [Volver a Week 12 ➡️](../README.md)
