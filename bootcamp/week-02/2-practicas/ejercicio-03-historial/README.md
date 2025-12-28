# 🔍 Ejercicio 03: Navegando el Historial

## 🎯 Objetivo

Dominar la navegación del historial de Git usando `git log`, `git show`, `git diff` y referencias.

---

## 📋 Requisitos Previos

- [ ] Completar [Ejercicio 02: Commits Profesionales](../ejercicio-02-commits/README.md)
- [ ] Leer [Lección 03: Navegando el Historial](../../1-teoria/03-historial-git.md)
- [ ] Tener el proyecto `blog-personal` con commits

---

## ⏱️ Tiempo Estimado

45 minutos

---

## 📝 Instrucciones

### Parte 1: Explorar con git log (15 min)

```bash
# EJERCICIO: Dominar git log
# ¿QUÉ VAMOS A HACER?: Explorar diferentes formas de ver el historial
# ¿POR QUÉ LO HACEMOS?: Encontrar información específica rápidamente
# ¿PARA QUÉ SIRVE?: Debugging, auditoría, entender evolución del código

# Usar el proyecto del ejercicio anterior
cd ~/bootcamp-ejercicios/blog-personal

# === FORMATOS BÁSICOS ===

# Paso 1: Log estándar (verbose)
git log

# Presiona 'q' para salir del pager

# Paso 2: Log compacto (una línea por commit)
git log --oneline

# Paso 3: Log con gráfico
git log --oneline --graph

# Paso 4: Log con todas las referencias
git log --oneline --graph --all --decorate
```

```bash
# === FILTROS ===

# Paso 5: Limitar cantidad
git log -5 --oneline
git log -n 3 --oneline

# Paso 6: Filtrar por tipo de commit
git log --oneline --grep="feat"
git log --oneline --grep="fix"
git log --oneline --grep="docs"

# Paso 7: Filtrar por archivo
git log --oneline -- index.html
git log --oneline -- css/

# Paso 8: Filtrar por fecha (ajusta según tu fecha)
git log --oneline --since="today"
git log --oneline --since="1 day ago"
```

```bash
# === FORMATOS PERSONALIZADOS ===

# Paso 9: Formato personalizado
git log --pretty=format:"%h %s" -5

# Paso 10: Con autor y fecha
git log --pretty=format:"%h - %s (%an, %ar)" -5

# Paso 11: Con colores
git log --pretty=format:"%C(yellow)%h%C(reset) %C(blue)%an%C(reset): %s" -5
```

**🔍 Anota tus observaciones:**
- ¿Cuántos commits de tipo `feat` tienes?
- ¿Cuál fue tu primer commit?
- ¿Cuál es el hash corto de tu último commit?

### Parte 2: Inspeccionar con git show (10 min)

```bash
# EJERCICIO: Inspeccionar commits específicos
# ¿QUÉ VAMOS A HACER?: Ver detalles de commits individuales
# ¿POR QUÉ LO HACEMOS?: Entender exactamente qué cambió en cada commit
# ¿PARA QUÉ SIRVE?: Code review, debugging, documentación

# Paso 1: Ver el último commit completo
git show

# Paso 2: Ver commit anterior
git show HEAD~1

# Paso 3: Ver dos commits atrás
git show HEAD~2

# Paso 4: Ver solo los archivos modificados
git show --name-only HEAD

# Paso 5: Ver estadísticas de cambios
git show --stat HEAD

# Paso 6: Ver un commit específico por hash
# Primero obtén un hash de tu log
git log --oneline -5
# Luego úsalo (reemplaza abc1234 con tu hash real)
git show abc1234
```

```bash
# === VER ARCHIVO EN VERSIÓN ANTERIOR ===

# Paso 7: Ver cómo estaba README.md hace 3 commits
git show HEAD~3:README.md

# Paso 8: Ver index.html en el primer commit
# Primero encuentra el hash del commit donde se creó
git log --oneline -- index.html
# Luego vélo (usa tu hash)
git show <hash>:index.html
```

### Parte 3: Comparar con git diff (15 min)

```bash
# EJERCICIO: Comparar versiones
# ¿QUÉ VAMOS A HACER?: Ver diferencias entre commits
# ¿POR QUÉ LO HACEMOS?: Entender qué cambió entre versiones
# ¿PARA QUÉ SIRVE?: Code review, encontrar cuándo se introdujo un bug

# === PREPARAR CAMBIOS PARA PRACTICAR ===

# Paso 1: Hacer un cambio en el proyecto
echo "" >> README.md
echo "## Notas Adicionales" >> README.md
echo "Este proyecto sigue creciendo." >> README.md

# Paso 2: Ver cambios no staged
git diff

# Paso 3: Agregar al staging
git add README.md

# Paso 4: Ver cambios en staging
git diff --staged

# Paso 5: Commitear
git commit -m "docs: agregar sección de notas adicionales"
```

