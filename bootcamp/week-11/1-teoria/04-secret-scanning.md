# 🔑 Lección 04: Secret Scanning

> **Duración**: 20 minutos
> 
> **Objetivos**: Configurar Secret Scanning, Push Protection y Custom Patterns.

---

## 📋 Tabla de Contenidos

1. [¿Qué es Secret Scanning?](#-qué-es-secret-scanning)
2. [Tipos de Secrets Detectados](#-tipos-de-secrets-detectados)
3. [Push Protection](#-push-protection)
4. [Gestión de Alertas](#-gestión-de-alertas)
5. [Custom Patterns](#-custom-patterns)
6. [Partner Programs](#-partner-programs)

---

## 🎯 ¿Qué es Secret Scanning?

**Secret Scanning** detecta credenciales expuestas accidentalmente en tu código, previniendo brechas de seguridad.

![Secret Scanning](../0-assets/04-secret-scanning.svg)

### Dos Modos de Operación

```
┌─────────────────────────────────────────────────────────┐
│                 SECRET SCANNING                          │
├────────────────────────┬────────────────────────────────┤
│   🔍 HISTORICAL        │   🛡️ PUSH PROTECTION           │
│      SCANNING          │                                │
├────────────────────────┼────────────────────────────────┤
│ Escanea TODO el        │ Bloquea push ANTES            │
│ historial del repo     │ de que entre al repo          │
├────────────────────────┼────────────────────────────────┤
│ Detecta secrets        │ Previene que secrets          │
│ ya expuestos           │ lleguen al historial          │
├────────────────────────┼────────────────────────────────┤
│ Crea alertas           │ Rechaza el git push           │
│ para remediar          │ inmediatamente                │
└────────────────────────┴────────────────────────────────┘
```

### Habilitar Secret Scanning

```
Settings → Security → Code security and analysis
→ Secret scanning: Enable
→ Push protection: Enable (recomendado)
```

---

## 🔐 Tipos de Secrets Detectados

GitHub detecta **200+ tipos de secrets** de más de 100 proveedores.

### Categorías Principales

| Categoría | Ejemplos |
|-----------|----------|
| **Cloud Providers** | AWS, Azure, GCP, DigitalOcean |
| **Version Control** | GitHub, GitLab, Bitbucket tokens |
| **CI/CD** | CircleCI, Travis, Jenkins |
| **Databases** | MongoDB, Redis, PostgreSQL |
| **Communication** | Slack, Discord, Twilio |
| **Payment** | Stripe, PayPal, Square |
| **Package Registries** | npm, PyPI, NuGet |

### Patrones de GitHub Tokens

```
┌──────────────────────────────────────────────────────┐
│           GITHUB TOKEN PREFIXES                       │
├──────────────────────────────────────────────────────┤
│                                                      │
│  ghp_xxxx   →  Personal Access Token (classic)      │
│  github_pat_xxxx  →  Fine-grained PAT              │
│  gho_xxxx   →  OAuth Access Token                   │
│  ghu_xxxx   →  User-to-Server Token                │
│  ghs_xxxx   →  Server-to-Server Token              │
│  ghr_xxxx   →  Refresh Token                       │
│                                                      │
└──────────────────────────────────────────────────────┘
```

### Ejemplo: AWS Access Key

```
# Pattern detectado:
AKIA[0-9A-Z]{16}

# Ejemplos que serían detectados:
AKIAIOSFODNN7EXAMPLE
AKIAI44QH8DHBEXAMPLE
```

---

## 🛡️ Push Protection

**Push Protection** bloquea commits que contienen secrets **antes** de que lleguen al repositorio.

### Flujo de Push Protection

```
Developer           GitHub              Result
    │                  │                  │
    │  git push        │                  │
    │─────────────────►│                  │
    │                  │  Scan commit     │
    │                  │  for secrets     │
    │                  │                  │
    │  Secret found!   │                  │
    │◄─────────────────│                  │
    │                  │                  │
    │  Push BLOCKED    │                  │
    │                  │                  │
    ▼                  ▼                  ▼
```

### Mensaje de Error

```bash
$ git push origin main

remote: error: GH009: Sorry, this push was blocked.
remote:
remote: —— GitHub Secret Scanning ——————————————————————
remote:
remote: Push cannot contain secrets
remote:
remote:  GITHUB_TOKEN (GitHub Token)
remote:   — locations:
remote:     - commit: abc1234
remote:       path: config/secrets.js:15
remote:
remote: To push this code, you must either:
remote:
remote:  1. Remove the secret from your commits
remote:
remote:  2. If this is a false positive, visit:
remote:     https://github.com/owner/repo/security/secret-scanning/...
remote:     to bypass this block
remote:
remote: ———————————————————————————————————————————————
```

### Opciones del Developer

| Opción | Cuándo Usar |
|--------|-------------|
| **Remover secret** | El secret es real, debe quitarse |
| **Bypass: It's a test** | Es un secret de prueba/mock |
| **Bypass: False positive** | No es un secret real |
| **Bypass: Will fix later** | Urgencia (registra responsable) |

### Bypass con Justificación

```bash
# El bypass queda registrado:
# - Quién hizo bypass
# - Qué justificación dio
# - Cuándo lo hizo
# - Qué secret era

# Los administradores pueden revisar bypasses en:
# Security → Secret scanning → Bypassed pushes
```

---

## 📊 Gestión de Alertas

### Ver Alertas

```
Repository → Security → Secret scanning alerts
```

### Anatomía de una Alerta

```
┌─────────────────────────────────────────────────────────┐
│  🔴 GitHub Personal Access Token exposed                │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Secret type: github_personal_access_token             │
│  Secret: ghp_xxxx...xxxx (partially hidden)            │
│                                                         │
│  Location:                                             │
│  └─ config/auth.js (line 23)                          │
│     └─ Commit: abc1234 by @developer                  │
│        └─ Date: 2024-01-15                            │
│                                                         │
│  Validity: ✅ Active (GitHub verified)                 │
│                                                         │
│  ⚠️ This secret is still valid and should be revoked  │
│                                                         │
│  [Close as: Revoked] [False positive] [Used in tests] │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Estados de Alertas

| Estado | Significado |
|--------|-------------|
| **Open** | Requiere acción |
| **Closed: Revoked** | Secret fue revocado |
| **Closed: False positive** | No era un secret real |
| **Closed: Used in tests** | Secret de prueba |
| **Closed: Won't fix** | Riesgo aceptado |

### Proceso de Remediación

```
┌─────────────────────────────────────────────────────────┐
│           PROCESO DE REMEDIACIÓN                        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. 🔔 Recibir alerta                                  │
│        ↓                                               │
│  2. 🔍 Verificar si es válido                         │
│        ↓                                               │
│  3. 🔄 REVOCAR el secret (inmediatamente!)            │
│        ↓                                               │
│  4. 🔑 Rotar: crear nuevo secret                      │
│        ↓                                               │
│  5. 🔧 Actualizar donde se usa                        │
│        ↓                                               │
│  6. ✅ Cerrar la alerta                               │
│        ↓                                               │
│  7. 🧹 (Opcional) Limpiar historial de git            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Comandos para Limpiar Historial

```bash
# ⚠️ CUIDADO: Esto reescribe el historial

# Opción 1: BFG Repo-Cleaner (recomendado)
bfg --delete-files secrets.js
bfg --replace-text passwords.txt

# Opción 2: git filter-branch
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch config/secrets.js" \
  --prune-empty --tag-name-filter cat -- --all

# Forzar push después de limpiar
git push origin --force --all
git push origin --force --tags
```

---

## 🎨 Custom Patterns

Para secrets internos que GitHub no detecta automáticamente, puedes crear **Custom Patterns**.

### Crear Custom Pattern (Organization Level)

```
Organization → Settings → Security → Code security
→ Secret scanning → Custom patterns → New pattern
```

### Anatomía de un Custom Pattern

```yaml
Pattern Name: Internal API Key
Secret Format: Regular Expression

# Pattern (regex):
internal_api_[a-zA-Z0-9]{32}

# Test string (para validar):
internal_api_abc123def456ghi789jkl012mno345

# Before secret (opcional):
API_KEY=
apiKey:

# After secret (opcional):
[^a-zA-Z0-9]
$
```

### Ejemplos de Custom Patterns

| Nombre | Regex | Descripción |
|--------|-------|-------------|
| Internal API Key | `internal_api_[a-zA-Z0-9]{32}` | Keys internas |
| Database Password | `DB_PASSWORD=['"][^'"]{8,}['"]` | Passwords de DB |
| JWT Secret | `JWT_SECRET=['"][^'"]{20,}['"]` | Secrets de JWT |
| Company Token | `MYCOMPANY_[A-Z0-9]{16}` | Tokens corporativos |

### Dry Run Mode

```
# Antes de habilitar alertas, puedes hacer "dry run":
# - Escanea el repo
# - Muestra qué encontraría
# - No crea alertas reales

Custom pattern → Edit → Enable in dry run mode
```

---

## 🤝 Partner Programs

GitHub tiene acuerdos con proveedores de servicios para **notificación automática** de secrets expuestos.

### Flujo con Partners

```
┌─────────────────────────────────────────────────────────┐
│           PARTNER NOTIFICATION FLOW                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. Developer expone AWS key en repo público           │
│        ↓                                               │
│  2. GitHub detecta el secret                           │
│        ↓                                               │
│  3. GitHub notifica a AWS (automático)                 │
│        ↓                                               │
│  4. AWS revoca la key (automático)                     │
│        ↓                                               │
│  5. AWS notifica al dueño de la cuenta                │
│        ↓                                               │
│  6. GitHub crea alerta en el repo                      │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Partners que Revocan Automáticamente

| Partner | Tipo de Secret | Auto-revoke |
|---------|---------------|-------------|
| AWS | Access Keys | ✅ |
| Azure | Service Principal | ✅ |
| Stripe | API Keys | ✅ |
| Slack | Tokens | ✅ |
| npm | Access Tokens | ✅ |
| GitHub | PATs | ✅ |

---

## 🔧 Configuración via API

### Habilitar Secret Scanning

```bash
# ¿Qué hace?: Habilita secret scanning en un repo
# ¿Por qué?: Automatizar configuración
# ¿Para qué sirve?: Scripts de onboarding

curl -X PATCH \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/OWNER/REPO \
  -d '{"security_and_analysis":{"secret_scanning":{"status":"enabled"}}}'
```

### Listar Alertas

```bash
# ¿Qué hace?: Lista alertas de secret scanning
curl -H "Authorization: Bearer $GITHUB_TOKEN" \
  https://api.github.com/repos/OWNER/REPO/secret-scanning/alerts
```

---

## 📝 Resumen

| Feature | Descripción | Disponibilidad |
|---------|-------------|----------------|
| **Secret Scanning** | Detecta secrets en código | Public: Free, Private: GHAS |
| **Push Protection** | Bloquea push con secrets | Public: Free, Private: GHAS |
| **Custom Patterns** | Patrones personalizados | GHAS (org level) |
| **Partner Alerts** | Notificación a proveedores | Todos |

### Checklist de Configuración

- [ ] Secret scanning habilitado
- [ ] Push protection habilitado
- [ ] Custom patterns configurados (si aplica)
- [ ] Alertas existentes revisadas
- [ ] Proceso de remediación documentado

### Best Practices

1. **Siempre habilita Push Protection** - Prevenir > Remediar
2. **Nunca commits secrets** - Usa environment variables
3. **Rota inmediatamente** - Un secret expuesto está comprometido
4. **Revisa el historial** - Secrets en commits antiguos siguen siendo riesgo
5. **Usa secret managers** - HashiCorp Vault, AWS Secrets Manager

---

## 🔗 Recursos

- [Secret Scanning Docs](https://docs.github.com/en/code-security/secret-scanning)
- [Supported Secret Types](https://docs.github.com/en/code-security/secret-scanning/secret-scanning-patterns)
- [Custom Patterns](https://docs.github.com/en/code-security/secret-scanning/defining-custom-patterns-for-secret-scanning)
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)

---

## ✅ Fin de la Teoría

Has completado las 4 lecciones teóricas de Security Features:

1. ✅ GitHub Advanced Security Overview
2. ✅ Code Scanning con CodeQL
3. ✅ Dependabot
4. ✅ Secret Scanning

**Siguiente paso**: [Ejercicios Prácticos](../2-practicas/README.md)

---

[⬅️ Volver a Week 11](../README.md)
