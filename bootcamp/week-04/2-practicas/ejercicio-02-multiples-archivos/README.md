# Ejercicio 02: Conflictos en Multiples Archivos

## Objetivo

Manejar un merge con conflictos en varios archivos simultaneamente.

**Duracion estimada:** 40 minutos

---

## Requisitos Previos

- Completar Ejercicio 01
- Familiaridad con resolucion basica de conflictos

---

## Escenario

Un proyecto web donde dos desarrolladores modificaron varios archivos de configuracion y estilos. Deberas resolver conflictos en 3 archivos diferentes.

---

## Parte 1: Preparar el Proyecto

### Paso 1.1: Crear directorio

```bash
# EJERCICIO: Crear carpeta del proyecto
# ¿QUE HACE?: Crea directorio aislado
# ¿POR QUE?: Entorno limpio para practicar
# ¿PARA QUE SIRVE?: Simular proyecto multi-archivo

mkdir ejercicio-multiples-conflictos
cd ejercicio-multiples-conflictos
git init
```

### Paso 1.2: Crear estructura inicial

```bash
# EJERCICIO: Crear archivos del proyecto
# ¿QUE HACE?: Crea 3 archivos de configuracion
# ¿POR QUE?: Necesitamos multiples archivos para el ejercicio
# ¿PARA QUE SIRVE?: Simular proyecto real con varios archivos

# Archivo 1: package.json
cat > package.json << 'EOF'
{
  "name": "mi-proyecto",
  "version": "1.0.0",
  "description": "Proyecto de ejemplo",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"No tests\""
  }
}
EOF

# Archivo 2: config.json
cat > config.json << 'EOF'
{
  "apiUrl": "https://api.example.com",
  "timeout": 5000,
  "retries": 3,
  "cache": true
}
EOF

# Archivo 3: styles.css
cat > styles.css << 'EOF'
/* Estilos principales */
body {
  font-family: Arial, sans-serif;
  background-color: #ffffff;
  color: #333333;
  margin: 0;
  padding: 20px;
}

.header {
  background-color: #f0f0f0;
  padding: 10px;
}
EOF
```

### Paso 1.3: Commit inicial

```bash
# EJERCICIO: Guardar estado inicial
# ¿QUE HACE?: Commit con todos los archivos
# ¿POR QUE?: Establecer punto de partida comun
# ¿PARA QUE SIRVE?: Base para crear divergencia

git add .
git commit -m "feat: setup inicial del proyecto"
```

---

## Parte 2: Crear Branch y Modificar

### Paso 2.1: Crear feature branch

```bash
# EJERCICIO: Crear branch para nuevo feature
# ¿QUE HACE?: Crea branch feature/mejoras
# ¿POR QUE?: Simular desarrollo paralelo
# ¿PARA QUE SIRVE?: Primera linea de cambios

git checkout -b feature/mejoras
```

### Paso 2.2: Modificar archivos en feature

```bash
# EJERCICIO: Actualizar package.json en feature
# ¿QUE HACE?: Cambia version y agrega script
# ¿POR QUE?: Simular actualizacion de version
# ¿PARA QUE SIRVE?: Crear conflicto en package.json

cat > package.json << 'EOF'
{
  "name": "mi-proyecto",
  "version": "2.0.0",
  "description": "Proyecto de ejemplo - Mejorado",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "jest",
    "build": "webpack"
  }
}
EOF

# EJERCICIO: Actualizar config.json en feature
# ¿QUE HACE?: Cambia timeout y agrega opciones
# ¿POR QUE?: Simular cambios de configuracion
# ¿PARA QUE SIRVE?: Crear conflicto en config.json

cat > config.json << 'EOF'
{
  "apiUrl": "https://api.example.com/v2",
  "timeout": 10000,
  "retries": 5,
  "cache": true,
  "compression": true
}
EOF

# EJERCICIO: Actualizar styles.css en feature
# ¿QUE HACE?: Cambia colores a dark theme
# ¿POR QUE?: Simular rediseno visual
# ¿PARA QUE SIRVE?: Crear conflicto en styles.css

cat > styles.css << 'EOF'
/* Estilos principales - Dark Theme */
body {
  font-family: 'Roboto', sans-serif;
  background-color: #1a1a1a;
  color: #ffffff;
  margin: 0;
  padding: 20px;
}

.header {
  background-color: #2d2d2d;
  padding: 15px;
}
EOF

git add .
git commit -m "feat: mejoras generales - dark theme y optimizaciones"
```

