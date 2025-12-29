# 📋 Rúbrica de Evaluación - Semana 08

## 🎯 CI/CD Pipelines

Esta rúbrica define los criterios de evaluación para la Semana 08 del bootcamp, enfocada en CI/CD Pipelines con GitHub Actions.

---

## 📊 Resumen de Evaluación

| Componente | Puntos | Porcentaje |
|------------|--------|------------|
| Fundamentos CI/CD | 15 | 15% |
| Build y Testing | 20 | 20% |
| Artifacts y Caching | 25 | 25% |
| Secrets y Variables | 15 | 15% |
| Proyecto Final | 25 | 25% |
| **TOTAL** | **100** | **100%** |

---

## 1️⃣ Fundamentos CI/CD (15 puntos)

### Conocimientos Teóricos

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Conceptos CI/CD | 5 | Explica diferencia entre CI, CD (delivery) y CD (deployment) |
| Pipeline Stages | 5 | Identifica stages: lint, build, test, package, deploy |
| Beneficios | 3 | Enumera beneficios de CI/CD en equipos de desarrollo |
| Flujo de trabajo | 2 | Describe el flujo desde commit hasta deployment |

### Niveles de Desempeño

| Nivel | Puntos | Indicadores |
|-------|--------|-------------|
| Excelente | 14-15 | Domina conceptos, explica con ejemplos propios |
| Bueno | 11-13 | Comprende conceptos, algunos gaps menores |
| Regular | 8-10 | Conocimiento básico, confusiones en términos |
| Insuficiente | <8 | No distingue CI de CD, conceptos confusos |

---

## 2️⃣ Build y Testing (20 puntos)

### Ejercicio 01: Pipeline CI Completo

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Pipeline funcional | 6 | Workflow ejecuta sin errores |
| Stages secuenciales | 4 | lint → build → test en orden correcto |
| Dependencies (needs) | 3 | Jobs con dependencias configuradas |
| Testing coverage | 4 | Tests ejecutan con reporte de coverage |
| Fail-fast strategy | 3 | Pipeline falla rápido si hay errores |

### Niveles de Desempeño

| Nivel | Puntos | Indicadores |
|-------|--------|-------------|
| Excelente | 18-20 | Pipeline robusto, coverage >80%, fail-fast |
| Bueno | 14-17 | Pipeline funciona, coverage >60% |
| Regular | 10-13 | Pipeline básico, algunos tests fallan |
| Insuficiente | <10 | Pipeline no ejecuta o sin tests |

---

## 3️⃣ Artifacts y Caching (25 puntos)

### Ejercicio 02: Caching de Dependencias

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Cache configurado | 5 | actions/cache o cache en setup-node |
| Cache key correcta | 4 | Incluye OS y hash de lock file |
| Restore keys | 3 | Fallback keys configuradas |
| Cache hit verificado | 3 | Logs muestran cache funcionando |

### Ejercicio 03: Artifacts entre Jobs

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Upload artifacts | 4 | actions/upload-artifact@v4 |
| Download artifacts | 3 | actions/download-artifact@v4 |
| Retention days | 2 | Configuración de retención |
| Artifacts útiles | 1 | Coverage, builds, logs relevantes |

### Niveles de Desempeño

| Nivel | Puntos | Indicadores |
|-------|--------|-------------|
| Excelente | 23-25 | Cache óptimo, artifacts bien organizados |
| Bueno | 18-22 | Cache funciona, artifacts configurados |
| Regular | 13-17 | Cache básico, algunos artifacts |
| Insuficiente | <13 | Sin cache o artifacts mal configurados |

---

## 4️⃣ Secrets y Variables (15 puntos)

### Ejercicio 04: Secrets y Environments

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Secrets configurados | 4 | Secrets en repo settings |
| Acceso en workflow | 3 | ${{ secrets.NAME }} correcto |
| Variables (vars) | 3 | Uso de variables de repositorio |
| Environments | 3 | Environment con protección |
| Documentación | 2 | README documenta secrets necesarios |

