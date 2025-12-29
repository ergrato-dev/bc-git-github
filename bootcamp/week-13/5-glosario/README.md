# 📖 Glosario - Semana 13

## Security Policies & Compliance

Términos clave y definiciones para la Semana 13 del bootcamp.

---

## A

### Acknowledgment
**Definición**: Confirmación formal de recepción de un reporte de vulnerabilidad.  
**Contexto**: Primer paso en el proceso de VDP tras recibir un reporte.  
**Ejemplo**: "Enviamos acknowledgment dentro de 48 horas de recibir el reporte."

### Audit Log
**Definición**: Registro cronológico de eventos y acciones en un sistema.  
**Contexto**: GitHub mantiene audit logs de todas las acciones en organizaciones enterprise.  
**Ejemplo**: `gh api /orgs/{org}/audit-log --paginate`

### Audit Log Streaming
**Definición**: Envío en tiempo real de eventos de auditoría a sistemas externos.  
**Contexto**: Permite integrar logs de GitHub con SIEM (Splunk, Datadog, etc.).

---

## B

### BAA (Business Associate Agreement)
**Definición**: Contrato requerido por HIPAA entre entidades que manejan PHI.  
**Contexto**: GitHub Enterprise Cloud puede firmar BAA para clientes healthcare.

### Branch Protection
**Definición**: Reglas que restringen acciones en branches específicos.  
**Contexto**: Control de compliance que requiere reviews y checks antes de merge.

### Bug Bounty
**Definición**: Programa que ofrece compensación monetaria por reportes de vulnerabilidades.  
**Contexto**: Extensión de un VDP con incentivos financieros.  
**Diferencia con VDP**: VDP ofrece reconocimiento; bug bounty ofrece dinero.

---

## C

### CISO (Chief Information Security Officer)
**Definición**: Ejecutivo responsable de la estrategia de seguridad de la organización.  
**Contexto**: Típicamente el sponsor ejecutivo de iniciativas GHAS.

### Code Scanning
**Definición**: Análisis estático de código para detectar vulnerabilidades.  
**Contexto**: Feature de GHAS que usa CodeQL para encontrar security issues.

### CodeQL
**Definición**: Motor de análisis semántico de código desarrollado por GitHub.  
**Contexto**: Lenguaje de queries para encontrar patrones de vulnerabilidades.

### Compliance
**Definición**: Estado de conformidad con regulaciones, estándares o políticas.  
**Contexto**: Las organizaciones deben demostrar compliance con frameworks como SOC 2.

### Coordinated Disclosure
**Definición**: Proceso donde researcher y vendor acuerdan fecha de publicación.  
**Contexto**: También llamado "responsible disclosure", típicamente 90 días.

### CVSS (Common Vulnerability Scoring System)
**Definición**: Estándar para evaluar la severidad de vulnerabilidades.  
**Contexto**: Escala de 0.0 a 10.0; Critical (9.0+), High (7.0-8.9), Medium (4.0-6.9), Low (0.1-3.9).  
**Ejemplo**: SQL Injection sin autenticación: CVSS 9.8 (Critical)

### CVE (Common Vulnerabilities and Exposures)
**Definición**: Identificador único para vulnerabilidades conocidas públicamente.  
**Contexto**: GitHub puede solicitar CVEs para advisories publicados.  
**Formato**: CVE-YYYY-NNNNN (ej: CVE-2024-12345)

---

## D

### Dependency Review
**Definición**: Análisis de cambios en dependencias durante pull requests.  
**Contexto**: Bloquea PRs que introducen dependencias con vulnerabilidades conocidas.

### Dependabot
**Definición**: Herramienta de GitHub para gestión automatizada de dependencias.  
**Componentes**: Alerts (notificaciones), Updates (PRs automáticos), Security Updates.

### Disclosure Timeline
**Definición**: Período acordado entre reporte y publicación pública.  
**Contexto**: Estándar de la industria: 90 días desde el reporte inicial.

---

## E

