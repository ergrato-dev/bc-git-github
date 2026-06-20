# 🔧 Configuración de Git — Personal y Equipos Compartidos

Guía paso a paso para configurar Git correctamente en entornos personales y en máquinas compartidas (aulas, laboratorios, entornos de formación).

---

## 📋 Objetivo

Al finalizar esta guía sabrás:

- ✅ Configurar Git desde cero en tu máquina personal
- ✅ Configurar Git en máquinas compartidas sin mezclar identidades
- ✅ Entender los 3 niveles de configuración (`local`, `global`, `system`)
- ✅ Aplicar configuraciones recomendadas para mejorar tu flujo de trabajo
- ✅ Evitar que credenciales y datos personales queden expuestos en entornos compartidos

---

## 🧠 Los 3 Niveles de Configuración

Git tiene 3 niveles jerárquicos. Cada nivel sobrescribe al anterior.

```
system          /etc/gitconfig          → Toda la máquina, todos los usuarios
    ↓
global          ~/.gitconfig            → Solo tu usuario
    ↓
local           .git/config             → Solo este repositorio
```

| Nivel | Comando | Alcance | Archivo |
|---|---|---|---|
| Sistema | `git config --system` | Todos los usuarios del equipo | `/etc/gitconfig` |
| Usuario | `git config --global` | Solo tu cuenta de usuario | `~/.gitconfig` |
| Repositorio | `git config --local` | Solo el repo actual (por defecto) | `.git/config` |

📌 **Regla**: lo más específico gana. Un valor en `local` pisa al de `global`, y `global` pisa a `system`.

### Ver la Configuración Actual

```bash
# Ver toda la configuración que aplica en este repo (resuelta)
git config --list --show-origin

# Ver solo la configuración global
git config --global --list

# Ver solo la configuración del repositorio actual
git config --local --list

# Ver un valor concreto (ej: nombre de usuario)
git config user.name
```

---

## 👤 Configuración para Uso Personal

Cuando usas tu propia máquina y eres el único usuario.

### Paso 1: Identidad

```bash
# Identidad obligatoria — sin esto Git no te deja hacer commits
git config --global user.name "María García"
git config --global user.email "maria@example.com"

# Opcional: firma GPG para commits verificados (recomendado para profesionales)
git config --global user.signingkey "TU_ID_GPG"
git config --global commit.gpgsign true
```

### Paso 2: Editor Predeterminado

```bash
# VS Code
git config --global core.editor "code --wait"

# Vim
git config --global core.editor "vim"

# Nano
git config --global core.editor "nano"

# Sublime Text
git config --global core.editor "subl -w"
```

### Paso 3: Comportamiento de Saltos de Línea

```bash
# Linux / macOS
git config --global core.autocrlf input

# Windows
git config --global core.autocrlf true
```

### Paso 4: Rama Inicial

```bash
# Desde Git 2.28+, configura main como rama por defecto
git config --global init.defaultBranch main
```

### Paso 5: Colores y Legibilidad

```bash
# Activar colores en la salida de Git
git config --global color.ui auto

# Colores específicos para diff y status
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
```

### Paso 6: Push más Seguro

```bash
# Solo hacer push de la rama actual (evita pushear todas por error)
git config --global push.default simple

# Evitar push accidental sin rama remota configurada
git config --global push.autoSetupRemote true
```

### Paso 7: Pull con Rebase (Historial más Limpio)

```bash
# Evita commits de merge innecesarios al hacer pull
git config --global pull.rebase true

# Configurar estrategia de fast-forward por defecto
git config --global pull.ff only
```

### Paso 8: Credenciales

```bash
# Almacenar credenciales en caché (Linux/macOS)
git config --global credential.helper cache

# Almacenar credenciales en disco (más cómodo, menos seguro)
git config --global credential.helper store

# En macOS también puedes usar el llavero del sistema
git config --global credential.helper osxkeychain

# En Windows usar el administrador de credenciales
git config --global credential.helper manager
```

⚠️ **Precaución con `store`**: guarda la contraseña en texto plano en `~/.git-credentials`. Evítalo en máquinas compartidas.

### Paso 9: Manejo de Conflictos

```bash
# Herramienta de merge visual
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd "code --wait --merge $REMOTE $LOCAL $BASE $MERGED"

# Mostrar diff en 3 columnas en conflictos
git config --global merge.conflictstyle diff3
```

