# 📊 Rúbrica de Evaluación - Week 02

## 🎯 Repositories y Commits

**Semana**: 02 - Repositories y Commits  
**Tiempo total**: 6 horas  
**Peso en el bootcamp**: 6.25% (1/16 semanas)

---

## 📋 Criterios de Evaluación

### 1️⃣ Uso del Staging Area (20 puntos)

| Criterio | Excelente (20) | Bueno (16) | Aceptable (12) | Insuficiente (0-8) |
|----------|----------------|------------|----------------|---------------------|
| **Comprensión** | Explica claramente el propósito del staging area | Entiende el concepto básico | Comprensión parcial | No comprende |
| **Uso estratégico** | Usa staging para crear commits atómicos y lógicos | Usa staging correctamente | Uso básico sin estrategia | No usa staging correctamente |
| **Comandos** | Domina add, reset, restore con opciones | Usa comandos básicos | Solo usa `git add .` | No sabe usar comandos |

#### ✅ Comandos que debe demostrar

```bash
git add <archivo>           # Agregar archivo específico
git add -p                  # Agregar por partes (hunks)
git reset HEAD <archivo>    # Quitar del staging
git restore --staged <file> # Alternativa moderna
git status                  # Verificar estado
git diff --staged           # Ver cambios en staging
```

---

### 2️⃣ Commits Profesionales (25 puntos)

> **⚠️ NOTA**: Esta es la categoría más importante de la semana. Los mensajes de commit profesionales son esenciales en equipos de desarrollo.

| Criterio | Excelente (25) | Bueno (20) | Aceptable (15) | Insuficiente (0-10) |
|----------|----------------|------------|----------------|---------------------|
| **Cantidad** | 10+ commits bien distribuidos | 7-9 commits | 4-6 commits | Menos de 4 commits |
| **Conventional Commits** | Todos siguen el formato correctamente | Mayoría sigue el formato | Algunos siguen el formato | No sigue el formato |
| **Atomicidad** | Cada commit tiene un solo propósito lógico | Mayoría son atómicos | Algunos commits mezclados | Commits gigantes o sin sentido |
| **Mensajes** | Descriptivos, claros, en imperativo | Buenos mensajes | Mensajes básicos | "cambios", "update", "." |

#### 📏 Formato Conventional Commits

```bash
# Estructura:
<type>(<scope>): <description>

[optional body]

[optional footer(s)]

# Tipos permitidos:
feat:     Nueva funcionalidad
fix:      Corrección de bug
docs:     Cambios en documentación
style:    Formato (sin cambio de código)
refactor: Refactorización de código
test:     Añadir o corregir tests
chore:    Tareas de mantenimiento
```

#### ✅ Ejemplos Correctos

```bash
git commit -m "feat: agregar estructura inicial del blog"
git commit -m "docs: crear README con descripción del proyecto"
git commit -m "feat(posts): agregar primer artículo sobre Git"
git commit -m "fix: corregir typo en título del README"
git commit -m "chore: agregar .gitignore para archivos temporales"
```

#### ❌ Ejemplos Incorrectos

```bash
git commit -m "cambios"
git commit -m "wip"
git commit -m "."
git commit -m "asdfasdf"
git commit -m "agregué muchas cosas y también corregí bugs"
```

---

### 3️⃣ Navegación del Historial (15 puntos)

| Criterio | Excelente (15) | Bueno (12) | Aceptable (9) | Insuficiente (0-6) |
|----------|----------------|------------|----------------|---------------------|
| **Git log** | Usa formatos personalizados y filtros | Usa opciones básicas | Solo `git log` básico | No sabe usar git log |
| **Git diff** | Compara commits, branches, staged | Usa diff básico | Uso limitado | No usa diff |
| **Git show** | Inspecciona commits específicos | Uso básico | Uso limitado | No usa show |

#### ✅ Comandos que debe demostrar

```bash
# Git log con formato
git log --oneline
git log --oneline --graph --all
git log --pretty=format:"%h %s (%an, %ar)"
git log -n 5
git log --since="1 week ago"

# Git diff
git diff                    # Working vs staging
git diff --staged           # Staging vs último commit
git diff HEAD~2..HEAD       # Entre commits

# Git show
git show <commit-hash>
git show HEAD~1
```

---

### 4️⃣ README.md del Proyecto (25 puntos)

> **📌 Recordatorio**: El README es un entregable crítico (ver requisitos de Week 01)

| Criterio | Excelente (25) | Bueno (20) | Aceptable (15) | Insuficiente (0-10) |
|----------|----------------|------------|----------------|---------------------|
| **Estructura** | Todas las secciones requeridas | Mayoría de secciones | Algunas secciones | Pocas o ninguna |
| **Contenido** | Información completa y personalizada | Buen contenido | Contenido básico | Vacío o copiado |
| **Formato** | Markdown correcto, tablas, código | Buen uso de Markdown | Uso básico | Sin formato |
| **Reflexión** | Reflexión profunda sobre staging y commits | Reflexión adecuada | Reflexión superficial | Sin reflexión |

