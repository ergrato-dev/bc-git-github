# Ejercicio 01: Conflicto Simple

## Objetivo

Provocar intencionalmente un merge conflict y resolverlo manualmente.

**Duracion estimada:** 35 minutos

---

## Requisitos Previos

- Git instalado y configurado
- Conocimiento de branches y merge
- Editor de texto (VS Code recomendado)

---

## Escenario

Vas a simular un escenario donde dos "desarrolladores" modifican la misma linea de un archivo, generando un conflicto que deberas resolver.

---

## Parte 1: Preparar el Repositorio

### Paso 1.1: Crear directorio del ejercicio

```bash
# EJERCICIO: Crear carpeta de trabajo
# ¿QUE HACE?: Crea un directorio aislado para el ejercicio
# ¿POR QUE?: Evitar afectar otros proyectos
# ¿PARA QUE SIRVE?: Tener un entorno limpio de practica

mkdir ejercicio-conflicto-simple
cd ejercicio-conflicto-simple
```

### Paso 1.2: Inicializar repositorio

```bash
# EJERCICIO: Inicializar Git
# ¿QUE HACE?: Crea un nuevo repositorio Git
# ¿POR QUE?: Necesitamos control de versiones para practicar
# ¿PARA QUE SIRVE?: Habilitar todas las funciones de Git

git init
```

### Paso 1.3: Crear archivo inicial

```bash
# EJERCICIO: Crear archivo de configuracion
# ¿QUE HACE?: Crea un archivo con contenido inicial
# ¿POR QUE?: Necesitamos un archivo para generar el conflicto
# ¿PARA QUE SIRVE?: Sera el archivo donde ocurra el conflicto

cat > config.js << 'EOF'
// Configuracion de la aplicacion
const config = {
  appName: "Mi Aplicacion",
  version: "1.0.0",
  theme: "default",
  language: "es",
  debug: false
};

module.exports = config;
EOF
```

### Paso 1.4: Commit inicial

```bash
# EJERCICIO: Crear commit inicial
# ¿QUE HACE?: Guarda el estado inicial del archivo
# ¿POR QUE?: Necesitamos un punto de partida comun
# ¿PARA QUE SIRVE?: Base desde donde divergeran los branches

git add config.js
git commit -m "feat: agregar configuracion inicial"
```

---

## Parte 2: Crear Divergencia

### Paso 2.1: Crear branch feature

```bash
# EJERCICIO: Crear branch para nueva funcionalidad
# ¿QUE HACE?: Crea y cambia a un nuevo branch
# ¿POR QUE?: Simular trabajo paralelo de otro desarrollador
# ¿PARA QUE SIRVE?: Tener dos lineas de desarrollo independientes

git checkout -b feature/dark-theme
```

### Paso 2.2: Modificar en feature branch

```bash
# EJERCICIO: Modificar archivo en feature branch
# ¿QUE HACE?: Cambia el tema a "dark"
# ¿POR QUE?: Simular que un desarrollador implementa dark mode
# ¿PARA QUE SIRVE?: Crear la primera version que causara conflicto

cat > config.js << 'EOF'
// Configuracion de la aplicacion
const config = {
  appName: "Mi Aplicacion",
  version: "1.0.0",
  theme: "dark",
  language: "es",
  debug: false
};

module.exports = config;
EOF

git add config.js
git commit -m "feat: cambiar tema a dark mode"
```

### Paso 2.3: Volver a main y modificar

```bash
# EJERCICIO: Volver a main
# ¿QUE HACE?: Cambia al branch principal
# ¿POR QUE?: Simular que otro desarrollador trabaja en main
# ¿PARA QUE SIRVE?: Crear la segunda version conflictiva

git checkout main
```

### Paso 2.4: Modificar la misma linea en main

```bash
# EJERCICIO: Modificar mismo archivo en main
# ¿QUE HACE?: Cambia el tema a "light" (diferente a feature)
# ¿POR QUE?: Crear la condicion para un conflicto
# ¿PARA QUE SIRVE?: Ambos branches modificaron la misma linea

cat > config.js << 'EOF'
// Configuracion de la aplicacion
const config = {
  appName: "Mi Aplicacion",
  version: "1.0.0",
  theme: "light",
  language: "es",
  debug: false
};

module.exports = config;
EOF

git add config.js
git commit -m "feat: cambiar tema a light mode"
```

---

## Parte 3: Provocar el Conflicto

### Paso 3.1: Intentar merge

```bash
# EJERCICIO: Intentar merge del feature branch
# ¿QUE HACE?: Intenta combinar feature/dark-theme con main
# ¿POR QUE?: Ambos modificaron la misma linea
# ¿PARA QUE SIRVE?: Provocar el conflicto intencionalmente

git merge feature/dark-theme
```

### Resultado Esperado

```
Auto-merging config.js
CONFLICT (content): Merge conflict in config.js
Automatic merge failed; fix conflicts and then commit the result.
```

### Paso 3.2: Verificar estado

```bash
# EJERCICIO: Ver estado del repositorio
# ¿QUE HACE?: Muestra archivos en conflicto
# ¿POR QUE?: Confirmar que hay un conflicto pendiente
# ¿PARA QUE SIRVE?: Identificar que archivos necesitan resolucion

git status
```

### Resultado Esperado

```
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   config.js
```

---

## Parte 4: Analizar el Conflicto

### Paso 4.1: Ver contenido del archivo

```bash
# EJERCICIO: Ver el archivo con marcadores de conflicto
# ¿QUE HACE?: Muestra el contenido con los marcadores
# ¿POR QUE?: Necesitamos entender que esta en conflicto
# ¿PARA QUE SIRVE?: Identificar las dos versiones

cat config.js
```

