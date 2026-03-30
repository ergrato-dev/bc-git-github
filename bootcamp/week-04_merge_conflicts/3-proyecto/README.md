# Proyecto: Collaborative Conflict Resolution

## Descripcion

Simular un entorno de trabajo en equipo donde multiples "desarrolladores" modifican los mismos archivos de un proyecto web, generando conflictos que debes identificar, analizar y resolver de manera profesional.

**Duracion estimada:** 2 horas

---

## Objetivos de Aprendizaje

Al completar este proyecto seras capaz de:

- Simular trabajo colaborativo con multiples branches
- Generar y resolver conflictos de diferentes tipos
- Documentar el proceso de resolucion de conflictos
- Aplicar estrategias de prevencion en proyectos futuros

---

## Escenario

Eres parte de un equipo de 3 desarrolladores trabajando en una aplicacion web:

- **Developer A** (tu): Trabajas en el branch `main`
- **Developer B**: Trabaja en `feature/ui-redesign`
- **Developer C**: Trabaja en `feature/api-integration`

Todos han modificado archivos compartidos y ahora debes integrar todo en `main`.

---

## Requisitos

- Git instalado y configurado
- Editor de texto (VS Code recomendado)
- Completar los ejercicios de la semana

---

## Parte 1: Setup del Proyecto (15 min)

### 1.1 Crear estructura del proyecto

```bash
# Crear directorio del proyecto
mkdir proyecto-collaborative-conflict
cd proyecto-collaborative-conflict
git init

# Crear estructura de archivos
mkdir -p src css js
```

### 1.2 Crear archivos iniciales

**index.html:**
```bash
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Manager</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Task Manager</h1>
        <nav>
            <a href="#tasks">Tasks</a>
            <a href="#about">About</a>
        </nav>
    </header>
    
    <main>
        <section id="tasks">
            <h2>My Tasks</h2>
            <ul id="task-list">
                <li>Sample Task 1</li>
                <li>Sample Task 2</li>
            </ul>
        </section>
    </main>
    
    <footer>
        <p>Task Manager v1.0</p>
    </footer>
    
    <script src="js/app.js"></script>
</body>
</html>
EOF
```

**css/styles.css:**
```bash
cat > css/styles.css << 'EOF'
/* Task Manager Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    color: #333;
    line-height: 1.6;
}

header {
    background-color: #333;
    color: white;
    padding: 1rem;
}

header h1 {
    font-size: 1.5rem;
}

nav a {
    color: white;
    margin-left: 1rem;
}

main {
    max-width: 800px;
    margin: 2rem auto;
    padding: 1rem;
}

footer {
    text-align: center;
    padding: 1rem;
    background-color: #333;
    color: white;
}
EOF
```

**js/app.js:**
```bash
cat > js/app.js << 'EOF'
// Task Manager Application
const app = {
    version: "1.0.0",
    tasks: [],
    
    init: function() {
        console.log("Task Manager initialized");
        this.loadTasks();
    },
    
    loadTasks: function() {
        // Load tasks from storage
        console.log("Loading tasks...");
    },
    
    addTask: function(task) {
        this.tasks.push(task);
        console.log("Task added:", task);
    },
    
    removeTask: function(index) {
        this.tasks.splice(index, 1);
        console.log("Task removed");
    }
};

document.addEventListener("DOMContentLoaded", function() {
    app.init();
});
EOF
```

**config.json:**
```bash
cat > config.json << 'EOF'
{
    "appName": "Task Manager",
    "version": "1.0.0",
    "api": {
        "baseUrl": "http://localhost:3000",
        "timeout": 5000
    },
    "features": {
        "darkMode": false,
        "notifications": false
    }
}
EOF
```

### 1.3 Commit inicial

```bash
git add .
git commit -m "feat: setup inicial del Task Manager"
```

---

## Parte 2: Simular Developer B - UI Redesign (20 min)

### 2.1 Crear branch

```bash
git checkout -b feature/ui-redesign
```

### 2.2 Modificar archivos

**Actualizar index.html** (agregar clases y estructura):
```bash
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Manager Pro</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header class="header-redesign">
        <div class="logo">
            <h1>Task Manager Pro</h1>
        </div>
        <nav class="main-nav">
            <a href="#tasks" class="nav-link">Tasks</a>
            <a href="#calendar" class="nav-link">Calendar</a>
            <a href="#settings" class="nav-link">Settings</a>
        </nav>
        <button id="theme-toggle">Toggle Theme</button>
    </header>
    
    <main class="container">
        <section id="tasks" class="task-section">
            <h2>My Tasks</h2>
            <div class="task-filters">
                <button class="filter-btn active">All</button>
                <button class="filter-btn">Active</button>
                <button class="filter-btn">Completed</button>
            </div>
            <ul id="task-list" class="task-list">
            </ul>
            <form id="add-task-form" class="add-task-form">
                <input type="text" placeholder="Add new task..." />
                <button type="submit">Add</button>
            </form>
        </section>
    </main>
    
    <footer class="footer-redesign">
        <p>Task Manager Pro v2.0 | Redesigned UI</p>
    </footer>
    
    <script src="js/app.js"></script>
</body>
</html>
EOF
```

