# 📜 Lección 03: Navegando el Historial

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- [ ] Usar `git log` con diferentes formatos y filtros
- [ ] Inspeccionar commits específicos con `git show`
- [ ] Comparar versiones con `git diff`
- [ ] Entender las referencias en Git (HEAD, ~, ^)
- [ ] Buscar en el historial de forma eficiente

---

## 📚 Conceptos Teóricos

### El Historial en Git

El historial de Git es una **cadena de commits** donde cada uno apunta a su padre (commit anterior). Esta estructura te permite:

- Ver qué cambios se hicieron y cuándo
- Identificar quién hizo cada cambio
- Volver a estados anteriores
- Encontrar cuándo se introdujo un bug

### Referencias en Git

| Referencia | Significado | Ejemplo |
|------------|-------------|---------|
| `HEAD` | Commit actual (donde estás) | `git show HEAD` |
| `HEAD~1` | Un commit atrás | `git show HEAD~1` |
| `HEAD~2` | Dos commits atrás | `git diff HEAD~2..HEAD` |
| `main` | Último commit de branch main | `git log main` |
| `abc123` | Commit específico por SHA | `git show abc123` |

> 💡 **Tip**: Puedes usar los primeros 7 caracteres del SHA en lugar del hash completo.

---

## ⌨️ Comandos Principales

### 1. `git log` - Ver el historial

![Git Log Visualizado](../0-assets/04-git-log-visualizado.svg)

```bash
# ¿Qué hace?: Muestra el historial de commits
# ¿Por qué?: Para ver qué se ha hecho en el proyecto
# ¿Para qué sirve?: Navegar, auditar y entender la evolución del código

# Log básico (muestra todo)
git log

# Log en una línea por commit
git log --oneline

# Log con gráfico de branches
git log --oneline --graph

# Log con gráfico de todas las branches
git log --oneline --graph --all

# Log decorado (muestra branches y tags)
git log --oneline --decorate
```

### 2. `git log` - Filtros útiles

```bash
# ¿Qué hace?: Filtra el historial por diferentes criterios
# ¿Por qué?: Para encontrar commits específicos rápidamente
# ¿Para qué sirve?: Buscar cambios, auditar, debugging

# Limitar cantidad de commits
git log -n 5
git log -5                    # Forma corta

# Por autor
git log --author="Juan"
git log --author="juan@email.com"

# Por fecha
git log --since="2024-01-01"
git log --until="2024-12-31"
git log --since="1 week ago"
git log --since="yesterday"

# Por mensaje
git log --grep="feat"
git log --grep="login"

# Por archivo
git log -- archivo.txt
git log --follow archivo.txt  # Sigue renombres

# Combinar filtros
git log --author="Juan" --since="1 week ago" --oneline
```

### 3. `git log` - Formatos personalizados

```bash
# ¿Qué hace?: Personaliza el output de git log
# ¿Por qué?: Para ver exactamente la información que necesitas
# ¿Para qué sirve?: Reportes, scripts, preferencias personales

# Formato pretty predefinidos
git log --pretty=oneline
git log --pretty=short
git log --pretty=full
git log --pretty=fuller

# Formato personalizado
git log --pretty=format:"%h %s"
git log --pretty=format:"%h - %an, %ar : %s"
git log --pretty=format:"%C(yellow)%h%C(reset) %s %C(blue)(%an)%C(reset)"
```

**Placeholders comunes:**

| Placeholder | Significado |
|-------------|-------------|
| `%H` | Hash completo |
| `%h` | Hash corto |
| `%an` | Nombre del autor |
| `%ae` | Email del autor |
| `%ar` | Fecha relativa (ej: "2 days ago") |
| `%ad` | Fecha absoluta |
| `%s` | Subject (primera línea del mensaje) |
| `%b` | Body del mensaje |
| `%C(color)` | Cambiar color |
| `%C(reset)` | Resetear color |

### 4. `git show` - Inspeccionar un commit

```bash
# ¿Qué hace?: Muestra los detalles de un commit específico
# ¿Por qué?: Para ver exactamente qué cambios incluyó un commit
# ¿Para qué sirve?: Code review, debugging, entender cambios

# Mostrar el último commit
git show

# Mostrar commit específico
git show abc1234

# Mostrar commit anterior
git show HEAD~1

# Solo mostrar archivos modificados
git show --name-only abc1234

# Solo mostrar estadísticas
git show --stat abc1234

# Mostrar archivo específico en un commit
git show abc1234:ruta/archivo.txt
```

### 5. `git diff` - Comparar versiones

```bash
# ¿Qué hace?: Muestra diferencias entre versiones
# ¿Por qué?: Para ver exactamente qué cambió
# ¿Para qué sirve?: Review, debugging, verificar antes de commit

# Cambios en working directory (no staged)
git diff

# Cambios en staging area
git diff --staged
git diff --cached            # Alias

# Entre dos commits
git diff abc1234..def5678
git diff HEAD~3..HEAD

# Entre branches
git diff main..feature

# De un archivo específico
git diff archivo.txt
git diff HEAD~2..HEAD archivo.txt

# Solo nombres de archivos cambiados
git diff --name-only HEAD~3..HEAD

# Estadísticas de cambios
git diff --stat HEAD~3..HEAD
```

