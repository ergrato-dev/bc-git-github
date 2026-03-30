# 🚨 Ejercicio 04: Incident Simulation

> **Duración**: 35 minutos
>
> **Objetivo**: Simular una respuesta completa a un incidente de seguridad.

---

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio serás capaz de:

- ✅ Aplicar las **6 fases** de incident response
- ✅ Tomar **decisiones bajo presión**
- ✅ **Comunicar** efectivamente durante un incidente
- ✅ Conducir un **post-mortem** estructurado

---

## 📋 Escenario

**⏰ Hora actual: Viernes 16:45**

Recibes esta alerta en Slack:

```
🚨 ALERT - Security Scanner
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Severity: HIGH
Source: GitHub Secret Scanning
Repository: acme/payment-service

Detection: AWS Access Key exposed in commit
Commit: abc123f
File: config/aws.js
Author: developer@acme.com
Time: 16:30 UTC

The exposed key has "AdministratorAccess" policy attached.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Tu rol**: Security Engineer on-call

---

## 🔥 Parte 1: Detection & Initial Response (5 min)

### Tarea 1: Clasificación Inicial

```yaml
# Completa la clasificación:

1. ¿Qué tipo de incidente es?
   □ Data breach
   □ Credential exposure
   □ Malware
   □ DDoS
   □ Otro: ____________

2. ¿Cuál es la severidad?
   □ SEV1 - Critical (breach activo)
   □ SEV2 - High (exposición sin evidencia de uso)
   □ SEV3 - Medium
   □ SEV4 - Low

3. ¿Por qué esa severidad?
   Justificación: ________________________________

4. ¿Cuál es el SLA de respuesta?
   Response time: ________________________________
   Resolution target: ________________________________
```

### Tarea 2: Declarar el Incidente

```markdown
# Incident Declaration

**Incident ID**: INC-2024-____
**Severity**: SEV___
**Declared by**: [Tu nombre]
**Time**: 16:47 UTC

## Initial Assessment
________________________________
________________________________

## Immediate Actions Required
1. ________________________________
2. ________________________________
3. ________________________________
```

---

## 🛑 Parte 2: Containment (10 min)

### Tarea 3: Acciones de Contención

**Ordena estas acciones por prioridad (1 = primero):**

```
___ Notificar a management
___ Revocar la AWS key expuesta
___ Revisar CloudTrail logs
___ Crear incident ticket
___ Eliminar el commit con la key
___ Rotar todas las credenciales AWS
___ Notificar al developer
___ Bloquear acceso del developer (si comprometido)
```

### Tarea 4: Ejecutar Contención

Documenta los comandos/acciones que ejecutarías:

```bash
# 1. Revocar la AWS key (AWS Console o CLI)
aws iam ________________________________

# 2. Verificar si la key fue usada (CloudTrail)
aws cloudtrail ________________________________

# 3. En GitHub - eliminar el secret del historial
# ¿Qué herramienta usarías?
________________________________
```

### Tarea 5: Comunicación Inicial

Escribe el mensaje para el canal de incidentes:

```markdown
# 🚨 INC-2024-XXX - Active Incident

**Status**: 🔴 ACTIVE
**Severity**: SEV___
**Incident Commander**: [Tu nombre]

## Summary
________________________________

## Current Status
- [ ] Key revoked
- [ ] CloudTrail reviewed
- [ ] Impact assessed

## Team
- IC: @________
- Tech: @________
- Comms: @________

## Next Update
In ___ minutes
```

---

## 🔍 Parte 3: Investigation (10 min)

### Escenario Adicional

Revisas CloudTrail y encuentras:

```json
{
  "eventTime": "2024-12-15T16:35:00Z",
  "eventName": "ListBuckets",
  "sourceIPAddress": "203.0.113.42",
  "userAgent": "aws-cli/2.0 Python/3.8",
  "responseElements": null
},
{
  "eventTime": "2024-12-15T16:36:00Z", 
  "eventName": "GetObject",
  "sourceIPAddress": "203.0.113.42",
  "requestParameters": {
    "bucketName": "acme-customer-data",
    "key": "exports/customers-2024.csv"
  }
},
{
  "eventTime": "2024-12-15T16:37:00Z",
  "eventName": "CreateAccessKey",
  "sourceIPAddress": "203.0.113.42",
  "responseElements": {
    "accessKey": {
      "userName": "backup-service",
      "accessKeyId": "AKIA..."
    }
  }
}
```

### Tarea 6: Análisis de Logs

```yaml
# Responde basándote en los logs:

1. ¿La key comprometida fue usada?
   Respuesta: ________________________________

2. ¿Qué acciones realizó el atacante?
   - ________________________________
   - ________________________________
   - ________________________________

3. ¿Hay evidencia de data exfiltration?
   Respuesta: ________________________________
   Archivo(s) afectado(s): ________________________________

4. ¿Qué persistence estableció el atacante?
   Respuesta: ________________________________

5. ¿Esto cambia la severidad del incidente?
   Nueva severidad: SEV___
   Razón: ________________________________
```

### Tarea 7: Actualizar el Incidente

```markdown
# 🚨 INC-2024-XXX - Update #2

**Status**: 🔴 ACTIVE - ESCALATED
**Severity**: SEV___ (upgraded from SEV___)

## New Findings
________________________________
________________________________

## Data Potentially Exposed
- File: ________________________________
- Content: ________________________________
- Records affected: ~________________________________

