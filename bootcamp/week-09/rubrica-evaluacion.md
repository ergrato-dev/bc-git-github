# 📋 Rúbrica de Evaluación - Week 09

## Custom Actions y Advanced Workflows

**Total: 100 puntos**

---

## 📊 Resumen de Evaluación

| Categoría | Puntos | Peso |
|-----------|--------|------|
| Fundamentos Custom Actions | 15 | 15% |
| JavaScript Actions | 20 | 20% |
| Composite Actions | 15 | 15% |
| Reusable Workflows | 15 | 15% |
| Dispatch Events | 10 | 10% |
| Proyecto Final | 25 | 25% |
| **Total** | **100** | **100%** |

---

## 1️⃣ Fundamentos Custom Actions (15 puntos)

### 1.1 Conocimiento de Tipos (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | Explica diferencias entre JavaScript, Composite y Docker actions |
| Bueno | 4 | Conoce los tres tipos con algunas imprecisiones |
| Básico | 3 | Identifica tipos pero no diferencias claras |
| Insuficiente | 0-2 | No distingue entre tipos de actions |

### 1.2 Estructura action.yml (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | action.yml completo con inputs, outputs, branding |
| Bueno | 4 | action.yml funcional con inputs/outputs |
| Básico | 3 | action.yml mínimo funcional |
| Insuficiente | 0-2 | action.yml incompleto o con errores |

### 1.3 Casos de Uso (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | Identifica cuándo usar cada tipo de action |
| Bueno | 4 | Buena comprensión con ejemplos |
| Básico | 3 | Comprensión parcial |
| Insuficiente | 0-2 | No identifica casos de uso apropiados |

---

## 2️⃣ JavaScript Actions (20 puntos)

### 2.1 Uso de @actions/core (8 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 8 | Usa getInput, setOutput, setFailed, info, warning |
| Bueno | 6-7 | Usa funciones principales correctamente |
| Básico | 4-5 | Usa funciones básicas (getInput, setOutput) |
| Insuficiente | 0-3 | No usa @actions/core correctamente |

### 2.2 Manejo de Inputs/Outputs (6 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 6 | Inputs validados, outputs expuestos correctamente |
| Bueno | 4-5 | Inputs y outputs funcionales |
| Básico | 3 | Solo inputs básicos |
| Insuficiente | 0-2 | Inputs/outputs mal implementados |

### 2.3 Manejo de Errores (6 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 6 | Try/catch completo, setFailed con mensajes claros |
| Bueno | 4-5 | Manejo de errores básico |
| Básico | 3 | Algunos errores manejados |
| Insuficiente | 0-2 | Sin manejo de errores |

---

## 3️⃣ Composite Actions (15 puntos)

### 3.1 Estructura Composite (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | runs.using: composite con steps bien estructurados |
| Bueno | 4 | Estructura correcta con minor issues |
| Básico | 3 | Estructura funcional mínima |
| Insuficiente | 0-2 | Estructura incorrecta |

### 3.2 Reutilización de Steps (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | Combina múltiples steps y/o otras actions |
| Bueno | 4 | Reutiliza steps de forma efectiva |
| Básico | 3 | Steps básicos combinados |
| Insuficiente | 0-2 | No demuestra reutilización |

### 3.3 Paso de Parámetros (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | Inputs pasados a steps con ${{ inputs.x }} |
| Bueno | 4 | Parámetros pasados correctamente |
| Básico | 3 | Paso básico de parámetros |
| Insuficiente | 0-2 | No pasa parámetros a steps |

---

## 4️⃣ Reusable Workflows (15 puntos)

### 4.1 Configuración workflow_call (6 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 6 | on: workflow_call con inputs y secrets |
| Bueno | 4-5 | workflow_call funcional con inputs |
| Básico | 3 | workflow_call básico |
| Insuficiente | 0-2 | Configuración incorrecta |

### 4.2 Llamada desde Otro Workflow (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | uses: con referencia correcta y parámetros |
| Bueno | 4 | Llamada funcional |
| Básico | 3 | Llamada básica sin parámetros |
| Insuficiente | 0-2 | No implementa llamada correctamente |

### 4.3 Paso de Secrets (4 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 4 | secrets: inherit o paso explícito correcto |
| Bueno | 3 | Secrets pasados correctamente |
| Básico | 2 | Intento de paso de secrets |
| Insuficiente | 0-1 | No maneja secrets |

---

## 5️⃣ Dispatch Events (10 puntos)

### 5.1 workflow_dispatch (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | Inputs definidos con types, options, defaults |
| Bueno | 4 | workflow_dispatch funcional con inputs |
| Básico | 3 | workflow_dispatch básico |
| Insuficiente | 0-2 | No implementa correctamente |

### 5.2 repository_dispatch (5 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 5 | Trigger externo con event_type y client_payload |
| Bueno | 4 | repository_dispatch funcional |
| Básico | 3 | Configuración básica |
| Insuficiente | 0-2 | No implementa o no funciona |

---

## 6️⃣ Proyecto Final: Custom Action (25 puntos)

### 6.1 Funcionalidad (10 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 10 | Action completa, funcional, resuelve problema real |
| Bueno | 7-9 | Action funcional con buen diseño |
| Básico | 4-6 | Action funciona pero limitada |
| Insuficiente | 0-3 | No funciona correctamente |

### 6.2 Documentación (8 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 8 | README completo: descripción, inputs, outputs, ejemplos |
| Bueno | 6-7 | Documentación clara y útil |
| Básico | 4-5 | Documentación mínima |
| Insuficiente | 0-3 | Sin documentación o muy pobre |

### 6.3 Testing y Ejemplo (7 pts)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Excelente | 7 | Tests incluidos + workflow de ejemplo funcional |
| Bueno | 5-6 | Workflow de ejemplo que demuestra uso |
| Básico | 3-4 | Ejemplo básico de uso |
| Insuficiente | 0-2 | Sin ejemplo o no funciona |

---

## 📈 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐ Excelente | Dominio completo de custom actions |
| 80-89 | ✅ Muy Bueno | Buen manejo con detalles menores |
| 70-79 | 👍 Bueno | Comprensión sólida de conceptos |
| 60-69 | 📝 Suficiente | Conocimiento básico funcional |
| < 60 | ❌ Insuficiente | Requiere refuerzo |

---

## ✅ Checklist de Entrega

### Obligatorios

- [ ] JavaScript Action funcional con action.yml
- [ ] Composite Action funcional
- [ ] Reusable Workflow implementado y llamado
- [ ] workflow_dispatch configurado con inputs
- [ ] Proyecto: Custom Action completa con documentación

### Opcionales (Puntos Extra)

| Extra | Puntos |
|-------|--------|
| Docker Action funcional | +5 |
| Action publicada en Marketplace | +5 |
| Tests automatizados para la action | +3 |
| repository_dispatch con API call | +2 |

---

## 🔗 Navegación

| ⬅️ Semana | 📋 Proyecto |
|:---------:|:-----------:|
| [Week 09](README.md) | [Proyecto](3-proyecto/README.md) |
