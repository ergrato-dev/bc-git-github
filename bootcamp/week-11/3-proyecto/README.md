# �️ Proyecto: Security Hardening Pipeline

> **Duración**: 2 horas
> 
> **Objetivo**: Implementar un pipeline completo de seguridad que integre todas las features de GHAS.

---

## 🎯 Descripción

En este proyecto implementarás **todas las features de seguridad** de GitHub en un repository existente, creando un "Security Hardening Pipeline" completo que proteja el código en cada etapa del desarrollo.

---

## 📋 Requisitos

### Prerrequisitos
- Completar los 4 ejercicios prácticos de la semana
- Repository con código (JavaScript/Python recomendado)
- Cuenta GitHub con acceso a Security features

### Entregables

1. **Repository con Security Features habilitados**
   - Code Scanning con CodeQL
   - Dependabot alerts + security updates
   - Secret Scanning + Push Protection
   - Dependency Review en PRs

2. **Archivos de configuración**
   - `.github/workflows/codeql.yml`
   - `.github/workflows/dependency-review.yml`
   - `.github/dependabot.yml`
   - `SECURITY.md`

3. **Documentación**
   - README actualizado con badges de seguridad
   - Documento explicando la implementación

---

## 🏗️ Estructura del Proyecto

```
mi-proyecto-seguro/
├── .github/
│   ├── workflows/
│   │   ├── codeql.yml              # Code Scanning
│   │   ├── dependency-review.yml    # Análisis de deps en PRs
│   │   └── dependabot-auto-merge.yml # (Bonus) Auto-merge
│   └── dependabot.yml              # Version updates
├── SECURITY.md                      # Política de seguridad
├── README.md                        # Con badges de seguridad
└── [tu código fuente]
```

---

## 📝 Instrucciones

### Parte 1: Configurar Code Scanning (25 min)

1. **Habilitar Code Scanning**
   ```
   Settings → Security → Code security and analysis
   → Code scanning → Set up → Default (o Advanced)
   ```

2. **Verificar workflow** (si usas Advanced):
   ```yaml
   # .github/workflows/codeql.yml
   name: "CodeQL"
   on:
     push:
       branches: [main]
     pull_request:
       branches: [main]
     schedule:
       - cron: '0 6 * * 1'
   
   jobs:
     analyze:
       runs-on: ubuntu-latest
       permissions:
         security-events: write
       steps:
         - uses: actions/checkout@v4
         - uses: github/codeql-action/init@v3
           with:
             languages: javascript  # o python, java, etc.
         - uses: github/codeql-action/analyze@v3
   ```

3. **Ejecutar y verificar resultados**
   - Actions → CodeQL → Ver ejecución
   - Security → Code scanning alerts

### Parte 2: Configurar Dependabot (25 min)

1. **Habilitar Dependabot**
   ```
   Settings → Security → Code security and analysis
   → Dependabot alerts: Enable
   → Dependabot security updates: Enable
   ```

2. **Crear dependabot.yml**
   ```yaml
   # .github/dependabot.yml
   version: 2
   updates:
     - package-ecosystem: "npm"  # o pip, maven, etc.
       directory: "/"
       schedule:
         interval: "weekly"
       labels:
         - "dependencies"
       commit-message:
         prefix: "deps"
       groups:
         patches:
           update-types: ["patch"]
     
     - package-ecosystem: "github-actions"
       directory: "/"
       schedule:
         interval: "weekly"
       labels:
         - "ci"
   ```

3. **Verificar PRs generados**
   - Pull requests → filtrar por author:dependabot

### Parte 3: Configurar Dependency Review (20 min)

1. **Crear workflow**
   ```yaml
   # .github/workflows/dependency-review.yml
   name: "Dependency Review"
   on:
     pull_request:
       branches: [main]
   
   permissions:
     contents: read
     pull-requests: write
   
   jobs:
     dependency-review:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - uses: actions/dependency-review-action@v4
           with:
             fail-on-severity: moderate
             allow-licenses: MIT, Apache-2.0, BSD-2-Clause, BSD-3-Clause, ISC
             comment-summary-in-pr: always
   ```