### Paso 10: Alias Esenciales

```bash
# Incluye al menos estos 5
git config --global alias.co checkout
git config --global alias.ci "commit -m"
git config --global alias.st "status -sb"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.br "branch -v"

# Ver todos tus alias
git config --global alias.aliases "!git config --get-regexp ^alias\\. | sed 's/alias\\.\\([^ ]*\\) \\(.*\\)/\\1 => \\2/' | sort"
```

### Resultado Final: `~/.gitconfig`

Después de aplicar los pasos, tu archivo se ve así:

```ini
[user]
    name = María García
    email = maria@example.com
    signingkey = TU_ID_GPG

[core]
    editor = code --wait
    autocrlf = input

[init]
    defaultBranch = main

[color]
    ui = auto

[push]
    default = simple
    autoSetupRemote = true

[pull]
    rebase = true
    ff = only

[commit]
    gpgsign = true

[merge]
    conflictstyle = diff3

[alias]
    co = checkout
    ci = commit -m
    st = status -sb
    lg = log --oneline --graph --decorate --all
    br = branch -v
    aliases = !git config --get-regexp ^alias\\. | sed 's/alias\\.\\([^ ]*\\) \\(.*\\)/\\1 => \\2/' | sort
```

---

## ✅ Lista de Chequeo: Configuración Personal

- [ ] `user.name` configurado con nombre real
- [ ] `user.email` configurado con email real (el mismo de GitHub/GitLab)
- [ ] `core.editor` configurado con tu editor preferido
- [ ] `core.autocrlf` configurado según tu sistema operativo
- [ ] `init.defaultBranch` configurado como `main`
- [ ] `pull.rebase` configurado (evita merge commits innecesarios)
- [ ] `push.default` configurado como `simple`
- [ ] Al menos 5 alias esenciales creados
- [ ] Credenciales configuradas (cache, store o keychain)
- [ ] Verifiqué la configuración con `git config --list`
- [ ] Hice mi primer commit de prueba en un repo temporal

---

## 👥 Configuración en Equipos Compartidos

En aulas, laboratorios, entornos de formación o máquinas de uso común, el riesgo principal es que **tu identidad y credenciales queden expuestas a otros usuarios**.

### Principios para Ambientes Compartidos

| Principio | Explicación |
|---|---|
| **No usar `--global`** | La configuración global queda para el usuario del sistema. Si comparten cuenta de OS, usa `--local` |
| **Credenciales nunca en disco** | Evita `credential.helper store`. Prefiere `cache` con timeout corto o token por sesión |
| **Identidad por repositorio** | Cada persona configura su `user.name` y `user.email` a nivel `--local` en su propio repo clonado |
| **Limpiar al terminar** | Cerrar sesión, borrar tokens, limpiar credenciales cacheadas |
| **No guardar contraseñas** | Usa tokens de acceso personal (PAT) con alcance limitado y fecha de expiración |

---

### Escenario 1: Cada Usuario Tiene su Propia Cuenta de OS

Si cada alumno o usuario inicia sesión con su propio usuario del sistema operativo, la configuración `--global` es segura. Cada persona tiene su propio `~/.gitconfig` aislado.

```bash
# Cada alumno ejecuta esto en su sesión
git config --global user.name "Nombre del Alumno"
git config --global user.email "alumno@bootcamp.com"
git config --global init.defaultBranch main
git config --global pull.rebase true
```

✅ **Ventaja**: Configuración global limpia y persistente para cada persona.

---

### Escenario 2: Cuenta de OS Compartida (Varios Usuarios, Misma Sesión)

Caso típico en aulas con una cuenta genérica (`alumno`, `lab`, `formacion`). Varias personas usan la misma cuenta de sistema operativo.

#### ⚠️ Peligros

- Un alumno hace commit y queda con el `user.name` del anterior
- Las credenciales de GitHub quedan cacheadas y accesibles para el siguiente
- Si alguien configuró `credential.helper store`, las contraseñas quedan en texto plano

#### ✅ Protocolo: Configuración por Sesión

Cada persona debe seguir este ritual al iniciar y al terminar su sesión.

##### Al Iniciar la Sesión

