# 🔐 Soluciones - Semana 12: Vulnerability Management

> **⚠️ IMPORTANTE**: Este directorio contiene soluciones de referencia.
> Intenta completar los ejercicios y el proyecto antes de consultar estas soluciones.

---

## 📁 Contenido

```
solution/
├── README.md                           # Este archivo
├── ejercicio-01-solution.md            # Vulnerability Analysis
├── ejercicio-02-solution.md            # Security Advisory
├── ejercicio-03-solution.md            # Patch Implementation
├── ejercicio-04-solution.md            # Incident Simulation
└── proyecto-solution/                  # Proyecto completo
    ├── 01-triage-report.md
    ├── 02-advisories/
    │   ├── GHSA-001-idor.md
    │   ├── GHSA-002-xss.md
    │   └── GHSA-003-sqli.md
    ├── 03-fix-implementation.md
    ├── 04-communications/
    │   ├── reporter-ack.md
    │   └── stakeholder-update.md
    └── 05-post-mortem.md
```

---

## 📝 Ejercicio 01: Vulnerability Analysis - Solución

### Reporte A: SQL Injection

```yaml
Válida: SÍ
CWE: CWE-89 (SQL Injection)
CVSS: CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:N
Score: 9.1 (Critical)
Prioridad: P1
SLA: 24-48 horas
```

### Reporte B: Reflected XSS

```yaml
Válida: SÍ
CWE: CWE-79 (Cross-site Scripting)
CVSS: CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:C/C:L/I:L/A:N
Score: 6.1 (Medium)
Prioridad: P3
SLA: 30 días
```

### Reporte C: Passwords en Logs

```yaml
Válida: SÍ
CWE: CWE-532 (Information Exposure Through Log Files)
CVSS: CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:N
Score: 5.5 (Medium)
Prioridad: P2
SLA: 7 días
```

### Reporte D: Missing Header

```yaml
Válida: NO (Informational)
Razón: /api/health retorna JSON, no contenido ejecutable
Acción: Cerrar como informative
```

### Matriz Final

| Orden | Vuln | CWE | CVSS | Prioridad |
|-------|------|-----|------|-----------|
| 1 | SQL Injection | CWE-89 | 9.1 | P1 |
| 2 | Logs passwords | CWE-532 | 5.5 | P2 |
| 3 | XSS | CWE-79 | 6.1 | P3 |
| 4 | Header | N/A | N/A | Info |

---

## 📝 Ejercicio 02: Security Advisory - Solución

### Advisory Completo

```markdown
# GHSA-xxxx-xxxx-xxxx: SQL Injection in authentication endpoint

## Summary
A SQL injection vulnerability in the login endpoint of @acme/auth-service
allows unauthenticated attackers to bypass authentication completely.

## Severity
**Critical** - CVSS 9.1 (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:N)

## Affected Versions
- @acme/auth-service < 2.1.0

## Patched Versions
- @acme/auth-service >= 2.1.0

## Description
The `authenticateUser` function in versions prior to 2.1.0 concatenates
user input directly into SQL queries without proper sanitization. This
allows attackers to manipulate the SQL query structure and bypass
authentication controls.

## Impact
- Complete authentication bypass
- Access to any user account including administrators
- Potential for data exfiltration via error-based SQL injection
- Possible privilege escalation to database administrator

## Workarounds
- Implement a WAF rule to block SQL injection patterns in login requests
- Enable additional authentication factors (MFA)
- Monitor authentication logs for anomalies

## References
- [Fix PR](https://github.com/acme/auth-service/pull/456)
- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [CWE-89](https://cwe.mitre.org/data/definitions/89.html)

## Credit
Thanks to security-researcher-123 for responsible disclosure through
our bug bounty program.

## Timeline
- 2024-12-01: Report received
- 2024-12-02: Vulnerability confirmed
- 2024-12-05: Fix developed
- 2024-12-15: Advisory published, v2.1.0 released
```

---

## 📝 Ejercicio 03: Patch Implementation - Solución

### Código Corregido

```javascript
// auth/login.js - SECURE VERSION
const db = require('../database');
const bcrypt = require('bcrypt');

async function authenticateUser(username, password) {
  // Input validation
  if (!username || !password ||
      typeof username !== 'string' ||
      typeof password !== 'string') {
    return { success: false, error: 'Invalid input' };
  }
  
  // Parameterized query - prevents SQL injection
  const query = `
    SELECT id, username, email, role, password_hash 
    FROM users 
    WHERE username = $1
  `;
  
  try {
    const result = await db.query(query, [username]);
    
    if (result.rows.length > 0) {
      const user = result.rows[0];
      const passwordMatch = await bcrypt.compare(password, user.password_hash);
      
      if (passwordMatch) {
        return {
          success: true,
          user: {
            id: user.id,
            username: user.username,
            email: user.email,
            role: user.role
          }
        };
      }
    }
    
    return { success: false, error: 'Invalid credentials' };
  } catch (error) {
    console.error('Auth error:', error.message);
    return { success: false, error: 'Authentication failed' };
  }
}

module.exports = { authenticateUser };
```

