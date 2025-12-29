# 🔑 Ejercicio 04: Secret Scanning

> **Duración**: 40 minutos
> 
> **Objetivo**: Configurar Secret Scanning, Push Protection y gestionar alertas.

---

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio serás capaz de:

- ✅ Habilitar Secret Scanning y Push Protection
- ✅ Entender el flujo de detección de secrets
- ✅ Gestionar alertas de secrets expuestos
- ✅ Configurar custom patterns (concepto)

---

## 📋 Requisitos Previos

- Repository público (Secret Scanning gratis) o GHAS license
- Tokens de prueba (generaremos algunos fake)
- Acceso a Settings del repository

---

## ⚠️ Nota Importante

> **ADVERTENCIA**: En este ejercicio usaremos tokens **falsos/inválidos** para propósitos de aprendizaje. **NUNCA** expongas tokens reales en un repository.

---

## 🏗️ Parte 1: Preparar Repository (8 min)

### Paso 1.1: Crear repository público

```bash
# ¿Qué hace?: Crea un nuevo repository para el ejercicio
mkdir security-lab-secret-scanning
cd security-lab-secret-scanning
git init
```

> **Nota**: Debe ser **público** para tener Secret Scanning gratis, o tener GHAS license para privados.

### Paso 1.2: Crear archivo de configuración

Crea `config/settings.js`:

```javascript
// config/settings.js
// Archivo de configuración de la aplicación

module.exports = {
    app: {
        name: 'Security Lab',
        version: '1.0.0',
        port: process.env.PORT || 3000
    },
    
    database: {
        host: process.env.DB_HOST || 'localhost',
        port: process.env.DB_PORT || 5432,
        name: process.env.DB_NAME || 'myapp'
        // Credentials should come from environment variables!
    },
    
    // ✅ CORRECTO: API keys desde variables de entorno
    api: {
        stripeKey: process.env.STRIPE_API_KEY,
        sendgridKey: process.env.SENDGRID_API_KEY
    }
};
```

### Paso 1.3: Crear README

```markdown
# Security Lab - Secret Scanning

Este proyecto es para practicar Secret Scanning de GitHub.

## Setup

```bash
npm install
cp .env.example .env
# Edita .env con tus credenciales
npm start
```

## Environment Variables

- `DB_HOST`: Database host
- `STRIPE_API_KEY`: Stripe API key
- `SENDGRID_API_KEY`: SendGrid API key
```

### Paso 1.4: Commit inicial seguro

```bash
git add .
git commit -m "feat: initial secure configuration"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/security-lab-secret-scanning.git
git push -u origin main
```

---

## 🔧 Parte 2: Habilitar Secret Scanning (5 min)

### Paso 2.1: Habilitar en Settings

```
Repository → Settings → Security → Code security and analysis
```

Habilita:
- ✅ Secret scanning
- ✅ Push protection

### Paso 2.2: Verificar estado

```
Security → Secret scanning alerts
```

Debería mostrar: "No secrets detected" ✅

---

## 🧪 Parte 3: Simular Exposición de Secret (12 min)

### Paso 3.1: Crear branch para prueba

```bash
git checkout -b test-secret-detection
```

### Paso 3.2: Crear archivo con "secrets" falsos

Crea `config/credentials.js`:

```javascript
// config/credentials.js
// ⚠️ ARCHIVO DE PRUEBA - TOKENS FALSOS PARA APRENDIZAJE
// NUNCA hagas esto con tokens reales

module.exports = {
    // ❌ MALO: Token hardcodeado (FALSO para demo)
    // Este formato simula un GitHub PAT pero es inválido
    github: {
        token: 'ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    },
    
    // ❌ MALO: AWS Key hardcodeada (FALSA para demo)
    aws: {
        accessKeyId: 'AKIAIOSFODNN7EXAMPLE',
        secretAccessKey: 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
    },
    
    // ❌ MALO: API Key de Stripe (FALSA para demo)
    stripe: {
        secretKey: 'sk_test_xxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    }
};
```

