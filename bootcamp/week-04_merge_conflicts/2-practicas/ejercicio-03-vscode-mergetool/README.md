# Ejercicio 03: VS Code y Mergetool

## Objetivo

Usar herramientas visuales para resolver conflictos de forma mas eficiente.

**Duracion estimada:** 40 minutos

---

## Requisitos Previos

- VS Code instalado
- Completar Ejercicios 01 y 02
- Git configurado

---

## Escenario

Configurar y usar VS Code como herramienta principal para resolver conflictos, aprovechando su interfaz visual.

---

## Parte 1: Configurar Git Mergetool

### Paso 1.1: Verificar configuracion actual

```bash
# EJERCICIO: Ver configuracion de merge tools
# ¿QUE HACE?: Muestra configuracion existente
# ¿POR QUE?: Saber si ya hay algo configurado
# ¿PARA QUE SIRVE?: Punto de partida

git config --global --list | grep -E "(merge|diff)" || echo "No hay configuracion de merge tools"
```

### Paso 1.2: Configurar VS Code como mergetool

```bash
# EJERCICIO: Configurar VS Code
# ¿QUE HACE?: Establece VS Code como herramienta de merge
# ¿POR QUE?: VS Code tiene excelente soporte visual
# ¿PARA QUE SIRVE?: Resolver conflictos visualmente

git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'
git config --global mergetool.prompt false
```

### Paso 1.3: Configurar VS Code como difftool (opcional)

```bash
# EJERCICIO: Configurar difftool
# ¿QUE HACE?: Usa VS Code para ver diferencias
# ¿POR QUE?: Consistencia en herramientas
# ¿PARA QUE SIRVE?: Ver diffs visualmente

git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
```

### Paso 1.4: Verificar configuracion

```bash
# EJERCICIO: Confirmar configuracion
# ¿QUE HACE?: Muestra la configuracion aplicada
# ¿POR QUE?: Verificar que todo esta correcto
# ¿PARA QUE SIRVE?: Validacion

git config --global --list | grep -E "(merge|diff)"
```

### Resultado Esperado

```
merge.tool=vscode
mergetool.vscode.cmd=code --wait $MERGED
mergetool.prompt=false
diff.tool=vscode
difftool.vscode.cmd=code --wait --diff $LOCAL $REMOTE
```

---

## Parte 2: Crear Escenario de Conflicto

### Paso 2.1: Preparar repositorio

```bash
# EJERCICIO: Crear proyecto de prueba
mkdir ejercicio-vscode-mergetool
cd ejercicio-vscode-mergetool
git init

# Crear archivo con contenido sustancial
cat > app.js << 'EOF'
// Aplicacion principal
class App {
  constructor() {
    this.name = "Mi App";
    this.version = "1.0.0";
    this.config = {
      debug: false,
      theme: "default",
      language: "es"
    };
  }

  init() {
    console.log(`Iniciando ${this.name} v${this.version}`);
    this.loadConfig();
  }

  loadConfig() {
    // Cargar configuracion
    console.log("Configuracion cargada");
  }

  run() {
    this.init();
    console.log("Aplicacion ejecutandose");
  }
}

const app = new App();
app.run();
EOF

git add app.js
git commit -m "feat: crear aplicacion base"
```

### Paso 2.2: Crear branch y modificar

```bash
# EJERCICIO: Branch con cambios significativos
git checkout -b feature/refactor

cat > app.js << 'EOF'
// Aplicacion principal - Refactorizada
class App {
  constructor(options = {}) {
    this.name = options.name || "Mi App";
    this.version = "2.0.0";
    this.config = {
      debug: options.debug || false,
      theme: options.theme || "dark",
      language: options.language || "es",
      logging: true
    };
  }

  init() {
    if (this.config.debug) {
      console.log(`[DEBUG] Iniciando ${this.name} v${this.version}`);
    }
    this.loadConfig();
    this.validateConfig();
  }

  loadConfig() {
    // Cargar configuracion desde archivo
    console.log("Configuracion cargada desde archivo");
  }

  validateConfig() {
    // Validar configuracion
    if (!this.config.theme) {
      throw new Error("Theme es requerido");
    }
  }

  run() {
    this.init();
    console.log("Aplicacion ejecutandose en modo " + this.config.theme);
  }
}

const app = new App({ debug: true });
app.run();
EOF

git add app.js
git commit -m "refactor: mejorar clase App con opciones"
```