### Commit Message

```bash
git commit -m "fix: use parameterized queries in authentication

- Replace string concatenation with parameterized queries
- Add bcrypt password verification
- Add input validation
- Prevent sensitive data in error messages

Security: GHSA-xxxx-xxxx-xxxx"
```

---

## 📝 Ejercicio 04: Incident Simulation - Solución

### Clasificación

```yaml
Tipo: Credential exposure
Severidad inicial: SEV2
Severidad final: SEV1 (escalado por uso confirmado)
SLA: Response 15min, Resolution 4h
```

### Orden de Contención

1. Revocar AWS key expuesta
2. Revisar CloudTrail logs
3. Revocar key creada por atacante
4. Crear incident ticket
5. Notificar management
6. Eliminar commit con key
7. Rotar credenciales
8. Notificar developer

### Análisis de Logs

- Key fue usada: SÍ
- Acciones del atacante: ListBuckets, GetObject, CreateAccessKey
- Data exfiltration: customers-2024.csv
- Persistence: Nueva access key para backup-service

### Root Cause

Developer cometió archivo de configuración con credenciales hardcodeadas. Push protection no estaba habilitado.

---

## 🏆 Proyecto: Solución Completa

### Triage Report

```yaml
Vulnerability 1 - IDOR:
  Valid: Yes
  CWE: CWE-639
  CVSS: 6.5 (Medium) - CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:N
  Priority: P2
  SLA: 7 days

Vulnerability 2 - Stored XSS:
  Valid: Yes
  CWE: CWE-79
  CVSS: 6.1 (Medium) - CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:C/C:L/I:L/A:N
  Priority: P3
  SLA: 30 days

Vulnerability 3 - SQL Injection:
  Valid: Yes
  CWE: CWE-89
  CVSS: 9.8 (Critical) - CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
  Priority: P1
  SLA: 48 hours

Priority Order:
1. SQL Injection (Critical, database access)
2. IDOR (Customer data exposure)
3. XSS (Requires user interaction)
```

### Reporter Acknowledgment

```markdown
Subject: Re: Security Report - Multiple Vulnerabilities in TechStore

Hi Elena,

Thank you for your detailed security report submitted on December 20th.

We have triaged all three reported vulnerabilities and confirmed their validity:

- VULN-2024-001: IDOR in Order API - Confirmed
- VULN-2024-002: Stored XSS in Reviews - Confirmed
- VULN-2024-003: SQL Injection in Search - Confirmed (Critical)

Our proposed timeline:
- Fixes developed: December 27
- Testing complete: December 30
- Coordinated disclosure: January 15, 2025

Does this 26-day timeline work for you? We want to ensure users have
time to update before public disclosure.

Regarding our bug bounty program, based on the severity and quality of
your report, you qualify for:
- IDOR: $2,000
- XSS: $1,500
- SQL Injection: $5,000
- Bonus for attack chain: $1,000
- Total: $9,500

Please confirm your payment details and preferred disclosure date.

Best regards,
[Name]
Security Team, TechStore Inc.
```

### Post-Mortem Summary

```markdown
# Post-Mortem: TechStore Multi-Vulnerability Incident

## Executive Summary
On December 20, 2024, TechStore received a security report identifying
three vulnerabilities (IDOR, XSS, SQL Injection) that together could
enable complete account takeover and payment data access. No evidence
of exploitation was found. All vulnerabilities were patched within 10
days and coordinated disclosure completed successfully.

## Root Causes
1. IDOR: Missing authorization middleware on order endpoints
2. XSS: No input sanitization or output encoding in review system
3. SQLi: String concatenation in search query builder

## Common Factor
Insufficient security code review process. All three vulnerabilities
would have been caught by automated SAST tools or security-focused
code review.

## Action Items
1. Enable GitHub code scanning on all repositories (Owner: DevOps, Jan 5)
2. Implement mandatory security review for sensitive endpoints (Owner: Eng Lead, Jan 15)
3. Deploy WAF with OWASP Core Rule Set (Owner: Security, Jan 10)
4. Security training for all developers (Owner: HR/Security, Feb 1)
5. Quarterly penetration testing (Owner: Security, Ongoing)
```

---

## 💡 Notas para Instructores

### Puntos de Evaluación Críticos

1. **CVSS Accuracy**: Los estudiantes deben justificar cada métrica
2. **Priorización**: Severidad ≠ Prioridad (contexto de negocio)
3. **Comunicación**: Tono diferente para reporter vs ejecutivos
4. **No revelar exploits**: Advisories públicos no deben tener PoCs detallados
5. **Action items**: Deben ser específicos, con owner y fecha

### Errores Comunes

- Asignar P1 a todo lo que es "High" o "Critical"
- Incluir detalles de explotación en advisories
- Olvidar coordinar con el reporter
- Post-mortems que culpan a individuos
- SLAs irrealistas

---

[⬅️ Volver a Week-12](../README.md)
