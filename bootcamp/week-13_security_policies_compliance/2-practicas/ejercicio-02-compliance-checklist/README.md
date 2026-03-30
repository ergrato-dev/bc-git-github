# Ejercicio 02: Compliance Checklist

## 🎯 Objetivo

Crear un checklist de compliance completo que mapee los controles de GitHub a los requisitos de múltiples frameworks regulatorios (SOC 2, GDPR, HIPAA, PCI-DSS, ISO 27001).

## ⏱️ Duración

40 minutos

## 📋 Contexto

Eres el **Compliance Officer** de **HealthTech Solutions**, una empresa que desarrolla software para el sector salud. Tu aplicación:

- Procesa datos de pacientes (PHI) → HIPAA
- Opera en Europa → GDPR
- Acepta pagos → PCI-DSS
- Es un servicio SaaS → SOC 2
- Busca certificación → ISO 27001

Necesitas crear un checklist que demuestre cómo GitHub ayuda a cumplir con estos frameworks.

---

## 📝 Instrucciones

### Parte 1: Matriz de Controles (20 minutos)

Crea una matriz que mapee controles de GitHub a requisitos de compliance.

#### 1.1 Access Control

Completa la siguiente tabla:

```markdown
## Access Control Mapping

| GitHub Control | SOC 2 | GDPR | HIPAA | PCI-DSS | ISO 27001 |
|----------------|-------|------|-------|---------|-----------|
| 2FA/MFA Enforcement | CC6.1 | Art.32 | §164.312(d) | 8.3 | A.8.5 |
| SAML/SSO | | | | | |
| Team Permissions | | | | | |
| Repository Access Levels | | | | | |
| Branch Protection | | | | | |
| CODEOWNERS | | | | | |
```

**Requisitos**:
- Mapear cada control a los 5 frameworks
- Incluir el artículo/sección específica
- Dejar vacío si no aplica directamente

#### 1.2 Audit & Monitoring

```markdown
## Audit & Monitoring Mapping

| GitHub Control | SOC 2 | GDPR | HIPAA | PCI-DSS | ISO 27001 |
|----------------|-------|------|-------|---------|-----------|
| Audit Log | CC7.2 | Art.30 | §164.312(b) | 10.1 | A.8.16 |
| Audit Log Streaming | | | | | |
| Security Overview | | | | | |
| Alert Notifications | | | | | |
| Webhooks | | | | | |
```

#### 1.3 Vulnerability Management

```markdown
## Vulnerability Management Mapping

| GitHub Control | SOC 2 | GDPR | HIPAA | PCI-DSS | ISO 27001 |
|----------------|-------|------|-------|---------|-----------|
| Dependabot Alerts | CC7.1 | Art.32 | §164.308(a)(1) | 6.1 | A.8.8 |
| Code Scanning | | | | | |
| Secret Scanning | | | | | |
| Push Protection | | | | | |
| Dependency Review | | | | | |
```

#### 1.4 Change Management

```markdown
## Change Management Mapping

| GitHub Control | SOC 2 | GDPR | HIPAA | PCI-DSS | ISO 27001 |
|----------------|-------|------|-------|---------|-----------|
| Pull Requests | CC8.1 | - | - | 6.4 | A.8.32 |
| Required Reviews | | | | | |
| Status Checks | | | | | |
| Signed Commits | | | | | |
| Protected Branches | | | | | |
```

---

### Parte 2: Checklist de Implementación (15 minutos)

Crea un checklist práctico para verificar la implementación de controles.

#### 2.1 Checklist por Framework

```markdown
## SOC 2 Type II Checklist

### CC6 - Logical and Physical Access Controls
- [ ] 2FA enforced for all organization members
- [ ] SSO configured with IdP
- [ ] Base permissions set to "Read" or lower
- [ ] [Agregar más controles...]

### CC7 - System Operations
- [ ] Audit log retention configured (90+ days)
- [ ] [Agregar más controles...]

### CC8 - Change Management
- [ ] Branch protection on main branches
- [ ] [Agregar más controles...]
```

Repite para:
- GDPR (enfoque en privacidad y derechos del interesado)
- HIPAA (enfoque en PHI protection)
- PCI-DSS (enfoque en datos de pago)
- ISO 27001 (enfoque en ISMS)

#### 2.2 Evidence Collection

Para cada control, documenta qué evidencia necesitas recolectar:

```markdown
## Evidence Collection Guide

| Control | Evidence Type | How to Collect | Retention |
|---------|---------------|----------------|-----------|
| 2FA Enforcement | Screenshot + Report | Org settings + API | 1 year |
| Audit Log | Export JSON | gh api /orgs/{org}/audit-log | 7 years |
| Branch Protection | Config export | gh api /repos/{owner}/{repo}/branches/{branch}/protection | 1 year |
| [Agregar más...] | | | |
```

---

### Parte 3: Workflow de Auditoría (5 minutos)

Crea un GitHub Action que automatice la verificación de compliance:

```yaml
# .github/workflows/compliance-check.yml
name: Compliance Verification

on:
  schedule:
    - cron: '0 0 1 * *'  # Monthly
  workflow_dispatch:

jobs:
  compliance-check:
    runs-on: ubuntu-latest
    steps:
      - name: Check 2FA Status
        # [Implementar verificación]
        
      - name: Check Branch Protection
        # [Implementar verificación]
        
      - name: Generate Compliance Report
        # [Generar reporte]
        
      - name: Upload Evidence
        # [Subir evidencia]
```

**Requisitos**:
- Al menos 5 verificaciones automáticas
- Generación de reporte
- Almacenamiento de evidencia

---

## 📦 Entregables

1. **compliance-matrix.md** - Matriz completa de mapeo de controles
2. **implementation-checklist.md** - Checklist por framework
3. **evidence-guide.md** - Guía de recolección de evidencia
4. **compliance-check.yml** - GitHub Action de verificación

---

## ✅ Criterios de Éxito

| Criterio | Puntos |
|----------|--------|
| Matriz de controles completa (4 categorías) | 30 |
| Mapeo correcto a los 5 frameworks | 20 |
| Checklists prácticos y accionables | 20 |
| Guía de evidencia útil | 15 |
| Workflow de automatización funcional | 15 |
| **Total** | **100** |

---

## 💡 Tips

1. **Investiga**: Cada framework tiene documentación oficial
2. **Sé práctico**: Los checklists deben ser ejecutables
3. **Automatiza**: Lo que se puede automatizar, automatízalo
4. **Documenta**: Los auditores necesitan trazabilidad
5. **Prioriza**: No todos los controles tienen el mismo peso

---

## 🔗 Recursos

- [SOC 2 Trust Services Criteria](https://www.aicpa.org/content/dam/aicpa/interestareas/frc/assuranceadvisoryservices/downloadabledocuments/trust-services-criteria.pdf)
- [GDPR Official Text](https://gdpr-info.eu/)
- [HIPAA Security Rule](https://www.hhs.gov/hipaa/for-professionals/security/index.html)
- [PCI-DSS v4.0 Requirements](https://www.pcisecuritystandards.org/document_library/)
- [ISO 27001:2022 Controls](https://www.iso.org/standard/27001)

---

## 📁 Estructura de Archivos

```
ejercicio-02-compliance-checklist/
├── README.md                    # Este archivo
├── starter/
│   └── matrix-template.md       # Plantilla de matriz
└── solution/
    ├── compliance-matrix.md     # Matriz completa
    ├── implementation-checklist.md
    ├── evidence-guide.md
    └── compliance-check.yml
```
