# Ejercicio 04: Security Policies

## 🎯 Objetivo

Implementar políticas de seguridad organizacionales incluyendo 2FA enforcement, gestión de tokens, y configuración de sesiones.

**Duración**: 35 minutos

---

## 📋 Escenario

Como administrador de seguridad de TechStartup Inc., debes implementar:

1. **2FA obligatorio** para toda la organización
2. **Políticas de tokens** restrictivas
3. **Audit de accesos** y gestión de sesiones
4. **Security policies** documentadas

---

## 🔐 Parte 1: Two-Factor Authentication (10 min)

### Paso 1.1: Verificar tu 2FA

```bash
# ¿QUÉ VAMOS A HACER?: Verificar que tienes 2FA habilitado
# ¿POR QUÉ?: Necesitas 2FA antes de requerirlo para la org
# ¿PARA QUÉ SIRVE?: Evitar bloquearte de tu propia org

# Verificar tu estado de 2FA
gh api user --jq '.two_factor_authentication'

# Resultado esperado: true
# Si es false, habilitar en: Settings → Password and authentication
```

### Paso 1.2: Habilitar 2FA Requirement

```yaml
# Organization → Settings → Authentication security

Two-factor authentication requirement:
  ✅ Require two-factor authentication for everyone

# ⚠️ ADVERTENCIA:
# - Miembros sin 2FA serán REMOVIDOS
# - Recibirán email de notificación
# - Pueden re-unirse después de habilitar 2FA
```

### Paso 1.3: Verificar compliance

```bash
# ¿QUÉ VAMOS A HACER?: Listar miembros sin 2FA
# ¿POR QUÉ?: Identificar usuarios no conformes
# ¿PARA QUÉ SIRVE?: Enforcement proactivo antes de deadline

# Listar miembros sin 2FA (si hay alguno)
gh api "orgs/techstartup-bootcamp-TUNOMBRE/members?filter=2fa_disabled" \
  --jq '.[].login'

# Si la lista está vacía, todos cumplen
# Si hay usuarios, notificarles antes del enforcement
```

### Paso 1.4: Documentar política

```bash
# ¿QUÉ VAMOS A HACER?: Crear documento de política de 2FA
# ¿POR QUÉ?: Comunicar expectativas claramente
# ¿PARA QUÉ SIRVE?: Compliance y onboarding

cd webapp

cat > SECURITY.md << 'EOF'
# Security Policy - TechStartup Inc.

## Two-Factor Authentication (2FA)

### Requirement
All organization members MUST have 2FA enabled on their GitHub account.

### Acceptable 2FA Methods
1. **Preferred**: Security Keys (YubiKey, Titan Key)
2. **Recommended**: TOTP Apps (Google Authenticator, Authy, 1Password)
3. **Acceptable**: GitHub Mobile
4. **Not Recommended**: SMS (vulnerable to SIM swap)

### Enforcement
- Members without 2FA will be automatically removed
- Re-joining requires enabling 2FA first
- No exceptions for any role

### Setup Instructions
1. Go to GitHub Settings → Password and authentication
2. Click "Enable two-factor authentication"
3. Choose your preferred method
4. Save recovery codes in a secure location

### Recovery Codes
- Store recovery codes in password manager
- Never share recovery codes
- If lost, contact org admin for re-invitation

## Reporting Security Issues

Report vulnerabilities to: security@techstartup.example.com

Do NOT create public issues for security vulnerabilities.
EOF

git add SECURITY.md
git commit -m "docs: add security policy with 2FA requirements"
git push origin main
```

---

## 🎫 Parte 2: Token Policies (10 min)

### Paso 2.1: Configurar políticas de PAT

