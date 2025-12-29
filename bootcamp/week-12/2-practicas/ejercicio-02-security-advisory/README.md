# 📝 Ejercicio 02: Security Advisory

> **Duración**: 40 minutos
>
> **Objetivo**: Crear y gestionar un Security Advisory completo en GitHub.

---

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio serás capaz de:

- ✅ Crear un **draft security advisory**
- ✅ Completar todos los **campos requeridos**
- ✅ Invitar **colaboradores**
- ✅ Preparar el advisory para **publicación**

---

## 📋 Escenario

Después de analizar el Reporte A del ejercicio anterior (SQL Injection), has confirmado la vulnerabilidad y desarrollado un fix. Ahora necesitas crear el Security Advisory oficial antes de publicar.

---

## 🔨 Parte 1: Crear Draft Advisory (15 min)

### Paso 1: Acceder a Security Advisories

```
# En tu repository de práctica (o simular):

Repository → Security tab → Advisories → New draft security advisory
```

### Paso 2: Completar Información Básica

#### Tarea: Completa estos campos

```yaml
# ===========================================
# INFORMACIÓN BÁSICA
# ===========================================

# 1. Título (claro y descriptivo)
Title: ________________________________

# 2. CVE ID (selecciona una opción)
CVE ID: 
  □ Request CVE ID
  □ I have an existing CVE ID: _______________

# 3. Descripción
# Incluye: qué es, cómo se explota, impacto
Description: |
  ## Summary
  [Escribe aquí]
  
  ## Details
  [Escribe aquí]
  
  ## Impact
  [Escribe aquí]
```

### Paso 3: Especificar Paquete Afectado

```yaml
# ===========================================
# INFORMACIÓN DEL PAQUETE
# ===========================================

# 4. Ecosistema
Ecosystem: ____________
# Opciones: npm, pip, maven, rubygems, nuget, composer, go, etc.

# 5. Nombre del paquete
Package name: ____________

# 6. Versiones afectadas
# Sintaxis: < 2.0.0, >= 1.0.0 < 1.5.3, etc.
Affected versions: ____________

# 7. Versiones parcheadas
Patched versions: ____________
```

### Paso 4: Establecer Severidad

```yaml
# ===========================================
# SEVERIDAD
# ===========================================

# 8. Severidad (basada en CVSS del ejercicio 01)
Severity: ____________
# Opciones: Critical, High, Medium, Low

# 9. CVSS Vector String
CVSS Vector: CVSS:3.1/AV:___/AC:___/PR:___/UI:___/S:___/C:___/I:___/A:___

# 10. CVSS Score
Score: ____________
```

### Paso 5: Clasificación CWE

```yaml
# ===========================================
# CLASIFICACIÓN
# ===========================================

# 11. CWE ID
CWE: CWE-___

# 12. CWE Name
CWE Name: ____________
```

---

## 📄 Parte 2: Draft Completo (10 min)

### Tarea: Crea el Advisory Completo

Usando la información del ejercicio 01, completa este template:

```markdown
# Security Advisory Draft

## Title
SQL Injection in authentication endpoint allows complete bypass

## CVE ID
[Request from GitHub]

## Description

### Summary
A SQL injection vulnerability exists in the login endpoint of 
[package-name] versions prior to [X.X.X]. An unauthenticated attacker 
can bypass authentication by injecting SQL commands into the username 
parameter.

### Details
The login function concatenates user input directly into SQL queries 
without proper sanitization or parameterization:

```python
# Vulnerable code (DO NOT USE)
query = f"SELECT * FROM users WHERE username='{username}' AND password='{password}'"
```

An attacker can exploit this by providing specially crafted input:
- Username: `admin'--`
- Password: `anything`

This results in the query:
```sql
SELECT * FROM users WHERE username='admin'--' AND password='anything'
```

The `--` comments out the password check, allowing authentication bypass.

### Impact
- Complete authentication bypass
- Access to any user account including administrators
- Potential for data exfiltration
- Potential for privilege escalation

## Affected Products

| Ecosystem | Package | Affected Versions | Patched Versions |
|-----------|---------|-------------------|------------------|
| [ecosystem] | [package-name] | < X.X.X | >= X.X.X |

## Severity
**Critical (9.1)**

CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:N

## Weakness
CWE-89: Improper Neutralization of Special Elements used in an SQL 
Command ('SQL Injection')

## References
- Fix PR: #XXX
- Related Issue: #XXX
- OWASP SQL Injection: https://owasp.org/www-community/attacks/SQL_Injection

## Credit
Thanks to [reporter-name] for responsible disclosure.

## Timeline
- YYYY-MM-DD: Report received
- YYYY-MM-DD: Vulnerability confirmed
- YYYY-MM-DD: Fix developed
- YYYY-MM-DD: Advisory published
```

---

## 👥 Parte 3: Gestión de Colaboradores (10 min)

### Paso 1: Invitar Colaboradores

```
Advisory → Collaborators → Add collaborator
```

### Tarea: Define los Colaboradores

```yaml
# Lista de colaboradores a invitar:

