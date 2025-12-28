# 📊 Rúbrica de Evaluación - Week 01

## 🎯 Fundamentos de Git

**Semana**: 01 - Fundamentos de Git  
**Tiempo total**: 6 horas  
**Peso en el bootcamp**: 6.25% (1/16 semanas)

---

## 📋 Criterios de Evaluación

### 1️⃣ Instalación y Configuración (20 puntos)

| Criterio | Excelente (20) | Bueno (16) | Aceptable (12) | Insuficiente (0-8) |
|----------|----------------|------------|----------------|---------------------|
| **Git instalado** | Git instalado y funcionando correctamente en el sistema | Git instalado con warnings menores | Git instalado pero con problemas de PATH | Git no instalado o no funciona |
| **Identidad configurada** | Nombre y email configurados correctamente | Solo uno de los dos configurado | Configurado pero con datos incorrectos | Sin configurar |
| **Verificación** | Captura de `git --version` y `git config --list` | Solo una de las capturas | Capturas incompletas | Sin capturas |

#### ✅ Checklist de Verificación

```bash
# Comandos que el estudiante debe demostrar:
git --version                    # Debe mostrar versión 2.x o superior
git config user.name             # Debe mostrar nombre completo
git config user.email            # Debe mostrar email válido
git config --global --list       # Debe mostrar configuración completa
```

---

### 2️⃣ Comprensión Teórica (15 puntos)

| Criterio | Excelente (15) | Bueno (12) | Aceptable (9) | Insuficiente (0-5) |
|----------|----------------|------------|----------------|---------------------|
| **Control de versiones** | Explica claramente qué es y sus beneficios | Entiende el concepto básico | Comprensión parcial | No comprende el concepto |
| **Git vs GitHub** | Distingue perfectamente entre ambos | Distingue con alguna confusión | Confunde algunos aspectos | No distingue |
| **Sistemas distribuidos** | Explica ventajas sobre sistemas centralizados | Entiende la diferencia básica | Comprensión superficial | No comprende |

#### 📝 Preguntas de Verificación

1. ¿Cuál es la diferencia entre Git y GitHub?
2. ¿Por qué Git es un sistema distribuido?
3. ¿Qué problema resuelve el control de versiones?
4. ¿Qué es un commit y para qué sirve?

---

### 3️⃣ Repository Local (30 puntos)

| Criterio | Excelente (30) | Bueno (24) | Aceptable (18) | Insuficiente (0-12) |
|----------|----------------|------------|----------------|---------------------|
| **Inicialización** | Repository inicializado correctamente con `git init` | Inicializado con warnings | Inicializado pero en ubicación incorrecta | No inicializado |
| **Commits** | Mínimo 5 commits con mensajes descriptivos siguiendo convenciones | 3-4 commits con buenos mensajes | 1-2 commits o mensajes pobres | Sin commits o mensajes vacíos |
| **Historial** | Historial limpio y lógico, demuestra progresión | Historial aceptable | Historial desordenado | Sin historial coherente |

#### 📏 Estándar de Commits

```bash
# Formato esperado (Conventional Commits):
git commit -m "feat: agregar archivo README con descripción del proyecto"
git commit -m "docs: añadir instrucciones de instalación"
git commit -m "chore: crear estructura inicial de carpetas"

# ❌ Evitar:
git commit -m "cambios"
git commit -m "asdf"
git commit -m "."
```

---

### 4️⃣ Documentación - README.md (25 puntos)

> **⚠️ NOTA IMPORTANTE**: El README es un entregable crítico. Aprender a documentar es tan importante como aprender a programar. Un proyecto sin documentación es un proyecto incompleto.

| Criterio | Excelente (25) | Bueno (20) | Aceptable (15) | Insuficiente (0-10) |
|----------|----------------|------------|----------------|---------------------|
| **Estructura** | Todas las secciones requeridas, bien organizadas | Mayoría de secciones, buena organización | Algunas secciones, organización básica | Pocas o ninguna sección |
| **Contenido** | Información completa, útil y personalizada | Buen contenido, algo genérico | Contenido básico | Vacío o copiado |
| **Formato Markdown** | Uso correcto de headers, listas, tablas, código | Buen uso de Markdown | Uso básico | Sin formato o incorrecto |
| **Reflexión personal** | Reflexión profunda y honesta sobre el aprendizaje | Reflexión adecuada | Reflexión superficial | Sin reflexión |

#### 📋 Secciones Obligatorias del README

| Sección | Puntos | Descripción |
|---------|--------|-------------|
| Título + Descripción | 3 pts | Nombre del proyecto y qué es |
| Sobre Mí | 3 pts | Nombre, bootcamp, fecha |
| Objetivos | 4 pts | Qué se logró con el proyecto |
| Tecnologías | 3 pts | Git, Markdown, Terminal |
| Comandos Aprendidos | 5 pts | Tabla o lista de comandos con descripción |
| Reflexión Personal | 5 pts | Qué aprendí, qué fue difícil, próximos pasos |
| Formato correcto | 2 pts | Markdown bien aplicado |
| **TOTAL** | **25 pts** | |

