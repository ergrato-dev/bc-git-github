# 🚀 Ejercicio 04: Flujo Feature Branch Completo

## 📋 Información

| Campo | Valor |
|-------|-------|
| **Duración** | 40 minutos |
| **Dificultad** | ⭐⭐⭐ Avanzado |
| **Prerrequisitos** | Ejercicios 01-03 completados |
| **Temas** | Feature branch workflow, integración, cleanup |

---

## 🎯 Objetivos

Al completar este ejercicio serás capaz de:

- ✅ Implementar un flujo feature branch profesional
- ✅ Desarrollar múltiples features en paralelo
- ✅ Sincronizar features con cambios de main
- ✅ Integrar features y limpiar branches

---

## 📖 Escenario

Trabajarás en un proyecto de **blog** donde desarrollarás 3 features en paralelo, simulando un equipo de desarrollo:

1. **feature/posts** - Sistema de posts
2. **feature/comments** - Sistema de comentarios
3. **feature/search** - Buscador

---

## 📝 Instrucciones

### Parte 1: Setup del Proyecto (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 1: Crear proyecto
# ══════════════════════════════════════════════════════════════

mkdir blog-project && cd blog-project
git init

# ══════════════════════════════════════════════════════════════
# PASO 2: Estructura inicial
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea la estructura base del blog
# ¿Por qué?: Simular un proyecto real en desarrollo
# ¿Para qué sirve?: Punto de partida para las features

cat > README.md << 'EOF'
# Blog Platform

A simple blog platform built with vanilla JavaScript.

## Features
- [ ] Posts system
- [ ] Comments
- [ ] Search functionality

## Getting Started
1. Clone the repository
2. Open index.html in your browser
EOF

cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Blog</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>My Blog</h1>
    </header>
    <main id="content">
        <!-- Content will be loaded here -->
    </main>
    <script src="app.js"></script>
</body>
</html>
EOF

cat > styles.css << 'EOF'
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
}
header {
    background: #333;
    color: white;
    padding: 1rem;
}
main {
    max-width: 800px;
    margin: 2rem auto;
    padding: 0 1rem;
}
EOF

cat > app.js << 'EOF'
// Blog Application
console.log('Blog initialized');
EOF

git add .
git commit -m "chore: initial blog setup"

# Crear branch develop
git branch develop
```

---

### Parte 2: Desarrollar Features en Paralelo (15 min)

```bash
# ══════════════════════════════════════════════════════════════
# FEATURE 1: Sistema de Posts
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea la feature de posts
# ¿Por qué?: Primera funcionalidad del blog
# ¿Para qué sirve?: Mostrar artículos del blog

git switch -c feature/posts

# Commit 1: Modelo de posts
cat > posts.js << 'EOF'
// Posts Module
const Posts = {
    items: [],
    
    add(post) {
        post.id = Date.now();
        post.date = new Date().toISOString();
        this.items.push(post);
        return post;
    },
    
    getAll() {
        return this.items;
    },
    
    getById(id) {
        return this.items.find(post => post.id === id);
    }
};
EOF

git add posts.js
git commit -m "feat(posts): add Posts module with CRUD operations"

# Commit 2: Renderizado de posts
cat > posts-view.js << 'EOF'
// Posts View
function renderPosts(posts) {
    const container = document.getElementById('content');
    container.innerHTML = posts.map(post => `
        <article class="post">
            <h2>${post.title}</h2>
            <p class="meta">Posted on ${post.date}</p>
            <p>${post.content}</p>
        </article>
    `).join('');
}
EOF

git add posts-view.js
git commit -m "feat(posts): add posts rendering function"

# ══════════════════════════════════════════════════════════════
# FEATURE 2: Sistema de Comentarios (desde main)
# ══════════════════════════════════════════════════════════════

git switch main
git switch -c feature/comments

# ¿Qué hace?: Crea sistema de comentarios
# ¿Por qué?: Permitir interacción en los posts
# ¿Para qué sirve?: Engagement de usuarios

cat > comments.js << 'EOF'
// Comments Module
const Comments = {
    items: [],
    
    add(postId, comment) {
        comment.id = Date.now();
        comment.postId = postId;
        comment.date = new Date().toISOString();
        this.items.push(comment);
        return comment;
    },
    
    getByPostId(postId) {
        return this.items.filter(c => c.postId === postId);
    }
};
EOF