#### 📋 Secciones Obligatorias (Week 02)

| Sección | Puntos | Descripción |
|---------|--------|-------------|
| Título + Descripción | 3 pts | Nombre del proyecto y qué es |
| Sobre Mí | 2 pts | Nombre, bootcamp, fecha |
| Objetivos | 3 pts | Qué lograste esta semana |
| Estructura del proyecto | 3 pts | Árbol de carpetas/archivos |
| Comandos utilizados | 5 pts | Tabla de comandos Git usados |
| Conventional Commits | 4 pts | Explicar tipos usados con ejemplos |
| Reflexión personal | 5 pts | Qué aprendí sobre staging y commits |

---

### 5️⃣ Deshacer Cambios (15 puntos)

| Criterio | Excelente (15) | Bueno (12) | Aceptable (9) | Insuficiente (0-6) |
|----------|----------------|------------|----------------|---------------------|
| **Comprensión** | Distingue reset, restore, revert | Entiende diferencias básicas | Confusión entre comandos | No comprende |
| **Práctica segura** | Sabe cuándo usar cada comando | Usa comandos con cuidado | Uso inseguro | Daña el historial |
| **Recuperación** | Puede recuperar de errores comunes | Recupera con ayuda | Dificultad para recuperar | No puede recuperar |

#### ✅ Comandos que debe conocer

```bash
# Deshacer cambios en working directory
git restore <archivo>
git checkout -- <archivo>    # Método antiguo

# Quitar del staging
git restore --staged <archivo>
git reset HEAD <archivo>     # Método antiguo

# Modificar último commit
git commit --amend -m "nuevo mensaje"
git commit --amend --no-edit  # Agregar cambios sin cambiar mensaje

# Reset (CUIDADO - puede perder trabajo)
git reset --soft HEAD~1      # Mantiene cambios en staging
git reset --mixed HEAD~1     # Mantiene cambios en working (default)
git reset --hard HEAD~1      # BORRA todo (peligroso)
```

---

## 📊 Tabla de Puntuación Final

| Categoría | Puntos Máximos | Puntos Obtenidos |
|-----------|----------------|------------------|
| Uso del Staging Area | 20 | |
| **Commits Profesionales** | **25** | |
| Navegación del Historial | 15 | |
| **README.md del Proyecto** | **25** | |
| Deshacer Cambios | 15 | |
| **TOTAL** | **100** | |

> **📌 Nota**: Los commits profesionales y el README representan el 50% de la evaluación.

---

## 🏆 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐⭐⭐⭐⭐ Excelente | Dominio completo de staging y commits |
| 80-89 | ⭐⭐⭐⭐ Muy Bueno | Comprensión sólida con detalles menores |
| 70-79 | ⭐⭐⭐ Bueno | Comprensión adecuada, necesita práctica |
| 60-69 | ⭐⭐ Aceptable | Comprensión básica, requiere refuerzo |
| 0-59 | ⭐ Insuficiente | No cumple requisitos mínimos |

---

## 📝 Entregables Requeridos

### Obligatorios

1. **Repository del proyecto blog** - Con estructura organizada
2. **Mínimo 10 commits** - Todos con Conventional Commits
3. **README.md completo** - Con todas las secciones requeridas
4. **Capturas de pantalla**:
   - `git log --oneline` mostrando tus commits
   - `git log --oneline --graph` (si hay branches)
   - Ejemplo de `git diff` o `git show`

### Opcionales (Puntos Extra)

- [ ] Crear alias personalizados para git log (+3 pts)
- [ ] Usar `git add -p` para commits parciales (+3 pts)
- [ ] Incluir capturas de terminal en el README (+2 pts)
- [ ] Reflexión extendida sobre workflow (+2 pts)

---

## ⚠️ Penalizaciones

| Infracción | Penalización |
|------------|--------------|
| Entrega tardía (por día) | -10% |
| Plagio o copia | -100% (0 puntos) |
| Commits sin Conventional Commits | -3 pts por commit |
| Menos de 10 commits | -5 pts por cada commit faltante |
| README vacío o sin secciones | -25 pts |
| README sin reflexión | -10 pts |
| Commits tipo "cambios", "update", "." | -2 pts por cada uno |

---

## 💡 Consejos para Máxima Puntuación

1. **Planifica tus commits** - Piensa antes de commitear
2. **Commits pequeños y frecuentes** - Un propósito por commit
3. **Sigue Conventional Commits** - Es estándar de la industria
4. **Usa staging estratégicamente** - No siempre `git add .`
5. **Documenta mientras avanzas** - No dejes el README para el final
6. **Practica deshacer** - En un repo de prueba, no en tu proyecto

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [README](README.md) | [Week 02](README.md) | [Week 03](../week-03_branching_basico/README.md) |

---

_Rúbrica Week 02 | Bootcamp Git/GitHub | 2025_