### Resultado Esperado

```javascript
// Configuracion de la aplicacion
const config = {
  appName: "Mi Aplicacion",
  version: "1.0.0",
<<<<<<< HEAD
  theme: "light",
=======
  theme: "dark",
>>>>>>> feature/dark-theme
  language: "es",
  debug: false
};

module.exports = config;
```

### Paso 4.2: Identificar las secciones

```
<<<<<<< HEAD
  theme: "light",      <-- TU version (main, donde estas)
=======
  theme: "dark",       <-- VERSION ENTRANTE (feature/dark-theme)
>>>>>>> feature/dark-theme
```

---

## Parte 5: Resolver el Conflicto

### Opcion A: Conservar version de main (light)

```bash
# EJERCICIO: Resolver conservando tu version
# ¿QUE HACE?: Elimina marcadores y deja "light"
# ¿POR QUE?: Decides que light mode es lo correcto
# ¿PARA QUE SIRVE?: Completar la resolucion

cat > config.js << 'EOF'
// Configuracion de la aplicacion
const config = {
  appName: "Mi Aplicacion",
  version: "1.0.0",
  theme: "light",
  language: "es",
  debug: false
};

module.exports = config;
EOF
```

### Opcion B: Conservar version de feature (dark)

```bash
# EJERCICIO: Resolver conservando version entrante
# ¿QUE HACE?: Elimina marcadores y deja "dark"
# ¿POR QUE?: Decides que dark mode es lo correcto
# ¿PARA QUE SIRVE?: Completar la resolucion

cat > config.js << 'EOF'
// Configuracion de la aplicacion
const config = {
  appName: "Mi Aplicacion",
  version: "1.0.0",
  theme: "dark",
  language: "es",
  debug: false
};

module.exports = config;
EOF
```

### Opcion C: Combinar ambas (RECOMENDADA para este ejercicio)

```bash
# EJERCICIO: Resolver combinando ambas versiones
# ¿QUE HACE?: Crea solucion que soporta ambos temas
# ¿POR QUE?: Aprovechamos el trabajo de ambos desarrolladores
# ¿PARA QUE SIRVE?: Solucion mas completa

cat > config.js << 'EOF'
// Configuracion de la aplicacion
const config = {
  appName: "Mi Aplicacion",
  version: "1.0.0",
  theme: "dark",
  availableThemes: ["light", "dark"],
  language: "es",
  debug: false
};

module.exports = config;
EOF
```

---

## Parte 6: Completar el Merge

### Paso 6.1: Agregar archivo resuelto

```bash
# EJERCICIO: Marcar conflicto como resuelto
# ¿QUE HACE?: Agrega el archivo al staging area
# ¿POR QUE?: Indica a Git que resolviste el conflicto
# ¿PARA QUE SIRVE?: Preparar para el commit

git add config.js
```

### Paso 6.2: Verificar estado

```bash
# EJERCICIO: Confirmar que el conflicto esta resuelto
# ¿QUE HACE?: Muestra el estado actualizado
# ¿POR QUE?: Verificar antes de hacer commit
# ¿PARA QUE SIRVE?: Asegurar que no hay conflictos pendientes

git status
```

### Resultado Esperado

```
On branch main
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:
        modified:   config.js
```

### Paso 6.3: Completar merge con commit

```bash
# EJERCICIO: Crear merge commit
# ¿QUE HACE?: Finaliza el proceso de merge
# ¿POR QUE?: Completar la union de los branches
# ¿PARA QUE SIRVE?: Registrar la resolucion en el historial

git commit -m "Merge feature/dark-theme: agregar soporte multi-tema"
```

---

## Parte 7: Verificar Resultado

### Paso 7.1: Ver historial

```bash
# EJERCICIO: Ver historial de commits
# ¿QUE HACE?: Muestra el grafico de commits
# ¿POR QUE?: Visualizar el merge completado
# ¿PARA QUE SIRVE?: Confirmar que el merge fue exitoso

git log --oneline --graph --all
```

### Resultado Esperado

```
*   abc1234 (HEAD -> main) Merge feature/dark-theme: agregar soporte multi-tema
|\
| * def5678 (feature/dark-theme) feat: cambiar tema a dark mode
* | ghi9012 feat: cambiar tema a light mode
|/
* jkl3456 feat: agregar configuracion inicial
```

### Paso 7.2: Verificar archivo final

```bash
# EJERCICIO: Ver contenido final
# ¿QUE HACE?: Muestra el archivo resuelto
# ¿POR QUE?: Confirmar que la resolucion es correcta
# ¿PARA QUE SIRVE?: Validar el resultado

cat config.js
```

---

## Limpieza (Opcional)

```bash
# Volver al directorio padre
cd ..

# Eliminar directorio del ejercicio (opcional)
# rm -rf ejercicio-conflicto-simple
```

---

## Checklist de Completado

- [ ] Cree el repositorio y archivo inicial
- [ ] Cree branch feature/dark-theme
- [ ] Modifique el archivo en feature branch
- [ ] Modifique la misma linea en main
- [ ] Provoque el conflicto con git merge
- [ ] Identifique los marcadores de conflicto
- [ ] Resolvi el conflicto (elegi una opcion)
- [ ] Complete el merge con git add y git commit
- [ ] Verifique el historial con git log

---

## Preguntas de Reflexion

1. ¿Por que Git no pudo resolver este conflicto automaticamente?
2. ¿Cual seria la mejor opcion de resolucion en un proyecto real?
3. ¿Que pasaria si no eliminas todos los marcadores?
4. ¿Como evitarias este conflicto en el futuro?

---

*Ejercicio 01 de 04 | Week 04: Merge Conflicts*