```bash
# === COMPARAR ENTRE COMMITS ===

# Paso 6: Diferencias entre HEAD y HEAD~1
git diff HEAD~1..HEAD

# Paso 7: Diferencias entre HEAD y HEAD~3
git diff HEAD~3..HEAD

# Paso 8: Solo nombres de archivos modificados
git diff --name-only HEAD~3..HEAD

# Paso 9: Estadísticas de cambios
git diff --stat HEAD~3..HEAD

# Paso 10: Diferencias de un archivo específico
git diff HEAD~2..HEAD -- README.md
```

```bash
# === REFERENCIAS ESPECIALES ===

# Paso 11: Ver qué es HEAD actualmente
git rev-parse HEAD
git rev-parse --short HEAD

# Paso 12: Ver a qué apunta HEAD~1
git rev-parse --short HEAD~1

# Paso 13: Comparar usando hashes directamente
git log --oneline -3
# Usa los hashes que ves (ejemplo):
# git diff abc1234..def5678
```

### Parte 4: Crear Alias Útiles (5 min)

```bash
# EJERCICIO: Configurar alias para productividad
# ¿QUÉ VAMOS A HACER?: Crear atajos para comandos frecuentes
# ¿POR QUÉ LO HACEMOS?: Escribir menos, hacer más
# ¿PARA QUÉ SIRVE?: Flujo de trabajo más eficiente

# Paso 1: Crear alias para log bonito
git config --local alias.lg "log --oneline --graph --decorate"

# Paso 2: Crear alias para últimos commits
git config --local alias.recent "log -10 --oneline"

# Paso 3: Crear alias para historial de un archivo
git config --local alias.filelog "log --follow -p"

# Paso 4: Crear alias para diff con colores
git config --local alias.df "diff --color-words"

# Paso 5: Probar los alias
git lg
git recent
git df HEAD~1..HEAD
```

```bash
# Paso 6: Ver todos los alias configurados
git config --local --get-regexp alias
```

---

## 🔨 Mini-Proyecto: Investigación

Responde estas preguntas usando los comandos aprendidos:

```bash
# 1. ¿Cuántos commits tienes en total?
git log --oneline | wc -l

# 2. ¿Cuál es el mensaje de tu tercer commit?
git log --oneline | head -3 | tail -1

# 3. ¿Qué archivos se modificaron en los últimos 3 commits?
git diff --name-only HEAD~3..HEAD

# 4. ¿Cuántas líneas tiene tu README.md actual?
wc -l README.md

# 5. ¿Cuántas líneas tenía hace 3 commits?
git show HEAD~3:README.md | wc -l
```

---

## ✅ Verificación Final

Ejecuta este script de verificación:

```bash
echo "=== VERIFICACIÓN DEL EJERCICIO ==="
echo ""
echo "1. Total de commits:"
git log --oneline | wc -l

echo ""
echo "2. Últimos 5 commits:"
git log --oneline -5

echo ""
echo "3. Commits por tipo:"
git log --oneline | grep -oE "(feat|fix|docs|style|chore|refactor)" | sort | uniq -c

echo ""
echo "4. Alias configurados:"
git config --local --get-regexp alias

echo ""
echo "5. Hash del commit actual:"
git rev-parse --short HEAD

echo ""
echo "=== FIN VERIFICACIÓN ==="
```

---

## 📊 Checklist de Aprendizaje

- [ ] Sé usar `git log` con filtros (--oneline, --graph, -n, --grep)
- [ ] Puedo inspeccionar commits con `git show`
- [ ] Entiendo las referencias (HEAD, HEAD~1, HEAD~n)
- [ ] Puedo comparar versiones con `git diff`
- [ ] Configuré alias para ser más productivo

---

## 🎯 Desafío Extra (Opcional)

1. **Crear más alias útiles**: Investiga qué alias usan desarrolladores profesionales.

2. **Usar git blame**: Ejecuta `git blame README.md` y entiende el output.

3. **Formato personalizado avanzado**: Crea un alias que muestre el log con formato: `hash | autor | fecha | mensaje`

```bash
# Ejemplo de formato avanzado
git config --local alias.lfancy "log --pretty=format:'%C(yellow)%h%C(reset) | %C(blue)%an%C(reset) | %C(green)%ar%C(reset) | %s'"
```

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [Ejercicio 02](../ejercicio-02-commits/README.md) | [Week 02](../../README.md) | [Proyecto](../../3-proyecto/README.md) |

---

_Ejercicio 03 Week 02 | Bootcamp Git/GitHub | 2025_
