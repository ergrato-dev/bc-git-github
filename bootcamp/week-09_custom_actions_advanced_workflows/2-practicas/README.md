# 🏋️ Ejercicios Prácticos - Semana 09

> Custom Actions y Advanced Workflows - 2.5 horas (42% del tiempo)

---

## 📋 Índice de Ejercicios

| # | Ejercicio | Duración | Tema |
|---|-----------|----------|------|
| 01 | [JavaScript Action](ejercicio-01-javascript-action/README.md) | 40 min | @actions/core, @actions/github, ncc |
| 02 | [Composite Action](ejercicio-02-composite-action/README.md) | 35 min | YAML puro, reutilización de steps |
| 03 | [Reusable Workflow](ejercicio-03-reusable-workflow/README.md) | 35 min | workflow_call, inputs, secrets |
| 04 | [Dispatch Events](ejercicio-04-dispatch-events/README.md) | 40 min | workflow_dispatch, repository_dispatch |

**Tiempo total**: 2h 30min

---

## 🎯 Objetivos de los Ejercicios

Al completar estos ejercicios podrás:

- [x] Crear JavaScript Actions con el Actions Toolkit
- [x] Desarrollar Composite Actions sin código
- [x] Implementar Reusable Workflows compartibles
- [x] Configurar triggers manuales y externos

---

## 📊 Progresión de Dificultad

```
Ejercicio 01 ████████░░ (Intermedio)
Ejercicio 02 ████████░░ (Intermedio)  
Ejercicio 03 █████████░ (Intermedio-Avanzado)
Ejercicio 04 █████████░ (Intermedio-Avanzado)
```

---

## 🛠️ Requisitos Previos

Antes de comenzar, asegúrate de tener:

- [ ] Node.js 18+ instalado
- [ ] npm o yarn disponible
- [ ] Repositorio de prueba en GitHub
- [ ] Token de GitHub con permisos `workflow`
- [ ] Lecciones teóricas 01-04 completadas

---

## 📁 Estructura de Carpetas

```
2-practicas/
├── README.md (este archivo)
├── ejercicio-01-javascript-action/
│   └── README.md
├── ejercicio-02-composite-action/
│   └── README.md
├── ejercicio-03-reusable-workflow/
│   └── README.md
└── ejercicio-04-dispatch-events/
    └── README.md
```

---

## 🔄 Flujo de Trabajo Recomendado

```
1. Leer README del ejercicio
   ↓
2. Crear archivos según instrucciones
   ↓
3. Probar localmente (si aplica)
   ↓
4. Push a GitHub
   ↓
5. Verificar en Actions UI
   ↓
6. Completar desafíos extra (opcional)
   ↓
7. Siguiente ejercicio
```

---

## ✅ Checklist de Completado

### Ejercicio 01 - JavaScript Action
- [ ] `action.yml` creado con inputs/outputs
- [ ] `src/index.js` implementado
- [ ] `npm run build` genera `dist/index.js`
- [ ] Workflow de prueba pasa

### Ejercicio 02 - Composite Action
- [ ] Action detecta package manager
- [ ] Cache funciona correctamente
- [ ] Outputs se propagan
- [ ] Summary se genera

### Ejercicio 03 - Reusable Workflow
- [ ] Template con `workflow_call`
- [ ] Caller usa `uses:` correctamente
- [ ] `secrets: inherit` funciona
- [ ] Outputs del workflow disponibles

### Ejercicio 04 - Dispatch Events
- [ ] UI muestra formulario con inputs
- [ ] API triggers funcionan
- [ ] Lógica condicional por event_type
- [ ] Validaciones implementadas

---

## 🎯 Rúbrica de Evaluación

| Criterio | Puntos |
|----------|--------|
| JavaScript Action funcional | 20 |
| Composite Action con cache | 15 |
| Reusable Workflow con outputs | 15 |
| Dispatch Events configurados | 10 |
| **Total Ejercicios** | **60** |

Ver [rúbrica completa](../rubrica-evaluacion.md) para detalles.

---

## 💡 Tips para los Ejercicios

### JavaScript Actions
```bash
# Siempre compilar antes de push
npm run build

# El dist/ debe estar en git
git add dist/
```

### Composite Actions
```yaml
# SIEMPRE especificar shell
- run: echo "hello"
  shell: bash  # ← Obligatorio
```

### Reusable Workflows
```yaml
# Heredar todos los secrets
secrets: inherit

# O pasar específicos
secrets:
  TOKEN: ${{ secrets.MY_TOKEN }}
```

### Dispatch Events
```bash
# Verificar que tienes token
echo $GITHUB_TOKEN

# Test con curl
curl -H "Authorization: Bearer $GITHUB_TOKEN" \
  https://api.github.com/user
```

---

## ⏭️ Siguiente Paso

Una vez completados los ejercicios, aplica lo aprendido en el proyecto:

[🎯 Ir al Proyecto →](../3-proyecto/README.md)

---

[⬅️ Volver a Teoría](../1-teoria/README.md) · [📋 Semana 09](../README.md)