#### ✅ Ejemplo de README Excelente

```markdown
# 🎯 Mi Primer Repository Git

## 📝 Descripción
Este es mi primer repositorio creado durante el Bootcamp Git/GitHub.
Aquí documento mi aprendizaje sobre control de versiones.

## 👤 Sobre Mí
- **Nombre:** María García
- **Bootcamp:** Git/GitHub - Semana 1
- **Fecha:** Enero 2025

## 🎯 Objetivos
- [x] Instalar Git
- [x] Configurar identidad
- [x] Crear mi primer repository
- [x] Hacer mínimo 5 commits

## 🛠️ Tecnologías
| Tecnología | Uso |
|------------|-----|
| Git | Control de versiones |
| Markdown | Documentación |
| Git Bash | Terminal |

## 📚 Comandos Aprendidos
| Comando | ¿Qué hace? |
|---------|----------|
| `git init` | Crea un repository nuevo |
| `git add .` | Agrega archivos al staging |
| `git commit -m "msg"` | Guarda cambios con mensaje |
| `git status` | Muestra estado actual |
| `git log` | Muestra historial |

## 💭 Mi Reflexión

### ¿Qué aprendí?
Aprendí que Git es mucho más que "guardar archivos"...

### ¿Qué fue difícil?
Al principio la terminal me daba miedo, pero...

### ¿Qué quiero aprender?
Quiero entender mejor los branches y...
```

#### ❌ README No Aceptado (0 puntos)

- README vacío
- Solo título sin contenido
- Copiado de otro estudiante
- Sin ninguna sección de las requeridas
- Sin reflexión personal

---

### 5️⃣ Archivos Adicionales y Buenas Prácticas (10 puntos)

| Criterio | Excelente (10) | Bueno (8) | Aceptable (6) | Insuficiente (0-4) |
|----------|----------------|------------|----------------|---------------------|
| **.gitignore** | Apropiado para el tipo de proyecto | Funcional pero genérico | Muy básico | Inexistente |
| **Frecuencia de commits** | Commits atómicos y frecuentes | Commits regulares | Pocos commits grandes | Un solo commit con todo |
| **Mensajes descriptivos** | Todos siguen Conventional Commits | Mayoría de mensajes buenos | Algunos mensajes útiles | Mensajes pobres o vacíos |

---

## 📊 Tabla de Puntuación Final

| Categoría | Puntos Máximos | Puntos Obtenidos |
|-----------|----------------|------------------|
| Instalación y Configuración | 20 | |
| Comprensión Teórica | 15 | |
| Repository Local | 30 | |
| **README.md (Documentación)** | **25** | |
| Archivos y Buenas Prácticas | 10 | |
| **TOTAL** | **100** | |

> **📌 Nota**: El README.md tiene un peso significativo (25%) porque documentar es una habilidad esencial en desarrollo profesional.

---

## 🏆 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐⭐⭐⭐⭐ Excelente | Dominio completo de los fundamentos |
| 80-89 | ⭐⭐⭐⭐ Muy Bueno | Comprensión sólida con detalles menores |
| 70-79 | ⭐⭐⭐ Bueno | Comprensión adecuada, necesita práctica |
| 60-69 | ⭐⭐ Aceptable | Comprensión básica, requiere refuerzo |
| 0-59 | ⭐ Insuficiente | No cumple requisitos mínimos |

---

## 📝 Entregables Requeridos

### Obligatorios

1. **Captura de pantalla**: `git --version` mostrando versión instalada
2. **Captura de pantalla**: `git config --list` mostrando configuración
3. **Repository local**: Con mínimo 5 commits significativos
4. **README.md completo**: Con TODAS las secciones requeridas (ver sección 4)
5. **.gitignore**: Configurado apropiadamente

### Opcionales (Puntos Extra)

- [ ] Capturas de pantalla en el README mostrando terminal (+3 pts)
- [ ] Diagrama del flujo de trabajo Git creado por el estudiante (+5 pts)
- [ ] README con más de 6 secciones bien desarrolladas (+2 pts)

---

## ⚠️ Penalizaciones

| Infracción | Penalización |
|------------|--------------|
| Entrega tardía (por día) | -10% |
| Plagio o copia | -100% (0 puntos) |
| Commits sin mensajes | -5 pts por commit |
| **README vacío o sin secciones** | **-25 pts** |
| README sin reflexión personal | -10 pts |
| Sin .gitignore | -5 pts |

---

## 💡 Consejos para Obtener Máxima Puntuación

1. **Lee toda la rúbrica** antes de comenzar
2. **Dedica tiempo al README** - es el 25% de la nota
3. **Haz commits frecuentes** con mensajes descriptivos
4. **Incluye reflexión personal** honesta sobre tu aprendizaje
5. **Verifica tu trabajo** antes de entregar
6. **Pregunta si tienes dudas** - no esperes al último momento

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [README](README.md) | [Week 01](README.md) | [Week 02](../week-02/README.md) |

---

_Rúbrica Week 01 | Bootcamp Git/GitHub | 2025_