### Evidence
**Definición**: Documentación que demuestra implementación de controles.  
**Contexto**: Los auditores requieren evidence para verificar compliance.  
**Ejemplos**: Screenshots, exports de configuración, logs.

---

## F

### False Positive
**Definición**: Alerta de seguridad que no representa una vulnerabilidad real.  
**Contexto**: Reducir false positives mejora la adopción de herramientas de seguridad.

### Full Disclosure
**Definición**: Publicación inmediata de vulnerabilidad sin coordinación con vendor.  
**Contexto**: Práctica controversial; el coordinated disclosure es preferido.

---

## G

### GDPR (General Data Protection Regulation)
**Definición**: Regulación de protección de datos de la Unión Europea.  
**Contexto**: Aplica a cualquier organización que procese datos de ciudadanos EU.  
**Artículos clave**: Art. 32 (Seguridad), Art. 33 (Notificación de brechas).

### GHAS (GitHub Advanced Security)
**Definición**: Suite de herramientas de seguridad avanzadas de GitHub.  
**Componentes**: Code Scanning, Secret Scanning, Push Protection, Dependency Review.  
**Disponibilidad**: Incluido en repos públicos; add-on de pago para privados (Enterprise).

### Governance
**Definición**: Estructura de roles, responsabilidades y procesos de decisión.  
**Contexto**: GHAS enterprise requiere governance clara para éxito a escala.

---

## H

### Hall of Fame
**Definición**: Página pública que reconoce a researchers que reportaron vulnerabilidades.  
**Contexto**: Forma de reconocimiento no monetario en programas VDP.

### HIPAA (Health Insurance Portability and Accountability Act)
**Definición**: Ley de USA que protege información de salud (PHI).  
**Contexto**: Organizaciones healthcare deben cumplir con Security Rule y Privacy Rule.

---

## I

### ISMS (Information Security Management System)
**Definición**: Sistema de gestión de seguridad de información según ISO 27001.  
**Contexto**: Framework para gestionar riesgos de seguridad de forma sistemática.

### ISO 27001
**Definición**: Estándar internacional para gestión de seguridad de información.  
**Contexto**: Certificación reconocida globalmente; auditoría cada 3 años.

---

## M

### MTTR (Mean Time To Remediate)
**Definición**: Tiempo promedio desde detección hasta resolución de vulnerabilidad.  
**Contexto**: Métrica clave de eficiencia del programa de seguridad.  
**Target típico**: Critical <48h, High <7d, Medium <30d.

### MFA/2FA (Multi-Factor Authentication)
**Definición**: Autenticación que requiere múltiples factores de verificación.  
**Contexto**: Control de seguridad fundamental; enforcement obligatorio en orgs.

---

## P

### PCI-DSS (Payment Card Industry Data Security Standard)
**Definición**: Estándar de seguridad para organizaciones que procesan tarjetas de pago.  
**Contexto**: 12 requisitos agrupados en 6 objetivos de control.

### PHI (Protected Health Information)
**Definición**: Información de salud protegida bajo HIPAA.  
**Contexto**: Nunca debe aparecer en código, logs o datos de prueba.

### Push Protection
**Definición**: Feature que bloquea commits con secretos antes del push.  
**Contexto**: Prevención proactiva vs. detección reactiva de secret scanning.

---

## R

### Responsible Disclosure
**Definición**: Práctica de reportar vulnerabilidades de forma privada al vendor.  
**Contexto**: Sinónimo de coordinated disclosure; opuesto a full disclosure.

### RFC 9116
**Definición**: Estándar que define el formato y ubicación de security.txt.  
**Contexto**: Ubicación: `/.well-known/security.txt`

### Ruleset
**Definición**: Conjunto de reglas aplicables a repositories en una organización.  
**Contexto**: Permite enforcement de controles de seguridad a escala.

---

## S

### Safe Harbor
**Definición**: Protección legal para researchers que reportan vulnerabilidades.  
**Contexto**: Declaración de que la organización no tomará acción legal.  
**Condiciones típicas**: Good faith, no data exfiltration, follow guidelines.