```bash
# Paso 1: Verificar identidad actual
git config user.name
git config user.email
# Si salen datos de otra persona, ¡corregir antes de hacer nada!

# Paso 2: Configurar identidad SOLO en el repositorio que voy a usar
cd mi-repositorio
git config user.name "María García"
git config user.email "maria@bootcamp.com"

# Paso 3: Configurar credenciales solo en caché, con timeout corto
git config --global credential.helper "cache --timeout=3600"

# Paso 4: Verificar que no haya credenciales almacenadas en disco
cat ~/.git-credentials 2>/dev/null && echo "⚠️ HAY CREDENCIALES GUARDADAS" || echo "✅ Limpio"
```

💡 **Tip para instructores**: Creen un script `iniciar-sesion-git.sh` que los alumnos ejecuten al empezar:

```bash
#!/bin/bash
# iniciar-sesion-git.sh — Ejecutar al inicio de cada sesión

echo "=== Configuración de Git para sesión compartida ==="
echo ""

# Limpiar credenciales previas
git credential-cache exit 2>/dev/null
echo "✅ Caché de credenciales limpiada"

# Solicitar datos al alumno
read -p "Nombre completo: " NOMBRE
read -p "Email: " EMAIL

# Configurar identidad global (solo nombre y email)
git config --global user.name "$NOMBRE"
git config --global user.email "$EMAIL"

# Credenciales con timeout de 2 horas
git config --global credential.helper "cache --timeout=7200"

echo ""
echo "✅ Listo. Tu identidad para esta sesión:"
echo "   Nombre: $(git config user.name)"
echo "   Email:  $(git config user.email)"
echo ""
echo "⚠️  Recuerda ejecutar 'cerrar-sesion-git.sh' al terminar."
```

##### Al Terminar la Sesión

```bash
# Paso 1: Borrar credenciales en caché
git credential-cache exit

# Paso 2: Borrar identidad global (opcional, según política del aula)
git config --global --unset user.name
git config --global --unset user.email

# Paso 3: Verificar que no quedó nada
git config --global --list

# Paso 4: Cerrar sesión del sistema operativo
```

Script `cerrar-sesion-git.sh`:

```bash
#!/bin/bash
# cerrar-sesion-git.sh — Ejecutar al finalizar cada sesión

echo "=== Cerrando sesión Git ==="

# Limpiar credenciales
git credential-cache exit
echo "✅ Credenciales eliminadas"

# Limpiar identidad global
git config --global --unset user.name 2>/dev/null
git config --global --unset user.email 2>/dev/null
echo "✅ Identidad global eliminada"

echo "✅ Sesión cerrada. Tus datos ya no están en esta máquina."
```

---

### Escenario 3: Usar `.gitconfig` por Proyecto (Máximo Aislamiento)

Alternativa más segura aún: no usar `--global` en absoluto. Cada persona configura su identidad a nivel `--local` dentro de su propio repositorio.

```bash
# Paso 1: Clonar el repositorio
git clone https://github.com/bootcamp/ejercicios.git
cd ejercicios

# Paso 2: Configurar identidad SOLO en este repositorio
git config user.name "María García"
git config user.email "maria@bootcamp.com"

# Paso 3: Verificar que la configuración es local
git config --local --list | grep user
# Salida:
# user.name=María García
# user.email=maria@bootcamp.com

# Paso 4: Verificar que no hay configuración global que interfiera
git config --global user.name    # Debería estar vacío o ser genérico
```

✅ **Ventaja**: Imposible que un alumno use accidentalmente la identidad de otro.

❌ **Desventaja**: Hay que repetir la configuración en cada repositorio clonado.

---

## ✅ Lista de Chequeo: Máquinas Compartidas

### Antes de Empezar la Sesión

- [ ] Verifiqué que no hay credenciales almacenadas en `~/.git-credentials`
- [ ] Ejecuté `git credential-cache exit` para limpiar caché previa
- [ ] Verifiqué `git config user.name` — si muestra otro nombre, lo corrijo
- [ ] Configuré mi identidad (`user.name` y `user.email`) en mi repositorio (`--local`)
- [ ] Configuré `credential.helper cache --timeout=3600` (no `store`)
- [ ] Entendí que los PAT (Personal Access Tokens) deben tener fecha de expiración

### Durante la Sesión