**Actualizar css/styles.css** (nuevo diseno):
```bash
cat > css/styles.css << 'EOF'
/* Task Manager Pro - Redesigned Styles */
:root {
    --primary-color: #6366f1;
    --secondary-color: #8b5cf6;
    --bg-color: #f8fafc;
    --text-color: #1e293b;
    --card-bg: #ffffff;
}

[data-theme="dark"] {
    --bg-color: #0f172a;
    --text-color: #f1f5f9;
    --card-bg: #1e293b;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', sans-serif;
    background-color: var(--bg-color);
    color: var(--text-color);
    line-height: 1.6;
    transition: all 0.3s ease;
}

.header-redesign {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    padding: 1.5rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.main-nav .nav-link {
    color: white;
    text-decoration: none;
    margin-left: 2rem;
    font-weight: 500;
}

.container {
    max-width: 900px;
    margin: 2rem auto;
    padding: 1.5rem;
}

.task-section {
    background: var(--card-bg);
    border-radius: 12px;
    padding: 2rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.task-filters {
    margin: 1rem 0;
}

.filter-btn {
    padding: 0.5rem 1rem;
    margin-right: 0.5rem;
    border: none;
    border-radius: 20px;
    cursor: pointer;
}

.filter-btn.active {
    background-color: var(--primary-color);
    color: white;
}

.footer-redesign {
    text-align: center;
    padding: 1.5rem;
    background-color: var(--card-bg);
    margin-top: 2rem;
}
EOF
```

**Actualizar config.json**:
```bash
cat > config.json << 'EOF'
{
    "appName": "Task Manager Pro",
    "version": "2.0.0",
    "api": {
        "baseUrl": "http://localhost:3000",
        "timeout": 5000
    },
    "features": {
        "darkMode": true,
        "notifications": false,
        "animations": true
    },
    "ui": {
        "theme": "light",
        "primaryColor": "#6366f1"
    }
}
EOF
```

### 2.3 Commit cambios

```bash
git add .
git commit -m "feat(ui): rediseno completo con soporte dark mode"
```

---

## Parte 3: Simular Developer C - API Integration (20 min)

### 3.1 Crear branch desde main

```bash
git checkout main
git checkout -b feature/api-integration
```

### 3.2 Modificar archivos

**Actualizar index.html** (agregar elementos de API):
```bash
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Manager - Connected</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Task Manager</h1>
        <span id="connection-status" class="status-indicator">Connecting...</span>
        <nav>
            <a href="#tasks">Tasks</a>
            <a href="#sync">Sync</a>
            <a href="#about">About</a>
        </nav>
    </header>
    
    <main>
        <section id="tasks">
            <h2>My Tasks</h2>
            <div id="loading-indicator" class="hidden">Loading...</div>
            <ul id="task-list">
            </ul>
            <button id="sync-btn">Sync with Server</button>
        </section>
        
        <section id="api-status">
            <h3>API Status</h3>
            <p>Server: <span id="server-status">Unknown</span></p>
            <p>Last sync: <span id="last-sync">Never</span></p>
        </section>
    </main>
    
    <footer>
        <p>Task Manager v1.5 - API Connected</p>
    </footer>
    
    <script src="js/api.js"></script>
    <script src="js/app.js"></script>
</body>
</html>
EOF
```

