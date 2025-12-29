# 📊 Rúbrica de Evaluación - Week 12

## Vulnerability Management

**Total: 100 puntos**

---

## 1️⃣ Vulnerability Lifecycle (15 puntos)

### Comprensión del Ciclo de Vida

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Identificación de fases | 5 pts | Conoce las fases: Discovery → Triage → Remediation → Disclosure |
| Triage correcto | 5 pts | Clasifica correctamente severidad y prioridad |
| Timeline apropiado | 5 pts | Establece tiempos de respuesta adecuados |

### Indicadores

- ✅ **Excelente (15 pts)**: Domina el ciclo completo con tiempos y responsables
- ✅ **Bueno (12 pts)**: Comprende las fases principales
- ⚠️ **Básico (8 pts)**: Conocimiento parcial del proceso
- ❌ **Insuficiente (0-5 pts)**: No comprende el ciclo

---

## 2️⃣ Security Advisories (20 puntos)

### Creación y Gestión de Advisories

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Draft advisory creado | 8 pts | Advisory con todos los campos requeridos |
| Información completa | 6 pts | Ecosystem, affected/patched versions, severity |
| CWE correcta | 3 pts | Clasificación CWE apropiada |
| Colaboradores añadidos | 3 pts | Invitar colaboradores al draft |

### Campos Requeridos

```yaml
✅ Ecosystem seleccionado
✅ Package name correcto
✅ Affected versions especificadas
✅ Patched versions indicadas
✅ Severity asignada (CVSS)
✅ CWE classification
✅ Description clara
✅ References incluidas
```

### Indicadores

- ✅ **Excelente (20 pts)**: Advisory completo, profesional, listo para publicar
- ✅ **Bueno (16 pts)**: Advisory funcional con campos principales
- ⚠️ **Básico (10 pts)**: Advisory incompleto o con errores
- ❌ **Insuficiente (0-6 pts)**: No crea advisory o está muy incompleto

---

## 3️⃣ CVE Process (15 puntos)

### Comprensión del Proceso CVE

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Conoce proceso CNA | 5 pts | Entiende el rol de GitHub como CNA |
| CVSS scoring | 5 pts | Calcula score CVSS correctamente |
| Documentación CVE | 5 pts | Conoce información requerida para CVE |

### CVSS Scoring

| Componente | Verificación |
|------------|--------------|
| Attack Vector | Network / Adjacent / Local / Physical |
| Attack Complexity | Low / High |
| Privileges Required | None / Low / High |
| User Interaction | None / Required |
| Scope | Unchanged / Changed |
| CIA Impact | None / Low / High |

### Indicadores

- ✅ **Excelente (15 pts)**: Calcula CVSS correctamente, entiende proceso completo
- ✅ **Bueno (12 pts)**: Comprende proceso, scoring básico
- ⚠️ **Básico (8 pts)**: Conocimiento superficial
- ❌ **Insuficiente (0-5 pts)**: No comprende CVE/CVSS

---

## 4️⃣ Patch Implementation (15 puntos)

### Desarrollo de Fix de Seguridad

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Fix correcto | 6 pts | Soluciona la vulnerabilidad efectivamente |
| Private fork usado | 4 pts | Desarrolla en fork privado |
| Testing incluido | 3 pts | Incluye tests para el fix |
| Backward compatible | 2 pts | Minimiza breaking changes |

### Mejores Prácticas

```markdown
✅ Fix desarrollado en private fork
✅ No expone detalles antes de disclosure
✅ Incluye tests de regresión
✅ Documentación actualizada
✅ Commit message apropiado
```

### Indicadores

- ✅ **Excelente (15 pts)**: Fix completo, testeado, en private fork
- ✅ **Bueno (12 pts)**: Fix funcional con testing básico
- ⚠️ **Básico (8 pts)**: Fix implementado pero sin mejores prácticas
- ❌ **Insuficiente (0-5 pts)**: Fix incorrecto o incompleto

