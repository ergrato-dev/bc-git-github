# ⚡ Ejercicio 02: Merge Fast-Forward

## 📋 Información

| Campo | Valor |
|-------|-------|
| **Duración** | 35 minutos |
| **Dificultad** | ⭐⭐ Intermedio |
| **Prerrequisitos** | Ejercicio 01 completado |
| **Temas** | `git merge`, fast-forward, historial lineal |

---

## 🎯 Objetivos

Al completar este ejercicio serás capaz de:

- ✅ Entender cuándo ocurre un merge fast-forward
- ✅ Realizar merge fast-forward correctamente
- ✅ Visualizar el historial después del merge
- ✅ Usar `--ff-only` para garantizar fast-forward

---

## 📖 Concepto Clave

Un **fast-forward merge** ocurre cuando:
- El branch destino (main) NO tiene commits nuevos
- Git simplemente "avanza" el puntero de main
- NO se crea un commit de merge
- El historial queda **lineal**

```
ANTES:                      DESPUÉS:
main ─●─●                   main ─●─●─●─●
          \                           ↑
           ●─● feature               feature (puede eliminarse)
```

---

## 📝 Instrucciones

### Parte 1: Setup del Repositorio (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 1: Crear directorio del ejercicio
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea un espacio de trabajo nuevo
# ¿Por qué?: Para tener un repositorio limpio
# ¿Para qué sirve?: Practicar merge sin interferencias

mkdir ejercicio-merge-ff && cd ejercicio-merge-ff
git init

# ══════════════════════════════════════════════════════════════
# PASO 2: Crear estructura inicial
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea archivos base del proyecto
# ¿Por qué?: Simular un proyecto real
# ¿Para qué sirve?: Tener contenido para trabajar

echo "# Mi Aplicación Web" > README.md
echo "console.log('App started');" > app.js

git add .
git commit -m "chore: initial project setup"

# Verificar
git log --oneline
# abc1234 chore: initial project setup
```

---

### Parte 2: Crear Feature Branch (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 3: Crear y cambiar a feature branch
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea branch para desarrollar login
# ¿Por qué?: Aislar el desarrollo de la feature
# ¿Para qué sirve?: No afectar main mientras trabajamos

git switch -c feature/login

# Verificar
git branch
#   main
# * feature/login

# ══════════════════════════════════════════════════════════════
# PASO 4: Hacer commits en feature branch
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Desarrolla la feature de login
# ¿Por qué?: Simular trabajo real en una feature
# ¿Para qué sirve?: Crear commits que luego mergearemos

# Commit 1: Crear formulario de login
cat > login.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <form id="loginForm">
        <input type="email" placeholder="Email">
        <input type="password" placeholder="Password">
        <button type="submit">Login</button>
    </form>
</body>
</html>
EOF

git add login.html
git commit -m "feat: add login form HTML"

# Commit 2: Añadir JavaScript
cat > login.js << 'EOF'
document.getElementById('loginForm').addEventListener('submit', (e) => {
    e.preventDefault();
    console.log('Login submitted');
});
EOF

git add login.js
git commit -m "feat: add login form handler"

# Commit 3: Añadir estilos
cat > login.css << 'EOF'
#loginForm {
    max-width: 300px;
    margin: 50px auto;
}
#loginForm input {
    display: block;
    width: 100%;
    margin: 10px 0;
}
EOF

git add login.css
git commit -m "feat: add login form styles"
```

---

### Parte 3: Verificar Estado Antes del Merge (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 5: Ver el estado de los branches
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra el historial de todos los branches
# ¿Por qué?: Para visualizar la estructura antes del merge
# ¿Para qué sirve?: Entender qué está pasando

git log --oneline --graph --all

# Resultado esperado:
# * abc1234 (HEAD -> feature/login) feat: add login form styles
# * def5678 feat: add login form handler
# * ghi9012 feat: add login form HTML
# * jkl3456 (main) chore: initial project setup

# ══════════════════════════════════════════════════════════════
# PASO 6: Verificar que main no tiene commits nuevos
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra los commits de main
# ¿Por qué?: Confirmar que main no avanzó
# ¿Para qué sirve?: Asegurar que fast-forward es posible

git switch main
git log --oneline

# Resultado esperado:
# jkl3456 chore: initial project setup

