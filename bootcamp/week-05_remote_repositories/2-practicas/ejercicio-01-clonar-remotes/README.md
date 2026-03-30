# Ejercicio 01: Clonar y Configurar Remotes

## Informacion General

| Campo | Valor |
|-------|-------|
| Duracion | 35 minutos |
| Dificultad | Principiante |
| Prerequisitos | Cuenta de GitHub, SSH configurado |

---

## Objetivos

Al completar este ejercicio seras capaz de:

- Clonar un repositorio remoto
- Verificar la configuracion de remotes
- Agregar y configurar multiples remotes
- Cambiar URLs de remotes existentes

---

## Parte 1: Clonar un Repositorio (10 min)

### Paso 1.1: Preparar directorio de trabajo

```bash
# EJERCICIO: Crear directorio para el ejercicio
# ¿QUE HACE?: Crea una carpeta y entra en ella
# ¿POR QUE?: Necesitamos un lugar limpio para trabajar
# ¿PARA QUE SIRVE?: Mantener proyectos organizados

cd ~
mkdir -p ejercicios-week05
cd ejercicios-week05
```

### Paso 1.2: Clonar repositorio publico

```bash
# EJERCICIO: Clonar un repositorio de ejemplo
# ¿QUE HACE?: Descarga el repositorio completo a tu maquina
# ¿POR QUE?: Es la forma de obtener un proyecto existente
# ¿PARA QUE SIRVE?: Tener copia local para trabajar

git clone https://github.com/octocat/Hello-World.git
cd Hello-World

# Verificar que se clono correctamente
ls -la
```

**Resultado esperado:**
```
total XX
drwxr-xr-x  4 user user 4096 ... .
drwxr-xr-x  3 user user 4096 ... ..
drwxr-xr-x  8 user user 4096 ... .git
-rw-r--r--  1 user user  XXX ... README
```

### Paso 1.3: Verificar remote configurado

```bash
# EJERCICIO: Ver remotes existentes
# ¿QUE HACE?: Lista todos los remotes con sus URLs
# ¿POR QUE?: Al clonar, Git configura origin automaticamente
# ¿PARA QUE SIRVE?: Confirmar la conexion con el repositorio

git remote -v

# Resultado esperado:
# origin  https://github.com/octocat/Hello-World.git (fetch)
# origin  https://github.com/octocat/Hello-World.git (push)
```

---

## Parte 2: Clonar con Opciones (10 min)

### Paso 2.1: Clonar en carpeta personalizada

```bash
# EJERCICIO: Clonar con nombre de carpeta diferente
# ¿QUE HACE?: Clona el repo en una carpeta con nombre elegido
# ¿POR QUE?: A veces el nombre del repo no es descriptivo
# ¿PARA QUE SIRVE?: Organizar proyectos con nombres claros

cd ~/ejercicios-week05
git clone https://github.com/octocat/Hello-World.git mi-primer-clone

# Verificar
ls -la mi-primer-clone/
```

### Paso 2.2: Clonar solo ultimo commit (shallow)

```bash
# EJERCICIO: Clone superficial
# ¿QUE HACE?: Descarga solo el ultimo commit, sin historial
# ¿POR QUE?: Ahorra tiempo y espacio en repos grandes
# ¿PARA QUE SIRVE?: Cuando solo necesitas el codigo actual

git clone --depth 1 https://github.com/octocat/Hello-World.git clone-shallow
cd clone-shallow

# Verificar profundidad
git log --oneline
# Solo veras 1 commit

# Volver al directorio principal
cd ~/ejercicios-week05/Hello-World
```

---

## Parte 3: Gestionar Remotes (15 min)

### Paso 3.1: Ver informacion detallada del remote

```bash
# EJERCICIO: Obtener informacion completa de origin
# ¿QUE HACE?: Muestra branches, tracking y configuracion
# ¿POR QUE?: Para entender la conexion con el remoto
# ¿PARA QUE SIRVE?: Diagnostico y verificacion

git remote show origin
```

**Resultado esperado:**
```
* remote origin
  Fetch URL: https://github.com/octocat/Hello-World.git
  Push  URL: https://github.com/octocat/Hello-World.git
  HEAD branch: master
  Remote branches:
    master  tracked
    ...
```

### Paso 3.2: Agregar un segundo remote

