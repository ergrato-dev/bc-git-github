# ⚡ Git Aliases — Atajos de Terminal

Guía paso a paso para crear, gestionar y aprovechar alias de Git. Ahorra tiempo y reduce errores al escribir comandos largos.

---

## 📋 Objetivo

Al finalizar esta guía sabrás:

- ✅ Qué es un alias de Git y por qué usarlo
- ✅ Crear tus propios alias paso a paso
- ✅ Conocer los alias más útiles para el día a día
- ✅ Gestionar tus alias: listar, editar y eliminar
- ✅ Configurar un `.gitconfig` portátil y reutilizable

---

## 🤔 ¿Qué es un Alias?

Un **alias** es un atajo o abreviatura que creas para un comando de Git. En lugar de escribir comandos largos una y otra vez, defines un nombre corto que los reemplaza.

**Sin alias**:

```bash
git log --oneline --graph --decorate --all
```

**Con alias**:

```bash
git lg
```

El resultado es idéntico. El alias solo te ahorra teclear 42 caracteres cada vez.

---

## 🛠️ Cómo Crear un Alias — Paso a Paso

### Nivel 1: Alias Simple (reemplazo directo)

Un alias que reemplaza un comando por su versión corta.

```bash
# Paso 1: Define el alias
git config --global alias.co checkout

# Paso 2: Úsalo
git co main
# Equivale a: git checkout main
```

📌 **Explicación**:

- `--global`: el alias queda disponible en todos tus repositorios
- `alias.co`: defines que el alias se llamará `co`
- `checkout`: el comando real que ejecutará

### Nivel 2: Alias con Argumentos (usa `!`)

Cuando el alias necesita ejecutar lógica más compleja o comandos del sistema.

```bash
# Alias que combina varios comandos git
git config --global alias.undo "reset --soft HEAD~1"

# Alias que ejecuta un comando de shell
git config --global alias.ls "!git ls-files | less"

# Alias que ignora archivos locales (útil para .env, config personales)
git config --global alias.ignore-local "!git update-index --skip-worktree"
```

📌 **Explicación**:

- Sin `!`: Git interpreta el texto como subcomando de Git
- Con `!`: Git lo pasa a la shell (bash) para que lo ejecute

### Nivel 3: Alias con Funciones de Shell

Para alias que necesitan lógica condicional, pipes o múltiples pasos.

```bash
git config --global alias.cleanup "!f() { git branch --merged | grep -v '\\*\\|main\\|develop' | xargs -r git branch -d; }; f"

git config --global alias.standup "!f() { git log --since='1 day ago' --author=\"$(git config user.name)\" --oneline; }; f"
```

⚠️ **Precaución**: Estos alias son avanzados. Asegúrate de entender qué hace cada parte antes de usarlos.

---

## 📋 Lista de Chequeo: Crear un Alias

Antes de definir un alias, verifica:

- [ ] El nombre del alias no colisiona con un comando real de Git (`git st` ya que `st` no es comando real)
- [ ] El nombre es corto pero descriptivo (2-4 letras suele ser ideal)
- [ ] Probé el comando original primero para confirmar que funciona
- [ ] Entiendo qué hace cada parte del alias (especialmente si usa `!` o pipes)
- [ ] No estoy sobrescribiendo un alias que ya existe (`git config --global --list | grep alias`)

---

## 📦 Los Alias Más Útiles

### 🏃 Movimiento entre Ramas

```bash
# Checkout abreviado
git config --global alias.co checkout

# Crear y moverse a nueva branch
git config --global alias.cob "checkout -b"

# Volver a la rama anterior
git config --global alias.back "checkout -"

# Listar branches locales con último commit
git config --global alias.br "branch -v"
```

### 📝 Commits

```bash
# Commit con mensaje
git config --global alias.ci "commit -m"

# Commit de todo lo modificado (add + commit)
git config --global alias.ca "commit -a -m"

# Enmendar el último commit (añadir cambios olvidados)
git config --global alias.amend "commit --amend --no-edit"

# Enmendar el último commit y editar mensaje
git config --global alias.amed "commit --amend"
```

### 📊 Estado e Historial

```bash
# Estado compacto
git config --global alias.st "status -sb"

# Log de una línea por commit
git config --global alias.ll "log --oneline"

# Log con gráfico, todas las ramas, compacto
git config --global alias.lg "log --oneline --graph --decorate --all"

# Log con gráfico más detallado (fechas relativas)
git config --global alias.lg2 "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"

# Log del día actual (para daily standup)
git config --global alias.today "log --since='1 day ago' --oneline --author=\"$(git config user.name)\""

# Ver último commit con diff incluido
git config --global alias.last "log -1 HEAD --stat"

# Buscar en el historial de commits
git config --global alias.search "log --all --oneline --grep"

# Ver qué cambió en cada archivo (más legible que diff)
git config --global alias.changes "diff --name-status"
```