**Actualizar js/app.js** (agregar integracion API):
```bash
cat > js/app.js << 'EOF'
// Task Manager Application - API Connected
const app = {
    version: "1.5.0",
    tasks: [],
    apiConnected: false,
    
    init: async function() {
        console.log("Task Manager initialized - API version");
        await this.checkConnection();
        this.loadTasks();
        this.setupEventListeners();
    },
    
    checkConnection: async function() {
        try {
            const response = await api.healthCheck();
            this.apiConnected = response.ok;
            this.updateConnectionStatus();
        } catch (error) {
            console.error("API connection failed:", error);
            this.apiConnected = false;
        }
    },
    
    updateConnectionStatus: function() {
        const statusEl = document.getElementById("connection-status");
        statusEl.textContent = this.apiConnected ? "Connected" : "Offline";
        statusEl.className = this.apiConnected ? "status-online" : "status-offline";
    },
    
    loadTasks: async function() {
        if (this.apiConnected) {
            this.tasks = await api.getTasks();
        } else {
            this.tasks = JSON.parse(localStorage.getItem("tasks") || "[]");
        }
        this.renderTasks();
    },
    
    renderTasks: function() {
        const list = document.getElementById("task-list");
        list.innerHTML = this.tasks.map(task => 
            `<li>${task.title}</li>`
        ).join("");
    },
    
    addTask: async function(task) {
        if (this.apiConnected) {
            await api.createTask(task);
        }
        this.tasks.push(task);
        localStorage.setItem("tasks", JSON.stringify(this.tasks));
        console.log("Task added:", task);
    },
    
    syncTasks: async function() {
        if (!this.apiConnected) {
            console.log("Cannot sync - offline");
            return;
        }
        await api.syncTasks(this.tasks);
        document.getElementById("last-sync").textContent = new Date().toLocaleString();
    },
    
    setupEventListeners: function() {
        document.getElementById("sync-btn")?.addEventListener("click", () => this.syncTasks());
    }
};

document.addEventListener("DOMContentLoaded", function() {
    app.init();
});
EOF
```

**Crear js/api.js**:
```bash
cat > js/api.js << 'EOF'
// API Client
const api = {
    baseUrl: "http://localhost:3000/api",
    
    async healthCheck() {
        return fetch(`${this.baseUrl}/health`);
    },
    
    async getTasks() {
        const response = await fetch(`${this.baseUrl}/tasks`);
        return response.json();
    },
    
    async createTask(task) {
        return fetch(`${this.baseUrl}/tasks`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(task)
        });
    },
    
    async syncTasks(tasks) {
        return fetch(`${this.baseUrl}/sync`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ tasks })
        });
    }
};
EOF
```

**Actualizar config.json**:
```bash
cat > config.json << 'EOF'
{
    "appName": "Task Manager",
    "version": "1.5.0",
    "api": {
        "baseUrl": "http://api.taskmanager.com",
        "timeout": 10000,
        "retries": 3,
        "endpoints": {
            "tasks": "/api/tasks",
            "sync": "/api/sync",
            "health": "/api/health"
        }
    },
    "features": {
        "darkMode": false,
        "notifications": true,
        "offlineMode": true
    }
}
EOF
```

**Actualizar css/styles.css** (agregar estilos de estado):
```bash
cat > css/styles.css << 'EOF'
/* Task Manager Styles - API Version */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f0f4f8;
    color: #333;
    line-height: 1.6;
}

header {
    background-color: #2d3748;
    color: white;
    padding: 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

header h1 {
    font-size: 1.5rem;
}

.status-indicator {
    padding: 0.25rem 0.75rem;
    border-radius: 12px;
    font-size: 0.8rem;
}

.status-online {
    background-color: #48bb78;
    color: white;
}

.status-offline {
    background-color: #f56565;
    color: white;
}

nav a {
    color: white;
    margin-left: 1rem;
    text-decoration: none;
}

main {
    max-width: 800px;
    margin: 2rem auto;
    padding: 1rem;
}

#api-status {
    margin-top: 2rem;
    padding: 1rem;
    background-color: #edf2f7;
    border-radius: 8px;
}

.hidden {
    display: none;
}

footer {
    text-align: center;
    padding: 1rem;
    background-color: #2d3748;
    color: white;
}
EOF
```

### 3.3 Commit cambios

```bash
git add .
git commit -m "feat(api): integracion con API y modo offline"
```

---

## Parte 4: Volver a Main y Hacer Cambios (10 min)

### 4.1 Cambiar a main

```bash
git checkout main
```

### 4.2 Hacer cambios como Developer A

**Pequenas mejoras en main:**
```bash
# Actualizar version en config
cat > config.json << 'EOF'
{
    "appName": "Task Manager",
    "version": "1.1.0",
    "api": {
        "baseUrl": "http://localhost:3000",
        "timeout": 8000
    },
    "features": {
        "darkMode": false,
        "notifications": true
    },
    "author": "Developer A"
}
EOF

git add config.json
git commit -m "chore: actualizar config con autor"
```

---

## Parte 5: Integrar Branches - Resolver Conflictos (40 min)

### 5.1 Merge feature/ui-redesign

```bash
git merge feature/ui-redesign
```

**Conflictos esperados:**
- index.html
- css/styles.css
- config.json

**Resuelve cada conflicto:**

1. Para cada archivo, abre y analiza los marcadores
2. Decide que conservar de cada version
3. Elimina los marcadores
4. `git add` cada archivo resuelto
5. `git commit` cuando todos esten resueltos

### 5.2 Merge feature/api-integration

```bash
git merge feature/api-integration
```

**Mas conflictos esperados:**
- index.html (ahora con cambios de UI + API)
- js/app.js
- css/styles.css
- config.json

