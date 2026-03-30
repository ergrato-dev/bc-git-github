# 🛠️ Ejercicios Prácticos - Semana 15

## Administración Avanzada de GitHub

**Tiempo total**: 150 minutos (2.5 horas)

---

## 📋 Índice de Ejercicios

| # | Ejercicio | Duración | Tema |
|---|-----------|----------|------|
| 01 | [Audit Log Analysis](ejercicio-01-audit-analysis/README.md) | 40 min | Análisis y queries de audit log |
| 02 | [API Automation](ejercicio-02-api-automation/README.md) | 40 min | Scripts con REST/GraphQL API |
| 03 | [Migration Planning](ejercicio-03-migration/README.md) | 35 min | Planificación de migraciones |
| 04 | [Backup Strategy](ejercicio-04-backup/README.md) | 35 min | Implementar backup automatizado |

---

## 🎯 Objetivos

Al completar estos ejercicios serás capaz de:

- ✅ Consultar y analizar audit logs para compliance
- ✅ Automatizar tareas administrativas con la API
- ✅ Planificar y ejecutar migraciones de repos
- ✅ Implementar estrategias de backup y recovery

---

## 📊 Requisitos Previos

```bash
# Herramientas necesarias
gh --version          # GitHub CLI 2.x+
jq --version          # jq 1.6+
git --version         # Git 2.x+

# Extensiones opcionales
gh extension install github/gh-gei
```

---

## 🔑 Permisos Necesarios

| Ejercicio | Scope mínimo |
|-----------|--------------|
| Audit Log | `read:org`, `read:audit_log` |
| API Automation | `repo`, `admin:org` |
| Migration | `repo`, `admin:org`, `workflow` |
| Backup | `repo`, `read:org` |

---

## 📁 Estructura

```
2-practicas/
├── README.md                          # Este archivo
├── ejercicio-01-audit-analysis/
│   └── README.md                      # Análisis de audit log
├── ejercicio-02-api-automation/
│   └── README.md                      # Automatización con API
├── ejercicio-03-migration/
│   └── README.md                      # Planificación de migración
└── ejercicio-04-backup/
    └── README.md                      # Estrategia de backup
```

---

## ✅ Evaluación

Cada ejercicio se evalúa según la rúbrica en [RUBRICA_EVALUACION.md](../RUBRICA_EVALUACION.md):

- **15 puntos** por ejercicio completado
- **Total**: 60 puntos (60% de la nota semanal)

---

**Siguiente**: [Ejercicio 01 - Audit Log Analysis](ejercicio-01-audit-analysis/README.md)
