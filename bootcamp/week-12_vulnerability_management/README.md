# 🔐 Week 12: Vulnerability Management

> **Fase 3: GitHub Advanced Security** - Semana 2 de 3
>
> **Duración**: 6 horas | **Nivel**: Intermedio-Avanzado

---

## 🎯 Objetivos de Aprendizaje

Al finalizar esta semana serás capaz de:

- ✅ Comprender el **ciclo de vida completo** de una vulnerabilidad
- ✅ Crear y gestionar **Security Advisories** (draft y publicados)
- ✅ Entender el proceso de asignación de **CVE** a través de GitHub
- ✅ Implementar **parches de seguridad** siguiendo mejores prácticas
- ✅ Establecer un **proceso de respuesta a incidentes** estructurado
- ✅ Utilizar recursos de **GitHub Security Lab**

---

## 📚 Requisitos Previos

- ✅ Completar Week 11 (Security Features)
- ✅ Conocimiento de Code Scanning, Dependabot y Secret Scanning
- ✅ Repository con dependencias (para análisis)
- ✅ Familiaridad con CVSS y severidades

---

## 🗂️ Estructura de la Semana

```
week-12/
├── README.md                 # Este archivo
├── rubrica-evaluacion.md     # Criterios de evaluación
├── 0-assets/                 # Diagramas SVG
│   ├── 01-vulnerability-lifecycle.svg
│   ├── 02-security-advisory-flow.svg
│   ├── 03-cve-process.svg
│   └── 04-incident-response.svg
├── 1-teoria/                 # Material teórico (90 min)
│   ├── 01-vulnerability-lifecycle.md
│   ├── 02-security-advisories.md
│   ├── 03-cve-process.md
│   └── 04-incident-response.md
├── 2-practicas/              # Ejercicios guiados (150 min)
│   ├── ejercicio-01-vulnerability-analysis/
│   ├── ejercicio-02-security-advisory/
│   ├── ejercicio-03-patch-implementation/
│   └── ejercicio-04-incident-simulation/
├── 3-proyecto/               # Proyecto semanal (2h)
├── 4-recursos/               # Material adicional
└── 5-glosario/               # Términos clave
```

---

## 📝 Contenidos

### 1️⃣ Teoría (90 minutos)

| # | Lección | Duración | Descripción |
|---|---------|----------|-------------|
| 01 | [Vulnerability Lifecycle](1-teoria/01-vulnerability-lifecycle.md) | 25 min | Detección, triage, remediación, disclosure |
| 02 | [Security Advisories](1-teoria/02-security-advisories.md) | 25 min | Crear, editar, publicar advisories en GitHub |
| 03 | [CVE Process](1-teoria/03-cve-process.md) | 20 min | Solicitar CVE, CNA de GitHub, GHSA |
| 04 | [Incident Response](1-teoria/04-incident-response.md) | 20 min | Plan de respuesta, comunicación, post-mortem |

### 2️⃣ Prácticas (150 minutos)

| # | Ejercicio | Duración | Habilidades |
|---|-----------|----------|-------------|
| 01 | [Vulnerability Analysis](2-practicas/ejercicio-01-vulnerability-analysis/) | 40 min | Triage, CVSS scoring, priorización |
| 02 | [Security Advisory](2-practicas/ejercicio-02-security-advisory/) | 40 min | Crear draft advisory, colaboradores |
| 03 | [Patch Implementation](2-practicas/ejercicio-03-patch-implementation/) | 35 min | Fix, private fork, coordinated release |
| 04 | [Incident Simulation](2-practicas/ejercicio-04-incident-simulation/) | 35 min | Simular respuesta completa a incidente |

### 3️⃣ Proyecto (2 horas)

**🛡️ Vulnerability Response Simulation**

Simular el ciclo completo de respuesta a una vulnerabilidad:
1. Recibir reporte de vulnerabilidad
2. Crear Security Advisory privado
3. Desarrollar fix en private fork
4. Solicitar CVE (simulado)
5. Coordinar disclosure y publicar

---

## ⏱️ Distribución del Tiempo (6 horas)

| Actividad | Tiempo | Porcentaje |
|-----------|--------|------------|
| 📖 Teoría | 1.5 horas | 25% |
| 💻 Prácticas | 2.5 horas | 42% |
| 🏗️ Proyecto | 2 horas | 33% |

---

## 📌 Entregables

1. ✅ Análisis de vulnerabilidad con CVSS score documentado
2. ✅ Security Advisory draft creado (o simulado)
3. ✅ Patch implementado siguiendo mejores prácticas
4. ✅ Plan de incident response documentado
5. ✅ Proyecto: Vulnerability Response Simulation completo

---

## 🔗 Quick Reference

### Crear Security Advisory

```
Repository → Security tab → Advisories → New draft security advisory
```

### Campos del Advisory

```yaml
# Información requerida
Ecosystem: npm / pip / maven / etc.
Package name: nombre-paquete
Affected versions: "< 1.2.3"
Patched versions: ">= 1.2.3"
Severity: Critical / High / Medium / Low

# CWE (Common Weakness Enumeration)
CWE-79: Cross-site Scripting (XSS)
CWE-89: SQL Injection
CWE-22: Path Traversal
CWE-78: OS Command Injection
```

### CVSS Calculator

```
Base Score = f(Attack Vector, Complexity, Privileges, User Interaction,
               Scope, Confidentiality, Integrity, Availability)

Severidad:
- None: 0.0
- Low: 0.1 - 3.9
- Medium: 4.0 - 6.9
- High: 7.0 - 8.9
- Critical: 9.0 - 10.0
```

### Workflow de Disclosure Coordinado

```
1. Reporte recibido → Acknowledger (48h)
2. Triage → Confirmar vulnerabilidad (5 días)
3. Fix development → Private fork
4. CVE request → A través de GitHub CNA
5. Release coordination → Fecha acordada
6. Public disclosure → Advisory + CVE publicados
```

---

## 🏆 Certificación

Esta semana cubre temas de **GitHub Advanced Security Certification**:
- Vulnerability management
- Security advisories
- Coordinated disclosure

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 11: Security Features](../week-11/README.md) | [Bootcamp](../README.md) | [Week 13: Security Policies](../week-13/README.md) |
3. ✅ Patch de seguridad implementado
4. ✅ Proceso de incident response documentado
5. ✅ Proyecto vulnerability response completado

---

## 🎓 Certificación Asociada

<table>
<tr>
<td>🏅</td>
<td><strong>GitHub Advanced Security</strong></td>
</tr>
<tr>
<td colspan="2">Esta semana cubre: Vulnerability management, Security advisories, Incident response - <strong>Semana final de preparación para certificación Advanced Security</strong></td>
</tr>
</table>

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Inicio | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Week 11: Security Features](../week-11/README.md) | [Bootcamp](../README.md) | [Week 13: Enterprise Administration](../week-13/README.md) |

---

_Week 12 | Bootcamp Git/GitHub_