---

## 5️⃣ Incident Response (10 puntos)

### Plan de Respuesta a Incidentes

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Plan documentado | 4 pts | Documento con proceso claro |
| Roles definidos | 3 pts | Responsabilidades asignadas |
| Comunicación | 3 pts | Plan de comunicación interna/externa |

### Elementos del Plan

| Fase | Verificación |
|------|--------------|
| Preparation | Equipo, herramientas, contactos |
| Detection | Cómo se identifica el incidente |
| Containment | Acciones inmediatas |
| Eradication | Eliminar la causa |
| Recovery | Restaurar operaciones |
| Lessons Learned | Post-mortem |

### Indicadores

- ✅ **Excelente (10 pts)**: Plan completo con todas las fases
- ✅ **Bueno (8 pts)**: Plan funcional con elementos principales
- ⚠️ **Básico (5 pts)**: Plan básico incompleto
- ❌ **Insuficiente (0-3 pts)**: Sin plan o muy deficiente

---

## 6️⃣ Proyecto: Vulnerability Response Simulation (25 puntos)

### Simulación Completa

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Recepción de reporte | 4 pts | Acknowledge y respuesta inicial |
| Security Advisory | 6 pts | Draft completo y profesional |
| Fix implementation | 6 pts | Parche correcto en private fork |
| Coordinated disclosure | 5 pts | Timeline y comunicación adecuados |
| Documentación | 4 pts | Post-mortem y lecciones aprendidas |

### Checklist del Proyecto

```markdown
□ Reporte recibido y acknowledged en <48h
□ Vulnerabilidad verificada y triageada
□ CVSS score calculado
□ Draft advisory creado con todos los campos
□ Fix desarrollado en private fork
□ Tests de regresión incluidos
□ Timeline de disclosure acordado
□ Advisory publicado (o simulado)
□ CVE asignado (o proceso documentado)
□ Post-mortem completado
```

### Indicadores

- ✅ **Excelente (25 pts)**: Simulación completa, profesional, documentada
- ✅ **Bueno (20 pts)**: Proceso completo con documentación básica
- ⚠️ **Básico (15 pts)**: Proceso incompleto o con gaps
- ❌ **Insuficiente (0-10 pts)**: Simulación muy incompleta

---

## 📊 Resumen de Puntuación

| Componente | Puntos | Peso |
|------------|--------|------|
| Vulnerability Lifecycle | 15 pts | 15% |
| Security Advisories | 20 pts | 20% |
| CVE Process | 15 pts | 15% |
| Patch Implementation | 15 pts | 15% |
| Incident Response | 10 pts | 10% |
| Proyecto | 25 pts | 25% |
| **Total** | **100 pts** | **100%** |

---

## 🎯 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐ Excelente | Dominio completo de vulnerability management |
| 80-89 | ✅ Bueno | Comprensión sólida con áreas menores a mejorar |
| 70-79 | 📝 Satisfactorio | Conocimiento básico funcional |
| 60-69 | ⚠️ En desarrollo | Requiere práctica adicional |
| <60 | ❌ Insuficiente | Necesita refuerzo significativo |

---

## 📝 Criterios de Aprobación

Para aprobar Week 12, el estudiante debe:

1. ✅ Obtener mínimo **70 puntos** totales
2. ✅ Completar el **proyecto** (mínimo 15 pts)
3. ✅ Demostrar comprensión de **Security Advisories** (mínimo 12 pts)
4. ✅ Entregar al menos **3 de los 4 ejercicios** prácticos

---

## 🏆 Bonus (hasta 10 puntos extra)

| Bonus | Puntos | Descripción |
|-------|--------|-------------|
| GitHub Security Lab | +3 pts | Completar un lab de Security Lab |
| Custom CVE research | +3 pts | Analizar CVE real con write-up |
| Automation | +4 pts | Automatizar parte del proceso de respuesta |

---

[⬅️ Volver a Week 12](README.md)