## Additional Containment
- [ ] Revoke newly created access key
- [ ] Review all IAM users
- [ ] Enable MFA on all accounts
- [ ] Notify data protection officer

## Next Steps
________________________________
```

---

## 🔧 Parte 4: Eradication & Recovery (5 min)

### Tarea 8: Plan de Erradicación

```yaml
# Checklist de erradicación:

IAM Cleanup:
  - [ ] Revoke original exposed key
  - [ ] Revoke attacker-created key
  - [ ] Audit all IAM users for suspicious keys
  - [ ] Enable MFA requirement

Repository Cleanup:
  - [ ] Remove secret from git history (BFG/git-filter-repo)
  - [ ] Force push cleaned history
  - [ ] Invalidate all developer tokens
  - [ ] Enable secret scanning + push protection

AWS Hardening:
  - [ ] Review and restrict IAM policies
  - [ ] Enable CloudTrail alerts
  - [ ] Review S3 bucket policies
  - [ ] Enable GuardDuty
```

### Tarea 9: Plan de Recuperación

```yaml
# Pasos de recuperación:

1. Generar nuevas credenciales:
   - ________________________________

2. Actualizar aplicaciones que usan las credenciales:
   - ________________________________

3. Verificar que servicios funcionan:
   - ________________________________

4. Monitoring aumentado por 72h:
   - ________________________________
```

---

## 📝 Parte 5: Post-Mortem (5 min)

### Tarea 10: Draft del Post-Mortem

```markdown
# Post-Mortem: AWS Credentials Exposure

**Date**: 2024-12-15
**Severity**: SEV___
**Duration**: ___ hours
**Author**: [Tu nombre]

---

## Executive Summary
[2-3 oraciones]
________________________________
________________________________

---

## Timeline (UTC)

| Time | Event |
|------|-------|
| 16:30 | ________________________________ |
| 16:35 | ________________________________ |
| 16:45 | ________________________________ |
| 16:47 | ________________________________ |
| _____ | ________________________________ |
| _____ | ________________________________ |

---

## Root Cause
________________________________
________________________________

---

## Impact
- Data exposed: ________________________________
- Users affected: ________________________________
- Financial impact: ________________________________

---

## What Went Well
- ________________________________
- ________________________________

---

## What Could Be Improved
- ________________________________
- ________________________________

---

## Action Items

| Action | Owner | Due | Status |
|--------|-------|-----|--------|
| Enable push protection | _____ | _____ | ⏳ |
| Implement secrets manager | _____ | _____ | ⏳ |
| Security training | _____ | _____ | ⏳ |
| ________________________ | _____ | _____ | ⏳ |

```

---

## ✅ Entregables

Al finalizar este ejercicio debes tener:

1. **Clasificación inicial** del incidente
2. **Acciones de contención** priorizadas
3. **Análisis de logs** con conclusiones
4. **Comunicaciones** del incidente
5. **Draft de post-mortem**

---

## ✅ Checklist de Completado

- [ ] Clasifiqué el incidente correctamente
- [ ] Prioricé acciones de contención
- [ ] Analicé los logs de CloudTrail
- [ ] Actualicé la severidad basándome en evidencia
- [ ] Documenté plan de erradicación
- [ ] Escribí draft de post-mortem

---

## 📝 Solución de Referencia

<details>
<summary>Ver solución (después de intentar)</summary>

### Clasificación Inicial

```yaml
1. Tipo: Credential exposure
2. Severidad: SEV2 → SEV1 (después de ver uso)
3. Justificación: Key con AdminAccess + evidencia de uso malicioso
4. SLA: Response 15min, Resolution 4h
```

### Orden de Contención

```
1 - Revocar la AWS key expuesta
2 - Revisar CloudTrail logs
3 - Crear incident ticket
4 - Revocar key creada por atacante
5 - Notificar a management
6 - Eliminar el commit con la key
7 - Rotar todas las credenciales AWS
8 - Notificar al developer
```

### Análisis de Logs

```yaml
1. ¿Key usada? SÍ - múltiples llamadas API
2. Acciones del atacante:
   - ListBuckets (reconocimiento)
   - GetObject (exfiltración de datos)
   - CreateAccessKey (persistencia)
3. Data exfiltration: SÍ - customers-2024.csv
4. Persistence: Nueva access key para backup-service
5. Severidad: Escalar a SEV1 (breach confirmado)
```

### Root Cause

```
El developer cometió accidentalmente un archivo de configuración
que contenía credenciales AWS hardcodeadas. El repositorio tenía
secret scanning habilitado pero no push protection, permitiendo
que el commit llegara a main antes de la detección.
```

### Action Items

```yaml
- Enable push protection: Security Team, 24h
- Implement AWS Secrets Manager: DevOps, 1 week
- Mandatory pre-commit hooks: Engineering, 2 weeks
- Security awareness training: HR/Security, 1 month
- Notify affected customers: Legal/Comms, 48h
```

</details>

---

## 📚 Recursos

- [NIST Incident Response Guide](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-61r2.pdf)
- [AWS Security Incident Response](https://docs.aws.amazon.com/whitepapers/latest/aws-security-incident-response-guide/welcome.html)
- [GitHub Secret Scanning](https://docs.github.com/en/code-security/secret-scanning)

---

[⬅️ Anterior: Patch Implementation](../ejercicio-03-patch-implementation/) | [Volver a Prácticas ➡️](../README.md)
