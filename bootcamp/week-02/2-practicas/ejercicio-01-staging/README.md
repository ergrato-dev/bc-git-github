# 📦 Ejercicio 01: Staging Estratégico

## 🎯 Objetivo

Dominar el uso del staging area para crear commits atómicos y organizados.

---

## 📋 Requisitos Previos

- [ ] Git instalado y configurado
- [ ] Completar [Lección 01: El Staging Area](../../1-teoria/01-staging-area.md)
- [ ] Terminal abierta

---

## ⏱️ Tiempo Estimado

45 minutos

---

## 📝 Instrucciones

### Parte 1: Preparar el Entorno (5 min)

```bash
# EJERCICIO: Preparar carpeta de trabajo
# ¿QUÉ VAMOS A HACER?: Crear un repositorio de prueba
# ¿POR QUÉ LO HACEMOS?: Necesitamos un espacio limpio para practicar
# ¿PARA QUÉ SIRVE?: Evitar afectar otros proyectos mientras aprendemos

# Paso 1: Crear carpeta del ejercicio
mkdir ~/bootcamp-ejercicios/week-02-ejercicio-01
cd ~/bootcamp-ejercicios/week-02-ejercicio-01

# Paso 2: Inicializar repository
git init

# Paso 3: Configurar identidad LOCAL (importante en equipos compartidos)
git config --local user.name "Tu Nombre"
git config --local user.email "tu.email@ejemplo.com"

# Verificar configuración
git config --local --list
```

### Parte 2: Crear Archivos Iniciales (10 min)

```bash
# EJERCICIO: Crear estructura de proyecto
# ¿QUÉ VAMOS A HACER?: Crear archivos para simular un proyecto web
# ¿POR QUÉ LO HACEMOS?: Necesitamos archivos para practicar staging
# ¿PARA QUÉ SIRVE?: Simular un escenario real de desarrollo

# Paso 1: Crear archivo HTML
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Sitio Web</title>
</head>
<body>
    <h1>Bienvenido</h1>
    <p>Este es mi sitio web de prueba.</p>
</body>
</html>
EOF

# Paso 2: Crear archivo CSS
cat > styles.css << 'EOF'
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
}

h1 {
    color: blue;
}
EOF

# Paso 3: Crear archivo JavaScript
cat > app.js << 'EOF'
// Archivo principal de JavaScript
console.log("Aplicación iniciada");

function saludar(nombre) {
    return "Hola, " + nombre;
}
EOF

# Paso 4: Verificar estado
git status
```

**🔍 Resultado esperado de `git status`:**
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        app.js
        index.html
        styles.css
```

### Parte 3: Agregar Archivos Selectivamente (15 min)

```bash
# EJERCICIO: Staging selectivo
# ¿QUÉ VAMOS A HACER?: Agregar archivos uno por uno al staging
# ¿POR QUÉ LO HACEMOS?: Para crear commits atómicos y organizados
# ¿PARA QUÉ SIRVE?: Cada commit tendrá un propósito claro

# Paso 1: Agregar solo HTML al staging
git add index.html

# Paso 2: Verificar qué está en staging
git status
```

**🔍 ¿Qué deberías ver?**
- `index.html` en verde (staged)
- `styles.css` y `app.js` en rojo (untracked)

```bash
# Paso 3: Ver exactamente qué cambios están en staging
git diff --staged

# Paso 4: Hacer primer commit
git commit -m "feat: crear estructura HTML base"

# Paso 5: Agregar CSS al staging
git add styles.css

# Paso 6: Verificar y commitear
git status
git commit -m "style: agregar estilos iniciales"

# Paso 7: Agregar JavaScript
git add app.js
git commit -m "feat: agregar lógica JavaScript inicial"

