# 🧪 Ejercicio 02: Caching de Dependencias

## 🎯 Objetivo

Implementar estrategias de caching para optimizar tiempos de ejecución de pipelines, reduciendo el tiempo de instalación de dependencias.

---

## 📋 Información del Ejercicio

| Aspecto | Detalle |
|---------|---------|
| **Duración** | 35 minutos |
| **Dificultad** | Intermedia |
| **Requisitos** | Ejercicio 01 completado |
| **Temas** | Cache, cache keys, restore keys, setup-node cache |

---

## 📚 Conceptos Previos

- [x] Qué es el caching en CI/CD
- [x] Por qué es importante cachear dependencias
- [x] Diferencia entre cache hit y miss
- [x] Cache keys y restore keys

---

## 🎬 Escenario

Tu pipeline CI del ejercicio anterior tarda ~3 minutos porque `npm install` descarga las dependencias en cada ejecución. Tu tarea es:

1. **Implementar caching** de node_modules
2. **Comparar tiempos** antes y después
3. **Configurar cache keys** dinámicas

---

## 📊 Comparativa de Tiempos

| Escenario | npm install | Total Pipeline |
|-----------|-------------|----------------|
| **Sin cache** | ~2-3 min | ~5-6 min |
| **Con cache hit** | ~5-10 seg | ~1-2 min |
| **Ahorro** | ~95% | ~70% |

---

## 🚀 Instrucciones

### Paso 1: Entender el Problema (5 min)

Observa el workflow actual sin cache:

```yaml
# Cada job descarga dependencias desde cero
jobs:
  lint:
    steps:
      - run: npm ci  # ~2 min (descarga 500MB)
  
  test:
    steps:
      - run: npm ci  # ~2 min (descarga otra vez)
  
  build:
    steps:
      - run: npm ci  # ~2 min (descarga otra vez)
```

**Problema:** 3 jobs × 2 min = 6 minutos solo en `npm install`

### Paso 2: Opción A - Cache Built-in de setup-node (Recomendado) (10 min)

La forma más simple es usar el cache integrado de `actions/setup-node`:

**Archivo: `.github/workflows/ci-cached.yml`**

```yaml
# =============================================================================
# Pipeline CI con Cache Built-in
# =============================================================================
# ¿QUÉ HACE?: Usa cache automático de setup-node
# ¿POR QUÉ?: Es la forma más simple y efectiva
# ¿PARA QUÉ?: Reducir tiempo de npm install de minutos a segundos
# =============================================================================

name: CI with Built-in Cache

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  lint:
    name: 🔍 Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      # ¿QUÉ?: Configura Node.js CON cache habilitado
      # ¿POR QUÉ?: El parámetro 'cache: npm' activa caching automático
      # ¿PARA QUÉ?: npm ci usará cache si package-lock.json no cambió
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'  # 👈 Esta línea activa el cache
      
      - name: Install dependencies
        run: npm ci
        # Primera vez: ~2 min (descarga + guarda cache)
        # Siguientes: ~5 seg (usa cache)
      
      - name: Run ESLint
        run: npm run lint

  test:
    name: 🧪 Test
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'  # 👈 Reutiliza el mismo cache
      
      - run: npm ci
      - run: npm test

  build:
    name: 🏗️ Build
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'  # 👈 Reutiliza el mismo cache
      
      - run: npm ci
      - run: npm run build
```

### Paso 3: Opción B - Cache Manual con actions/cache (10 min)

Para más control, puedes usar `actions/cache` directamente:

```yaml
# =============================================================================
# Pipeline CI con Cache Manual
# =============================================================================
# ¿QUÉ HACE?: Control completo sobre qué cachear y cuándo
# ¿POR QUÉ?: Permite configurar restore-keys y rutas personalizadas
# ¿PARA QUÉ?: Casos avanzados donde built-in no es suficiente
# =============================================================================

name: CI with Manual Cache

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  lint:
    name: 🔍 Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          # Sin cache aquí, lo manejamos manualmente
      
      # ¿QUÉ?: Configurar cache manual de node_modules
      # ¿POR QUÉ?: Más control sobre cache key y restore keys
      - name: Cache node modules
        id: cache-npm
        uses: actions/cache@v4
        with:
          # Qué cachear
          path: |
            node_modules
            ~/.npm
          # Key principal: cambia cuando cambia package-lock.json
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
          # Keys de fallback: usar cache parcial si hay similar
          restore-keys: |
            ${{ runner.os }}-node-
      
      # ¿QUÉ?: Instalar solo si no hay cache hit
      # ¿POR QUÉ?: Si hay cache exacto, no necesitamos npm ci
      - name: Install dependencies
        if: steps.cache-npm.outputs.cache-hit != 'true'
        run: npm ci
      
      - name: Run ESLint
        run: npm run lint
      
      # Mostrar info del cache
      - name: Cache info
        run: |
          echo "## 📦 Cache Info" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "- Cache hit: ${{ steps.cache-npm.outputs.cache-hit }}" >> $GITHUB_STEP_SUMMARY
          echo "- Key used: \`${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}\`" >> $GITHUB_STEP_SUMMARY
```