# ¡main sigue en el commit inicial! Fast-forward es posible.
```

---

### Parte 4: Ejecutar Merge Fast-Forward (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 7: Realizar el merge
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Integra los commits de feature/login en main
# ¿Por qué?: La feature está lista para producción
# ¿Para qué sirve?: Actualizar main con la nueva funcionalidad

# Asegurarse de estar en main
git branch
# * main

# Ejecutar merge
git merge feature/login

# Resultado esperado:
# Updating jkl3456..abc1234
# Fast-forward
#  login.css  | 10 ++++++++++
#  login.html | 14 ++++++++++++++
#  login.js   |  4 ++++
#  3 files changed, 28 insertions(+)
#  create mode 100644 login.css
#  create mode 100644 login.html
#  create mode 100644 login.js

# ══════════════════════════════════════════════════════════════
# PASO 8: Verificar el resultado
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra el nuevo estado del historial
# ¿Por qué?: Para confirmar el merge exitoso
# ¿Para qué sirve?: Verificar que el historial es lineal

git log --oneline --graph --all

# Resultado esperado (historial LINEAL):
# * abc1234 (HEAD -> main, feature/login) feat: add login form styles
# * def5678 feat: add login form handler
# * ghi9012 feat: add login form HTML
# * jkl3456 chore: initial project setup

# Nota: NO hay commit de merge
# main y feature/login apuntan al mismo commit

# ══════════════════════════════════════════════════════════════
# PASO 9: Verificar los archivos
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Lista los archivos del proyecto
# ¿Por qué?: Confirmar que los archivos de login están en main
# ¿Para qué sirve?: Validar que el merge trajo todo

ls -la

# Resultado esperado:
# README.md
# app.js
# login.css
# login.html
# login.js
```

---

### Parte 5: Limpiar y Practicar --ff-only (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 10: Eliminar el feature branch
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Elimina el branch que ya fue mergeado
# ¿Por qué?: Ya no necesitamos el branch
# ¿Para qué sirve?: Mantener el repositorio limpio

git branch -d feature/login

# Resultado esperado:
# Deleted branch feature/login (was abc1234).

# Verificar
git branch
# * main

# ══════════════════════════════════════════════════════════════
# PASO 11: Crear otra feature para practicar --ff-only
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea otra feature branch
# ¿Por qué?: Para practicar la opción --ff-only
# ¿Para qué sirve?: Garantizar merge fast-forward

git switch -c feature/navbar

# Crear contenido
cat > navbar.html << 'EOF'
<nav>
    <a href="/">Home</a>
    <a href="/login">Login</a>
    <a href="/about">About</a>
</nav>
EOF

git add navbar.html
git commit -m "feat: add navigation bar"

# ══════════════════════════════════════════════════════════════
# PASO 12: Merge con --ff-only
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Hace merge SOLO si es fast-forward posible
# ¿Por qué?: Para garantizar historial lineal
# ¿Para qué sirve?: Prevenir commits de merge accidentales

git switch main
git merge --ff-only feature/navbar

# Resultado esperado:
# Updating abc1234..xyz7890
# Fast-forward
#  navbar.html | 6 ++++++
#  1 file changed, 6 insertions(+)

# ══════════════════════════════════════════════════════════════
# PASO 13: Simular caso donde --ff-only falla
# ══════════════════════════════════════════════════════════════

# Crear branch y hacer commit
git switch -c feature/footer
echo "<footer>Copyright 2025</footer>" > footer.html
git add footer.html
git commit -m "feat: add footer"

# Volver a main y hacer un commit (esto crea divergencia)
git switch main
echo "// Updated" >> app.js
git commit -am "chore: update app.js"

# Intentar merge --ff-only (fallará)
git merge --ff-only feature/footer

# Resultado esperado:
# fatal: Not possible to fast-forward, aborting.

# Esto falla porque main tiene commits que feature/footer no tiene
```

---

## ✅ Checklist de Verificación

- [ ] Entiendes cuándo ocurre fast-forward (sin divergencia)
- [ ] Puedes realizar merge fast-forward básico
- [ ] El historial queda lineal después del merge
- [ ] Sabes usar `--ff-only` para garantizar fast-forward
- [ ] Entiendes por qué `--ff-only` puede fallar

---

## 🧪 Desafío Extra

```bash
# El feature/footer no pudo hacer fast-forward.
# ¿Cómo lo solucionarías para lograr un historial lineal?

# Pista: Investiga sobre git rebase
# git switch feature/footer
# git rebase main
# git switch main
# git merge --ff-only feature/footer
```

---

## 🎯 Resultado Esperado Final

```
$ git log --oneline --graph

* xyz7890 (HEAD -> main) chore: update app.js
* abc1234 feat: add navigation bar
* def5678 feat: add login form styles
* ghi9012 feat: add login form handler
* jkl3456 feat: add login form HTML
* mno1234 chore: initial project setup
```

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [Ejercicio 01](../ejercicio-01-branches/README.md) | [README](../README.md) | [Ejercicio 03](../ejercicio-03-merge-commit/README.md) |

---

<div align="center">

**Ejercicio 02** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
