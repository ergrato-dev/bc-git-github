# 📋 Rúbrica de Evaluación - Week 07

## GitHub Actions Fundamentos

**Puntuación Total:** 100 puntos

---

## 📊 Distribución de Puntos

| Categoría | Puntos | Porcentaje |
|-----------|--------|------------|
| Workflows Básicos | 25 | 25% |
| Events y Triggers | 20 | 20% |
| Actions y Marketplace | 25 | 25% |
| Proyecto CI | 30 | 30% |
| **Total** | **100** | **100%** |

---

## 1️⃣ Workflows Básicos (25 puntos)

### Estructura del Workflow (10 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Ubicación correcta | 3 | Archivo en `.github/workflows/` |
| Nombre descriptivo | 2 | `name:` claro y significativo |
| Sintaxis YAML válida | 3 | Sin errores de parsing |
| Documentación | 2 | Comentarios explicativos |

### Jobs y Steps (15 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Jobs definidos | 4 | Al menos un job configurado |
| Steps organizados | 4 | Pasos lógicos y ordenados |
| `runs-on` correcto | 3 | Runner apropiado seleccionado |
| Nombres descriptivos | 2 | `name:` en steps |
| Outputs correctos | 2 | Uso de outputs entre steps |

---

## 2️⃣ Events y Triggers (20 puntos)

### Configuración de Events (12 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| `on: push` | 3 | Trigger en push configurado |
| `on: pull_request` | 3 | Trigger en PR configurado |
| Branch filters | 3 | Filtros de branches aplicados |
| Path filters | 3 | Filtros de rutas (si aplica) |

### Triggers Avanzados (8 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| `workflow_dispatch` | 3 | Trigger manual configurado |
| `schedule` | 3 | Cron expression válida |
| Inputs definidos | 2 | Inputs para dispatch manual |

---

## 3️⃣ Actions y Marketplace (25 puntos)

### Uso de Actions (15 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| `actions/checkout` | 4 | Checkout del código |
| `actions/setup-*` | 4 | Setup de lenguaje/runtime |
| `actions/cache` | 4 | Caché de dependencias |
| Versiones fijadas | 3 | Uso de @v4 o SHA |

### Matrix Strategy (10 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Matrix definida | 4 | Estrategia de matrix configurada |
| Múltiples versiones | 3 | Node 18, 20, 22 o similar |
| Múltiples OS | 3 | ubuntu, windows, macos |

---

## 4️⃣ Proyecto CI Básico (30 puntos)

### Implementación (20 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Lint ejecutado | 5 | ESLint o similar funcionando |
| Tests ejecutados | 5 | Suite de tests pasando |
| Build completado | 5 | Build sin errores |
| Workflow completo | 5 | Pipeline end-to-end |

### Calidad (10 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Caché implementado | 3 | Dependencias cacheadas |
| Fail-fast apropiado | 2 | Comportamiento de fallo correcto |
| Status badges | 2 | Badge en README |
| Documentación | 3 | README del workflow |

---

## 📈 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐ Excelente | Dominio completo de Actions |
| 80-89 | ✅ Muy Bien | Comprensión sólida |
| 70-79 | 👍 Bien | Conocimiento adecuado |
| 60-69 | 📝 Suficiente | Necesita práctica |
| < 60 | ❌ Insuficiente | Requiere refuerzo |

---

## 🎯 Criterios de Aprobación

Para aprobar esta semana debes:

1. ✅ Obtener mínimo **70 puntos** en total
2. ✅ Completar al menos **3 de 4** ejercicios prácticos
3. ✅ Entregar el proyecto CI básico funcionando
4. ✅ Tener al menos un workflow ejecutándose sin errores

---

## 📝 Entregables Requeridos

| # | Entregable | Obligatorio |
|---|------------|-------------|
| 1 | Workflow Hello World | ✅ Sí |
| 2 | Workflow múltiples triggers | ✅ Sí |
| 3 | Workflow con marketplace actions | ✅ Sí |
| 4 | Workflow con matrix strategy | ⭕ Opcional |
| 5 | Proyecto CI completo | ✅ Sí |

---

## 🔍 Verificación de Workflows

### Cómo verificar que funciona:

```bash
# Ver historial de ejecuciones
gh run list --workflow=ci.yml

# Ver detalles de una ejecución
gh run view <run-id>

# Ver logs de un job
gh run view <run-id> --log
```

### En la interfaz de GitHub:

1. Ir a **Actions** tab
2. Ver ejecuciones del workflow
3. Verificar estado ✅ verde en todos los jobs

---

## 📚 Recursos de Apoyo

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)

---

_Rúbrica Week 07 | Bootcamp Git/GitHub | GitHub Actions Fundamentos_
