# Ejercicio 04: Abortar y Reintentar Merge

## Objetivo

Aprender a cancelar un merge en progreso y manejar situaciones donde necesitas reintentar con diferente estrategia.

**Duracion estimada:** 35 minutos

---

## Requisitos Previos

- Completar Ejercicios 01-03
- Entender proceso basico de merge conflicts

---

## Escenario

A veces empiezas a resolver un conflicto y te das cuenta de que:
- Necesitas mas informacion
- Elegiste la estrategia incorrecta
- Quieres consultar con el equipo primero

En estos casos, necesitas **abortar** el merge y volver al estado anterior.

---

## Parte 1: Preparar Escenario

### Paso 1.1: Crear repositorio

```bash
# EJERCICIO: Setup inicial
mkdir ejercicio-abortar-merge
cd ejercicio-abortar-merge
git init

# Crear archivo complejo
cat > database.js << 'EOF'
// Configuracion de base de datos
const dbConfig = {
  host: "localhost",
  port: 5432,
  database: "app_dev",
  username: "admin",
  password: "secret123",
  pool: {
    min: 2,
    max: 10
  },
  ssl: false
};

function connect() {
  console.log(`Conectando a ${dbConfig.host}:${dbConfig.port}`);
  return dbConfig;
}

module.exports = { dbConfig, connect };
EOF

git add database.js
git commit -m "feat: configuracion inicial de database"
```

### Paso 1.2: Crear branch con cambios significativos

```bash
# EJERCICIO: Branch con configuracion de produccion
git checkout -b feature/production-config

cat > database.js << 'EOF'
// Configuracion de base de datos - Produccion
const dbConfig = {
  host: process.env.DB_HOST || "db.production.com",
  port: parseInt(process.env.DB_PORT) || 5432,
  database: process.env.DB_NAME || "app_prod",
  username: process.env.DB_USER || "app_user",
  password: process.env.DB_PASS,
  pool: {
    min: 5,
    max: 50,
    idleTimeout: 30000
  },
  ssl: {
    rejectUnauthorized: true,
    ca: process.env.DB_CA_CERT
  },
  logging: false
};

function connect() {
  if (!dbConfig.password) {
    throw new Error("DB_PASS environment variable required");
  }
  console.log(`Conectando a ${dbConfig.host}:${dbConfig.port}/${dbConfig.database}`);
  return dbConfig;
}

function disconnect() {
  console.log("Desconectando de la base de datos");
}

module.exports = { dbConfig, connect, disconnect };
EOF

git add database.js
git commit -m "feat: configuracion de produccion con variables de entorno"
```

### Paso 1.3: Modificar en main

```bash
# EJERCICIO: Volver a main con cambios diferentes
git checkout main

cat > database.js << 'EOF'
// Configuracion de base de datos - Development
const dbConfig = {
  host: "localhost",
  port: 5432,
  database: "app_development",
  username: "dev_user",
  password: "dev_password",
  pool: {
    min: 1,
    max: 5,
    acquireTimeout: 60000
  },
  ssl: false,
  debug: true
};

function connect() {
  console.log("[DEV] Conectando a " + dbConfig.host);
  console.log("[DEV] Database: " + dbConfig.database);
  return dbConfig;
}

function testConnection() {
  console.log("[DEV] Testing connection...");
  return true;
}

module.exports = { dbConfig, connect, testConnection };
EOF

git add database.js
git commit -m "feat: configuracion de desarrollo mejorada"
```

---

## Parte 2: Provocar Conflicto Complejo

### Paso 2.1: Intentar merge

```bash
# EJERCICIO: Merge que generara conflictos complejos
git merge feature/production-config
```

### Resultado

```
CONFLICT (content): Merge conflict in database.js
Automatic merge failed; fix conflicts and then commit the result.
```

### Paso 2.2: Ver el desastre

```bash
# EJERCICIO: Ver la magnitud del conflicto
cat database.js
```

Veras un archivo lleno de marcadores de conflicto, dificil de resolver rapidamente.

---

## Parte 3: Abortar el Merge

### Paso 3.1: Verificar estado actual

```bash
# EJERCICIO: Ver estado durante merge
# ¿QUE HACE?: Muestra que estamos en medio de un merge
# ¿POR QUE?: Confirmar situacion antes de abortar
# ¿PARA QUE SIRVE?: Entender el estado

git status
```

### Resultado

```
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   database.js
```

### Paso 3.2: Abortar el merge

```bash
# EJERCICIO: Cancelar el merge
# ¿QUE HACE?: Cancela el merge y vuelve al estado anterior
# ¿POR QUE?: El conflicto es muy complejo para resolver ahora
# ¿PARA QUE SIRVE?: Volver a un estado limpio

git merge --abort
```

### Paso 3.3: Verificar estado limpio

```bash
# EJERCICIO: Confirmar que volvimos al estado anterior
# ¿QUE HACE?: Muestra estado del repositorio
# ¿POR QUE?: Verificar que abort funciono
# ¿PARA QUE SIRVE?: Confirmar estado limpio

git status
```

### Resultado

```
On branch main
nothing to commit, working tree clean
```

### Paso 3.4: Verificar archivo

```bash
# EJERCICIO: Ver que el archivo volvio a su estado original
cat database.js
```

El archivo debe mostrar la version de main, sin marcadores de conflicto.

---

## Parte 4: Estrategias de Reintento

### Estrategia A: Merge favoreciendo nuestra version

```bash
# EJERCICIO: Merge con estrategia -X ours
# ¿QUE HACE?: En conflictos automaticos, prefiere nuestra version
# ¿POR QUE?: Queremos mantener configuracion de desarrollo
# ¿PARA QUE SIRVE?: Reducir conflictos manuales

git merge -X ours feature/production-config
```