### Paso 2.3: Modificar en main

```bash
# EJERCICIO: Volver a main y modificar
git checkout main

cat > app.js << 'EOF'
// Aplicacion principal - Con logging
class App {
  constructor() {
    this.name = "Mi App";
    this.version = "1.5.0";
    this.config = {
      debug: true,
      theme: "light",
      language: "es"
    };
    this.logger = console;
  }

  init() {
    this.logger.log(`Iniciando ${this.name} v${this.version}`);
    this.loadConfig();
    this.setupLogger();
  }

  loadConfig() {
    // Cargar configuracion del entorno
    this.logger.log("Configuracion cargada del entorno");
  }

  setupLogger() {
    // Configurar sistema de logging
    this.logger.log("Logger configurado");
  }

  run() {
    this.init();
    this.logger.log("Aplicacion ejecutandose correctamente");
  }
}

const app = new App();
app.run();
EOF

git add app.js
git commit -m "feat: agregar sistema de logging"
```

---

## Parte 3: Provocar Conflicto

### Paso 3.1: Intentar merge

```bash
# EJERCICIO: Merge que causara conflicto
# ¿QUE HACE?: Intenta combinar los cambios
# ¿POR QUE?: Muchas lineas modificadas en ambos
# ¿PARA QUE SIRVE?: Escenario complejo para VS Code

git merge feature/refactor
```

### Resultado Esperado

```
Auto-merging app.js
CONFLICT (content): Merge conflict in app.js
Automatic merge failed; fix conflicts and then commit the result.
```

---

## Parte 4: Resolver con VS Code (Metodo 1 - Manual)

### Paso 4.1: Abrir archivo directamente

```bash
# EJERCICIO: Abrir archivo en VS Code
# ¿QUE HACE?: Abre el archivo con marcadores de conflicto
# ¿POR QUE?: VS Code detecta y muestra opciones visuales
# ¿PARA QUE SIRVE?: Resolucion visual

code app.js
```

### Paso 4.2: Usar interfaz de VS Code

En VS Code veras:

```
Accept Current Change | Accept Incoming Change | Accept Both Changes | Compare Changes
```

**Opciones disponibles:**

| Boton | Accion | Equivalente |
|-------|--------|-------------|
| Accept Current Change | Mantiene tu version (HEAD) | `--ours` |
| Accept Incoming Change | Mantiene version entrante | `--theirs` |
| Accept Both Changes | Conserva ambos bloques | Manual |
| Compare Changes | Muestra lado a lado | `git diff` |

### Paso 4.3: Resolver el conflicto

**Para este ejercicio:**

1. Haz clic en **"Compare Changes"** para ver las diferencias
2. Analiza que quieres conservar de cada version
3. Haz clic en la opcion apropiada para cada conflicto
4. O edita manualmente combinando lo mejor de ambos
5. Guarda el archivo (Ctrl+S / Cmd+S)
6. Cierra VS Code

### Paso 4.4: Completar merge

```bash
# EJERCICIO: Marcar como resuelto
# ¿QUE HACE?: Agrega archivo y completa merge
# ¿POR QUE?: Finalizar el proceso
# ¿PARA QUE SIRVE?: Commit del merge

git add app.js
git commit -m "Merge feature/refactor: combinar mejoras con logging"
```

---

## Parte 5: Resolver con Mergetool (Metodo 2)

### Paso 5.1: Recrear conflicto para practicar

```bash
# EJERCICIO: Deshacer merge para practicar con mergetool
git reset --hard HEAD~1

# Intentar merge de nuevo
git merge feature/refactor
```

