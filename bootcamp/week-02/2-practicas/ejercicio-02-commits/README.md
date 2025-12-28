# 📝 Ejercicio 02: Commits Profesionales

## 🎯 Objetivo

Dominar la escritura de commits profesionales usando Conventional Commits y mantener commits atómicos.

---

## 📋 Requisitos Previos

- [ ] Completar [Ejercicio 01: Staging Estratégico](../ejercicio-01-staging/README.md)
- [ ] Leer [Lección 02: Commits Profesionales](../../1-teoria/02-commits-profesionales.md)
- [ ] Terminal abierta

---

## ⏱️ Tiempo Estimado

50 minutos

---

## 📝 Instrucciones

### Parte 1: Preparar el Proyecto Blog (10 min)

```bash
# EJERCICIO: Crear proyecto de blog personal
# ¿QUÉ VAMOS A HACER?: Configurar un nuevo proyecto para practicar commits
# ¿POR QUÉ LO HACEMOS?: Simular desarrollo real con múltiples commits
# ¿PARA QUÉ SIRVE?: Practicar Conventional Commits en un escenario realista

# Paso 1: Crear carpeta del proyecto
mkdir ~/bootcamp-ejercicios/blog-personal
cd ~/bootcamp-ejercicios/blog-personal

# Paso 2: Inicializar Git
git init

# Paso 3: Configurar identidad LOCAL
git config --local user.name "Tu Nombre"
git config --local user.email "tu.email@ejemplo.com"

# Paso 4: Crear primer archivo (commit inicial)
echo "# Mi Blog Personal" > README.md
echo "" >> README.md
echo "Blog creado como ejercicio del bootcamp Git/GitHub." >> README.md

# Paso 5: Primer commit
git add README.md
git commit -m "chore: initial commit"
```

### Parte 2: Desarrollar el Blog con Commits Profesionales (25 min)

Sigue estos pasos creando UN COMMIT POR CADA PASO:

#### Paso 2.1: Crear estructura de carpetas

```bash
# EJERCICIO: Crear estructura del proyecto
# ¿QUÉ VAMOS A HACER?: Crear carpetas para organizar el blog
# ¿POR QUÉ LO HACEMOS?: Un proyecto organizado es más mantenible
# ¿PARA QUÉ SIRVE?: Establecer base para desarrollo profesional

mkdir -p posts css js images

# Crear archivo .gitkeep en carpeta vacía (Git no trackea carpetas vacías)
touch images/.gitkeep

git add .
git commit -m "feat: crear estructura de carpetas del proyecto"
```

#### Paso 2.2: Crear archivo HTML principal

```bash
# EJERCICIO: Crear página principal
# ¿QUÉ VAMOS A HACER?: Crear el index.html del blog
# ¿POR QUÉ LO HACEMOS?: Es el punto de entrada del sitio
# ¿PARA QUÉ SIRVE?: Base HTML para el blog

cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Blog Personal</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Mi Blog Personal</h1>
        <nav>
            <a href="index.html">Inicio</a>
            <a href="about.html">Sobre Mí</a>
        </nav>
    </header>
    <main>
        <h2>Últimos Posts</h2>
        <!-- Aquí irán los posts -->
    </main>
    <footer>
        <p>&copy; 2025 Mi Blog</p>
    </footer>
    <script src="js/app.js"></script>
</body>
</html>
EOF

git add index.html
git commit -m "feat: crear página principal del blog"
```

#### Paso 2.3: Agregar estilos CSS

```bash
# EJERCICIO: Crear estilos del blog
# ¿QUÉ VAMOS A HACER?: Crear archivo CSS con estilos base
# ¿POR QUÉ LO HACEMOS?: Separar presentación de estructura
# ¿PARA QUÉ SIRVE?: Hacer el blog visualmente atractivo

cat > css/styles.css << 'EOF'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

header {
    border-bottom: 2px solid #333;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

nav a {
    margin-right: 15px;
    text-decoration: none;
    color: #0066cc;
}

nav a:hover {
    text-decoration: underline;
}

footer {
    margin-top: 40px;
    padding-top: 10px;
    border-top: 1px solid #ccc;
    text-align: center;
    color: #666;
}
EOF

git add css/styles.css
git commit -m "style: agregar estilos base del blog"
```