---

## Parte 3: Modificar en Main

### Paso 3.1: Volver a main

```bash
# EJERCICIO: Cambiar a main
# ¿QUE HACE?: Vuelve al branch principal
# ¿POR QUE?: Simular otro desarrollador trabajando
# ¿PARA QUE SIRVE?: Crear segunda linea de cambios

git checkout main
```

### Paso 3.2: Modificar archivos en main

```bash
# EJERCICIO: Actualizar package.json en main
# ¿QUE HACE?: Diferente version y scripts
# ¿POR QUE?: Crear conflicto con feature
# ¿PARA QUE SIRVE?: Demostrar conflicto en JSON

cat > package.json << 'EOF'
{
  "name": "mi-proyecto",
  "version": "1.5.0",
  "description": "Proyecto de ejemplo - Estable",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "mocha",
    "lint": "eslint ."
  }
}
EOF

# EJERCICIO: Actualizar config.json en main
# ¿QUE HACE?: Diferentes valores de configuracion
# ¿POR QUE?: Crear conflicto con feature
# ¿PARA QUE SIRVE?: Demostrar conflicto en configuracion

cat > config.json << 'EOF'
{
  "apiUrl": "https://api.example.com/v1",
  "timeout": 8000,
  "retries": 3,
  "cache": false,
  "logging": true
}
EOF

# EJERCICIO: Actualizar styles.css en main
# ¿QUE HACE?: Diferente esquema de colores
# ¿POR QUE?: Crear conflicto con feature
# ¿PARA QUE SIRVE?: Demostrar conflicto en CSS

cat > styles.css << 'EOF'
/* Estilos principales - Light Theme */
body {
  font-family: 'Open Sans', sans-serif;
  background-color: #f5f5f5;
  color: #222222;
  margin: 0;
  padding: 20px;
}

.header {
  background-color: #e0e0e0;
  padding: 12px;
}
EOF

git add .
git commit -m "feat: actualizaciones de estabilidad - light theme"
```

---

## Parte 4: Provocar Conflictos

### Paso 4.1: Intentar merge

```bash
# EJERCICIO: Merge feature branch
# ¿QUE HACE?: Intenta combinar cambios
# ¿POR QUE?: Provocar multiples conflictos
# ¿PARA QUE SIRVE?: Practicar resolucion multiple

git merge feature/mejoras
```

### Resultado Esperado

```
Auto-merging styles.css
CONFLICT (content): Merge conflict in styles.css
Auto-merging package.json
CONFLICT (content): Merge conflict in package.json
Auto-merging config.json
CONFLICT (content): Merge conflict in config.json
Automatic merge failed; fix conflicts and then commit the result.
```

### Paso 4.2: Ver estado

```bash
# EJERCICIO: Verificar archivos en conflicto
# ¿QUE HACE?: Lista todos los conflictos
# ¿POR QUE?: Conocer alcance del problema
# ¿PARA QUE SIRVE?: Planificar resolucion

git status
```

### Resultado Esperado

```
Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   config.json
        both modified:   package.json
        both modified:   styles.css
```

---

## Parte 5: Resolver Conflictos Uno por Uno

### Paso 5.1: Resolver package.json

```bash
# EJERCICIO: Ver conflicto en package.json
cat package.json
```

**Conflicto visible:**
```json
{
  "name": "mi-proyecto",
<<<<<<< HEAD
  "version": "1.5.0",
  "description": "Proyecto de ejemplo - Estable",
=======
  "version": "2.0.0",
  "description": "Proyecto de ejemplo - Mejorado",
>>>>>>> feature/mejoras
  ...
}
```

```bash
# EJERCICIO: Resolver package.json combinando versiones
# ¿QUE HACE?: Crea version que combina lo mejor de ambos
# ¿POR QUE?: Aprovechar ambos conjuntos de cambios
# ¿PARA QUE SIRVE?: Resultado optimo

cat > package.json << 'EOF'
{
  "name": "mi-proyecto",
  "version": "2.0.0",
  "description": "Proyecto de ejemplo - Estable y Mejorado",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "jest",
    "build": "webpack",
    "lint": "eslint ."
  }
}
EOF

git add package.json
echo "package.json resuelto"
```