### Niveles de Desempeño

| Nivel | Puntos | Indicadores |
|-------|--------|-------------|
| Excelente | 14-15 | Secrets, vars, environments, docs completa |
| Bueno | 11-13 | Secrets y vars funcionando |
| Regular | 8-10 | Solo secrets básicos |
| Insuficiente | <8 | Secrets hardcodeados o no usados |

---

## 5️⃣ Proyecto Final (25 puntos)

### Full CI/CD Pipeline para Aplicación React

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **Pipeline completo** | 8 | lint → test → build → package |
| **Testing con coverage** | 5 | Jest con coverage >70% |
| **Caching optimizado** | 4 | npm cache funcionando |
| **Artifacts generados** | 4 | Build y coverage reports |
| **Documentación** | 4 | README con badges y explicación |

### Desglose de Pipeline Completo (8 pts)

| Stage | Puntos |
|-------|--------|
| Lint job | 2 |
| Test job con matrix | 2 |
| Build job | 2 |
| Dependencias correctas | 2 |

### Niveles de Desempeño

| Nivel | Puntos | Indicadores |
|-------|--------|-------------|
| Excelente | 23-25 | Pipeline completo, optimizado, documentado |
| Bueno | 18-22 | Pipeline funcional, buena documentación |
| Regular | 13-17 | Pipeline básico, docs incompleta |
| Insuficiente | <13 | Pipeline incompleto o no funciona |

---

## 📈 Escala de Calificación Final

| Puntos | Calificación | Nivel | Descripción |
|--------|--------------|-------|-------------|
| 90-100 | A | ⭐⭐⭐⭐⭐ Excelente | Dominio completo de CI/CD |
| 80-89 | B | ⭐⭐⭐⭐ Muy Bueno | Muy buen manejo de pipelines |
| 70-79 | C | ⭐⭐⭐ Bueno | Competencia adecuada |
| 60-69 | D | ⭐⭐ Regular | Necesita refuerzo |
| <60 | F | ⭐ Insuficiente | Debe repetir la semana |

---

## ✅ Checklist de Entrega

### Ejercicios Individuales

- [ ] Ejercicio 01: Pipeline CI completo ejecutando
- [ ] Ejercicio 02: Cache funcionando (verificar en logs)
- [ ] Ejercicio 03: Artifacts subidos y accesibles
- [ ] Ejercicio 04: Secrets y environments configurados

### Proyecto Final

- [ ] Workflow `.github/workflows/ci-cd.yml`
- [ ] Pipeline con 4 stages (lint, test, build, package)
- [ ] Coverage report como artifact
- [ ] Build output como artifact
- [ ] README.md con badge de CI
- [ ] Documentación de secrets necesarios

---

## 🎯 Criterios de Certificación

Para aprobar esta semana y avanzar hacia la certificación GitHub Actions:

| Requisito | Mínimo |
|-----------|--------|
| Puntuación total | ≥70 puntos |
| Proyecto final | ≥15 puntos |
| Ningún componente | <50% de sus puntos |

---

## 📝 Rúbrica de Feedback

### Comentarios por Área

| Área | Fortalezas | Áreas de Mejora |
|------|------------|-----------------|
| CI/CD Concepts | | |
| Build/Test | | |
| Artifacts/Cache | | |
| Secrets | | |
| Proyecto | | |

### Recomendaciones para Certificación

- [ ] Revisar documentación de artifacts
- [ ] Practicar más con caching
- [ ] Estudiar environments y OIDC
- [ ] Completar ejercicios adicionales

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | ➡️ Siguiente |
|:-----------:|:---------:|:------------:|
| [Rúbrica Week 07](../week-07/rubrica-evaluacion.md) | [README](README.md) | [Rúbrica Week 09](../week-09/rubrica-evaluacion.md) |
