# Leccion 02: Git Remote y Clone

## Objetivos de Aprendizaje

Al finalizar esta leccion seras capaz de:

- Clonar repositorios remotos con `git clone`
- Configurar y gestionar remotes con `git remote`
- Entender las diferentes opciones de clonado
- Trabajar con URLs SSH y HTTPS

---

## Git Clone

### Concepto

`git clone` copia un repositorio remoto completo a tu computadora:

```bash
# ¿Que hace?: Descarga todo el repositorio
# ¿Por que?: Para tener una copia local para trabajar
# ¿Para que sirve?: Empezar a contribuir al proyecto

git clone https://github.com/usuario/proyecto.git
```

**Lo que obtienes:**

```
proyecto/
├── .git/              # Historial completo
├── src/               # Codigo
├── README.md          # Documentacion
└── (todos los archivos)
```

### Opciones de Clone

#### Clone basico

```bash
# Clona en carpeta con nombre del repo
git clone https://github.com/usuario/proyecto.git

# Resultado: crea carpeta "proyecto/"
```

#### Clone con nombre personalizado

```bash
# ¿Que hace?: Clona en carpeta con nombre diferente
# ¿Por que?: El nombre del repo no te gusta o ya existe
# ¿Para que sirve?: Organizar proyectos a tu manera

git clone https://github.com/usuario/proyecto.git mi-proyecto

# Resultado: crea carpeta "mi-proyecto/"
```

#### Clone superficial (shallow)

```bash
# ¿Que hace?: Clona solo los ultimos N commits
# ¿Por que?: El historial completo es muy grande
# ¿Para que sirve?: Ahorrar tiempo y espacio

git clone --depth 1 https://github.com/usuario/proyecto.git

# Solo descarga el ultimo commit
# Util para proyectos enormes o CI/CD
```

#### Clone de un branch especifico

```bash
# ¿Que hace?: Clona solo un branch
# ¿Por que?: Solo necesitas ese branch
# ¿Para que sirve?: Trabajar en feature especifica

git clone --branch develop https://github.com/usuario/proyecto.git
git clone -b develop https://github.com/usuario/proyecto.git
```

---

## URLs: HTTPS vs SSH

### HTTPS

```bash
https://github.com/usuario/proyecto.git
```

| Ventaja | Desventaja |
|---------|------------|
| Funciona en cualquier red | Pide password cada vez |
| Facil de configurar | Menos seguro que SSH |
| No requiere SSH keys | Puede ser bloqueado por firewalls |

### SSH

```bash
git@github.com:usuario/proyecto.git
```

| Ventaja | Desventaja |
|---------|------------|
| No pide password | Requiere configurar SSH keys |
| Mas seguro | Puede ser bloqueado en redes corporativas |
| Mejor para uso frecuente | Setup inicial mas complejo |

### Como elegir

```bash
# Para uso personal y frecuente
git clone git@github.com:usuario/proyecto.git

# Para uso ocasional o en redes restrictivas
git clone https://github.com/usuario/proyecto.git
```

---

## Git Remote

### Ver Remotes

```bash
# ¿Que hace?: Lista remotes configurados
# ¿Por que?: Para ver que conexiones tienes
# ¿Para que sirve?: Verificar configuracion

git remote
# Salida: origin

# Con mas detalle
git remote -v
# Salida:
# origin  git@github.com:usuario/proyecto.git (fetch)
# origin  git@github.com:usuario/proyecto.git (push)
```

### Agregar Remote

```bash
# ¿Que hace?: Crea una nueva conexion remota
# ¿Por que?: Para conectar con otro repositorio
# ¿Para que sirve?: Push/pull a ese repo

# Sintaxis
git remote add <nombre> <url>

# Ejemplo: agregar upstream (repo original en fork workflow)
git remote add upstream https://github.com/original/proyecto.git

# Verificar
git remote -v
# origin    git@github.com:tu-usuario/proyecto.git (fetch)
# origin    git@github.com:tu-usuario/proyecto.git (push)
# upstream  https://github.com/original/proyecto.git (fetch)
# upstream  https://github.com/original/proyecto.git (push)
```

### Renombrar Remote

```bash
# ¿Que hace?: Cambia el nombre de un remote
# ¿Por que?: El nombre actual no es descriptivo
# ¿Para que sirve?: Mejor organizacion

git remote rename origin github
git remote rename upstream original
```

### Eliminar Remote

```bash
# ¿Que hace?: Elimina la conexion remota
# ¿Por que?: Ya no necesitas ese remote
# ¿Para que sirve?: Limpiar configuracion

git remote remove upstream
# o
git remote rm upstream
```

### Cambiar URL

```bash
# ¿Que hace?: Actualiza la URL de un remote
# ¿Por que?: Quieres cambiar de HTTPS a SSH
# ¿Para que sirve?: Usar diferente protocolo

# Cambiar de HTTPS a SSH
git remote set-url origin git@github.com:usuario/proyecto.git

# Cambiar de SSH a HTTPS
git remote set-url origin https://github.com/usuario/proyecto.git
```

---

## Ver Informacion de Remote

```bash
# ¿Que hace?: Muestra informacion detallada del remote
# ¿Por que?: Para ver branches remotos y configuracion
# ¿Para que sirve?: Diagnostico y verificacion

git remote show origin
```

**Salida tipica:**

```
* remote origin
  Fetch URL: git@github.com:usuario/proyecto.git
  Push  URL: git@github.com:usuario/proyecto.git
  HEAD branch: main
  Remote branches:
    develop        tracked
    feature-login  tracked
    main           tracked
  Local branches configured for 'git pull':
    main merges with remote main
  Local refs configured for 'git push':
    main pushes to main (up to date)
```

---

## Flujo Tipico: Empezar con Proyecto Existente

### Paso 1: Clonar

```bash
cd ~/proyectos
git clone git@github.com:empresa/aplicacion.git
cd aplicacion
```

### Paso 2: Verificar remotes

```bash
git remote -v
# origin  git@github.com:empresa/aplicacion.git (fetch)
# origin  git@github.com:empresa/aplicacion.git (push)
```

### Paso 3: Ver branches remotos

```bash
git branch -a
# * main
#   remotes/origin/HEAD -> origin/main
#   remotes/origin/develop
#   remotes/origin/main
```

### Paso 4: Trabajar

```bash
# Crear branch local desde remoto
git checkout -b feature/nueva-funcion

# Hacer cambios
vim archivo.js
git add .
git commit -m "feat: agregar nueva funcion"

# Subir al remoto
git push -u origin feature/nueva-funcion
```

---

## Flujo Tipico: Crear Proyecto Nuevo

### Paso 1: Crear en local

```bash
mkdir mi-proyecto
cd mi-proyecto
git init
echo "# Mi Proyecto" > README.md
git add .
git commit -m "Initial commit"
```

### Paso 2: Crear repo en GitHub (web)

Ir a github.com → New repository → `mi-proyecto`

### Paso 3: Conectar local con remote

```bash
git remote add origin git@github.com:tu-usuario/mi-proyecto.git
git push -u origin main
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
| `git remote remove <n>` | Eliminar remote |
| `git remote set-url <n> <url>` | Cambiar URL |
| `git remote show <n>` | Ver info de remote |

---

## Siguiente Leccion

En la siguiente leccion aprenderemos sobre `git push` para enviar cambios al repositorio remoto.

[Continuar con Leccion 03: Git Push](03-git-push.md)

---

*Week 05 - Leccion 02 | Bootcamp Git/GitHub*