> **Nota**: Estos son ejemplos de formato, no tokens reales válidos.

### Paso 3.3: Intentar commit y push

```bash
git add config/credentials.js
git commit -m "feat: add API credentials (BAD PRACTICE)"
```

### Paso 3.4: Intentar push (debería ser bloqueado)

```bash
git push origin test-secret-detection
```

### Paso 3.5: Ver mensaje de Push Protection

Si Push Protection está activo y detecta el patrón, verás:

```
remote: error: GH009: Sorry, this push was blocked.
remote: 
remote: —— GitHub Secret Scanning ———————————————————————
remote: 
remote: Push cannot contain secrets
remote: 
remote:  GITHUB_TOKEN detected
remote:   — locations:
remote:     - commit: abc1234
remote:       path: config/credentials.js:7
remote: 
remote: To push, you must either:
remote:  1. Remove the secret from your commits
remote:  2. Visit the URL below to bypass (if false positive)
remote: 
remote: https://github.com/USER/REPO/security/secret-scanning/...
```

### Paso 3.6: Si NO fue bloqueado

Si el push pasó (porque los tokens eran demasiado "fake"), GitHub aún creará **alertas** post-push.

---

## 🔄 Parte 4: Gestionar Alertas (10 min)

### Paso 4.1: Ver alertas creadas

```
Repository → Security → Secret scanning alerts
```

### Paso 4.2: Examinar una alerta

```
┌─────────────────────────────────────────────────────────┐
│  🔴 AWS Access Key ID exposed                           │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Secret type: aws_access_key_id                        │
│  Secret: AKIA...MPLE (partially shown)                 │
│                                                         │
│  Location:                                             │
│  └─ config/credentials.js (line 13)                   │
│     └─ Commit: abc1234                                │
│                                                         │
│  Validity: ❓ Cannot verify (no partner program)       │
│                                                         │
│  [Close as: Revoked] [False positive] [Used in tests] │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Paso 4.3: Cerrar alerta como "Used in tests"

Para las alertas de este ejercicio:

1. Haz clic en la alerta
2. Selecciona "Close as resolved"
3. Razón: "Used in tests"
4. Agrega comentario: "Tokens falsos para ejercicio de aprendizaje"

### Paso 4.4: Verificar historial de alertas

```
Secret scanning alerts → Closed
```

---

## 🔧 Parte 5: Limpiar el Repository (5 min)

### Paso 5.1: Remover el archivo con secrets

```bash
# ¿Qué hace?: Elimina el archivo problemático
git rm config/credentials.js
git commit -m "fix: remove hardcoded credentials file"
```

### Paso 5.2: Crear archivo de ejemplo seguro

Crea `config/credentials.example.js`:

```javascript
// config/credentials.example.js
// ✅ CORRECTO: Archivo de ejemplo sin valores reales

module.exports = {
    github: {
        // Obtener de: https://github.com/settings/tokens
        token: process.env.GITHUB_TOKEN || 'YOUR_GITHUB_TOKEN_HERE'
    },
    
    aws: {
        // Obtener de: AWS IAM Console
        accessKeyId: process.env.AWS_ACCESS_KEY_ID || 'YOUR_AWS_KEY_HERE',
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY || 'YOUR_AWS_SECRET_HERE'
    },
    
    stripe: {
        // Obtener de: https://dashboard.stripe.com/apikeys
        secretKey: process.env.STRIPE_SECRET_KEY || 'YOUR_STRIPE_KEY_HERE'
    }
};
```

### Paso 5.3: Actualizar .gitignore

```bash
# .gitignore
# Ignorar archivos de credenciales reales
config/credentials.js
.env
.env.local
*.pem
*.key
```

### Paso 5.4: Commit y push

```bash
git add .
git commit -m "fix: add secure credential example and update gitignore"
git push origin test-secret-detection
```

### Paso 5.5: Mergear a main

Crea PR y mergea los cambios seguros.

---

## 📝 Parte 6: Crear SECURITY.md (5 min)

### Paso 6.1: Crear política de seguridad

Crea `SECURITY.md` en la raíz del repository:

```markdown
# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |

## Reporting a Vulnerability

Si descubres una vulnerabilidad de seguridad:

### ❌ NO hacer
- No crear un issue público
- No compartir detalles en redes sociales
- No explotar la vulnerabilidad

### ✅ SÍ hacer
1. Enviar email a: security@example.com
2. Incluir:
   - Descripción detallada
   - Pasos para reproducir
   - Impacto potencial
   - (Opcional) Sugerencia de fix

### Proceso
- **Respuesta inicial**: 48 horas
- **Evaluación**: 7 días
- **Fix (si aplica)**: 30-90 días según severidad
- **Divulgación**: Coordinada después del fix

## Security Measures

Este proyecto implementa:

- ✅ Secret Scanning habilitado
- ✅ Push Protection activo
- ✅ Dependabot alerts
- ✅ Code Scanning con CodeQL

## Best Practices for Contributors

1. **Nunca commit secrets** - Usa variables de entorno
2. **Revisa antes de push** - Verifica que no hay credenciales
3. **Usa .gitignore** - Excluye archivos sensibles
4. **Reporta** - Si ves algo, di algo
```

### Paso 6.2: Commit

```bash
git add SECURITY.md
git commit -m "docs: add security policy"
git push origin main
```

---

## ✅ Verificación Final

### Checklist de Completado

- [ ] Secret Scanning habilitado
- [ ] Push Protection habilitado
- [ ] Intento de push con secret (bloqueado o alertado)
- [ ] Alertas gestionadas correctamente
- [ ] Archivo de credentials removido
- [ ] Ejemplo seguro creado
- [ ] .gitignore actualizado
- [ ] SECURITY.md creado

### Ver estado final

```
Security → Overview
```

Debería mostrar:
- Secret scanning: Enabled ✅
- Push protection: Enabled ✅
- Alerts: 0 open ✅

---

## 📝 Preguntas de Reflexión

1. ¿Por qué Push Protection es importante vs solo alertas?
2. ¿Qué harías si un secret real se expone accidentalmente?
3. ¿Por qué los commits históricos siguen siendo un riesgo?
4. ¿Cuándo usarías "bypass" en Push Protection?

---

## 🎁 Bonus: Limpiar Historial (Avanzado)

Si necesitas remover un secret del historial de Git:

```bash
# ⚠️ PELIGRO: Esto reescribe el historial

# Opción 1: BFG Repo-Cleaner (recomendado)
# Descargar: https://rtyley.github.io/bfg-repo-cleaner/

# Remover archivo del historial
java -jar bfg.jar --delete-files credentials.js

# Limpiar y forzar push
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push origin --force --all
```

> **Importante**: Después de limpiar, aún debes **revocar y rotar** el secret expuesto.

---

## 🔗 Recursos

- [Secret Scanning Documentation](https://docs.github.com/en/code-security/secret-scanning)
- [Push Protection](https://docs.github.com/en/code-security/secret-scanning/push-protection-for-repositories-and-organizations)
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)
- [git-secrets (AWS)](https://github.com/awslabs/git-secrets)

---

## ✅ Fin de los Ejercicios

Has completado los 4 ejercicios prácticos de Security Features:

1. ✅ Code Scanning con CodeQL
2. ✅ Configurar Dependabot
3. ✅ Dependency Review
4. ✅ Secret Scanning

**Siguiente paso**: [Proyecto Semanal](../../3-proyecto/README.md)

---

[⬅️ Ejercicio 03](../ejercicio-03-dependency-review/README.md) | [Volver a Week 11](../../README.md)