```yaml
# Organization → Settings → Personal access tokens

# Fine-grained personal access tokens
Personal access token policies:
  Allow access via fine-grained personal access tokens: ✅
  
  Require administrator approval:
    ✅ Require administrator approval for fine-grained PATs
    # Los devs solicitan, admins aprueban
  
  Restrict access for fine-grained PATs:
    Access to public repositories only: ❌
    # Permitir acceso a repos privados

# Personal access tokens (classic)
Allow access via personal access tokens (classic): 
  ⚪ Allow all members
  🔘 Restrict access  ← Seleccionar
  ⚪ Do not allow
```

### Paso 2.2: Crear token de ejemplo

```bash
# ¿QUÉ VAMOS A HACER?: Crear fine-grained token para la org
# ¿POR QUÉ?: Demostrar el flujo de aprobación
# ¿PARA QUÉ SIRVE?: Acceso controlado a recursos

# Via UI: Settings → Developer settings → Personal access tokens → Fine-grained tokens

# Configuración:
Token name: bootcamp-demo-token
Expiration: 7 days (mínimo recomendado)
Resource owner: techstartup-bootcamp-TUNOMBRE
Repository access: Only select repositories → webapp
Permissions:
  - Contents: Read
  - Pull requests: Read and write
```

### Paso 2.3: Aprobar token (como admin)

```bash
# ¿QUÉ VAMOS A HACER?: Aprobar pending token request
# ¿POR QUÉ?: Completar flujo de aprobación
# ¿PARA QUÉ SIRVE?: Demostrar governance de tokens

# Via UI: Organization → Settings → Personal access tokens → Pending requests

# Via API:
gh api orgs/techstartup-bootcamp-TUNOMBRE/personal-access-token-requests \
  --jq '.[] | "\(.id): \(.owner.login) - \(.token_name)"'

# Aprobar request (reemplazar REQUEST_ID):
# gh api --method POST \
#   orgs/techstartup-bootcamp-TUNOMBRE/personal-access-token-requests/REQUEST_ID \
#   -f action='approve'
```

### Paso 2.4: Revocar tokens (práctica)

```bash
# ¿QUÉ VAMOS A HACER?: Listar y revocar tokens activos
# ¿POR QUÉ?: Gestión de lifecycle de tokens
# ¿PARA QUÉ SIRVE?: Offboarding, incident response

# Listar tokens activos de la org
gh api orgs/techstartup-bootcamp-TUNOMBRE/personal-access-tokens \
  --jq '.[] | "\(.id): \(.owner.login) - \(.token.name) - expires: \(.token.expires_at)"'

# Para revocar un token específico:
# gh api --method DELETE \
#   orgs/techstartup-bootcamp-TUNOMBRE/personal-access-tokens/TOKEN_ID
```

---

## 🔍 Parte 3: Audit Log Review (10 min)

### Paso 3.1: Acceder al Audit Log

```yaml
# Organization → Settings → Logs → Audit log

# Filtros útiles:
action:org.update_member               # Cambios de membresía
action:team.add_member                 # Adiciones a teams
action:repo.create                     # Nuevos repos
action:protected_branch.policy_override # Bypasses de protección
action:personal_access_token           # Actividad de tokens
```

### Paso 3.2: Queries comunes

```bash
# ¿QUÉ VAMOS A HACER?: Ejecutar queries de auditoría comunes
# ¿POR QUÉ?: Identificar actividad sospechosa
# ¿PARA QUÉ SIRVE?: Security monitoring, compliance

# Nota: Audit log API requiere Enterprise
# Para Free/Team, usar UI

# Ejemplo de query en UI:
# action:repo.destroy                    # Repos eliminados
# action:org.remove_member              # Miembros removidos
# actor:username                        # Acciones de usuario específico
# created:>2024-01-01                   # Después de fecha
```

### Paso 3.3: Exportar audit log (Enterprise)

```bash
# ¿QUÉ VAMOS A HACER?: Exportar audit log para análisis
# ¿POR QUÉ?: Retención y análisis offline
# ¿PARA QUÉ SIRVE?: Compliance, forensics

# Via UI: Audit log → Export

# Formatos disponibles:
# - JSON (para procesamiento programático)
# - CSV (para análisis en spreadsheet)
```

