# Ejercicio 03: Fetch y Merge Manual

## Informacion General

| Campo | Valor |
|-------|-------|
| Duracion | 40 minutos |
| Dificultad | Intermedio |
| Prerequisitos | Ejercicio 02 completado |

---

## Objetivos

Al completar este ejercicio seras capaz de:

- Entender la diferencia entre fetch y pull
- Usar fetch para revisar cambios antes de aplicarlos
- Hacer merge manual despues de fetch
- Usar pull --rebase como alternativa

---

## Contexto

En este ejercicio simularemos un escenario de equipo donde:
1. Tu haces cambios locales
2. Un "companero" hace cambios en GitHub
3. Usas fetch para revisar antes de merge

---

## Parte 1: Preparar Escenario (10 min)

### Paso 1.1: Continuar con repositorio anterior

```bash
# EJERCICIO: Usar el repositorio de ejercicio 02
# ¿QUE HACE?: Navegar al repositorio existente
# ¿POR QUE?: Continuamos el flujo de trabajo
# ¿PARA QUE SIRVE?: No crear repos innecesarios

cd ~/practica-remotes

# Verificar estado limpio
git status
git log --oneline -3
```

### Paso 1.2: Crear cambios locales

```bash
# EJERCICIO: Hacer commits locales sin push
# ¿QUE HACE?: Crear trabajo local pendiente de subir
# ¿POR QUE?: Simular que has estado trabajando
# ¿PARA QUE SIRVE?: Crear situacion de divergencia

# Crear archivo de configuracion
cat > config.json << 'EOF'
{
  "app": "Practica Remotes",
  "version": "1.0.0",
  "author": "Tu Nombre"
}
EOF

git add config.json
git commit -m "feat: agregar archivo de configuracion"

# NO hacer push todavia
git status
# Your branch is ahead of 'origin/main' by 1 commit
```

### Paso 1.3: Simular cambio del "companero" en GitHub

1. Ve a `github.com/TU-USUARIO/practica-remotes`
2. Click en "Add file" > "Create new file"
3. Nombre: `CONTRIBUTING.md`
4. Contenido:
   ```markdown
   # Contribuciones

   ## Como contribuir

   1. Fork el repositorio
   2. Crea un branch
   3. Haz tus cambios
   4. Envia Pull Request
   ```
5. Commit message: "docs: agregar guia de contribucion"
6. Click "Commit new file"

---

## Parte 2: Fetch sin Merge (15 min)

### Paso 2.1: Verificar estado actual

```bash
# EJERCICIO: Ver estado antes de fetch
# ¿QUE HACE?: Muestra commits locales pendientes
# ¿POR QUE?: Documentar estado inicial
# ¿PARA QUE SIRVE?: Comparar antes y despues

git status
# Your branch is ahead of 'origin/main' by 1 commit

# Git no sabe que hay cambios en el remoto todavia
```

### Paso 2.2: Hacer fetch

```bash
# EJERCICIO: Descargar cambios sin aplicar
# ¿QUE HACE?: Actualiza origin/main con commits del remoto
# ¿POR QUE?: Queremos revisar antes de hacer merge
# ¿PARA QUE SIRVE?: Control sobre que se integra

git fetch origin

# Resultado esperado:
# remote: Enumerating objects: 4, done.
# ...
# From github.com:TU-USUARIO/practica-remotes
#    xyz9876..abc1234  main       -> origin/main
```

### Paso 2.3: Verificar estado despues de fetch

```bash
# EJERCICIO: Ver como cambio el estado
# ¿QUE HACE?: Muestra la divergencia entre local y remoto
# ¿POR QUE?: Fetch actualizo las referencias remotas
# ¿PARA QUE SIRVE?: Entender la situacion actual

git status

# Resultado esperado:
# On branch main
# Your branch and 'origin/main' have diverged,
# and have 1 and 1 different commits each, respectively.

# TU branch tiene 1 commit que origin/main no tiene
# origin/main tiene 1 commit que TU no tienes
```

### Paso 2.4: Ver commits nuevos del remoto

```bash
# EJERCICIO: Revisar que trajo fetch
# ¿QUE HACE?: Lista commits en origin/main que no estan en main
# ¿POR QUE?: Ver que hizo el "companero"
# ¿PARA QUE SIRVE?: Decidir si hacer merge

git log main..origin/main --oneline
# abc1234 docs: agregar guia de contribucion

# Ver contenido del commit
git show origin/main --stat
```