### 🔀 Merge y Rebase

```bash
# Merge abreviado
git config --global alias.mg "merge --no-ff"

# Abortar merge en curso
git config --global alias.abort "merge --abort"

# Rebase interactivo sobre main
git config --global alias.ri "rebase -i"

# Rebase interactivo desde el punto donde la branch divergió
git config --global alias.rc "rebase -i --onto main main"
```

### 🗑️ Deshacer y Limpiar

```bash
# Deshacer último commit (mantener cambios en staging)
git config --global alias.undo "reset --soft HEAD~1"

# Deshacer último commit (descartar cambios completamente)
git config --global alias.undo-hard "reset --hard HEAD~1"

# Deshacer cambios en un archivo (volver a última versión commiteada)
git config --global alias.unstage "reset HEAD --"

# Quitar archivo del staging
git config --global alias.discard "checkout --"

# Eliminar branches locales ya mergeadas
git config --global alias.cleanup "!f() { git branch --merged | grep -v '\\*\\|main\\|develop\\|master' | xargs -r git branch -d; }; f"
```

### 🌐 Remotos

```bash
# Push al origen en la rama actual
git config --global alias.ps "push origin HEAD"

# Push forzado con seguridad
git config --global alias.psf "push --force-with-lease origin HEAD"

# Pull con rebase (historial más limpio)
git config --global alias.pl "pull --rebase"

# Fetch de todos los remotos
git config --global alias.ft "fetch --all --prune"

# Ver URL del remoto
git config --global alias.rv "remote -v"
```

### 🎨 Estética y Utilidad

```bash
# Commit bonito con emoji automático según tipo de cambio
git config --global alias.smile "!f() { git commit -m \"$1 $(curl -s https://gitmoji.dev/api/gitmojis | grep -oP '(?<=\"emoji\":\")[^\"]*' | shuf -n1)\"; }; f"

# Ver los alias que tienes configurados
git config --global alias.aliases "!git config --get-regexp ^alias\\. | sed 's/alias\\.\\([^ ]*\\) \\(.*\\)/\\1 => \\2/' | sort"

# Ver contribuidores del repositorio ordenados por commits
git config --global alias.authors "shortlog -sn --all --no-merges"

# Guardar trabajo rápidamente (WIP — Work In Progress)
git config --global alias.wip "!git add -A && git commit -m 'wip: guardar progreso'"

# Restaurar último WIP y deshacer ese commit
git config --global alias.unwip "reset HEAD~1"
```

---

## 📦 Instalación Rápida — Copia y Pega

Ejecuta este bloque completo en tu terminal. Crea los alias más esenciales de una sola vez.

```bash
# Movimiento
git config --global alias.co checkout
git config --global alias.cob "checkout -b"
git config --global alias.br "branch -v"
git config --global alias.back "checkout -"

# Commits
git config --global alias.ci "commit -m"
git config --global alias.ca "commit -a -m"
git config --global alias.amend "commit --amend --no-edit"

# Estado e historial
git config --global alias.st "status -sb"
git config --global alias.ll "log --oneline"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.last "log -1 HEAD --stat"

# Deshacer
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.unstage "reset HEAD --"

# Remotos
git config --global alias.ps "push origin HEAD"
git config --global alias.pl "pull --rebase"

# Utilidad
git config --global alias.aliases "!git config --get-regexp ^alias\\. | sed 's/alias\\.\\([^ ]*\\) \\(.*\\)/\\1 => \\2/' | sort"

echo "✅ Alias instalados. Usa 'git aliases' para verlos todos."
```

---

## 🔍 Cómo Gestionar tus Alias

### Listar todos los alias configurados

```bash
# Ver todos los alias (si instalaste el alias 'aliases')
git aliases

# Alternativa sin alias
git config --global --get-regexp ^alias\.
```

### Ver qué hace un alias específico

```bash
# Ver definición del alias 'lg'
git config --global alias.lg
# Salida: log --oneline --graph --decorate --all
```

### Editar un alias existente

```bash
# Sobrescribir con nuevo valor
git config --global alias.co "checkout --guess"
```

### Eliminar un alias

```bash
# Eliminar alias 'co'
git config --global --unset alias.co
```

### Ver el archivo de configuración completo

```bash
# Abre ~/.gitconfig en tu editor
git config --global --edit
```

Dentro del archivo verás una sección `[alias]`:

```ini
[alias]
    co = checkout
    ci = commit -m
    lg = log --oneline --graph --decorate --all
    st = status -sb
```

Puedes editar este archivo directamente con cualquier editor de texto.

---

## 🧠 Alias de Shell (Bonus)

