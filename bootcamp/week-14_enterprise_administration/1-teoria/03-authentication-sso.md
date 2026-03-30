# Lección 03: Authentication & SSO

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- Implementar Two-Factor Authentication obligatorio
- Entender SAML Single Sign-On
- Configurar políticas de tokens y SSH keys
- Gestionar sesiones de usuario

---

## 📚 Conceptos Teóricos

### Capas de Autenticación en GitHub

```yaml
Niveles:
  1. Password + 2FA (básico)
  2. SAML SSO (enterprise)
  3. Personal Access Tokens
  4. SSH Keys
  5. GitHub Apps / OAuth Apps
```

![SSO Flow](../0-assets/03-sso-flow.svg)

---

## 🔐 Two-Factor Authentication (2FA)

### ¿Por qué es Crítico?

```yaml
Riesgos sin 2FA:
  - Password comprometido = cuenta comprometida
  - Phishing attacks
  - Credential stuffing
  - Sin protección adicional

Con 2FA:
  - Password + segundo factor
  - Protección contra phishing
  - Compliance requirement (SOC 2, etc.)
  - Industry standard
```

### Métodos de 2FA Soportados

```yaml
TOTP (Time-based One-Time Password):
  Apps: Google Authenticator, Authy, 1Password
  Seguridad: ⭐⭐⭐
  Conveniencia: ⭐⭐⭐

SMS:
  Método: Código via texto
  Seguridad: ⭐⭐ (vulnerable a SIM swap)
  Conveniencia: ⭐⭐⭐⭐
  
Security Keys (WebAuthn/FIDO2):
  Dispositivos: YubiKey, Titan Key
  Seguridad: ⭐⭐⭐⭐⭐
  Conveniencia: ⭐⭐⭐
  Recomendado: Para admins y cuentas críticas

GitHub Mobile:
  Método: Push notification
  Seguridad: ⭐⭐⭐⭐
  Conveniencia: ⭐⭐⭐⭐⭐
```

### Enforcement en Organization

```yaml
# Settings → Security → Two-factor authentication

Require 2FA:
  Enabled: true
  
Proceso:
  1. Habilitar requirement
  2. Miembros sin 2FA reciben notificación
  3. Tienen periodo de gracia (configurable)
  4. Después del deadline:
     - Removidos automáticamente de org
     - Pierden acceso a repos
     - Pueden re-unirse después de habilitar 2FA
```

### Verificar Estado de 2FA

```bash
# Listar miembros sin 2FA habilitado
gh api \
  "orgs/NOMBRE-ORG/members?filter=2fa_disabled" \
  --jq '.[].login'

# Contar miembros sin 2FA
gh api \
  "orgs/NOMBRE-ORG/members?filter=2fa_disabled" \
  --jq 'length'
```

---

## 🔑 SAML Single Sign-On

### ¿Qué es SAML SSO?

```yaml
SAML (Security Assertion Markup Language):
  - Protocolo de autenticación federada
  - Usuario se autentica en Identity Provider (IdP)
  - IdP envía "assertion" a GitHub (Service Provider)
  - GitHub confía en el IdP y otorga acceso

Beneficios:
  - Una sola credencial para todo
  - Control centralizado de acceso
  - Deprovision automático
  - Audit trail unificado
  - MFA del IdP se hereda
```

### Identity Providers Soportados

```yaml
Oficialmente soportados:
  - Azure Active Directory
  - Okta
  - OneLogin
  - PingOne

Compatibles (SAML 2.0):
  - Google Workspace
  - Auth0
  - Duo
  - JumpCloud
  - Cualquier IdP SAML 2.0
```

### Configuración Básica

```yaml
# Enterprise → Settings → Authentication security

SAML SSO Configuration:
  
  # Desde tu IdP, obtener:
  Sign-on URL: https://idp.example.com/saml/sso
  Issuer: https://idp.example.com
  Public Certificate: [pegar certificado X.509]
  
  # En GitHub, configurar:
  Signature Method: RSA-SHA256
  Digest Method: SHA256
  
  # Atributos SAML requeridos:
  NameID: user email
  Attributes:
    - email (requerido)
    - name (opcional)
    - login (opcional)

# En tu IdP, configurar:
  Assertion Consumer Service URL: 
    https://github.com/orgs/NOMBRE-ORG/saml/consume
  
  Entity ID:
    https://github.com/orgs/NOMBRE-ORG
```

### SAML Enforcement

```yaml
Enforcement Modes:

  Disabled:
    - No SAML
    - Password + 2FA normal
  
  Enabled (not enforced):
    - SAML disponible
    - Users pueden elegir
    - Para testing/migración
  
  Enforced:
    - SAML obligatorio
    - Sin SAML = sin acceso
    - Para producción

Recovery Codes:
  - Siempre mantener recovery codes
  - Necesarios si IdP no disponible
  - Guardar en lugar seguro
```

---

## 🔄 SCIM Provisioning

### ¿Qué es SCIM?

```yaml
SCIM (System for Cross-domain Identity Management):
  - Protocolo para provisioning automático
  - Sincroniza usuarios desde IdP a GitHub
  - Crea/actualiza/elimina usuarios automáticamente

Flujo:
  1. Nuevo empleado agregado en IdP
  2. SCIM crea usuario en GitHub
  3. Usuario asignado a grupos en IdP
  4. SCIM sincroniza team membership
  5. Empleado despedido en IdP
  6. SCIM elimina de GitHub
```

### Configuración SCIM

```yaml
# Enterprise → Settings → Authentication security

SCIM Configuration:
  SCIM URL: https://api.github.com/scim/v2/enterprises/ENTERPRISE
  
  Token: [generar personal access token con scim:enterprise scope]
  
# En IdP (ejemplo Okta):
  SCIM Base URL: [URL de arriba]
  Authorization: Bearer [token]
  
  Provisioning Options:
    - Create Users: ✅
    - Update User Attributes: ✅
    - Deactivate Users: ✅
    
  Attribute Mapping:
    userName → login
    email → email  
    displayName → name
```

