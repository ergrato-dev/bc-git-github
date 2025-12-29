# Ejercicio 04: Fork Workflow

## Informacion General

| Campo | Valor |
|-------|-------|
| Duracion | 40 minutos |
| Dificultad | Intermedio |
| Prerequisitos | Ejercicios anteriores completados |

---

## Objetivos

Al completar este ejercicio seras capaz de:

- Hacer fork de un repositorio
- Configurar multiples remotes (origin y upstream)
- Sincronizar tu fork con el repositorio original
- Entender el flujo de contribucion a proyectos open source

---

## Diagrama del Fork Workflow

![Fork Workflow](../../0-assets/04-fork-workflow.svg)

---

## Parte 1: Hacer Fork (5 min)

### Paso 1.1: Fork en GitHub

1. Ve a [github.com/octocat/Spoon-Knife](https://github.com/octocat/Spoon-Knife)
   - Este es un repositorio de practica de GitHub
2. Click en el boton "Fork" (esquina superior derecha)
3. Selecciona tu cuenta como destino
4. Espera a que se complete el fork

**Resultado:** Ahora tienes `github.com/TU-USUARIO/Spoon-Knife`

### Paso 1.2: Verificar el fork

- Tu fork esta en: `github.com/TU-USUARIO/Spoon-Knife`
- El original esta en: `github.com/octocat/Spoon-Knife`
- Tu fork es independiente pero conectado

---

## Parte 2: Clonar y Configurar Remotes (10 min)

### Paso 2.1: Clonar TU fork

```bash
# EJERCICIO: Clonar tu fork (no el original)
# ¿QUE HACE?: Descarga tu copia del repositorio
# ¿POR QUE?: Trabajas en tu fork, no en el original
# ¿PARA QUE SIRVE?: Tener copia local de TU version

cd ~
git clone git@github.com:TU-USUARIO/Spoon-Knife.git
cd Spoon-Knife

# Verificar que clonaste tu fork
git remote -v
# origin  git@github.com:TU-USUARIO/Spoon-Knife.git (fetch)
# origin  git@github.com:TU-USUARIO/Spoon-Knife.git (push)
```

### Paso 2.2: Agregar upstream (repositorio original)

```bash
# EJERCICIO: Conectar con el repositorio original
# ¿QUE HACE?: Agrega segundo remote llamado "upstream"
# ¿POR QUE?: Para poder sincronizar con el proyecto original
# ¿PARA QUE SIRVE?: Mantener tu fork actualizado

git remote add upstream https://github.com/octocat/Spoon-Knife.git

# Verificar ambos remotes
git remote -v
# origin    git@github.com:TU-USUARIO/Spoon-Knife.git (fetch)
# origin    git@github.com:TU-USUARIO/Spoon-Knife.git (push)
# upstream  https://github.com/octocat/Spoon-Knife.git (fetch)
# upstream  https://github.com/octocat/Spoon-Knife.git (push)
```

### Paso 2.3: Entender la configuracion

```
CONFIGURACION DE REMOTES
========================

upstream (octocat/Spoon-Knife)     <-- Repositorio original
    |                                   Solo lectura (fetch)
    |
    +--> origin (TU-USUARIO/Spoon-Knife)  <-- Tu fork
              |                               Lectura y escritura
              |
              +--> local (tu computadora)     <-- Donde trabajas
```

---

## Parte 3: Sincronizar con Upstream (10 min)

### Paso 3.1: Fetch de upstream

```bash
# EJERCICIO: Obtener cambios del repositorio original
# ¿QUE HACE?: Descarga commits de upstream sin aplicar
# ¿POR QUE?: El original puede tener commits nuevos
# ¿PARA QUE SIRVE?: Preparar sincronizacion

git fetch upstream

# Ver branches de upstream
git branch -a
# * main
#   remotes/origin/HEAD -> origin/main
#   remotes/origin/main
#   remotes/upstream/main
```

### Paso 3.2: Ver diferencias con upstream

```bash
# EJERCICIO: Comparar tu main con upstream/main
# ¿QUE HACE?: Muestra si upstream tiene commits nuevos
# ¿POR QUE?: Saber que hay de nuevo en el proyecto original
# ¿PARA QUE SIRVE?: Decidir si actualizar tu fork

git log main..upstream/main --oneline
# Si hay commits, los veras aqui
# Si no hay, significa que estan sincronizados
```

### Paso 3.3: Merge de upstream (si hay cambios)

```bash
# EJERCICIO: Actualizar tu main con upstream
# ¿QUE HACE?: Fusiona cambios del original a tu local
# ¿POR QUE?: Mantener tu fork al dia
# ¿PARA QUE SIRVE?: Evitar conflictos futuros

# Asegurarte que estas en main
git checkout main

# Merge de upstream
git merge upstream/main

# Resultado: ya sea "Already up to date" o los cambios aplicados
```

### Paso 3.4: Push a tu fork

```bash
# EJERCICIO: Actualizar tu fork en GitHub
# ¿QUE HACE?: Sube los cambios de upstream a origin (tu fork)
# ¿POR QUE?: Tu fork en GitHub debe reflejar los cambios
# ¿PARA QUE SIRVE?: Sincronizacion completa

git push origin main

# Ahora tu fork en GitHub esta actualizado con el original
```

---

## Parte 4: Contribuir con Cambios (15 min)

### Paso 4.1: Crear branch para tu contribucion

```bash
# EJERCICIO: Crear branch de trabajo
# ¿QUE HACE?: Crea branch separado para tus cambios
# ¿POR QUE?: Nunca trabajar directamente en main
# ¿PARA QUE SIRVE?: Aislar tu trabajo, facilitar PR

git checkout -b mi-contribucion

# Verificar
git branch
# * mi-contribucion
#   main
```

### Paso 4.2: Hacer cambios

```bash
# EJERCICIO: Agregar tu contribucion
# ¿QUE HACE?: Crea archivo con tu aporte
# ¿POR QUE?: Simular contribucion a proyecto
# ¿PARA QUE SIRVE?: Tener algo que enviar via PR

# Crear archivo de contribucion
cat > mi-archivo.md << 'EOF'
# Mi Contribucion

Hola, este es mi aporte al proyecto Spoon-Knife.

## Sobre mi

Soy estudiante del Bootcamp Git/GitHub.

## Fecha

Agregado en Week 05.
EOF

git add mi-archivo.md
git commit -m "docs: agregar mi contribucion al proyecto"
```

### Paso 4.3: Push a tu fork

```bash
# EJERCICIO: Subir branch a tu fork
# ¿QUE HACE?: Envia tu branch a origin (tu fork)
# ¿POR QUE?: Para luego crear Pull Request
# ¿PARA QUE SIRVE?: Tus cambios estaran en GitHub

git push -u origin mi-contribucion

# Resultado:
# To github.com:TU-USUARIO/Spoon-Knife.git
#  * [new branch]      mi-contribucion -> mi-contribucion
```

### Paso 4.4: Crear Pull Request (en GitHub)

1. Ve a `github.com/TU-USUARIO/Spoon-Knife`
2. Veras un banner: "mi-contribucion had recent pushes"
3. Click en "Compare & pull request"
4. Verifica:
   - base repository: `octocat/Spoon-Knife`
   - base: `main`
   - head repository: `TU-USUARIO/Spoon-Knife`
   - compare: `mi-contribucion`
5. Titulo: "docs: agregar contribucion de [tu nombre]"
6. Descripcion: Explica tu cambio
7. Click "Create pull request"

**Nota:** Este PR no sera aceptado (es un repo de practica), pero el flujo es el correcto.

---

## Parte 5: Mantener Fork Actualizado (Rutina)

### Rutina de sincronizacion

```bash
# EJERCICIO: Comandos para mantener fork al dia
# ¿QUE HACE?: Sincroniza tu fork con upstream
# ¿POR QUE?: Proyectos activos cambian constantemente
# ¿PARA QUE SIRVE?: Evitar divergencia grande con el original

# 1. Cambiar a main
git checkout main

# 2. Obtener cambios de upstream
git fetch upstream

# 3. Merge de upstream/main
git merge upstream/main

# 4. Actualizar tu fork en GitHub
git push origin main
```

---

## Verificacion Final

```bash
# Ver remotes configurados
git remote -v
# Debe mostrar origin (tu fork) y upstream (original)

# Ver branches
git branch -a
# Debe mostrar main, mi-contribucion, y remotes

# Ver estado
git status
# Debe estar limpio

# Ver historial
git log --oneline -5
```

---

## Resumen del Fork Workflow

```
1. FORK         github.com/original/repo --> github.com/tu-usuario/repo
2. CLONE        tu-usuario/repo --> local
3. ADD UPSTREAM git remote add upstream original/repo
4. BRANCH       git checkout -b feature
5. COMMIT       git add + git commit
6. PUSH         git push origin feature
7. PR           Crear Pull Request en GitHub
8. SYNC         fetch upstream + merge + push origin
```

---

## Comandos Clave

| Comando | Descripcion |
|---------|-------------|
| `git remote add upstream <url>` | Agregar repo original |
| `git fetch upstream` | Obtener cambios de upstream |
| `git merge upstream/main` | Sincronizar con upstream |
| `git push origin main` | Actualizar tu fork |
| `git checkout -b feature` | Branch para contribucion |
| `git push -u origin feature` | Subir branch para PR |

---

## Limpieza

```bash
# Si quieres eliminar el repositorio de practica
cd ~
rm -rf Spoon-Knife
```

---

## Siguiente Seccion

Has completado todos los ejercicios de la semana. Ahora puedes:

- [Ir al Proyecto Semanal](../../3-proyecto/README.md)
- [Revisar la Teoria](../../1-teoria/)
- [Consultar el Glosario](../../5-glosario/README.md)

---

*Week 05 - Ejercicio 04 | Bootcamp Git/GitHub*