### SAML SSO
**Definición**: Protocolo de autenticación federada (Single Sign-On).  
**Contexto**: Permite usar IdP corporativo (Okta, Azure AD) para GitHub.

### Secret Scanning
**Definición**: Detección automatizada de credenciales expuestas en código.  
**Contexto**: Escanea historial de commits; soporta 200+ tipos de secretos.

### Security Advisory
**Definición**: Documento que describe una vulnerabilidad y su remediación.  
**Contexto**: GitHub permite crear advisories privados y publicarlos con CVE.

### Security Champion
**Definición**: Desarrollador con responsabilidades adicionales de seguridad.  
**Contexto**: Punto de contacto de seguridad dentro de cada equipo.

### Security Overview
**Definición**: Dashboard centralizado de postura de seguridad organizacional.  
**Contexto**: Feature de GHAS Enterprise; muestra métricas y cobertura.

### SECURITY.md
**Definición**: Archivo que documenta la política de seguridad de un proyecto.  
**Contexto**: GitHub lo reconoce en raíz, docs/, o .github/.

### security.txt
**Definición**: Archivo estándar para publicar información de contacto de seguridad.  
**Contexto**: Definido por RFC 9116; ubicación: `/.well-known/security.txt`

### SLA (Service Level Agreement)
**Definición**: Compromiso de tiempo de respuesta o resolución.  
**Contexto**: VDPs definen SLAs por severidad de vulnerabilidad.

### SOC 2 (Service Organization Control 2)
**Definición**: Framework de auditoría para organizaciones de servicios.  
**Contexto**: Type I (punto en tiempo) vs Type II (período de tiempo).  
**Trust Services Criteria**: Security, Availability, Processing Integrity, Confidentiality, Privacy.

---

## T

### Triage
**Definición**: Proceso de evaluar, clasificar y priorizar reportes de seguridad.  
**Contexto**: Incluye validación, duplicación check, y asignación de severidad.

### Trust Services Criteria
**Definición**: Los cinco criterios evaluados en auditorías SOC 2.  
**Componentes**: Security (requerido), Availability, Processing Integrity, Confidentiality, Privacy.

---

## V

### VDP (Vulnerability Disclosure Program)
**Definición**: Programa formal para recibir reportes de vulnerabilidades.  
**Componentes**: Scope, process, SLAs, safe harbor, recognition.  
**Diferencia con Bug Bounty**: VDP no ofrece compensación monetaria.

### Vulnerability
**Definición**: Debilidad que puede ser explotada para comprometer seguridad.  
**Contexto**: Clasificadas por CVSS score y tipo (XSS, SQLi, RCE, etc.).

---

## W

### WebAuthn
**Definición**: Estándar de autenticación con hardware security keys.  
**Contexto**: GitHub soporta WebAuthn para 2FA; más seguro que SMS/TOTP.

---

## Acrónimos Rápidos

| Acrónimo | Significado |
|----------|-------------|
| BAA | Business Associate Agreement |
| CISO | Chief Information Security Officer |
| CVE | Common Vulnerabilities and Exposures |
| CVSS | Common Vulnerability Scoring System |
| GDPR | General Data Protection Regulation |
| GHAS | GitHub Advanced Security |
| HIPAA | Health Insurance Portability and Accountability Act |
| ISMS | Information Security Management System |
| MTTR | Mean Time To Remediate |
| PCI-DSS | Payment Card Industry Data Security Standard |
| PHI | Protected Health Information |
| SAML | Security Assertion Markup Language |
| SLA | Service Level Agreement |
| SOC | Service Organization Control |
| SSO | Single Sign-On |
| VDP | Vulnerability Disclosure Program |

---

## 📚 Referencias

- [GitHub Glossary](https://docs.github.com/en/get-started/quickstart/github-glossary)
- [NIST Glossary](https://csrc.nist.gov/glossary)
- [OWASP Terminology](https://owasp.org/www-community/)