git add comments.js
git commit -m "feat(comments): add Comments module"

cat > comments-view.js << 'EOF'
// Comments View
function renderComments(comments) {
    return comments.map(comment => `
        <div class="comment">
            <strong>${comment.author}</strong>
            <p>${comment.text}</p>
            <small>${comment.date}</small>
        </div>
    `).join('');
}
EOF

git add comments-view.js
git commit -m "feat(comments): add comments rendering"

# ══════════════════════════════════════════════════════════════
# FEATURE 3: Buscador (desde main)
# ══════════════════════════════════════════════════════════════

git switch main
git switch -c feature/search

# ¿Qué hace?: Implementa búsqueda
# ¿Por qué?: Facilitar encontrar contenido
# ¿Para qué sirve?: Mejorar UX del blog

cat > search.js << 'EOF'
// Search Module
const Search = {
    query: '',
    
    setQuery(q) {
        this.query = q.toLowerCase();
    },
    
    filterPosts(posts) {
        if (!this.query) return posts;
        return posts.filter(post => 
            post.title.toLowerCase().includes(this.query) ||
            post.content.toLowerCase().includes(this.query)
        );
    }
};
EOF

git add search.js
git commit -m "feat(search): add Search module"

# Añadir estilos de búsqueda
cat >> styles.css << 'EOF'

/* Search styles */
.search-box {
    margin-bottom: 2rem;
}
.search-box input {
    width: 100%;
    padding: 0.5rem;
    font-size: 1rem;
}
EOF

git add styles.css
git commit -m "feat(search): add search box styles"
```

---

### Parte 3: Visualizar Estado Actual (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 3: Ver todos los branches
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra el historial completo
# ¿Por qué?: Para ver cómo divergieron los branches
# ¿Para qué sirve?: Entender el estado antes de integrar

git log --oneline --graph --all

# Resultado esperado (3 features divergentes):
# * abc1234 (HEAD -> feature/search) feat(search): add search box styles
# * def5678 feat(search): add Search module
# | * ghi9012 (feature/comments) feat(comments): add comments rendering
# | * jkl3456 feat(comments): add Comments module
# |/
# | * mno7890 (feature/posts) feat(posts): add posts rendering function
# | * pqr1234 feat(posts): add Posts module with CRUD operations
# |/
# * stu5678 (main, develop) chore: initial blog setup

# Ver lista de branches
git branch -a
#   develop
#   feature/comments
#   feature/posts
# * feature/search
#   main
```

---

### Parte 4: Integrar Features a Main (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 4: Integrar feature/posts primero
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Integra posts a main
# ¿Por qué?: Es la feature principal
# ¿Para qué sirve?: Actualizar main con la funcionalidad

git switch main
git merge --no-ff feature/posts -m "feat: integrate posts feature"

# Verificar
git log --oneline -3

# ══════════════════════════════════════════════════════════════
# PASO 5: Integrar feature/comments
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Integra comentarios a main
# ¿Por qué?: Segunda funcionalidad
# ¿Para qué sirve?: Añadir interactividad

git merge --no-ff feature/comments -m "feat: integrate comments feature"

# ══════════════════════════════════════════════════════════════
# PASO 6: Integrar feature/search
# ══════════════════════════════════════════════════════════════

git merge --no-ff feature/search -m "feat: integrate search feature"

# ══════════════════════════════════════════════════════════════
# PASO 7: Verificar todas las integraciones
# ══════════════════════════════════════════════════════════════

git log --oneline --graph -10

# Resultado esperado:
# *   xyz7890 (HEAD -> main) feat: integrate search feature
# |\
# | * abc1234 (feature/search) feat(search): add search box styles
# | * def5678 feat(search): add Search module
# |/
# *   uvw3456 feat: integrate comments feature
# |\
# | * ghi9012 (feature/comments) feat(comments): add comments rendering
# | * jkl3456 feat(comments): add Comments module
# |/
# *   rst9012 feat: integrate posts feature
# |\
# | * mno7890 (feature/posts) feat(posts): add posts rendering
# | * pqr1234 feat(posts): add Posts module
# |/
# * stu5678 (develop) chore: initial blog setup