#### Paso 2.4: Agregar JavaScript básico

```bash
# EJERCICIO: Crear lógica JavaScript
# ¿QUÉ VAMOS A HACER?: Crear archivo JS con funcionalidad básica
# ¿POR QUÉ LO HACEMOS?: Separar lógica de presentación
# ¿PARA QUÉ SIRVE?: Agregar interactividad al blog

cat > js/app.js << 'EOF'
// Archivo principal de JavaScript del blog
console.log("Blog cargado correctamente");

// Función para mostrar fecha actual
function mostrarFecha() {
    const opciones = { 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric' 
    };
    return new Date().toLocaleDateString('es-ES', opciones);
}

// Mostrar fecha en consola
console.log("Fecha actual:", mostrarFecha());
EOF

git add js/app.js
git commit -m "feat: agregar lógica JavaScript básica"
```

#### Paso 2.5: Crear primer post

```bash
# EJERCICIO: Crear primer artículo del blog
# ¿QUÉ VAMOS A HACER?: Crear archivo HTML para el primer post
# ¿POR QUÉ LO HACEMOS?: Un blog necesita contenido
# ¿PARA QUÉ SIRVE?: Demostrar estructura de posts

cat > posts/primer-post.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Primer Post - Mi Blog</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <header>
        <h1>Mi Blog Personal</h1>
        <nav>
            <a href="../index.html">Inicio</a>
            <a href="../about.html">Sobre Mí</a>
        </nav>
    </header>
    <main>
        <article>
            <h2>Mi Primer Post: Aprendiendo Git</h2>
            <p><em>Publicado el: 15 de enero, 2025</em></p>
            <p>Hoy comencé el bootcamp de Git y GitHub. Estoy aprendiendo 
            sobre control de versiones y cómo usar Git de forma profesional.</p>
            <h3>Lo que aprendí hoy:</h3>
            <ul>
                <li>Qué es el staging area</li>
                <li>Cómo hacer commits profesionales</li>
                <li>La convención Conventional Commits</li>
            </ul>
        </article>
    </main>
    <footer>
        <p>&copy; 2025 Mi Blog</p>
    </footer>
</body>
</html>
EOF

git add posts/primer-post.html
git commit -m "feat(posts): agregar primer artículo sobre Git"
```

#### Paso 2.6: Actualizar index para mostrar el post

```bash
# EJERCICIO: Enlazar post desde página principal
# ¿QUÉ VAMOS A HACER?: Modificar index.html para mostrar enlace al post
# ¿POR QUÉ LO HACEMOS?: Los posts deben ser accesibles desde el inicio
# ¿PARA QUÉ SIRVE?: Navegación funcional del blog

# Usar sed para reemplazar el comentario con el enlace
sed -i 's/<!-- Aquí irán los posts -->/<article>\n            <h3><a href="posts\/primer-post.html">Mi Primer Post: Aprendiendo Git<\/a><\/h3>\n            <p>15 de enero, 2025<\/p>\n        <\/article>/' index.html

git add index.html
git commit -m "feat: enlazar primer post desde página principal"
```

#### Paso 2.7: Corregir un "bug" (simular fix)

```bash
# EJERCICIO: Corregir un problema
# ¿QUÉ VAMOS A HACER?: Simular corrección de un bug
# ¿POR QUÉ LO HACEMOS?: Practicar el tipo "fix" de Conventional Commits
# ¿PARA QUÉ SIRVE?: Entender cuándo usar fix vs feat

# Agregar meta description que "faltaba"
sed -i '/<title>/a\    <meta name="description" content="Blog personal sobre tecnología y programación">' index.html

git add index.html
git commit -m "fix: agregar meta description faltante en index"
```

#### Paso 2.8: Actualizar documentación