Además de los alias de Git, puedes crear alias en tu shell (bash/zsh) para comandos que combinan git con otras herramientas. Estos se definen en `~/.bashrc` o `~/.zshrc`.

```bash
# Añade estas líneas a tu ~/.bashrc o ~/.zshrc

# Git status rápido
alias gs='git status -sb'

# Git add + commit + push
gacp() {
    git add -A
    git commit -m "$1"
    git push origin HEAD
}
# Uso: gacp "feat: añadir formulario de login"

# Crear branch y moverse a ella
gcb() {
    git checkout -b "$1"
}
# Uso: gcb feat/nueva-funcionalidad

# Abrir el repositorio actual en GitHub
gh-open() {
    local url=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
    xdg-open "$url" 2>/dev/null || open "$url" 2>/dev/null
}
```

⚠️ **Cuándo usar cada uno**:

| Tipo de alias | Definido en | Mejor para |
|---|---|---|
| Git alias | `~/.gitconfig` | Comandos que solo involucran `git` |
| Shell alias | `~/.bashrc` / `~/.zshrc` | Combinar git con comandos del sistema |

---

## 🔄 Portabilidad: Lleva tus Alias a Cualquier Máquina

El archivo `~/.gitconfig` contiene todos tus alias. Puedes respaldarlo y reutilizarlo.

### Opción 1: Copia manual

```bash
# Respaldar
cp ~/.gitconfig ~/backup-gitconfig-$(date +%Y%m%d)

# Restaurar en otra máquina
cp ~/backup-gitconfig-20240101 ~/.gitconfig
```

### Opción 2: Gist o dotfiles (recomendado para equipos)

```bash
# 1. Extrae solo la sección de alias
git config --global --get-regexp ^alias\. > mis-alias.txt

# 2. En la nueva máquina, aplica los alias
while IFS=' ' read -r key value; do
    alias_name="${key#alias.}"
    git config --global "alias.$alias_name" "$value"
done < mis-alias.txt
```

### Opción 3: Dotfiles con Git (avanzado)

Muchos desarrolladores mantienen sus archivos de configuración en un repositorio Git público. Es una excelente práctica para equipos que quieren compartir convenciones.

---

## ⚠️ Errores Comunes

### 1. Sobrescribir un Comando Real de Git

**❌ Error**: `git config --global alias.st status` (ok, `st` no es comando nativo)

**✅ Regla**: Antes de crear un alias, verifica que el nombre no sea un comando real:

```bash
git help -a | grep "^   tu-alias"
```

### 2. Comillas Mal Escapadas en Alias con `!`

**❌ Error**:

```bash
git config --global alias.cleanup "!git branch --merged | grep -v main | xargs git branch -d"
```

**✅ Corregir**: Las comillas dentro del alias deben escaparse correctamente:

```bash
git config --global alias.cleanup "!f() { git branch --merged | grep -v '\\*\\|main\\|develop' | xargs -r git branch -d; }; f"
```

### 3. Crear Alias Sin Probar el Comando Original

**❌ Error**: Creas un alias complejo que crees que funciona, pero el comando original ya fallaba.

**✅ Solución**: Siempre prueba el comando completo primero, luego conviértelo en alias.

### 4. No Usar `--global` y Perder Alias Entre Repositorios

**❌ Error**: `git config alias.co checkout` (sin `--global`). El alias solo existe en ese repositorio.

**✅ Solución**: Usa `--global` a menos que quieras un alias específico para un solo proyecto.

---

## 🎯 Kit de Inicio: Los 7 Alias Esenciales

Si solo quieres crear 7 alias, empieza con estos. Cubren el 80% del uso diario.

```bash
git config --global alias.co checkout
git config --global alias.ci "commit -m"
git config --global alias.st "status -sb"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.br "branch -v"
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.ps "push origin HEAD"
```

| Alias | Reemplaza a | Te ahorra |
|---|---|---|
| `git co` | `git checkout` | 7 caracteres |
| `git ci "msg"` | `git commit -m "msg"` | 5 caracteres |
| `git st` | `git status -sb` | 11 caracteres |
| `git lg` | `git log --oneline --graph --decorate --all` | 36 caracteres |
| `git br` | `git branch -v` | 9 caracteres |
| `git undo` | `git reset --soft HEAD~1` | 20 caracteres |
| `git ps` | `git push origin HEAD` | 16 caracteres |

---

## 🔗 Referencias

- [Git Basics - Git Aliases (Documentación Oficial)](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases)
- [Git Configuration — git-config](https://git-scm.com/docs/git-config)
- [Oh My Zsh — Git Aliases Plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
- [GitHub Dotfiles Guide](https://dotfiles.github.io/)

---

⚡ **Recuerda**: Si escribes un comando más de 3 veces al día, conviértelo en alias. Tus dedos te lo agradecerán.