---

## 📝 Parte 4: Security Policy en Repositorio (5 min)

### Paso 4.1: Configurar Security Advisories

```yaml
# Repository → Settings → Security → Code security and analysis

Dependency graph: ✅ Enabled
Dependabot alerts: ✅ Enabled
Dependabot security updates: ✅ Enabled
Secret scanning: ✅ Enabled
Secret scanning push protection: ✅ Enabled
```

### Paso 4.2: Configurar Security Policy

```yaml
# Repository → Security → Security policy

# Esto crea/edita SECURITY.md
# Ya lo creamos anteriormente, verificar que existe
```

### Paso 4.3: Configurar Private Vulnerability Reporting

```yaml
# Repository → Settings → Security → Private vulnerability reporting

Enable private vulnerability reporting: ✅

# Permite que investigadores reporten vulnerabilidades
# de forma privada antes de disclosure público
```

---

## ✅ Checklist de Verificación

```markdown
## Security Policies - Verificación

### Two-Factor Authentication
- [ ] Tu cuenta tiene 2FA habilitado
- [ ] Org require 2FA habilitado
- [ ] No hay miembros sin 2FA (o están notificados)
- [ ] SECURITY.md documenta política de 2FA

### Token Policies
- [ ] Fine-grained tokens requieren aprobación
- [ ] Classic tokens restringidos
- [ ] Token de demo creado
- [ ] (Si aplicable) Token aprobado/denegado

### Audit Log
- [ ] Accediste al audit log
- [ ] Identificaste tipos de eventos
- [ ] (Enterprise) Conoces cómo exportar

### Repository Security
- [ ] Dependabot habilitado
- [ ] Secret scanning habilitado
- [ ] Private vulnerability reporting habilitado
- [ ] SECURITY.md creado

### Verificación Final
- [ ] gh api user --jq '.two_factor_authentication' → true
- [ ] SECURITY.md existe en repo
```

---

## 🔧 Troubleshooting

### Error: "You must have 2FA enabled"

```bash
# Problema: Intentas habilitar 2FA requirement sin tenerlo tú
# Solución: Habilitar 2FA en tu cuenta primero

# Ve a: github.com/settings/security
# Habilita 2FA antes de continuar
```

### Error: "Token request not found"

```bash
# Problema: No hay pending requests
# Solución: El flujo de aprobación solo aplica si:
# 1. Require administrator approval está habilitado
# 2. El token se creó DESPUÉS de habilitar la política
```

---

## 🔐 Security Best Practices Summary

```yaml
Organization Security Checklist:

Authentication:
  - [ ] 2FA required for all members
  - [ ] Security keys for admins
  - [ ] Recovery codes stored securely

Tokens:
  - [ ] Fine-grained tokens preferred
  - [ ] Admin approval required
  - [ ] Maximum expiration: 90 days
  - [ ] Regular token rotation

Access Control:
  - [ ] Least privilege principle
  - [ ] Regular access reviews
  - [ ] Automated offboarding

Monitoring:
  - [ ] Audit log review (weekly)
  - [ ] Alert on suspicious activity
  - [ ] Incident response plan documented

Repository Security:
  - [ ] Dependabot enabled
  - [ ] Secret scanning enabled
  - [ ] Branch protection on main
  - [ ] Required reviews for PRs
```

---

## 📚 Recursos

- [Requiring 2FA](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-two-factor-authentication-for-your-organization)
- [Managing PATs](https://docs.github.com/en/organizations/managing-programmatic-access-to-your-organization/setting-a-personal-access-token-policy-for-your-organization)
- [Audit Log](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-settings-for-your-organization/reviewing-the-audit-log-for-your-organization)

---

## 🎉 ¡Ejercicios Completados!

Has completado todos los ejercicios de la Semana 14. Ahora continúa con el [Proyecto Semanal](../../3-proyecto/README.md).