```bash
# EJERCICIO: Mejorar README
# ¿QUÉ VAMOS A HACER?: Actualizar documentación del proyecto
# ¿POR QUÉ LO HACEMOS?: La documentación debe reflejar el estado actual
# ¿PARA QUÉ SIRVE?: Practicar el tipo "docs"

cat > README.md << 'EOF'
# Mi Blog Personal

Blog creado como ejercicio del bootcamp Git/GitHub.

## Estructura del Proyecto

```
blog-personal/
├── index.html          # Página principal
├── about.html          # Página "Sobre Mí"
├── css/
│   └── styles.css      # Estilos del blog
├── js/
│   └── app.js          # JavaScript del blog
├── posts/
│   └── primer-post.html # Primer artículo
└── images/             # Imágenes del blog
```

## Tecnologías

- HTML5
- CSS3
- JavaScript (Vanilla)

## Comandos Git Utilizados

| Comando | Descripción |
|---------|-------------|
| `git add` | Agregar archivos al staging |
| `git commit` | Crear un commit |
| `git status` | Ver estado de archivos |
| `git log` | Ver historial |

## Autor

Tu Nombre - Bootcamp Git/GitHub 2025
EOF

git add README.md
git commit -m "docs: actualizar README con estructura y tecnologías"
```

### Parte 3: Usar git commit --amend (10 min)

```bash
# EJERCICIO: Modificar el último commit
# ¿QUÉ VAMOS A HACER?: Practicar --amend para corregir commits
# ¿POR QUÉ LO HACEMOS?: A veces olvidamos algo o cometemos errores
# ¿PARA QUÉ SIRVE?: Mantener historial limpio sin commits extra

# Paso 1: Agregar archivo .gitignore (que "olvidamos")
cat > .gitignore << 'EOF'
# Sistema operativo
.DS_Store
Thumbs.db

# Editor
*.swp
*.swo
.vscode/

# Temporal
*.tmp
*.log
EOF

# Paso 2: Agregar al último commit sin cambiar mensaje
git add .gitignore
git commit --amend --no-edit

# Paso 3: Verificar que el commit incluye .gitignore
git show --name-only HEAD
```

### Parte 4: Verificar Historial (5 min)

```bash
# EJERCICIO: Revisar el historial de commits
# ¿QUÉ VAMOS A HACER?: Verificar que todos los commits son profesionales
# ¿POR QUÉ LO HACEMOS?: Asegurar calidad del historial
# ¿PARA QUÉ SIRVE?: Auto-evaluación del ejercicio

# Ver historial completo
git log --oneline

# Verificar formato Conventional Commits
git log --oneline | head -10
```

**🔍 Tu historial debería verse similar a:**

```
abc1234 docs: actualizar README con estructura y tecnologías
def5678 fix: agregar meta description faltante en index
ghi9012 feat: enlazar primer post desde página principal
jkl3456 feat(posts): agregar primer artículo sobre Git
mno7890 feat: agregar lógica JavaScript básica
pqr1234 style: agregar estilos base del blog
stu5678 feat: crear página principal del blog
vwx9012 feat: crear estructura de carpetas del proyecto
yza3456 chore: initial commit
```

---

## ✅ Verificación Final

```bash
# Contar commits (mínimo 8)
git log --oneline | wc -l

# Verificar tipos usados
echo "Tipos de commits utilizados:"
git log --oneline | grep -oE "^[a-f0-9]+ (feat|fix|docs|style|chore)" | cut -d' ' -f2 | sort | uniq -c

# Ver estadísticas
git shortlog -s -n
```

---

## 📊 Checklist de Aprendizaje

- [ ] Todos mis commits siguen Conventional Commits
- [ ] Usé diferentes tipos: feat, fix, docs, style, chore
- [ ] Cada commit tiene un solo propósito (atómico)
- [ ] Los mensajes son descriptivos y claros
- [ ] Sé usar `git commit --amend`

---

## 🎯 Desafío Extra (Opcional)

1. **Crear página "Sobre Mí"**: Agrega `about.html` con su propio commit.

2. **Agregar segundo post**: Crea otro artículo en `posts/` con commits atómicos.

3. **Usar scope consistentemente**: Revisa si puedes mejorar usando scopes como `(posts)`, `(css)`, `(js)`.

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [Ejercicio 01](../ejercicio-01-staging/README.md) | [Week 02](../../README.md) | [Ejercicio 03](../ejercicio-03-historial/README.md) |

---

_Ejercicio 02 Week 02 | Bootcamp Git/GitHub | 2025_