---

## 🎫 Personal Access Tokens

### Tipos de Tokens

```yaml
Classic Tokens:
  - Scopes amplios
  - No expiran por default
  - Menos granulares
  - Legacy, evitar en nuevo desarrollo

Fine-grained Tokens (Recomendado):
  - Permisos específicos por repo
  - Expiration obligatoria
  - Aprobación de org requerida
  - Audit trail completo
```

### Políticas de Tokens

```yaml
# Settings → Personal access tokens

Token Policies:
  
  Fine-grained tokens:
    Allow access via fine-grained tokens: ✅
    Require approval: ✅  # Recomendado
    
  Classic tokens:
    Allow access via classic tokens: 
      - Allow all  
      - Restrict (recomendado)
      - Deny (más seguro)

Token Requirements:
  Max lifetime: 90 days  # Forzar renovación
  Require approval for new tokens: true
```

### Aprobar Token Requests

```bash
# Listar pending requests
gh api \
  orgs/NOMBRE-ORG/personal-access-token-requests \
  --jq '.[] | "\(.id): \(.owner.login) - \(.token_name)"'

# Aprobar request
gh api \
  --method POST \
  orgs/NOMBRE-ORG/personal-access-token-requests/REQUEST_ID \
  -f action='approve'

# Denegar
gh api \
  --method POST \
  orgs/NOMBRE-ORG/personal-access-token-requests/REQUEST_ID \
  -f action='deny' \
  -f reason='Not approved for this use case'
```

---

## 🔑 SSH Key Management

### Políticas de SSH Keys

```yaml
# Settings → Security → SSH certificate authorities

SSH Key Policies:
  
  # Requerir SSH keys firmadas por CA
  Require SSH certificates: false  # Enterprise feature
  
  # Configurar CA
  SSH Certificate Authority:
    - Upload CA public key
    - Keys firmadas por esta CA son trusted

# Best practices para keys individuales:
  - Ed25519 preferido sobre RSA
  - Passphrase obligatoria
  - Expiration dates
  - Nombres descriptivos
```

### Audit de SSH Keys

```bash
# Ver SSH keys de la org (Enterprise)
gh api \
  enterprises/ENTERPRISE/audit-log \
  --jq '.[] | select(.action | startswith("public_key"))'

# Ver keys de un usuario
gh api \
  users/USERNAME/keys \
  --jq '.[] | "\(.id): \(.title)"'
```

---

## ⏱️ Session Management

### Session Policies

```yaml
# Enterprise → Settings → Authentication security

Session Duration:
  Web session timeout: 12 hours (configurable)
  
  # Después de timeout:
  - Usuario debe re-autenticarse
  - SAML flow se repite si SSO enabled

Concurrent Sessions:
  - Por default: ilimitadas
  - Considerar limitar para seguridad

Session Revocation:
  - Admin puede revocar sesiones
  - Útil para offboarding inmediato
  - Para incident response
```

### Revocar Sesiones

```bash
# Forzar logout de un usuario (Enterprise admin)
# Via UI: Enterprise → People → User → Sessions → Revoke

# El usuario deberá:
# 1. Re-autenticarse
# 2. Pasar por SAML SSO si habilitado
# 3. Completar 2FA
```

---

## 🛡️ Security Best Practices

### Authentication Checklist

```markdown
## Authentication Security Checklist

### Two-Factor Authentication
- [ ] 2FA required para toda la org
- [ ] Security keys para owners/admins
- [ ] Recovery codes almacenados seguro
- [ ] No SMS como único 2FA

### SAML SSO (si Enterprise)
- [ ] IdP configurado correctamente
- [ ] SSO enforced
- [ ] SCIM habilitado
- [ ] Team sync configurado

### Tokens
- [ ] Fine-grained tokens preferidos
- [ ] Max lifetime < 90 días
- [ ] Approval required
- [ ] Classic tokens restringidos

### SSH Keys
- [ ] Ed25519 preferido
- [ ] Passphrase required
- [ ] Key rotation policy
- [ ] Certificate authority (Enterprise)

### Sessions
- [ ] Session timeout configurado
- [ ] Review active sessions periódico
- [ ] Proceso de revocación documentado
```

### Incident Response

```yaml
Cuenta Comprometida:
  1. Revocar todas las sesiones del usuario
  2. Deshabilitar cuenta temporalmente
  3. Revisar audit log de actividad
  4. Revocar todos los tokens
  5. Rotar SSH keys
  6. Investigar scope del compromiso
  7. Reset de password post-investigación
  8. Re-habilitar con 2FA forzado
```

---

## 🔗 Recursos Adicionales

- [Requiring 2FA](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-two-factor-authentication-for-your-organization/requiring-two-factor-authentication-in-your-organization)
- [SAML SSO](https://docs.github.com/en/enterprise-cloud@latest/admin/identity-and-access-management/using-saml-for-enterprise-iam)
- [SCIM Provisioning](https://docs.github.com/en/enterprise-cloud@latest/admin/identity-and-access-management/using-saml-for-enterprise-iam/configuring-user-provisioning-with-scim-for-your-enterprise)
- [Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **2FA** | Siempre requerir, security keys para admins |
| **SAML SSO** | Autenticación federada via IdP |
| **SCIM** | Provisioning automático de usuarios |
| **Tokens** | Fine-grained con expiration < 90 días |
| **Sessions** | Timeout y revocación para seguridad |

---

**Siguiente**: [Lección 04 - Policies & Rulesets](04-policies-rulesets.md)
