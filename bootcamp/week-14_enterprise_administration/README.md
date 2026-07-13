# 🏢 Week 14: Enterprise Administration

## GitHub Administration Certification - Fase 4, Semana 1 de 2

> **Tema**: Administración de Organizations, Teams, Permisos y Autenticación Enterprise

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana serás capaz de:

- ✅ **Administrar Organizations** - Crear y configurar organizaciones GitHub
- ✅ **Gestionar Teams** - Estructurar equipos con permisos apropiados
- ✅ **Configurar Permissions** - Implementar modelo de permisos granular
- ✅ **Implementar SSO/SAML** - Configurar autenticación enterprise
- ✅ **Aplicar Políticas** - Repository rulesets y branch protection
- ✅ **Gestionar Billing** - Licencias, seats y costos

---

## 📚 Contexto

### Posición en el Bootcamp

```
Fase 4: GitHub Administration (Semanas 14-15)
├── Week 14: Enterprise Administration ← ESTÁS AQUÍ
│   └── Organizations, Teams, Permissions, SSO
└── Week 15: Administration Avanzado
    └── Audit Logging, Automation, Migrations
```

### Prerequisitos

- ✅ Week 01-06: GitHub Foundations
- ✅ Week 07-10: GitHub Actions
- ✅ Week 11-13: GitHub Advanced Security
- 📋 Acceso a GitHub Organization (free tier suficiente)

---

## ⏱️ Distribución del Tiempo

**Total: 6 horas**

| Actividad | Tiempo | Porcentaje |
|-----------|--------|------------|
| 📖 Teoría | 1.5 horas | 25% |
| 💻 Prácticas | 2.5 horas | 42% |
| 🎯 Proyecto | 2 horas | 33% |

---

## 🗂️ Estructura de la Semana

```
week-14_enterprise_administration/
├── README.md                    # Este archivo
├── rubrica-evaluacion.md        # Criterios de evaluación (100 pts)
├── 0-assets/                    # Diagramas SVG
│   ├── 01-org-structure.svg
│   ├── 02-teams-permissions.svg
│   ├── 03-sso-flow.svg
│   └── 04-enterprise-hierarchy.svg
├── 1-teoria/                    # Material teórico (90 min)
│   ├── 01-organizations.md
│   ├── 02-teams-permissions.md
│   ├── 03-authentication-sso.md
│   └── 04-policies-rulesets.md
├── 2-practicas/                 # Ejercicios guiados (150 min)
│   ├── README.md
│   ├── ejercicio-01-org-setup/
│   ├── ejercicio-02-teams-structure/
│   ├── ejercicio-03-branch-protection/
│   └── ejercicio-04-security-policies/
├── 3-proyecto/                  # Proyecto semanal (120 min)
│   ├── README.md
│   └── solution/
├── 4-recursos/                  # Material adicional
│   └── README.md
└── 5-glosario/                  # Términos clave
    └── README.md
```

---

## 📖 Contenido Teórico

### Lección 1: Organizations (25 min)
- Crear y configurar Organizations
- Organization settings y profiles
- Member management
- Default permissions
- Organization-level security

### Lección 2: Teams & Permissions (25 min)
- Team hierarchy y nested teams
- Repository permission levels
- Team maintainers vs members
- CODEOWNERS integration
- Custom repository roles

### Lección 3: Authentication & SSO (20 min)
- Two-factor authentication enforcement
- SAML Single Sign-On
- SCIM provisioning
- Personal access tokens policies
- SSH key management

### Lección 4: Policies & Rulesets (20 min)
- Repository rulesets
- Branch protection rules
- Tag protection
- Push rules
- Deployment protection

---

## 💻 Ejercicios Prácticos

| # | Ejercicio | Duración | Descripción |
|---|-----------|----------|-------------|
| 01 | [Organization Setup](2-practicas/ejercicio-01-org-setup/) | 40 min | Crear y configurar una organization |
| 02 | [Teams Structure](2-practicas/ejercicio-02-teams-structure/) | 40 min | Diseñar estructura de teams |
| 03 | [Branch Protection](2-practicas/ejercicio-03-branch-protection/) | 35 min | Implementar rulesets |
| 04 | [Security Policies](2-practicas/ejercicio-04-security-policies/) | 35 min | 2FA enforcement, tokens y sesiones |

---

## 🎯 Proyecto Semanal

### Enterprise Organization Setup

Configurarás una **organización enterprise completa** para una empresa ficticia, incluyendo:

- Organization settings optimizados
- Estructura de teams jerárquica
- Modelo de permisos granular
- Repository rulesets
- Security policies
- Documentation

📁 Ver [instrucciones completas](3-proyecto/README.md)

---

## ✅ Criterios de Evaluación

| Componente | Puntos | Descripción |
|------------|--------|-------------|
| Teoría | 15 | Quiz de conceptos |
| Ejercicio 1 | 15 | Organization setup |
| Ejercicio 2 | 15 | Teams structure |
| Ejercicio 3 | 15 | Branch protection |
| Ejercicio 4 | 15 | SSO configuration |
| Proyecto | 25 | Enterprise org completa |
| **Total** | **100** | |

📋 Ver [rúbrica detallada](rubrica-evaluacion.md)

---

## 🔗 Recursos

### Documentación Oficial
- [Managing Organizations](https://docs.github.com/en/organizations)
- [Managing Teams](https://docs.github.com/en/organizations/organizing-members-into-teams)
- [Repository Roles](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles)
- [SAML SSO](https://docs.github.com/en/enterprise-cloud@latest/admin/identity-and-access-management/using-saml-for-enterprise-iam)

### Preparación Certificación
- [GitHub Administration Exam Guide](https://examregistration.github.com/certification/ADMIN)
- [GitHub Admin Learning Path](https://learn.microsoft.com/en-us/training/paths/github-administration/)

---

## 🧭 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 13: Security Policies](../week-13_security_policies_compliance/) | [Bootcamp](../README.md) | [Week 15: Admin Avanzado](../week-15_github_administration_avanzado/) |

---

**💡 Tip de la Semana**: La administración de GitHub es sobre **balance** - suficiente control para seguridad y compliance, pero suficiente flexibilidad para que los developers sean productivos.

### 3️⃣ Proyecto

**Proyecto Enterprise Setup**: Configurar Organization completa con teams, permisos y políticas de seguridad.

---

## ⏱️ Dedicación Semanal: 6 horas

| Actividad | Tiempo |
|-----------|--------|
| 📖 Teoría | 2.5 horas |
| 💻 Prácticas | 2 horas |
| 🏗️ Proyecto | 1.5 horas |

---

## 📌 Entregables

1. ✅ Organization configurada con estructura de teams
2. ✅ Permisos y roles documentados
3. ✅ Branch protection rules implementadas
4. ✅ Políticas de seguridad enterprise
5. ✅ Proyecto enterprise setup completado

---

## 🎓 Certificación Asociada

<table>
<tr>
<td>🏅</td>
<td><strong>GitHub Administration</strong></td>
</tr>
<tr>
<td colspan="2">Esta semana cubre: Organizations, Teams, Permissions, Enterprise policies - <strong>Primera semana de preparación para certificación Administration</strong></td>
</tr>
</table>

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 13: Security Policies](../week-13_security_policies_compliance/README.md) | [Bootcamp](../README.md) | [Week 15: Administration Avanzado](../week-15_github_administration_avanzado/README.md) |

---

_Week 14 | Bootcamp Git/GitHub | 6 horas_