### Paso 2.5: Ver diferencias de codigo

```bash
# EJERCICIO: Comparar tu main con origin/main
# ¿QUE HACE?: Muestra diferencias de archivos
# ¿POR QUE?: Revisar cambios especificos
# ¿PARA QUE SIRVE?: Verificar que no hay conflictos

git diff main origin/main

# Tambien puedes ver solo nombres de archivos
git diff main origin/main --name-only
# CONTRIBUTING.md
```

### Paso 2.6: Ver historial completo

```bash
# EJERCICIO: Visualizar la divergencia
# ¿QUE HACE?: Muestra historial con grafico
# ¿POR QUE?: Ver como divergieron los branches
# ¿PARA QUE SIRVE?: Entender la estructura de commits

git log --oneline --graph --all

# Resultado esperado (algo asi):
# * abc1234 (origin/main) docs: agregar guia de contribucion
# | * def5678 (HEAD -> main) feat: agregar archivo de configuracion
# |/
# * xyz9876 docs: actualizar README desde GitHub
# ...
```

---

## Parte 3: Merge Manual (10 min)

### Paso 3.1: Hacer merge de origin/main

```bash
# EJERCICIO: Fusionar cambios del remoto
# ¿QUE HACE?: Integra origin/main en tu main local
# ¿POR QUE?: Ya revisaste y quieres los cambios
# ¿PARA QUE SIRVE?: Sincronizar con el trabajo del equipo

git merge origin/main

# Resultado esperado:
# Merge made by the 'ort' strategy.
#  CONTRIBUTING.md | 10 ++++++++++
#  1 file changed, 10 insertions(+)
#  create mode 100644 CONTRIBUTING.md
```

### Paso 3.2: Verificar el merge

```bash
# EJERCICIO: Confirmar que merge fue exitoso
# ¿QUE HACE?: Verifica archivos y historial
# ¿POR QUE?: Asegurar que todo se integro bien
# ¿PARA QUE SIRVE?: Validacion antes de push

# Ver archivos
ls -la
# Debe incluir CONTRIBUTING.md y config.json

# Ver historial
git log --oneline --graph -5
# Veras el merge commit

git status
# Your branch is ahead of 'origin/main' by 2 commits
```

### Paso 3.3: Push del merge

```bash
# EJERCICIO: Subir el merge al remoto
# ¿QUE HACE?: Envia tus commits mas el merge a GitHub
# ¿POR QUE?: Compartir tu trabajo y el merge
# ¿PARA QUE SIRVE?: Sincronizar remoto con tu local

git push

# Verificar
git status
# Your branch is up to date with 'origin/main'.
```

---

## Parte 4: Alternativa con Rebase (5 min)

Para entender otra opcion, veamos como seria con rebase:

### Concepto (no ejecutar)

```bash
# En vez de fetch + merge, podrias hacer:
git fetch origin
git rebase origin/main

# O directamente:
git pull --rebase origin main

# La diferencia:
# - Merge: crea commit de merge, historial muestra divergencia
# - Rebase: reaplica tus commits, historial lineal
```

### Cuando usar cada uno

| Situacion | Recomendacion |
|-----------|---------------|
| Branch compartido | Merge |
| Trabajo local no compartido | Rebase |
| Quieres historial limpio | Rebase |
| Quieres preservar contexto | Merge |

---

## Verificacion Final

```bash
# Estado limpio y sincronizado
git status
# up to date

# Historial completo
git log --oneline -6

# Archivos presentes
ls -la
# config.json, CONTRIBUTING.md, README.md, app.js, styles.css

# Ver en GitHub que todo esta sincronizado
```

---

## Comparativa: Pull vs Fetch+Merge

| Aspecto | git pull | git fetch + git merge |
|---------|----------|----------------------|
| Pasos | 1 | 2 |
| Control | Menos | Mas |
| Revision previa | No | Si |
| Uso recomendado | Confianza total | Revisar primero |

---

## Resumen de Comandos

| Comando | Descripcion |
|---------|-------------|
| `git fetch origin` | Descargar sin merge |
| `git log main..origin/main` | Ver commits nuevos |
| `git diff main origin/main` | Ver diferencias |
| `git merge origin/main` | Aplicar cambios |
| `git pull --rebase` | Fetch + rebase |

---

## Siguiente Ejercicio

[Ejercicio 04: Fork Workflow](../ejercicio-04-fork-workflow/README.md)

---

*Week 05 - Ejercicio 03 | Bootcamp Git/GitHub*
