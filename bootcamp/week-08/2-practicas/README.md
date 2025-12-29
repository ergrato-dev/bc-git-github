# 💻 Ejercicios Prácticos - Semana 08

## 📋 Descripción

Ejercicios guiados para implementar pipelines CI/CD completos con GitHub Actions, incluyendo caching, artifacts y manejo seguro de secretos.

---

## 🎯 Objetivos de Aprendizaje

Al completar estos ejercicios podrás:

- ✅ Crear pipelines CI con jobs secuenciales usando `needs`
- ✅ Implementar caching de dependencias para optimizar tiempos
- ✅ Compartir archivos entre jobs usando artifacts
- ✅ Configurar secrets y environments con protecciones

---

## ⏱️ Tiempo Total: 2.5 horas

| Ejercicio | Duración | Dificultad |
|-----------|----------|------------|
| 01 - Pipeline Completo | 35 min | ⭐⭐ Intermedia |
| 02 - Caching Dependencias | 35 min | ⭐⭐ Intermedia |
| 03 - Artifacts entre Jobs | 40 min | ⭐⭐⭐ Intermedia-Avanzada |
| 04 - Secrets y Environments | 40 min | ⭐⭐⭐ Avanzada |

---

## 📂 Estructura de Ejercicios

```
2-practicas/
├── README.md                              # Este archivo
├── ejercicio-01-pipeline-completo/        # Build → Test → Lint
│   └── README.md
├── ejercicio-02-caching-dependencias/     # npm/pip cache
│   └── README.md
├── ejercicio-03-artifacts-jobs/           # Upload/download artifacts
│   └── README.md
└── ejercicio-04-secrets-environments/     # Secrets, vars, environments
    └── README.md
```

---

## 📝 Lista de Ejercicios

### Ejercicio 01: Pipeline CI Completo ⭐⭐

| Aspecto | Detalle |
|---------|---------|
| **Objetivo** | Crear pipeline con lint, test y build secuenciales |
| **Duración** | 35 minutos |
| **Temas** | Jobs, needs, steps, triggers, fail-fast |
| **Archivo** | [ejercicio-01-pipeline-completo/README.md](ejercicio-01-pipeline-completo/README.md) |

**Lo que aprenderás:**
- Configurar triggers para push y pull_request
- Crear jobs que dependen de otros con `needs`
- Generar Step Summaries informativos
- Manejar comportamiento fail-fast

---

### Ejercicio 02: Caching de Dependencias ⭐⭐

| Aspecto | Detalle |
|---------|---------|
| **Objetivo** | Reducir tiempo de npm install de minutos a segundos |
| **Duración** | 35 minutos |
| **Temas** | Cache, cache keys, restore keys, setup-node cache |
| **Archivo** | [ejercicio-02-caching-dependencias/README.md](ejercicio-02-caching-dependencias/README.md) |

**Lo que aprenderás:**
- Usar cache built-in de setup-node
- Configurar cache manual con actions/cache
- Entender cache keys y restore keys
- Medir ahorro de tiempo

---

### Ejercicio 03: Artifacts entre Jobs ⭐⭐⭐

| Aspecto | Detalle |
|---------|---------|
| **Objetivo** | Compartir archivos entre jobs del mismo workflow |
| **Duración** | 40 minutos |
| **Temas** | upload-artifact, download-artifact, retention, paths |
| **Archivo** | [ejercicio-03-artifacts-jobs/README.md](ejercicio-03-artifacts-jobs/README.md) |

**Lo que aprenderás:**
- Subir builds como artifacts
- Descargar en jobs posteriores
- Configurar retention y exclusiones
- Consolidar reportes de múltiples jobs

---

### Ejercicio 04: Secrets y Environments ⭐⭐⭐

| Aspecto | Detalle |
|---------|---------|
| **Objetivo** | Deploy seguro con secrets y aprobaciones |
| **Duración** | 40 minutos |
| **Temas** | Secrets, variables, environments, approvals, GITHUB_TOKEN |
| **Archivo** | [ejercicio-04-secrets-environments/README.md](ejercicio-04-secrets-environments/README.md) |

**Lo que aprenderás:**
- Configurar secrets de repositorio y environment
- Crear environments staging y production
- Configurar required reviewers y wait timers
- Usar GITHUB_TOKEN con permisos específicos

---

## ✅ Checklist de Progreso

- [ ] **Ejercicio 01**: Pipeline CI Completo
  - [ ] Workflow con 3 jobs secuenciales
  - [ ] Triggers configurados
  - [ ] Step Summaries funcionando
  
- [ ] **Ejercicio 02**: Caching Dependencias
  - [ ] Cache configurado con setup-node
  - [ ] Verificar cache hit en segunda ejecución
  - [ ] Medir reducción de tiempo
  
- [ ] **Ejercicio 03**: Artifacts entre Jobs
  - [ ] Upload artifact en job build
  - [ ] Download artifact en job test
  - [ ] Artifacts visibles en GitHub UI
  
- [ ] **Ejercicio 04**: Secrets y Environments
  - [ ] Secrets de repositorio creados
  - [ ] Environments staging y production
  - [ ] Deploy a production requiere aprobación

---

## 🔧 Requisitos Previos

Antes de comenzar, asegúrate de tener:

- [x] Cuenta de GitHub con acceso a Actions
- [x] Repositorio con permisos de administrador
- [x] Semana 07 completada (fundamentos de Actions)
- [x] Node.js instalado localmente (para pruebas)
- [x] Editor con soporte YAML (VS Code recomendado)

---

## 💡 Tips Generales

### Para todos los ejercicios:

```yaml
# 1. Siempre verificar sintaxis YAML antes de push
# Usar: https://www.yamllint.com/

# 2. Ver logs detallados en Actions
# Click en cada step para expandir

# 3. Re-ejecutar workflows fallidos
# Actions → Re-run failed jobs

# 4. Usar workflow_dispatch para testing
on:
  workflow_dispatch:  # Permite trigger manual
```

### Debugging común:

```yaml
# Imprimir variables de contexto
- run: echo "${{ toJSON(github) }}"

# Habilitar debug logging
# Settings → Secrets → Add: ACTIONS_STEP_DEBUG = true
```

---

## 📚 Recursos Relacionados

| Recurso | Enlace |
|---------|--------|
| Teoría 01 - Fundamentos CI/CD | [01-fundamentos-cicd.md](../1-teoria/01-fundamentos-cicd.md) |
| Teoría 02 - Build y Testing | [02-build-testing.md](../1-teoria/02-build-testing.md) |
| Teoría 03 - Artifacts y Caching | [03-artifacts-caching.md](../1-teoria/03-artifacts-caching.md) |
| Teoría 04 - Secrets y Variables | [04-secrets-variables.md](../1-teoria/04-secrets-variables.md) |
| Proyecto Semanal | [3-proyecto/README.md](../3-proyecto/README.md) |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | ➡️ Siguiente |
|:-----------:|:---------:|:------------:|
| [Teoría](../1-teoria/) | [Week 08](../README.md) | [Proyecto](../3-proyecto/) |
| [1-teoria](../1-teoria/) | [README](../README.md) | [3-proyecto](../3-proyecto/) |