**Nota:** `-X ours` NO es lo mismo que `--ours`. 
- `-X ours`: Resuelve conflictos automaticamente con nuestra version
- `--ours`: Ignora completamente los cambios entrantes

### Paso 4.1: Verificar resultado

```bash
# Ver si hubo conflictos o se resolvio automaticamente
git status

# Ver el archivo resultante
cat database.js
```

### Paso 4.2: Abortar si necesario

```bash
# Si el resultado no es lo esperado
git merge --abort
```

### Estrategia B: Merge favoreciendo version entrante

```bash
# EJERCICIO: Merge con estrategia -X theirs
# ¿QUE HACE?: En conflictos, prefiere version entrante
# ¿POR QUE?: Queremos adoptar configuracion de produccion
# ¿PARA QUE SIRVE?: Priorizar cambios del feature branch

git merge -X theirs feature/production-config
```

### Estrategia C: Merge manual con preparacion

```bash
# 1. Primero, ver las diferencias
git diff main feature/production-config

# 2. Entender que cambio
git log --oneline main..feature/production-config

# 3. Ahora si, merge con mejor preparacion
git merge feature/production-config
```

---

## Parte 5: Reset Durante Merge Incompleto

### Paso 5.1: Provocar conflicto de nuevo

```bash
# Asegurar estado limpio
git merge --abort 2>/dev/null || true

# Intentar merge
git merge feature/production-config
```

### Paso 5.2: Empezar a resolver (parcialmente)

```bash
# Hacer cambios parciales
echo "// Parcialmente resuelto" > database.js
git add database.js
```

### Paso 5.3: Cambiar de opinion - usar reset

```bash
# EJERCICIO: Reset durante merge
# ¿QUE HACE?: Cancela merge incluso con cambios staged
# ¿POR QUE?: Abort no funciona si ya hiciste git add
# ¿PARA QUE SIRVE?: Escape de emergencia

git reset --hard HEAD
```

### Paso 5.4: Verificar

```bash
git status
cat database.js
```

---

## Parte 6: Situaciones Especiales

### Caso 1: Conflicto en merge ya commiteado

```bash
# Si ya hiciste commit del merge pero quieres deshacerlo
# (CUIDADO: solo si no has hecho push)

# Volver al commit anterior al merge
git reset --hard HEAD~1
```

### Caso 2: Ver estado del merge en progreso

```bash
# Durante un merge con conflictos
git status

# Ver que branches estan involucrados
cat .git/MERGE_HEAD  # Muestra commit del branch entrante

# Ver mensaje de merge preparado
cat .git/MERGE_MSG
```

### Caso 3: Continuar merge despues de pausa

```bash
# Si dejaste un merge a medias y quieres continuar
git status  # Ver donde quedaste

# Resolver archivos pendientes
git add archivo-resuelto.js

# Continuar
git commit  # Usara el mensaje de merge preparado
```

---

## Parte 7: Practica de Recuperacion

### Ejercicio de recuperacion

```bash
# 1. Asegurar estado limpio
git merge --abort 2>/dev/null || git reset --hard HEAD

# 2. Provocar conflicto
git merge feature/production-config

# 3. Verificar estado
git status

# 4. DECISION: ¿Abortar o resolver?

# Opcion A: Abortar
git merge --abort

# Opcion B: Resolver rapido con estrategia
git checkout --ours database.js  # Tu version
git add database.js
git commit -m "Merge: mantener config de desarrollo"

# Opcion C: Resolver rapido con version entrante
git checkout --theirs database.js  # Version entrante
git add database.js
git commit -m "Merge: adoptar config de produccion"
```

---

## Comandos de Emergencia

| Situacion | Comando |
|-----------|---------|
| Cancelar merge en progreso | `git merge --abort` |
| Reset duro durante merge | `git reset --hard HEAD` |
| Deshacer merge commiteado | `git reset --hard HEAD~1` |
| Ver estado del merge | `git status` |
| Ver branch entrante | `cat .git/MERGE_HEAD` |

---

## Checklist de Completado

- [ ] Cree escenario con conflicto complejo
- [ ] Provoque el conflicto con merge
- [ ] Use `git merge --abort` para cancelar
- [ ] Verifique que el repositorio volvio al estado limpio
- [ ] Probe merge con `-X ours`
- [ ] Probe merge con `-X theirs`
- [ ] Practique `git reset --hard HEAD` durante merge
- [ ] Entendi cuando usar cada estrategia

---

## Diagrama de Decisiones

```
Merge con conflicto detectado
            |
            v
    ¿Puedo resolverlo ahora?
           / \
         Si   No
         |     |
         v     v
    Resolver  ¿Necesito consultar?
    manual         / \
         |       Si   No
         v        |    |
     Commit    Abort  ¿Puedo usar estrategia?
                |          / \
                v        Si   No
           Consultar      |    |
           equipo         v    v
                |     Merge   Abort
                |     -X ours/theirs
                v         |
           Reintentar  Verificar
                       resultado
```

---

## Preguntas de Reflexion

1. ¿En que situaciones usarias `git merge --abort`?
2. ¿Cual es la diferencia entre `-X ours` y `--ours`?
3. ¿Que pasa si haces `git reset --hard` durante un merge?
4. ¿Como comunicarias al equipo que abortaste un merge?

---

## Limpieza

```bash
cd ..
rm -rf ejercicio-abortar-merge
```

---

*Ejercicio 04 de 04 | Week 04: Merge Conflicts*