# Verificar archivos
ls *.js
# app.js  comments.js  comments-view.js  posts.js  posts-view.js  search.js
```

---

### Parte 5: Limpiar y Finalizar (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 8: Eliminar feature branches
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Limpia branches que ya fueron integrados
# ¿Por qué?: Mantener el repositorio organizado
# ¿Para qué sirve?: Evitar confusión con branches obsoletos

git branch -d feature/posts
git branch -d feature/comments
git branch -d feature/search

# Verificar
git branch
#   develop
# * main

# ══════════════════════════════════════════════════════════════
# PASO 9: Actualizar develop con main
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Sincroniza develop con los cambios de main
# ¿Por qué?: Mantener develop actualizado
# ¿Para qué sirve?: Base actualizada para nuevas features

git switch develop
git merge main -m "chore: sync develop with main"

# ══════════════════════════════════════════════════════════════
# PASO 10: Actualizar README
# ══════════════════════════════════════════════════════════════

git switch main

cat > README.md << 'EOF'
# Blog Platform

A simple blog platform built with vanilla JavaScript.

## Features
- [x] Posts system
- [x] Comments
- [x] Search functionality

## Project Structure
```
blog-project/
├── index.html          # Main HTML file
├── styles.css          # Styles
├── app.js              # Main app
├── posts.js            # Posts module
├── posts-view.js       # Posts rendering
├── comments.js         # Comments module
├── comments-view.js    # Comments rendering
└── search.js           # Search module
```

## Getting Started
1. Clone the repository
2. Open index.html in your browser

## Development
Each feature was developed in its own branch:
- feature/posts
- feature/comments
- feature/search
EOF

git add README.md
git commit -m "docs: update README with completed features"

# ══════════════════════════════════════════════════════════════
# PASO 11: Ver historial final
# ══════════════════════════════════════════════════════════════

git log --oneline --graph -15
```

---

## ✅ Checklist de Verificación

- [ ] Creaste 3 features branches desde main
- [ ] Cada feature tiene múltiples commits
- [ ] Integraste todas las features con `--no-ff`
- [ ] Eliminaste los feature branches después del merge
- [ ] El historial muestra claramente cada feature
- [ ] develop está sincronizado con main

---

## 🧪 Desafío Extra

```bash
# 1. Crea una nueva feature/tags desde develop
# 2. Mientras trabajas, haz un commit en main (simular hotfix)
# 3. Actualiza tu feature con los cambios de main (merge main into feature)
# 4. Completa la feature e intégrala

# Comandos clave:
git switch -c feature/tags develop
# ... hacer commits ...
git switch main
echo "hotfix" >> app.js && git commit -am "fix: critical hotfix"
git switch feature/tags
git merge main  # Actualizar feature con hotfix
# ... completar feature ...
git switch main
git merge --no-ff feature/tags
```

---

## 🎯 Resultado Esperado

### Estructura Final:
```
blog-project/
├── README.md
├── index.html
├── styles.css
├── app.js
├── posts.js
├── posts-view.js
├── comments.js
├── comments-view.js
└── search.js
```

### Historial Final:
```
* docs: update README with completed features
*   feat: integrate search feature
|\
| * feat(search): add search box styles
| * feat(search): add Search module
|/
*   feat: integrate comments feature
|\
| * feat(comments): add comments rendering
| * feat(comments): add Comments module
|/
*   feat: integrate posts feature
|\
| * feat(posts): add posts rendering function
| * feat(posts): add Posts module
|/
* chore: initial blog setup
```

---

## 📊 Resumen del Flujo

| Paso | Acción | Comando Principal |
|------|--------|-------------------|
| 1 | Crear feature branch | `git switch -c feature/name` |
| 2 | Desarrollar (commits) | `git commit -m "feat: ..."` |
| 3 | Integrar a main | `git merge --no-ff feature/name` |
| 4 | Limpiar | `git branch -d feature/name` |
| 5 | Repetir para cada feature | - |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [Ejercicio 03](../ejercicio-03-merge-commit/README.md) | [README](../README.md) | [Proyecto](../../3-proyecto/README.md) |

---

<div align="center">

**Ejercicio 04** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
