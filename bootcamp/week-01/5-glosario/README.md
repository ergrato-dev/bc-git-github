# 📖 Glosario - Week 01: Fundamentos de Git

Términos clave y definiciones de la semana 1 del bootcamp.

---

## 🔤 Índice Rápido

| Letra | Términos |
|-------|----------|
| **B** | [Branch](#branch) |
| **C** | [Commit](#commit), [Clone](#clone), [Checkout](#checkout) |
| **D** | [Distributed Version Control](#distributed-version-control) |
| **G** | [Git](#git), [GitHub](#github), [.gitignore](#gitignore) |
| **H** | [HEAD](#head), [Hash](#hash-sha-1) |
| **I** | [Init](#init) |
| **L** | [Local Repository](#local-repository), [Log](#log) |
| **R** | [Repository](#repository), [Remote](#remote) |
| **S** | [Staging Area](#staging-area), [Status](#status), [SHA-1](#hash-sha-1) |
| **V** | [Version Control](#version-control), [VCS](#vcs) |
| **W** | [Working Directory](#working-directory) |

---

## B

### Branch

**Definición**: Línea de desarrollo independiente que permite trabajar en features o correcciones sin afectar la rama principal.

```bash
# Crear un branch
git branch nombre-branch

# Cambiar a un branch
git checkout nombre-branch
```

**Relacionado**: [Checkout](#checkout), [HEAD](#head)

---

## C

### Commit

**Definición**: Instantánea (snapshot) de los cambios en un momento específico. Cada commit tiene un identificador único (hash) y un mensaje descriptivo.

```bash
# Crear un commit
git commit -m "feat: agregar función de login"
```

**Anatomía de un commit**:
- **Hash**: Identificador único (SHA-1)
- **Autor**: Quien hizo el commit
- **Fecha**: Cuándo se creó
- **Mensaje**: Descripción del cambio
- **Contenido**: Los archivos modificados

**Relacionado**: [Staging Area](#staging-area), [Hash](#hash-sha-1)

---

### Clone

**Definición**: Crear una copia completa de un repository remoto en tu máquina local, incluyendo todo el historial.

```bash
git clone https://github.com/usuario/repositorio.git
```

**Relacionado**: [Remote](#remote), [Repository](#repository)

---

### Checkout

**Definición**: Comando para cambiar entre branches o restaurar archivos del working directory.

```bash
# Cambiar de branch
git checkout main

# Crear y cambiar a nuevo branch
git checkout -b nueva-feature
```

**Nota**: En Git moderno, se prefiere `git switch` para cambiar branches.

**Relacionado**: [Branch](#branch), [HEAD](#head)

---

## D

### Distributed Version Control

**Definición**: Sistema de control de versiones donde cada usuario tiene una copia completa del repositorio y su historial. Git es el ejemplo más popular.

**Ventajas**:
- Trabajo offline
- Sin punto único de falla
- Operaciones locales rápidas
- Múltiples backups automáticos

**Contraste**: Sistemas centralizados (SVN, CVS) donde solo el servidor tiene el historial completo.

**Relacionado**: [VCS](#vcs), [Git](#git)

---

## G

### Git

**Definición**: Sistema de control de versiones distribuido, creado por Linus Torvalds en 2005 para el desarrollo del kernel de Linux.

**Características**:
- Distribuido (cada copia es completa)
- Rápido (operaciones locales)
- Integridad (checksums SHA-1)
- Open source y gratuito

**No confundir con**: [GitHub](#github) (plataforma de hosting)

---

### GitHub

**Definición**: Plataforma web para hosting de repositorios Git. Añade features de colaboración como Issues, Pull Requests, Actions, etc.

**Alternativas**: GitLab, Bitbucket, Azure DevOps

**Importante**: GitHub ≠ Git. GitHub es una plataforma; Git es la herramienta.

---

### .gitignore

**Definición**: Archivo que especifica qué archivos o carpetas Git debe ignorar (no trackear).

```text
# Ejemplo de .gitignore
node_modules/
*.log
.env
.DS_Store
```

**Ubicación**: Raíz del repository

**Relacionado**: [Repository](#repository), [Staging Area](#staging-area)

---

## H

### HEAD

**Definición**: Puntero que indica el commit actual en el que te encuentras. Normalmente apunta al último commit del branch activo.

```bash
# Ver a dónde apunta HEAD
git log -1

# HEAD~1 = commit anterior
# HEAD~2 = dos commits atrás
```

**Relacionado**: [Commit](#commit), [Branch](#branch)

---

### Hash (SHA-1)

**Definición**: Identificador único de 40 caracteres hexadecimales que Git genera para cada commit usando el algoritmo SHA-1.

```text
Ejemplo: a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0

# Usualmente se usa la versión corta (7 caracteres)
a1b2c3d
```

**Función**: Garantiza integridad y unicidad de cada commit.

**Relacionado**: [Commit](#commit)

---

## I

### Init

**Definición**: Comando para inicializar un nuevo repository Git en una carpeta existente.

```bash
# Inicializar repository
git init

# Resultado: crea carpeta oculta .git/
```

**Relacionado**: [Repository](#repository), [Working Directory](#working-directory)

---

## L

### Local Repository

**Definición**: El repository Git en tu máquina local, almacenado en la carpeta oculta `.git/`.

**Contiene**:
- Historial completo de commits
- Configuración del repository
- Referencias a branches
- Objetos Git (blobs, trees, commits)

**Relacionado**: [Remote](#remote), [Repository](#repository)

---

### Log

**Definición**: Comando para ver el historial de commits.

```bash
# Ver historial completo
git log

# Ver historial resumido
git log --oneline

# Ver historial con gráfico
git log --oneline --graph --all
```

**Relacionado**: [Commit](#commit), [Hash](#hash-sha-1)

---

## R

### Repository

**Definición**: Carpeta que contiene tu proyecto y todo su historial de cambios (almacenado en `.git/`).

**Tipos**:
- **Local**: En tu máquina
- **Remote**: En un servidor (GitHub, GitLab, etc.)
- **Bare**: Sin working directory (solo para servidores)

```bash
# Crear repository
git init

# Clonar repository existente
git clone <url>
```

**Relacionado**: [Init](#init), [Clone](#clone)

---

### Remote

**Definición**: Referencia a un repository en otro lugar (normalmente un servidor como GitHub).

```bash
# Ver remotes configurados
git remote -v

# Agregar remote
git remote add origin https://github.com/usuario/repo.git
```

**Nombre común**: `origin` (el remote principal)

**Relacionado**: [Clone](#clone), [Repository](#repository)

---

## S

### Staging Area

**Definición**: Área intermedia entre el working directory y el repository. Aquí preparas los cambios que irán en el próximo commit.

```bash
# Agregar archivo al staging
git add archivo.txt

# Agregar todos los cambios
git add .

# Ver qué hay en staging
git status
```

**También conocido como**: Index, Cache

**Relacionado**: [Commit](#commit), [Working Directory](#working-directory)

---

### Status

**Definición**: Comando para ver el estado actual del working directory y staging area.

```bash
git status

# Versión corta
git status -s
```

**Muestra**:
- Archivos modificados
- Archivos en staging
- Archivos sin trackear
- Branch actual

**Relacionado**: [Staging Area](#staging-area), [Working Directory](#working-directory)

---

## V

### Version Control

**Definición**: Sistema que registra cambios en archivos a lo largo del tiempo, permitiendo recuperar versiones específicas.

**Beneficios**:
- Historial completo de cambios
- Colaboración en equipo
- Reversibilidad (deshacer cambios)
- Trazabilidad (quién, qué, cuándo)

**Relacionado**: [VCS](#vcs), [Git](#git)

---

### VCS

**Definición**: Version Control System. Acrónimo para Sistema de Control de Versiones.

**Tipos**:
- **Local**: RCS (obsoleto)
- **Centralizado**: SVN, CVS
- **Distribuido**: Git, Mercurial

**Relacionado**: [Version Control](#version-control), [Distributed Version Control](#distributed-version-control)

---

## W

### Working Directory

**Definición**: Tu carpeta de trabajo actual donde editas archivos. Es una versión específica del proyecto extraída del repository.

**Estados de archivos**:
1. **Untracked**: Git no los conoce
2. **Unmodified**: Sin cambios desde el último commit
3. **Modified**: Cambiados pero no en staging
4. **Staged**: Listos para el próximo commit

**Relacionado**: [Staging Area](#staging-area), [Repository](#repository)

---

## 📊 Diagrama de Conceptos

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUJO BÁSICO DE GIT                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   Working Directory    Staging Area    Local Repository    │
│   ─────────────────    ────────────    ─────────────────   │
│                                                             │
│        edit           git add          git commit           │
│         │───────────────►│──────────────────►│             │
│         │                │                   │             │
│         │◄───────────────│◄──────────────────│             │
│                      git restore       git checkout        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔗 Navegación

| ⬅️ Recursos | 🏠 Week 01 | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [4-recursos](../4-recursos/) | [README](../README.md) | [Week 02](../../week-02/README.md) |

---

_Glosario Week 01 | Bootcamp Git/GitHub_