### Paso 5.2: Usar git mergetool

```bash
# EJERCICIO: Invocar mergetool
# ¿QUE HACE?: Abre VS Code automaticamente
# ¿POR QUE?: Usa la configuracion que establecimos
# ¿PARA QUE SIRVE?: Workflow alternativo

git mergetool
```

### Comportamiento

1. Git abre VS Code con el archivo en conflicto
2. Resuelve los conflictos usando la interfaz de VS Code
3. Guarda el archivo
4. Cierra VS Code
5. Git detecta que el archivo fue modificado

### Paso 5.3: Confirmar resolucion

```bash
# Git preguntara si se resolvio correctamente
# (solo si mergetool.prompt=true)

# Verificar estado
git status
```

### Paso 5.4: Completar

```bash
# EJERCICIO: Finalizar merge
git commit -m "Merge feature/refactor: usando mergetool"
```

---

## Parte 6: Source Control de VS Code

### Paso 6.1: Recrear conflicto

```bash
git reset --hard HEAD~1
git merge feature/refactor
```

### Paso 6.2: Usar panel Source Control

1. Abre VS Code: `code .`
2. Ve al panel **Source Control** (icono de branch en sidebar)
3. Veras "Merge Changes" con archivos en conflicto
4. Haz clic en el archivo `app.js`
5. VS Code abre vista de 3 paneles:
   - Izquierda: Tu version (Current)
   - Derecha: Version entrante (Incoming)
   - Abajo: Resultado

### Paso 6.3: Merge Editor de VS Code

En VS Code 1.69+ hay un **Merge Editor** dedicado:

1. Clic derecho en archivo con conflicto
2. Selecciona **"Open in Merge Editor"**
3. Usa checkboxes para elegir que incluir
4. Ve el resultado en tiempo real
5. Clic en **"Complete Merge"**

### Paso 6.4: Finalizar desde VS Code

1. En Source Control, haz clic en **"+"** junto a app.js (stage)
2. Escribe mensaje de commit
3. Clic en checkmark para commit

---

## Parte 7: Comandos Rapidos

### Resolver con ours/theirs desde terminal

```bash
# Si quieres aceptar TU version completamente
git checkout --ours app.js
git add app.js

# Si quieres aceptar version ENTRANTE completamente
git checkout --theirs app.js
git add app.js
```

### Ver diferencias con difftool

```bash
# Ver diferencias usando VS Code
git difftool HEAD feature/refactor
```

---

## Configuraciones Adicionales de VS Code

### settings.json de VS Code

```json
{
  "git.mergeEditor": true,
  "merge-conflict.autoNavigateNextConflict.enabled": true,
  "merge-conflict.diffViewPosition": "Below"
}
```

### Atajos de Teclado Utiles

| Atajo | Accion |
|-------|--------|
| `Ctrl+Shift+G` | Abrir Source Control |
| `F7` | Siguiente diferencia |
| `Shift+F7` | Diferencia anterior |

---

## Checklist de Completado

- [ ] Configure VS Code como mergetool
- [ ] Configure VS Code como difftool
- [ ] Cree escenario de conflicto
- [ ] Resolvi usando apertura directa de archivo
- [ ] Resolvi usando git mergetool
- [ ] Explore el panel Source Control
- [ ] Probe el Merge Editor (si disponible)

---

## Comparativa de Metodos

| Metodo | Pros | Contras |
|--------|------|---------|
| Terminal + Editor | Control total | Mas pasos |
| `git mergetool` | Automatizado | Menos flexible |
| Source Control | Visual, integrado | Requiere VS Code |
| Merge Editor | Muy visual | Solo VS Code nuevo |

---

## Preguntas de Reflexion

1. ¿Cual metodo prefieres? ¿Por que?
2. ¿En que situaciones usarias cada metodo?
3. ¿Que ventajas tiene la resolucion visual sobre terminal?
4. ¿Configurarias otra herramienta diferente a VS Code?

---

*Ejercicio 03 de 04 | Week 04: Merge Conflicts*
