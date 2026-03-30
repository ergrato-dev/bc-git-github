# 📖 Glosario - Semana 12: Vulnerability Management

> Términos clave para la gestión de vulnerabilidades y respuesta a incidentes.

---

## A

### Advisory
Documento oficial que describe una vulnerabilidad de seguridad, su impacto, versiones afectadas y cómo remediarla.

### Attack Vector
El método o camino que un atacante usa para explotar una vulnerabilidad. En CVSS: Network (N), Adjacent (A), Local (L), Physical (P).

---

## B

### Blameless Post-Mortem
Análisis de un incidente que se enfoca en mejorar sistemas y procesos, no en culpar a individuos.

### Bug Bounty
Programa donde organizaciones pagan a investigadores por reportar vulnerabilidades de forma responsable.

---

## C

### CNA (CVE Numbering Authority)
Organización autorizada para asignar identificadores CVE. GitHub es CNA para software open source.

### Containment
Fase del incident response donde se limita el alcance y daño del incidente.

### Coordinated Disclosure
Proceso donde el reporter y vendor acuerdan una fecha de publicación, dando tiempo para el fix.

### CVE (Common Vulnerabilities and Exposures)
Identificador único para vulnerabilidades. Formato: CVE-YYYY-NNNNN.

### CVSS (Common Vulnerability Scoring System)
Sistema estándar para evaluar severidad de vulnerabilidades. Score de 0.0 a 10.0.

### CWE (Common Weakness Enumeration)
Catálogo de debilidades de software (ej: CWE-89 = SQL Injection).

---

## D

### Detection
Primera fase del incident response: identificar que un incidente está ocurriendo.

### Disclosure
Acto de hacer pública una vulnerabilidad. Puede ser Full, Responsible o Coordinated.

---

## E

### Embargo
Período donde la información de una vulnerabilidad se mantiene confidencial mientras se desarrolla el fix.

### Eradication
Fase del incident response donde se elimina completamente la causa del incidente.

### Exploit
Código o técnica que aprovecha una vulnerabilidad.

---

## G

### GHSA (GitHub Security Advisory)
Identificador único para advisories en GitHub. Formato: GHSA-xxxx-xxxx-xxxx.

---

## I

### Incident Commander (IC)
Persona responsable de coordinar la respuesta a un incidente.

### Incident Response
Proceso organizado para detectar, contener, investigar y recuperarse de incidentes.

### IoC (Indicator of Compromise)
Evidencia forense de una posible intrusión: IPs maliciosas, hashes, dominios.

---

## M

### MTTR (Mean Time To Remediate)
Tiempo promedio desde detección hasta aplicación del fix.

---

## N

### NIST
National Institute of Standards and Technology. Publica frameworks de seguridad como SP 800-61.

### NVD (National Vulnerability Database)
Base de datos del gobierno de EE.UU. con información detallada sobre CVEs.

---

## P

### Patch
Actualización de software que corrige vulnerabilidades.

### PoC (Proof of Concept)
Demostración de que una vulnerabilidad es explotable.

### Post-Mortem
Análisis detallado después de un incidente para entender qué pasó y cómo prevenir.

### Private Fork
Fork temporal y privado para desarrollar un fix sin exponer la vulnerabilidad.

---

## R

### Recovery
Fase del incident response donde se restauran sistemas a operación normal.

### Remediation
Proceso de corregir una vulnerabilidad mediante patches o cambios.

### Root Cause Analysis (RCA)
Proceso de identificar la causa fundamental de un problema.

---

## S

### Severity
Clasificación del impacto: Critical, High, Medium, Low, Informational.

### SLA (Service Level Agreement)
Compromiso de tiempo para responder/resolver vulnerabilidades según severidad.

---

## T

### Triage
Proceso de evaluar y priorizar vulnerabilidades según severidad e impacto.

---

## V

### Vulnerability
Debilidad que puede ser explotada para comprometer la seguridad.

### Vulnerability Lifecycle
Ciclo completo: Discovery → Triage → Remediation → Disclosure.

### VDP (Vulnerability Disclosure Policy)
Documento que describe cómo recibir y manejar reportes de vulnerabilidades.

---

## Z

### Zero-Day
Vulnerabilidad explotada antes de que exista un patch. El vendor tiene "cero días" para responder.

---

## 📊 Tabla de Severidades CVSS

| Score | Severity | Color |
|-------|----------|-------|
| 0.0 | None | ⚪ |
| 0.1 - 3.9 | Low | 🟢 |
| 4.0 - 6.9 | Medium | 🟡 |
| 7.0 - 8.9 | High | 🟠 |
| 9.0 - 10.0 | Critical | 🔴 |

---

## 📊 CWEs Más Comunes

| CWE | Nombre | Descripción |
|-----|--------|-------------|
| CWE-79 | XSS | Inyección de scripts en páginas web |
| CWE-89 | SQL Injection | Inyección de SQL en queries |
| CWE-200 | Information Exposure | Exposición de información sensible |
| CWE-287 | Authentication Bypass | Eludir mecanismos de autenticación |
| CWE-352 | CSRF | Cross-Site Request Forgery |
| CWE-532 | Log Injection | Información sensible en logs |
| CWE-639 | IDOR | Insecure Direct Object Reference |
| CWE-798 | Hardcoded Credentials | Credenciales en código fuente |

---

## 🔗 Referencias

- [CVE Glossary](https://www.cve.org/ResourcesSupport/Glossary)
- [CWE Database](https://cwe.mitre.org/)
- [CVSS User Guide](https://www.first.org/cvss/user-guide)

---

[⬅️ Volver a Week-12](../README.md)