1. Reporter (quien reportó la vulnerabilidad):
   GitHub username: ____________
   Rol: Reporter
   
2. Security Lead (tu equipo):
   GitHub username: ____________
   Rol: Maintainer
   
3. Developer (quien hizo el fix):
   GitHub username: ____________
   Rol: Maintainer
```

### Paso 2: Comunicación en el Advisory

Escribe el primer mensaje en la discusión privada del advisory:

```markdown
# Mensaje a Colaboradores

@[reporter-username] Thank you for reporting this vulnerability.

We have confirmed the issue and are working on a fix. Our timeline:

- Fix development: [DATE]
- Testing: [DATE]
- Planned disclosure: [DATE]

Please let us know if this timeline works for coordinated disclosure.

@[developer-username] Can you start working on the fix in the 
temporary private fork?

cc: @[security-lead]
```

---

## 🔀 Parte 4: Preparar para Publicación (5 min)

### Checklist Pre-Publicación

```markdown
## Pre-Publication Checklist

### Advisory Content
- [ ] Title is clear and descriptive
- [ ] Description explains the vulnerability
- [ ] Impact is clearly stated
- [ ] Affected versions are correct
- [ ] Patched versions are specified
- [ ] CVSS score is calculated
- [ ] CWE is assigned
- [ ] References are included

### Coordination
- [ ] Reporter has been credited (with permission)
- [ ] Reporter agrees with disclosure date
- [ ] Fix has been developed and tested
- [ ] New version is ready to release

### Communication
- [ ] Release notes prepared
- [ ] Blog post drafted (if needed)
- [ ] Support team briefed
```

### Timeline de Publicación

```yaml
# Completa el timeline:

T-7 días:
  - [ ] Advisory draft finalizado
  - [ ] Fix completado y testeado

T-3 días:
  - [ ] Release candidate listo
  - [ ] Comunicación al reporter

T-1 día:
  - [ ] Release notes listos
  - [ ] Equipo de soporte notificado

T-0 (Disclosure):
  - [ ] Merge fix a main
  - [ ] Publicar nueva versión
  - [ ] Publicar advisory
  - [ ] Notificar por redes sociales/blog
```

---

## 📝 Entregables

Al finalizar este ejercicio debes tener:

1. **Draft Advisory** con todos los campos completados
2. **Lista de colaboradores** y sus roles
3. **Mensaje de coordinación** para el equipo
4. **Checklist pre-publicación** completado
5. **Timeline de disclosure** definido

---

## ✅ Checklist de Completado

- [ ] Creé draft advisory (o documento simulado)
- [ ] Completé todos los campos requeridos
- [ ] Definí colaboradores y roles
- [ ] Escribí mensaje de coordinación
- [ ] Completé checklist pre-publicación
- [ ] Definí timeline de disclosure

---

## 📝 Solución de Referencia

<details>
<summary>Ver ejemplo completo (después de intentar)</summary>

### Advisory Completado

```yaml
Title: SQL Injection in authentication endpoint allows complete bypass

CVE ID: CVE-2024-XXXXX (requested from GitHub)

Description: |
  ## Summary
  A SQL injection vulnerability exists in the login endpoint of 
  @acme/auth-service versions prior to 2.1.0. An unauthenticated 
  attacker can bypass authentication by injecting SQL commands.
  
  ## Details
  The `authenticateUser` function in `src/auth/login.js` concatenates
  user input directly into SQL queries without sanitization.
  
  ## Impact
  - Complete authentication bypass
  - Access to any user account
  - Potential data exfiltration

Ecosystem: npm
Package: @acme/auth-service
Affected versions: < 2.1.0
Patched versions: >= 2.1.0

Severity: Critical
CVSS Vector: CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:N
Score: 9.1

CWE: CWE-89
CWE Name: SQL Injection

References:
  - Fix: https://github.com/acme/auth-service/pull/456
  - OWASP: https://owasp.org/www-community/attacks/SQL_Injection

Credits: security-researcher-123
```

### Colaboradores

```yaml
Collaborators:
  - username: security-researcher-123
    role: Reporter
    
  - username: alice-security-lead
    role: Maintainer (Security)
    
  - username: bob-developer
    role: Maintainer (Fix author)
```

### Timeline

```yaml
Timeline:
  2024-12-01: Report received, acknowledged within 24h
  2024-12-02: Vulnerability confirmed
  2024-12-05: Fix developed in private fork
  2024-12-08: Fix tested and approved
  2024-12-10: Coordinated disclosure date agreed
  2024-12-15: Advisory published, v2.1.0 released
```

</details>

---

## 📚 Recursos

- [Creating a security advisory](https://docs.github.com/en/code-security/security-advisories/repository-security-advisories/creating-a-repository-security-advisory)
- [Adding collaborators](https://docs.github.com/en/code-security/security-advisories/repository-security-advisories/adding-a-collaborator-to-a-repository-security-advisory)

---

[⬅️ Anterior: Vulnerability Analysis](../ejercicio-01-vulnerability-analysis/) | [Siguiente: Patch Implementation ➡️](../ejercicio-03-patch-implementation/)