```bash
# EJERCICIO: Agregar remote adicional
# ¿QUE HACE?: Crea nueva conexion remota llamada "backup"
# ¿POR QUE?: Para tener multiples destinos de push
# ¿PARA QUE SIRVE?: Respaldo o sincronizacion con otro servidor

git remote add backup https://github.com/otro-usuario/Hello-World.git

# Verificar que se agrego
git remote -v

# Resultado esperado:
# backup  https://github.com/otro-usuario/Hello-World.git (fetch)
# backup  https://github.com/otro-usuario/Hello-World.git (push)
# origin  https://github.com/octocat/Hello-World.git (fetch)
# origin  https://github.com/octocat/Hello-World.git (push)
```

### Paso 3.3: Renombrar remote

```bash
# EJERCICIO: Cambiar nombre de un remote
# ¿QUE HACE?: Renombra "backup" a "mirror"
# ¿POR QUE?: El nombre no es descriptivo o quieres otro
# ¿PARA QUE SIRVE?: Mejor organizacion de remotes

git remote rename backup mirror

# Verificar
git remote -v
# Ahora se llama "mirror" en vez de "backup"
```

### Paso 3.4: Cambiar URL de remote

```bash
# EJERCICIO: Actualizar URL de un remote
# ¿QUE HACE?: Cambia la URL asociada al remote
# ¿POR QUE?: Quieres cambiar de HTTPS a SSH o viceversa
# ¿PARA QUE SIRVE?: Usar diferente protocolo o servidor

# Cambiar origin de HTTPS a SSH (ejemplo)
git remote set-url origin git@github.com:octocat/Hello-World.git

# Verificar cambio
git remote -v
# origin  git@github.com:octocat/Hello-World.git (fetch)
# origin  git@github.com:octocat/Hello-World.git (push)

# Revertir a HTTPS para este ejercicio
git remote set-url origin https://github.com/octocat/Hello-World.git
```

### Paso 3.5: Eliminar remote

```bash
# EJERCICIO: Eliminar un remote
# ¿QUE HACE?: Remueve la conexion remota
# ¿POR QUE?: Ya no necesitas ese destino
# ¿PARA QUE SIRVE?: Limpiar configuracion

git remote remove mirror

# Verificar que se elimino
git remote -v
# Solo debe quedar "origin"
```

---

## Verificacion Final

Ejecuta estos comandos para verificar que completaste el ejercicio:

```bash
# 1. Verificar que estas en el repositorio clonado
pwd
# Debe mostrar: .../ejercicios-week05/Hello-World

# 2. Verificar remote origin
git remote -v
# Debe mostrar origin con URL de GitHub

# 3. Verificar que puedes ver branches remotos
git branch -a

# 4. Verificar historial
git log --oneline -5
```

---

## Limpieza (Opcional)

```bash
# Si quieres limpiar los ejercicios
cd ~
rm -rf ejercicios-week05
```

---

## Errores Comunes

### Error: Repository not found

```bash
# Si ves este error al clonar
fatal: repository 'https://github.com/usuario/repo.git/' not found

# Verificar:
# - La URL esta correcta
# - El repositorio es publico o tienes acceso
# - No hay typos en usuario/repo
```

### Error: Remote already exists

```bash
# Si ves este error al agregar remote
fatal: remote origin already exists.

# Solucion: usar set-url o eliminar primero
git remote set-url origin nueva-url
# o
git remote remove origin
git remote add origin nueva-url
```

---

## Resumen de Comandos

| Comando | Descripcion |
|---------|-------------|
| `git clone <url>` | Clonar repositorio |
| `git clone <url> <dir>` | Clonar en directorio especifico |
| `git clone --depth 1` | Clone superficial |
| `git remote -v` | Ver remotes |
| `git remote add <n> <url>` | Agregar remote |
| `git remote rename <old> <new>` | Renombrar remote |
| `git remote set-url <n> <url>` | Cambiar URL |
| `git remote remove <n>` | Eliminar remote |
| `git remote show <n>` | Info detallada |

---

## Siguiente Ejercicio

[Ejercicio 02: Push y Pull Basico](../ejercicio-02-push-pull/README.md)

---

*Week 05 - Ejercicio 01 | Bootcamp Git/GitHub*
