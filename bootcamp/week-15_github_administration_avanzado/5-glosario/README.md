# 📖 Glosario - Semana 15

## Administración Avanzada de GitHub

---

## A

### Audit Log
Registro de todas las acciones en una organización. Incluye actor, acción, timestamp y metadata.

### API (Application Programming Interface)
Interfaz para interactuar con GitHub programáticamente. REST API y GraphQL API disponibles.

---

## B

### Backup
Copia de seguridad. Incluye git mirror (código) y metadata export (issues, PRs).

---

## C

### Compliance
Cumplimiento de regulaciones (SOC 2, GDPR). Audit log es clave para demostrar compliance.

---

## D

### Disaster Recovery (DR)
Plan para recuperar sistemas después de una falla. Define RTO y RPO.

---

## G

### GEI (GitHub Enterprise Importer)
Herramienta oficial para migrar repos completos incluyendo metadata.

### Git Mirror
Clon completo incluyendo todas las refs. Comando: `git clone --mirror URL`

### GraphQL
API de consultas flexibles. Permite solicitar exactamente los datos necesarios.

---

## L

### Log Streaming
Envío en tiempo real de audit logs a sistemas externos (S3, Splunk, Datadog).

---

## M

### Mannequin
Placeholder para usuarios inexistentes durante migración. Se puede reclamar después.

### Mutation
Operación GraphQL que modifica datos (equivalente a POST/PUT/DELETE).

---

## P

### PAT (Personal Access Token)
Token de autenticación para API y git operations.

---

## Q

### Query
Operación GraphQL de solo lectura (equivalente a GET).

---

## R

### Rate Limit
Límite de requests a la API. 5,000/hora para usuarios autenticados.

### RPO (Recovery Point Objective)
Pérdida de datos máxima aceptable. Define frecuencia de backups.

### RTO (Recovery Time Objective)
Tiempo máximo para restaurar servicios después de falla.

### Runbook
Documento con procedimientos operativos paso a paso.

---

## S

### SIEM
Sistema que agrega y analiza logs de seguridad de múltiples fuentes.

---

## T

### 3-2-1 Rule
Estrategia backup: 3 copias, 2 tipos de storage, 1 offsite.

---

## Tabla Resumen

| Término | Definición |
|---------|------------|
| Audit Log | Registro de actividad |
| GEI | Herramienta de migración |
| Mirror | Backup completo de git |
| RPO | Pérdida de datos aceptable |
| RTO | Tiempo de recuperación |
| GraphQL | API de consultas flexibles |
