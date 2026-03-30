# 🚀 Proyecto: Feature Development Simulation

## 📋 Descripción

Simularás el desarrollo de una **aplicación web de tareas (Todo App)** utilizando el flujo de trabajo **Feature Branch**. Desarrollarás múltiples funcionalidades en branches independientes y las integrarás al branch principal.

**Duración**: 2 horas | **Modalidad**: Individual

---

## 🎯 Objetivos

- ✅ Aplicar el flujo Feature Branch en un proyecto real
- ✅ Crear y gestionar múltiples branches
- ✅ Realizar merge fast-forward y three-way
- ✅ Documentar el flujo de trabajo con diagramas
- ✅ Seguir Conventional Commits en todos los commits

---

## 📁 Estructura del Proyecto

```
todo-app/
├── README.md              # Documentación del proyecto
├── index.html             # Página principal
├── css/
│   └── styles.css         # Estilos
├── js/
│   ├── app.js             # Aplicación principal
│   ├── todo.js            # Módulo de tareas
│   ├── storage.js         # Persistencia (localStorage)
│   └── ui.js              # Interfaz de usuario
└── BRANCH-DIAGRAM.md      # Diagrama de branches (ASCII o imagen)
```

---

## 📝 Requerimientos

### Branches Obligatorios

| Branch | Descripción | Commits mínimos |
|--------|-------------|-----------------|
| `main` | Branch principal, siempre estable | - |
| `develop` | Branch de integración | - |
| `feature/todo-crud` | Crear, leer, actualizar, eliminar tareas | 3+ |
| `feature/local-storage` | Persistencia en localStorage | 2+ |
| `feature/ui-styles` | Estilos y diseño visual | 2+ |

### Funcionalidades por Feature

#### Feature 1: `feature/todo-crud`
- Añadir nueva tarea
- Listar todas las tareas
- Marcar tarea como completada
- Eliminar tarea

#### Feature 2: `feature/local-storage`
- Guardar tareas en localStorage
- Cargar tareas al iniciar
- Sincronizar cambios automáticamente

#### Feature 3: `feature/ui-styles`
- Diseño responsive básico
- Estilos para tareas completadas
- Animaciones simples (opcional)

---

## 🔄 Flujo de Trabajo Requerido

```
1. Inicializar proyecto en main
2. Crear branch develop desde main
3. Desarrollar cada feature en su branch (desde develop)
4. Integrar features a develop con --no-ff
5. Cuando todas las features estén listas, merge develop → main
6. Eliminar feature branches
7. Documentar el proceso
```

### Diagrama Esperado

```
main:     ●─────────────────────────────────────●
           \                                   /
develop:    ●───●───────●───────●───────●─────●
                 \     /       /       /
feature/crud:     ●───●       /       /
                             /       /
feature/storage:    ●───────●       /
                                   /
feature/ui:              ●────────●
```

---

## ✅ Entregables

### 1. Repositorio Git (60 puntos)

| Criterio | Puntos |
|----------|--------|
| Estructura de branches correcta (main, develop, 3 features) | 15 pts |
| Mínimo 10 commits totales | 10 pts |
| Commits siguen Conventional Commits | 10 pts |
| Merge con `--no-ff` preservando historial | 15 pts |
| Feature branches eliminados después del merge | 10 pts |

### 2. Documentación (40 puntos)

| Criterio | Puntos |
|----------|--------|
| README.md completo del proyecto | 15 pts |
| Diagrama de branches (BRANCH-DIAGRAM.md) | 15 pts |
| Código comentado | 10 pts |

---

## 🛠️ Guía de Inicio

### Paso 1: Crear el proyecto

```bash
# Crear directorio
mkdir todo-app && cd todo-app
git init

# Crear estructura inicial
mkdir css js
touch README.md index.html css/styles.css js/app.js

# Commit inicial
git add .
git commit -m "chore: initial project structure"

# Crear develop
git branch develop
```

### Paso 2: Crear feature branch

```bash
git switch -c feature/todo-crud develop

# Desarrollar...
git commit -m "feat(todo): add Todo class with basic methods"
git commit -m "feat(todo): add CRUD operations"
git commit -m "feat(todo): add toggle complete functionality"
```

### Paso 3: Integrar a develop

```bash
git switch develop
git merge --no-ff feature/todo-crud -m "feat: integrate todo CRUD feature"
git branch -d feature/todo-crud
```

### Paso 4: Repetir para cada feature

### Paso 5: Merge final a main

```bash
git switch main
git merge --no-ff develop -m "release: v1.0.0 - Todo App complete"
```

---

## 📊 Ejemplo de Historial Esperado

```bash
$ git log --oneline --graph --all

*   abc1234 (HEAD -> main) release: v1.0.0 - Todo App complete
|\
| *   def5678 (develop) feat: integrate UI styles feature
| |\
| | * ghi9012 feat(ui): add responsive styles
| | * jkl3456 feat(ui): add base CSS
| |/
| *   mno7890 feat: integrate local storage feature
| |\
| | * pqr1234 feat(storage): add auto-sync
| | * stu5678 feat(storage): add localStorage wrapper
| |/
| *   vwx9012 feat: integrate todo CRUD feature
| |\
| | * yza3456 feat(todo): add toggle complete
| | * bcd7890 feat(todo): add CRUD operations
| | * efg1234 feat(todo): add Todo class
| |/
| * hij5678 chore: initial project structure
|/
* klm9012 chore: initial project structure
```

---

## 💡 Tips

1. **Commits pequeños**: Haz commits frecuentes y atómicos
2. **Mensajes claros**: Usa el formato `tipo(scope): descripción`
3. **Verifica antes de merge**: `git log --oneline --graph --all`
4. **No olvides el diagrama**: Es parte importante de la evaluación
5. **Prueba el flujo**: Asegúrate de que la app funciona después de cada merge

---

## 🔗 Navegación

| ⬅️ Prácticas | 🏠 Semana | Recursos ➡️ |
|:-------------|:---------:|------------:|
| [2-practicas](../2-practicas/) | [Week 03](../README.md) | [4-recursos](../4-recursos/) |

---

<div align="center">

**Proyecto Semanal** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
