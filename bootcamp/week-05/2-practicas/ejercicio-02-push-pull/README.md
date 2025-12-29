# Ejercicio 02: Push y Pull Basico

## Informacion General

| Campo | Valor |
|-------|-------|
| Duracion | 35 minutos |
| Dificultad | Principiante |
| Prerequisitos | Ejercicio 01 completado, repo propio en GitHub |

---

## Objetivos

Al completar este ejercicio seras capaz de:

- Crear un repositorio en GitHub
- Hacer push de commits locales
- Hacer pull de cambios remotos
- Establecer tracking entre branches

---

## Preparacion

Para este ejercicio necesitas crear un repositorio en GitHub:

1. Ve a [github.com/new](https://github.com/new)
2. Nombre: `practica-remotes`
3. Descripcion: "Practica de push y pull"
4. **NO** inicializar con README
5. Click en "Create repository"

---

## Parte 1: Conectar Local con Remote (10 min)

### Paso 1.1: Crear repositorio local

```bash
# EJERCICIO: Crear y configurar repositorio local
# ¿QUE HACE?: Crea carpeta, inicializa Git, crea archivo inicial
# ¿POR QUE?: Necesitamos un repo local para conectar con GitHub
# ¿PARA QUE SIRVE?: Simular flujo de trabajo real

cd ~
mkdir practica-remotes
cd practica-remotes
git init

# Crear archivo inicial
echo "# Practica Remotes" > README.md
echo "Ejercicio de push y pull - Week 05" >> README.md

git add README.md
git commit -m "Initial commit: agregar README"
```

### Paso 1.2: Conectar con GitHub

```bash
# EJERCICIO: Agregar remote origin
# ¿QUE HACE?: Conecta el repo local con GitHub
# ¿POR QUE?: Para poder hacer push/pull
# ¿PARA QUE SIRVE?: Sincronizacion con el servidor

# Reemplaza TU-USUARIO con tu nombre de GitHub
git remote add origin git@github.com:TU-USUARIO/practica-remotes.git

# Verificar conexion
git remote -v
```

### Paso 1.3: Primer push con tracking

```bash
# EJERCICIO: Push inicial estableciendo upstream
# ¿QUE HACE?: Sube commits y configura tracking branch
# ¿POR QUE?: Primera vez necesita -u para establecer relacion
# ¿PARA QUE SIRVE?: Futuros push/pull seran mas simples

git push -u origin main

# Si tu branch se llama master:
# git push -u origin master

# Resultado esperado:
# Enumerating objects: 3, done.
# ...
# To github.com:TU-USUARIO/practica-remotes.git
#  * [new branch]      main -> main
# Branch 'main' set up to track remote branch 'main' from 'origin'.
```

### Paso 1.4: Verificar tracking

```bash
# EJERCICIO: Verificar que tracking esta configurado
# ¿QUE HACE?: Muestra branches con su upstream
# ¿POR QUE?: Confirmar que -u funciono
# ¿PARA QUE SIRVE?: Saber que branch remoto sigue cada local

git branch -vv

# Resultado esperado:
# * main  abc1234 [origin/main] Initial commit: agregar README
```

---

## Parte 2: Push de Nuevos Cambios (10 min)

### Paso 2.1: Hacer cambios locales

```bash
# EJERCICIO: Crear mas archivos y commits
# ¿QUE HACE?: Simula trabajo normal de desarrollo
# ¿POR QUE?: Necesitamos contenido para hacer push
# ¿PARA QUE SIRVE?: Practicar el flujo de trabajo

# Archivo 1
echo "console.log('Hola mundo');" > app.js
git add app.js
git commit -m "feat: agregar app.js con mensaje inicial"

# Archivo 2
echo "body { margin: 0; }" > styles.css
git add styles.css
git commit -m "feat: agregar estilos base"

# Verificar commits locales
git log --oneline
# Deberia mostrar 3 commits
```

### Paso 2.2: Ver estado antes de push

```bash
# EJERCICIO: Verificar que hay commits pendientes
# ¿QUE HACE?: Muestra cuantos commits estan por subir
# ¿POR QUE?: Para saber el estado de sincronizacion
# ¿PARA QUE SIRVE?: Confirmar antes de hacer push

git status

# Resultado esperado:
# On branch main
# Your branch is ahead of 'origin/main' by 2 commits.
```

### Paso 2.3: Push de nuevos commits

```bash
# EJERCICIO: Subir commits al remoto
# ¿QUE HACE?: Envia los 2 nuevos commits a GitHub
# ¿POR QUE?: Ya configuramos upstream, solo necesitamos push
# ¿PARA QUE SIRVE?: Compartir trabajo con el equipo

git push

# Resultado esperado:
# Enumerating objects: 6, done.
# ...
# To github.com:TU-USUARIO/practica-remotes.git
#    abc1234..def5678  main -> main
```

### Paso 2.4: Verificar en GitHub

1. Ve a `github.com/TU-USUARIO/practica-remotes`
2. Deberias ver los 3 archivos: README.md, app.js, styles.css
3. Verifica el historial de commits

---

## Parte 3: Pull de Cambios (15 min)

### Paso 3.1: Simular cambio en GitHub

1. Ve a tu repositorio en GitHub
2. Click en `README.md`
3. Click en el icono de lapiz (Edit)
4. Agrega esta linea al final:
   ```
   ## Editado desde GitHub
   Esta linea fue agregada directamente en GitHub.
   ```
5. Click en "Commit changes"
6. Mensaje: "docs: actualizar README desde GitHub"

### Paso 3.2: Ver estado local

```bash
# EJERCICIO: Verificar que local esta desactualizado
# ¿QUE HACE?: Compara tu branch con origin/main
# ¿POR QUE?: Para saber si hay cambios remotos
# ¿PARA QUE SIRVE?: Decidir si necesitas hacer pull

git status
# Puede que no muestre cambios todavia...

# Actualizar referencias remotas
git fetch origin

git status
# Ahora deberia mostrar:
# Your branch is behind 'origin/main' by 1 commit
```

### Paso 3.3: Ver que hay de nuevo

```bash
# EJERCICIO: Revisar cambios antes de pull
# ¿QUE HACE?: Muestra commits en remoto que no tienes
# ¿POR QUE?: Buena practica revisar antes de merge
# ¿PARA QUE SIRVE?: Saber que vas a obtener

git log main..origin/main --oneline
# Muestra el commit hecho en GitHub

git diff main origin/main
# Muestra las diferencias de codigo
```

### Paso 3.4: Hacer pull

```bash
# EJERCICIO: Traer cambios del remoto
# ¿QUE HACE?: Descarga y hace merge de los cambios
# ¿POR QUE?: Para tener la version mas reciente
# ¿PARA QUE SIRVE?: Sincronizar tu trabajo con el equipo

git pull

# Resultado esperado:
# Updating abc1234..xyz9876
# Fast-forward
#  README.md | 4 ++++
#  1 file changed, 4 insertions(+)
```

### Paso 3.5: Verificar sincronizacion

```bash
# EJERCICIO: Confirmar que todo esta sincronizado
# ¿QUE HACE?: Verifica estado y contenido
# ¿POR QUE?: Confirmar que pull funciono
# ¿PARA QUE SIRVE?: Asegurar integridad

git status
# On branch main
# Your branch is up to date with 'origin/main'.

cat README.md
# Debe mostrar la linea agregada en GitHub

git log --oneline -4
# Debe mostrar todos los commits incluyendo el de GitHub
```

---

## Verificacion Final

```bash
# Verificar estado final
git status
# Debe decir "up to date"

# Verificar historial
git log --oneline
# Debe mostrar 4 commits

# Verificar remotes
git remote -v
# Debe mostrar origin con tu URL

# Verificar tracking
git branch -vv
# Debe mostrar [origin/main]
```

---

## Errores Comunes

### Error: Push rejected (non-fast-forward)

```bash
# Si alguien mas hizo push antes que tu
! [rejected]        main -> main (non-fast-forward)

# Solucion: primero hacer pull
git pull
# Resolver conflictos si hay
git push
```

### Error: No upstream branch

```bash
# Si no usaste -u en el primer push
fatal: The current branch main has no upstream branch.

# Solucion: establecer upstream
git push -u origin main
# o
git branch -u origin/main
```

---

## Resumen de Comandos

| Comando | Descripcion |
|---------|-------------|
| `git push -u origin main` | Push con tracking |
| `git push` | Push a upstream |
| `git fetch origin` | Descargar sin merge |
| `git pull` | Descargar y merge |
| `git status` | Ver estado sincronizacion |
| `git log main..origin/main` | Ver commits nuevos |
| `git branch -vv` | Ver tracking |

---

## Siguiente Ejercicio

[Ejercicio 03: Fetch y Merge Manual](../ejercicio-03-fetch-merge/README.md)

---

*Week 05 - Ejercicio 02 | Bootcamp Git/GitHub*