2. **Probar con un PR** que agregue una dependencia

### Parte 4: Configurar Secret Scanning (15 min)

1. **Habilitar Secret Scanning**
   ```
   Settings → Security → Code security and analysis
   → Secret scanning: Enable
   → Push protection: Enable
   ```

2. **Verificar alertas existentes**
   - Security → Secret scanning alerts

### Parte 5: Crear SECURITY.md (15 min)

```markdown
# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

### Contact
- Email: security@tudominio.com
- Response time: 48 hours

### Process
1. Report via email (not public issue)
2. Include detailed description
3. Wait for confirmation
4. Coordinated disclosure after fix

## Security Measures

This repository implements:

- ✅ Code Scanning with CodeQL
- ✅ Dependabot alerts and updates
- ✅ Secret Scanning with Push Protection
- ✅ Dependency Review on PRs
- ✅ Branch protection rules
```

### Parte 6: Actualizar README con Badges (10 min)

Agrega al inicio de tu README.md:

```markdown
# Mi Proyecto Seguro

![CodeQL](https://github.com/USER/REPO/workflows/CodeQL/badge.svg)
![Dependency Review](https://github.com/USER/REPO/workflows/Dependency%20Review/badge.svg)

## Security

See [SECURITY.md](SECURITY.md) for our security policy.

[![Security Rating](https://img.shields.io/badge/security-A+-brightgreen)](./SECURITY.md)
```

### Parte 7: Documentar (10 min)

Crea un archivo `docs/SECURITY-IMPLEMENTATION.md`:

```markdown
# Security Implementation

## Features Implemented

### 1. Code Scanning
- **Tool**: CodeQL
- **Languages**: JavaScript
- **Schedule**: Weekly + on PR
- **Severity threshold**: High

### 2. Dependabot
- **Ecosystems**: npm, github-actions
- **Schedule**: Weekly
- **Auto-merge**: Patches only

### 3. Secret Scanning
- **Push Protection**: Enabled
- **Custom Patterns**: None (using defaults)

### 4. Dependency Review
- **Fail on**: Moderate+
- **License check**: MIT, Apache-2.0, BSD

## Metrics (at implementation)
- Open code scanning alerts: X
- Open Dependabot alerts: X
- Secret scanning alerts: X
```

---

## 📊 Criterios de Evaluación

| Criterio | Puntos | Verificación |
|----------|--------|--------------|
| Code Scanning habilitado | 15 pts | Actions → CodeQL ejecutándose |
| Dependabot configurado | 15 pts | dependabot.yml válido |
| Dependency Review | 15 pts | Workflow en PRs |
| Secret Scanning + Push Protection | 10 pts | Settings verificados |
| SECURITY.md completo | 10 pts | Política clara |
| README con badges | 5 pts | Badges visibles |
| Documentación | 5 pts | SECURITY-IMPLEMENTATION.md |
| **Total** | **75 pts** | |

### Bonus (hasta 25 pts adicionales)
- Auto-merge workflow para Dependabot (+10 pts)
- Branch protection con required checks (+10 pts)
- Custom CodeQL queries (+5 pts)

---

## ✅ Checklist de Entrega

- [ ] Code Scanning configurado y ejecutado
- [ ] Dependabot alerts habilitado
- [ ] dependabot.yml con al menos 2 ecosistemas
- [ ] Dependency Review workflow funcional
- [ ] Secret Scanning + Push Protection activos
- [ ] SECURITY.md creado
- [ ] README con badges de seguridad
- [ ] Documentación de implementación

---

## 🔗 Recursos

- [GitHub Security Best Practices](https://docs.github.com/en/code-security/getting-started/github-security-features)
- [CodeQL Documentation](https://codeql.github.com/docs/)
- [Dependabot Configuration](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file)

---

[⬅️ Volver a Week 11](../README.md)
- Preguntar en el foro o Discord del bootcamp

---

**💡 Tip:** Comienza temprano y no dudes en pedir ayuda si te atascas. El objetivo es aprender, no solo entregar.