**Estrategia de resolucion:**

Para cada archivo, combina las funcionalidades:
- HTML: Mantener estructura de UI + agregar elementos de API
- CSS: Combinar estilos de ambos
- JS: Mantener estructura de UI, agregar funcionalidad API
- Config: Unificar todas las configuraciones

### 5.3 Documentar resoluciones

Crea un archivo documentando cada conflicto:

```bash
cat > CONFLICT_RESOLUTION.md << 'EOF'
# Documentacion de Resolucion de Conflictos

## Merge 1: feature/ui-redesign -> main

### Conflicto en index.html
- **Problema**: Estructura diferente del header y main
- **Resolucion**: Mantuve la estructura rediseñada
- **Razon**: Mejor UX y soporte para temas

### Conflicto en css/styles.css
- **Problema**: Estilos completamente diferentes
- **Resolucion**: Adopte los nuevos estilos con variables CSS
- **Razon**: Sistema de temas mas flexible

### Conflicto en config.json
- **Problema**: Diferentes versiones y features
- **Resolucion**: Combine configuraciones, version 2.0.0
- **Razon**: Incluir todas las nuevas features

---

## Merge 2: feature/api-integration -> main

### Conflicto en index.html
- **Problema**: UI rediseñada vs elementos de API
- **Resolucion**: Integre elementos de API en estructura rediseñada
- **Razon**: Mantener mejor UI + funcionalidad API

### Conflicto en js/app.js
- **Problema**: Codigo completamente reescrito
- **Resolucion**: [Describir tu resolucion]
- **Razon**: [Tu razonamiento]

### Conflicto en css/styles.css
- **Problema**: [Describir]
- **Resolucion**: [Tu resolucion]
- **Razon**: [Tu razonamiento]

### Conflicto en config.json
- **Problema**: [Describir]
- **Resolucion**: [Tu resolucion]
- **Razon**: [Tu razonamiento]

---

## Lecciones Aprendidas

1. [Tu leccion 1]
2. [Tu leccion 2]
3. [Tu leccion 3]

## Recomendaciones para el Equipo

1. [Recomendacion 1]
2. [Recomendacion 2]
EOF

git add CONFLICT_RESOLUTION.md
git commit -m "docs: agregar documentacion de resolucion de conflictos"
```

---

## Parte 6: Verificar y Documentar (15 min)

### 6.1 Verificar historial

```bash
git log --oneline --graph --all
```

### 6.2 Verificar que la aplicacion funciona

Abre `index.html` en un navegador y verifica que:
- La UI se ve correctamente
- Los elementos de API estan presentes
- El toggle de tema funciona (si lo implementaste)

### 6.3 Crear README del proyecto

```bash
cat > README.md << 'EOF'
# Task Manager - Proyecto Integrado

## Descripcion

Aplicacion de gestion de tareas que combina:
- UI rediseñada con soporte de temas
- Integracion con API
- Modo offline

## Branches Integrados

- `feature/ui-redesign`: Nuevo diseño visual
- `feature/api-integration`: Conexion con servidor

## Conflictos Resueltos

Ver [CONFLICT_RESOLUTION.md](CONFLICT_RESOLUTION.md) para documentacion detallada.

## Como Ejecutar

1. Abrir `index.html` en un navegador
2. (Opcional) Configurar servidor API en `config.json`

## Autores

- Developer A: Integracion y resolucion de conflictos
- Developer B: UI Redesign
- Developer C: API Integration
EOF

git add README.md
git commit -m "docs: agregar README del proyecto"
```

---

## Entregables

1. **Repository completo** con todos los merges realizados
2. **CONFLICT_RESOLUTION.md** documentando cada conflicto
3. **Historial de Git** mostrando los merge commits
4. **Aplicacion funcional** con todas las features integradas

---

## Criterios de Evaluacion

| Criterio | Puntos |
|----------|--------|
| Todos los conflictos resueltos correctamente | 30 |
| Aplicacion funcional post-merge | 20 |
| Documentacion de conflictos completa | 25 |
| Historial de commits limpio | 15 |
| README del proyecto | 10 |
| **Total** | **100** |

---

## Reflexion Final

Al completar este proyecto, reflexiona sobre:

1. ¿Cual fue el conflicto mas dificil de resolver?
2. ¿Que estrategias usaste para decidir que codigo conservar?
3. ¿Como evitarias estos conflictos en un proyecto real?
4. ¿Que herramientas te ayudaron mas?

---

*Proyecto Week 04 | Bootcamp Git/GitHub*
- Preguntar en el foro o Discord del bootcamp

---

**💡 Tip:** Comienza temprano y no dudes en pedir ayuda si te atascas. El objetivo es aprender, no solo entregar.