### Paso 4: Entender Cache Keys (5 min)

```yaml
# Anatomía de una cache key:
key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
      │              │            │
      │              │            └── Hash del lockfile
      │              │                (cambia si deps cambian)
      │              │
      │              └── Identificador del ecosistema
      │                  (separa caches de diferentes tools)
      │
      └── Sistema operativo
          (Linux vs Windows vs macOS tienen deps diferentes)

# Ejemplo de key generada:
# Linux-node-abc123def456...
```

### Paso 5: Restore Keys - Fallback (5 min)

```yaml
# Flujo de búsqueda de cache:
#
# 1. Busca key EXACTA: Linux-node-abc123
#    ¿Encontrado? → Cache hit ✅ (perfecto)
#
# 2. Si no, busca PREFIX: Linux-node-*
#    ¿Encontrado? → Cache parcial ✅ (útil pero ejecuta npm ci)
#
# 3. Si no, busca PREFIX: Linux-*
#    ¿Encontrado? → Cache muy parcial
#
# 4. Si no hay nada → Cache miss ❌ (descarga todo)

restore-keys: |
  ${{ runner.os }}-node-
  ${{ runner.os }}-
```

**Cuándo es útil el restore-key:**
- Agregaste 1 dependencia nueva
- Cache parcial tiene 99% de lo necesario
- npm ci solo descarga la nueva dependencia

### Paso 6: Verificar Funcionamiento (5 min)

```bash
# Push inicial - primer run guardará cache
git add .
git commit -m "feat: add caching to CI pipeline"
git push

# Espera a que termine...

# Segundo push - debe usar cache
echo "// test" >> src/calculator.js
git add .
git commit -m "test: verify cache is working"
git push
```

**En los logs de Actions:**

```
# Primera ejecución:
Cache not found for key: Linux-node-abc123
npm ci: Installing packages... (2 min)
Cache saved with key: Linux-node-abc123

# Segunda ejecución:
Cache restored from key: Linux-node-abc123  ← Cache hit!
npm ci: Already up to date (5 sec)
```

---

## ✅ Verificación

### Checklist

- [ ] Workflow con cache configurado
- [ ] Primera ejecución guarda el cache
- [ ] Segunda ejecución usa el cache (hit)
- [ ] Tiempo de npm ci reducido de minutos a segundos
- [ ] Step Summary muestra info del cache

### Métricas Esperadas

| Métrica | Sin Cache | Con Cache |
|---------|-----------|-----------|
| npm ci (lint) | ~120 seg | ~5 seg |
| npm ci (test) | ~120 seg | ~5 seg |
| npm ci (build) | ~120 seg | ~5 seg |
| **Total npm** | **~360 seg** | **~15 seg** |

---

## 🔧 Solución de Problemas

### Cache nunca hace hit

```yaml
# Verificar que package-lock.json existe
ls -la package-lock.json

# Si no existe, generarlo:
npm install
git add package-lock.json
git commit -m "add package-lock.json"
git push
```

### Cache key siempre diferente

```yaml
# Verificar que el path del hashFiles es correcto
hashFiles('**/package-lock.json')  # Busca en todo el repo
hashFiles('package-lock.json')      # Solo en raíz
```

### Cache demasiado viejo

```yaml
# Los caches expiran después de 7 días sin uso
# Para forzar nuevo cache, cambiar la key:
key: ${{ runner.os }}-node-v2-${{ hashFiles('**/package-lock.json') }}
#                         ^^^ Agregar versión
```

---

## 🎯 Desafíos Adicionales

### Desafío 1: Cache múltiple (npm + build)

```yaml
- name: Cache npm
  uses: actions/cache@v4
  with:
    path: node_modules
    key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}

- name: Cache build
  uses: actions/cache@v4
  with:
    path: dist
    key: ${{ runner.os }}-build-${{ github.sha }}
```

### Desafío 2: Cache con matrix

```yaml
strategy:
  matrix:
    node: [18, 20, 22]

steps:
  - uses: actions/setup-node@v4
    with:
      node-version: ${{ matrix.node }}
      cache: 'npm'
  # Cache key incluirá la versión de Node automáticamente
```

### Desafío 3: Medir ahorro de tiempo

```yaml
- name: Start timer
  run: echo "START=$(date +%s)" >> $GITHUB_ENV

- run: npm ci

- name: Report time
  run: |
    END=$(date +%s)
    DURATION=$((END - START))
    echo "npm ci took $DURATION seconds" >> $GITHUB_STEP_SUMMARY
```

---

## 📚 Recursos

- [Lección 03: Artifacts y Caching](../../1-teoria/03-artifacts-caching.md)
- [actions/cache documentation](https://github.com/actions/cache)
- [setup-node cache](https://github.com/actions/setup-node#caching-global-packages-data)

---

## 🔗 Navegación

| ⬅️ Anterior | 📚 Prácticas | ➡️ Siguiente |
|:-----------:|:------------:|:------------:|
| [Ejercicio 01](../ejercicio-01-pipeline-completo/README.md) | [README](../README.md) | [Ejercicio 03](../ejercicio-03-artifacts-jobs/README.md) |