---

## 🔨 Ejemplos Prácticos

### Ejemplo 1: Buscar cuándo se introdujo una función

```bash
# 1. Buscar commits que mencionen "login"
git log --oneline --grep="login"

# Output:
# a1b2c3d feat(auth): agregar validación de login
# b2c3d4e feat: implementar sistema de login
# c3d4e5f docs: documentar proceso de login

# 2. Ver detalles del commit sospechoso
git show b2c3d4e
```

### Ejemplo 2: Ver cambios de la última semana

```bash
# 1. Log de la semana
git log --oneline --since="1 week ago"

# 2. Ver estadísticas de cambios
git log --stat --since="1 week ago"

# 3. Ver qué archivos cambiaron
git diff --name-only HEAD~10..HEAD
```

### Ejemplo 3: Comparar tu branch con main

```bash
# 1. Ver commits que tienes y main no
git log main..HEAD --oneline

# 2. Ver diferencias de código
git diff main..HEAD

# 3. Solo archivos afectados
git diff --name-only main..HEAD
```

### Ejemplo 4: Crear un alias útil

```bash
# Crear un alias para log bonito
git config --local alias.lg "log --oneline --graph --all --decorate"

# Usarlo
git lg
```

---

## 🎯 Alias Recomendados

Agrega estos alias a tu configuración para ser más productivo:

```bash
# Log compacto con gráfico
git config --local alias.lg "log --oneline --graph --decorate"

# Log de todas las branches
git config --local alias.lga "log --oneline --graph --all --decorate"

# Log con formato bonito
git config --local alias.ll "log --pretty=format:'%C(yellow)%h%C(reset) %s %C(blue)(%an, %ar)%C(reset)' --graph"

# Últimos 10 commits
git config --local alias.recent "log -10 --oneline"

# Historial de un archivo
git config --local alias.filelog "log --follow -p"
```

---

## 📊 Comandos Especiales

### `git shortlog` - Resumen por autor

```bash
# ¿Qué hace?: Agrupa commits por autor
# ¿Para qué sirve?: Ver contribuciones del equipo

git shortlog
git shortlog -s -n          # Solo números, ordenado
```

### `git blame` - Quién escribió cada línea

```bash
# ¿Qué hace?: Muestra quién modificó cada línea
# ¿Para qué sirve?: Encontrar autor de código específico

git blame archivo.txt
git blame -L 10,20 archivo.txt  # Solo líneas 10-20
```

### `git bisect` - Encontrar commit problemático

```bash
# ¿Qué hace?: Búsqueda binaria para encontrar commit que introdujo bug
# ¿Para qué sirve?: Debugging eficiente

git bisect start
git bisect bad                  # Marcar actual como malo
git bisect good abc1234         # Marcar commit bueno conocido
# Git te lleva a commits intermedios, tú marcas good/bad
git bisect reset                # Terminar bisect
```

---

## ⚠️ Errores Comunes

### Error 1: Log muy largo

```bash
# Problema: git log muestra demasiado

# Solución: Limitar resultados
git log -10                   # Solo 10 commits
git log --oneline             # Formato compacto
# Presiona 'q' para salir del pager
```

### Error 2: No encuentro un commit

```bash
# Problema: Buscas algo pero no lo encuentras

# Soluciones:
git log --all                 # Buscar en todas las branches
git log --grep="palabra"      # Buscar en mensajes
git log -S "código"           # Buscar en cambios de código
git reflog                    # Ver historial de referencias (incluso borrados)
```

### Error 3: Confusión con rangos

```bash
# A..B = commits en B que no están en A
git log main..feature         # Commits en feature, no en main

# A...B = commits en A o B pero no en ambos
git log main...feature        # Commits únicos de cada branch
```

---

## 📝 Resumen de Comandos

| Comando | Acción |
|---------|--------|
| `git log` | Ver historial completo |
| `git log --oneline` | Historial compacto |
| `git log --graph` | Historial con gráfico |
| `git log -n 5` | Últimos 5 commits |
| `git log --author="X"` | Por autor |
| `git log --since="date"` | Desde fecha |
| `git log --grep="text"` | Buscar en mensajes |
| `git show <commit>` | Ver detalles de commit |
| `git diff` | Cambios no staged |
| `git diff --staged` | Cambios en staging |
| `git diff A..B` | Entre commits/branches |
| `git blame <file>` | Autor por línea |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Commits Profesionales](02-commits-profesionales.md) | [Week 02](../README.md) | [Deshacer Cambios](04-deshacer-cambios.md) |

---

## 📚 Recursos Adicionales

- [Git Book - Viewing the Commit History](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History)
- [Git Documentation - git-log](https://git-scm.com/docs/git-log)
- [Git Documentation - git-diff](https://git-scm.com/docs/git-diff)

---

_Lección 03 Week 02 | Bootcamp Git/GitHub | 2025_