### Paso 5.2: Resolver config.json

```bash
# EJERCICIO: Resolver config.json
# ¿QUE HACE?: Combina configuraciones de ambos
# ¿POR QUE?: Incluir todas las opciones utiles
# ¿PARA QUE SIRVE?: Configuracion completa

cat > config.json << 'EOF'
{
  "apiUrl": "https://api.example.com/v2",
  "timeout": 10000,
  "retries": 5,
  "cache": true,
  "compression": true,
  "logging": true
}
EOF

git add config.json
echo "config.json resuelto"
```

### Paso 5.3: Resolver styles.css

```bash
# EJERCICIO: Resolver styles.css
# ¿QUE HACE?: Crea sistema de temas flexible
# ¿POR QUE?: Soportar ambos temas
# ¿PARA QUE SIRVE?: CSS que funciona para ambos casos

cat > styles.css << 'EOF'
/* Estilos principales - Sistema de Temas */
:root {
  --bg-color: #f5f5f5;
  --text-color: #222222;
  --header-bg: #e0e0e0;
}

[data-theme="dark"] {
  --bg-color: #1a1a1a;
  --text-color: #ffffff;
  --header-bg: #2d2d2d;
}

body {
  font-family: 'Roboto', 'Open Sans', sans-serif;
  background-color: var(--bg-color);
  color: var(--text-color);
  margin: 0;
  padding: 20px;
}

.header {
  background-color: var(--header-bg);
  padding: 15px;
}
EOF

git add styles.css
echo "styles.css resuelto"
```

---

## Parte 6: Completar Merge

### Paso 6.1: Verificar estado

```bash
# EJERCICIO: Confirmar todos resueltos
# ¿QUE HACE?: Verifica que no hay conflictos pendientes
# ¿POR QUE?: Asegurar que podemos hacer commit
# ¿PARA QUE SIRVE?: Validacion antes de finalizar

git status
```

### Resultado Esperado

```
On branch main
All conflicts fixed but you are still merging.

Changes to be committed:
        modified:   config.json
        modified:   package.json
        modified:   styles.css
```

### Paso 6.2: Commit del merge

```bash
# EJERCICIO: Finalizar merge
# ¿QUE HACE?: Crea merge commit con todos los cambios
# ¿POR QUE?: Completar el proceso de merge
# ¿PARA QUE SIRVE?: Registrar la resolucion

git commit -m "Merge feature/mejoras: combinar mejoras con estabilidad

Resueltos conflictos en:
- package.json: combinados scripts de ambos
- config.json: merged configuraciones
- styles.css: implementado sistema de temas"
```

---

## Parte 7: Verificar

### Paso 7.1: Ver historial

```bash
# EJERCICIO: Visualizar resultado
git log --oneline --graph -6
```

### Paso 7.2: Ver archivos finales

```bash
# Verificar cada archivo resuelto
echo "=== package.json ===" && cat package.json
echo ""
echo "=== config.json ===" && cat config.json
echo ""
echo "=== styles.css ===" && cat styles.css
```

---

## Estrategia de Resolucion Multiple

| Orden | Archivo | Complejidad | Estrategia |
|-------|---------|-------------|------------|
| 1 | Mas simple | Baja | Resolver primero |
| 2 | Intermedio | Media | Resolver segundo |
| 3 | Mas complejo | Alta | Resolver ultimo |

**Tip:** Resuelve los archivos mas simples primero para ganar confianza.

---

## Checklist de Completado

- [ ] Cree proyecto con 3 archivos
- [ ] Modifique archivos en feature branch
- [ ] Modifique mismos archivos en main
- [ ] Provoque conflictos con merge
- [ ] Identifique los 3 archivos en conflicto
- [ ] Resolvi package.json
- [ ] Resolvi config.json
- [ ] Resolvi styles.css
- [ ] Complete merge con commit descriptivo

---

## Preguntas de Reflexion

1. ¿En que orden resolviste los archivos? ¿Por que?
2. ¿Cual archivo fue mas dificil de resolver?
3. ¿Como decidiste que cambios conservar de cada branch?
4. ¿Que harias diferente en un proyecto real?

---

*Ejercicio 02 de 04 | Week 04: Merge Conflicts*
