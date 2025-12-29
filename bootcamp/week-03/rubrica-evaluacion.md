# 📋 Rúbrica de Evaluación - Week 03

## 🌿 Branching Básico

**Puntuación Total**: 100 puntos

---

## 📊 Criterios de Evaluación

### 1. Gestión de Branches (25 puntos)

| Criterio | Excelente (25) | Bueno (20) | Satisfactorio (15) | Insuficiente (0-10) |
|----------|----------------|------------|--------------------|--------------------|
| **Creación de branches** | Crea branches con nombres descriptivos siguiendo convenciones (feature/*, fix/*, etc.) | Crea branches con nombres claros | Crea branches básicos | No crea branches o usa nombres confusos |
| **Estructura** | Mínimo 3 branches bien organizados (main, develop, feature/*) | 3 branches funcionales | 2 branches | Solo main o estructura incorrecta |
| **Navegación** | Domina `git switch` y `git checkout` sin errores | Usa comandos correctamente | Navega con ayuda | No puede navegar entre branches |

**Distribución de puntos:**
- Nombres de branches siguiendo convenciones: 10 pts
- Estructura con 3+ branches: 10 pts
- Navegación fluida entre branches: 5 pts

---

### 2. Operaciones de Merge (25 puntos)

| Criterio | Excelente (25) | Bueno (20) | Satisfactorio (15) | Insuficiente (0-10) |
|----------|----------------|------------|--------------------|--------------------|
| **Merge fast-forward** | Demuestra y explica cuándo ocurre fast-forward | Ejecuta fast-forward correctamente | Realiza merge sin entender el tipo | No puede realizar merge |
| **Merge commit** | Demuestra merge con commit y explica la diferencia | Ejecuta merge con commit | Realiza merge básico | Merge fallido o incompleto |
| **Historial limpio** | Historial muestra claramente los merges realizados | Historial comprensible | Historial confuso | Sin evidencia de merges |

**Distribución de puntos:**
- Merge fast-forward demostrado: 10 pts
- Merge con commit (recursive) demostrado: 10 pts
- Historial limpio y comprensible: 5 pts

---

### 3. Proyecto Feature Development (30 puntos)

| Criterio | Excelente (30) | Bueno (24) | Satisfactorio (18) | Insuficiente (0-12) |
|----------|----------------|------------|--------------------|--------------------|
| **Flujo de trabajo** | Implementa flujo feature branch completo y profesional | Flujo funcional con pequeños errores | Flujo básico implementado | Flujo incorrecto o incompleto |
| **Features** | 3+ features desarrolladas en branches separados | 2-3 features en branches | 1-2 features | Sin features claras |
| **Integración** | Todas las features integradas correctamente a main/develop | Mayoría integradas | Algunas integradas | Integración fallida |
| **Commits** | Commits atómicos con Conventional Commits | Commits claros | Commits básicos | Commits confusos o muy grandes |

**Distribución de puntos:**
- Flujo feature branch correcto: 10 pts
- Mínimo 3 features en branches separados: 10 pts
- Integración exitosa de todas las features: 5 pts
- Commits siguiendo Conventional Commits: 5 pts

---

### 4. Documentación (20 puntos)

| Criterio | Excelente (20) | Bueno (16) | Satisfactorio (12) | Insuficiente (0-8) |
|----------|----------------|------------|--------------------|--------------------|
| **README del proyecto** | README completo con descripción, estructura y flujo de branches | README claro y útil | README básico | Sin README o incompleto |
| **Diagrama de branches** | Diagrama visual claro mostrando el flujo de trabajo | Diagrama comprensible | Diagrama básico | Sin diagrama |
| **Explicaciones** | Documenta decisiones y explica el flujo usado | Explicaciones claras | Explicaciones mínimas | Sin explicaciones |

**Distribución de puntos:**
- README del proyecto completo: 8 pts
- Diagrama de branches (ASCII o imagen): 7 pts
- Explicación del flujo de trabajo: 5 pts

---

## 📈 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐ Excelente | Dominio completo de branching y merge |
| 80-89 | ✅ Bueno | Buen manejo con mejoras menores |
| 70-79 | 📝 Satisfactorio | Cumple requisitos básicos |
| 60-69 | ⚠️ Necesita mejora | Requiere práctica adicional |
| < 60 | ❌ Insuficiente | No cumple los objetivos mínimos |

---

## ✅ Checklist de Entrega

```markdown
## Verificación de Entrega Week 03

### Branches
- [ ] Branch `main` existe y está actualizado
- [ ] Branch `develop` creado (si aplica al flujo)
- [ ] Mínimo 2 branches `feature/*` creados
- [ ] Nombres de branches siguen convenciones

### Merge
- [ ] Al menos 1 merge fast-forward demostrado
- [ ] Al menos 1 merge con commit demostrado
- [ ] Todos los feature branches integrados

### Proyecto
- [ ] 3+ features desarrolladas
- [ ] Cada feature en su propio branch
- [ ] Todas las features integradas a main/develop
- [ ] Commits siguen Conventional Commits

### Documentación
- [ ] README.md del proyecto completo
- [ ] Diagrama de branches incluido
- [ ] Flujo de trabajo explicado

### Historial
- [ ] `git log --oneline --graph` muestra estructura clara
- [ ] No hay commits huérfanos
- [ ] Historial es comprensible
```

---

## 🎯 Comandos Clave a Evaluar

```bash
# El estudiante debe demostrar dominio de:
git branch                    # Listar branches
git branch <nombre>           # Crear branch
git branch -d <nombre>        # Eliminar branch
git switch <branch>           # Cambiar a branch (moderno)
git checkout <branch>         # Cambiar a branch (tradicional)
git switch -c <nuevo>         # Crear y cambiar
git merge <branch>            # Merge básico
git log --oneline --graph     # Visualizar historial
```

---

## 📝 Notas para el Evaluador

1. **Verificar flujo real**: Usar `git log --oneline --graph --all` para ver el historial completo
2. **Revisar nombres**: Los branches deben seguir convenciones (feature/, fix/, etc.)
3. **Evaluar comprensión**: El estudiante debe poder explicar la diferencia entre fast-forward y merge commit
4. **Documentación**: El diagrama puede ser ASCII art, imagen generada, o captura de herramienta gráfica

---

## 🔗 Recursos de Evaluación

- [Rúbrica General del Bootcamp](../../_docs/evaluaciones/README.md)
- [Guía de Conventional Commits](../week-02/1-teoria/02-commits-profesionales.md)
- [Ejercicios de Práctica](2-practicas/README.md)

---

<div align="center">

**Week 03** | Rúbrica de Evaluación | Bootcamp Git/GitHub

</div>
