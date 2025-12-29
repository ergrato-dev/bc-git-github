# 📖 Glosario - Semana 11: Security Features

Términos clave relacionados con GitHub Advanced Security.

---

## 🔤 Índice Rápido

[C](#c) | [D](#d) | [G](#g) | [P](#p) | [S](#s) | [V](#v)

---

## C

### Code Scanning
Feature de GitHub que realiza **análisis estático de seguridad (SAST)** del código fuente. Usa CodeQL u otras herramientas para detectar vulnerabilidades como SQL Injection, XSS, etc.

### CodeQL
Motor de análisis semántico desarrollado por GitHub/Semmle. Trata el código como datos consultables mediante un lenguaje de queries similar a SQL.

### CVE (Common Vulnerabilities and Exposures)
Identificador único para vulnerabilidades de seguridad conocidas. Formato: `CVE-YYYY-NNNNN` (ej: CVE-2021-44228).

### CVSS (Common Vulnerability Scoring System)
Sistema de puntuación de 0.0 a 10.0 que mide la severidad de una vulnerabilidad. Rangos: Low (0.1-3.9), Medium (4.0-6.9), High (7.0-8.9), Critical (9.0-10.0).

### CWE (Common Weakness Enumeration)
Catálogo de tipos de debilidades de software. Ejemplo: CWE-89 (SQL Injection), CWE-79 (XSS).

---

## D

### Dependabot
Bot de GitHub que gestiona dependencias automáticamente. Tres funciones: **alerts** (notifica CVEs), **security updates** (PRs para CVEs), **version updates** (PRs para nuevas versiones).

### Dependabot Alerts
Notificaciones automáticas cuando una dependencia tiene una vulnerabilidad conocida en la GitHub Advisory Database.

### Dependency Graph
Visualización de todas las dependencias de un proyecto, incluyendo dependencias transitivas.

### Dependency Review
Feature que analiza cambios en dependencias durante un Pull Request. Puede bloquear PRs que introducen dependencias vulnerables.

---

## G

### GHAS (GitHub Advanced Security)
Conjunto de features de seguridad de GitHub que incluye Code Scanning, Secret Scanning (con Push Protection) y funcionalidades avanzadas para organizaciones.

### GHSA (GitHub Security Advisory)
Identificador de GitHub para advisories de seguridad. Formato: `GHSA-xxxx-xxxx-xxxx`.

### GitHub Advisory Database
Base de datos curada de vulnerabilidades de seguridad mantenida por GitHub, alimentada por CVE, NVD y contribuciones de la comunidad.

---

## P

### Push Protection
Feature de Secret Scanning que **bloquea** el `git push` cuando detecta secrets en el código, previniendo que lleguen al repositorio.

---

## S

### SARIF (Static Analysis Results Interchange Format)
Formato JSON estándar para resultados de análisis estático. CodeQL y otras herramientas generan SARIF para integrarse con GitHub.

### SAST (Static Application Security Testing)
Análisis de seguridad del código fuente **sin ejecutarlo**. Code Scanning con CodeQL es una herramienta SAST.

### SCA (Software Composition Analysis)
Análisis de dependencias de terceros para identificar vulnerabilidades. Dependabot es una herramienta SCA.

### Secret Scanning
Feature de GitHub que detecta credenciales expuestas en el código (tokens, API keys, passwords). Soporta 200+ patrones de proveedores.

### Security Advisory
Documento que describe una vulnerabilidad de seguridad, su impacto y cómo mitigarla. Pueden ser privados (draft) o públicos.

### Security Policy (SECURITY.md)
Archivo en la raíz del repository que define cómo reportar vulnerabilidades de forma responsable.

### Shift Left
Filosofía de seguridad que mueve las verificaciones de seguridad **más temprano** en el ciclo de desarrollo (hacia la "izquierda" del timeline).

---

## V

### Version Updates
Funcionalidad de Dependabot que crea PRs automáticos para mantener dependencias actualizadas, independientemente de si tienen vulnerabilidades.

### Vulnerability
Debilidad en software que puede ser explotada para comprometer seguridad, integridad o disponibilidad.

---

## 📊 Tabla de Severidades

| Nivel | CVSS Score | Acción Recomendada |
|-------|------------|-------------------|
| 🔴 Critical | 9.0 - 10.0 | Fix inmediato (24-48h) |
| 🟠 High | 7.0 - 8.9 | Fix urgente (días) |
| 🟡 Medium | 4.0 - 6.9 | Fix en sprint actual |
| ⚪ Low | 0.1 - 3.9 | Backlog |

---

## 🔗 Referencias

- [GitHub Security Glossary](https://docs.github.com/en/code-security/getting-started/github-security-features)
- [OWASP Glossary](https://owasp.org/www-community/Glossary)
- [CVE Dictionary](https://cve.mitre.org/)

---

[⬅️ Volver a Week 11](../README.md)