- [ ] Hago commits con mi identidad, verificando ocasionalmente `git config user.name`
- [ ] No guardo contraseñas en el navegador de la máquina compartida
- [ ] Si GitHub me pide token, uso uno con alcance mínimo y expiración corta
- [ ] No dejo la sesión del sistema operativo abierta al alejarme

### Antes de Terminar la Sesión

- [ ] Ejecuté `git credential-cache exit`
- [ ] Borré mis datos de identidad global si usé `--global` para ellos
- [ ] Verifiqué con `git config --global --list` que no quedaron datos
- [ ] Cerré sesión en GitHub en el navegador
- [ ] Cerré sesión del sistema operativo

---

## 🛡️ Tokens de Acceso Personal (PAT)

En entornos compartidos **nunca uses tu contraseña de GitHub** para autenticarte. Usa tokens.

### Cómo Crear un Token para Clases

1. Ve a **GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)**
2. Clic en **Generate new token (classic)**
3. Configura:
   - **Note**: `Bootcamp - Máquina Compartida`
   - **Expiration**: `7 días` (o la duración del módulo)
   - **Scopes**: solo `repo` si necesitás push/pull, o `public_repo` si solo repos públicos
4. Copia el token generado (solo se muestra una vez)
5. Usalo como contraseña cuando Git te la pida

```bash
# Cuando Git pida password, pega el token (no tu contraseña real)
Username for 'https://github.com': tu-usuario
Password for 'https://github.com': ghp_xxxxxxxxxxxxxxxxxxxx
```

⚠️ Si el token expira o se compromete, revócalo desde la misma página de GitHub.

---

## 📦 Configuración por Tipo de Proyecto

Algunas configuraciones útiles a nivel `--local` según el proyecto.

### Proyecto con Windows y Linux en el Equipo

```bash
# En el repositorio, forzar saltos de línea LF para consistencia
git config core.autocrlf false
# Usar .gitattributes en su lugar (más confiable)
echo "* text=auto" > .gitattributes
git add .gitattributes
git commit -m "chore: normalizar saltos de línea con .gitattributes"
```

### Proyecto con Archivos Grandes (imágenes, binarios)

```bash
git config core.compression 0
git config core.looseCompression 0
```

### Proyecto con Submódulos

```bash
git config submodule.recurse true
git config fetch.recurseSubmodules on-demand
```

### Convenciones del Equipo en `.gitconfig` del Repositorio

Los instructores pueden incluir configuraciones recomendadas usando `git config` en scripts de setup. No se puede forzar desde el repositorio (`.git/config` no se versiona), pero sí se puede documentar:

```bash
# Script de setup que ejecuta cada alumno al clonar
git config user.name ""      # Lo completa el alumno
git config user.email ""     # Lo completa el alumno
git config pull.rebase true
git config push.default simple
git config core.autocrlf input
```

---

## 🔍 Diagnóstico Rápido

### "¿Quién soy según Git?"

```bash
# Una sola línea que muestra toda la identidad configurada
echo "Nombre: $(git config user.name)" && echo "Email: $(git config user.email)" && echo "Origen nombre: $(git config --show-origin user.name | head -1)" && echo "Origen email: $(git config --show-origin user.email | head -1)"
```

### "¿Qué credenciales están guardadas en esta máquina?"

```bash
# Verificar si hay helper store activo
git config --global credential.helper

# Ver si existe archivo de credenciales
ls -la ~/.git-credentials 2>/dev/null && echo "⚠️ ¡Hay credenciales en disco!" || echo "✅ No hay credenciales almacenadas"
```

### "¿Por qué mi commit salió con otro nombre?"

```bash
# Ver historial de los últimos 5 commits con autor
git log --format="%h %an <%ae> — %s" -5

# Si el autor es incorrecto, corregir identidad ANTES del próximo commit
git config user.name "Mi Nombre Correcto"
git config user.email "mi-email-correcto@example.com"
```

---

## 🔗 Referencias

- [Git Configuration — Documentación Oficial](https://git-scm.com/docs/git-config)
- [First-Time Git Setup](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)
- [Managing Personal Access Tokens — GitHub Docs](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
- [Git Credential Storage](https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage)

---

🔧 **Recuerda**: En tu máquina personal, configura una vez y olvídate. En máquinas compartidas, configura cada sesión y limpia al terminar. Tu identidad y seguridad son tu responsabilidad.