# Paso 8: Verificar historial
git log --oneline
```

**🔍 Resultado esperado del historial:**
```
abc1234 feat: agregar lógica JavaScript inicial
def5678 style: agregar estilos iniciales
ghi9012 feat: crear estructura HTML base
```

### Parte 4: Modificar y Usar git diff (10 min)

```bash
# EJERCICIO: Practicar con archivos modificados
# ¿QUÉ VAMOS A HACER?: Modificar archivos y ver diferencias
# ¿POR QUÉ LO HACEMOS?: Entender el flujo completo modified → staged → committed
# ¿PARA QUÉ SIRVE?: Tomar decisiones informadas sobre qué commitear

# Paso 1: Modificar HTML (añadir sección)
cat >> index.html << 'EOF'
    <section>
        <h2>Sobre Mí</h2>
        <p>Soy estudiante del bootcamp Git/GitHub.</p>
    </section>
EOF

# Paso 2: Modificar CSS (añadir estilos)
cat >> styles.css << 'EOF'

section {
    background-color: #f0f0f0;
    padding: 15px;
    margin-top: 20px;
}
EOF

# Paso 3: Ver estado
git status

# Paso 4: Ver TODOS los cambios (working directory)
git diff

# Paso 5: Agregar solo HTML al staging
git add index.html

# Paso 6: Ver cambios en staging (solo HTML)
git diff --staged

# Paso 7: Ver cambios que NO están en staging (solo CSS)
git diff
```

**🔍 Observa la diferencia:**
- `git diff --staged` → muestra cambios de index.html
- `git diff` → muestra cambios de styles.css

```bash
# Paso 8: Commitear HTML
git commit -m "feat: agregar sección 'Sobre Mí'"

# Paso 9: Agregar y commitear CSS
git add styles.css
git commit -m "style: agregar estilos para sección"
```

### Parte 5: Quitar del Staging (5 min)

```bash
# EJERCICIO: Practicar git restore --staged
# ¿QUÉ VAMOS A HACER?: Quitar archivos del staging sin perder cambios
# ¿POR QUÉ LO HACEMOS?: A veces agregamos algo por error
# ¿PARA QUÉ SIRVE?: Flexibilidad para reorganizar commits

# Paso 1: Modificar ambos archivos
echo "/* Nuevo comentario */" >> styles.css
echo "// Nuevo comentario" >> app.js

# Paso 2: Agregar TODO al staging (simular error)
git add .

# Paso 3: Ver estado
git status
# Ambos archivos en verde (staged)

# Paso 4: ¡Ups! Solo quería commitear CSS
# Quitar app.js del staging
git restore --staged app.js

# Paso 5: Verificar
git status
# CSS en verde, app.js en rojo

# Paso 6: Commitear solo CSS
git commit -m "style: agregar comentario en CSS"

# Paso 7: Ahora commitear JavaScript
git add app.js
git commit -m "chore: agregar comentario en JavaScript"
```

---

## ✅ Verificación Final

Ejecuta estos comandos para verificar que completaste el ejercicio:

```bash
# Ver historial completo
git log --oneline

# Deberías tener al menos 7 commits
git log --oneline | wc -l

# Verificar que todos siguen Conventional Commits
git log --oneline | grep -E "^[a-f0-9]+ (feat|fix|docs|style|refactor|test|chore)(\(.+\))?:"
```

---

## 📊 Checklist de Aprendizaje

- [ ] Puedo agregar archivos específicos con `git add archivo`
- [ ] Entiendo la diferencia entre `git diff` y `git diff --staged`
- [ ] Puedo quitar archivos del staging con `git restore --staged`
- [ ] Puedo crear commits atómicos (un propósito por commit)
- [ ] Mis commits siguen Conventional Commits

---

## 🎯 Desafío Extra (Opcional)

1. **Usar `git add -p`**: Modifica un archivo con dos cambios diferentes y usa `git add -p` para agregar solo uno de ellos.

2. **Crear `.gitignore`**: Crea archivos temporales y un `.gitignore` para excluirlos.

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [README Prácticas](../README.md) | [Week 02](../../README.md) | [Ejercicio 02](../ejercicio-02-commits/README.md) |

---

_Ejercicio 01 Week 02 | Bootcamp Git/GitHub | 2025_
