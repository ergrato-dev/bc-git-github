# 🌍 Ejercicio 01: Configuración de Environments

## 📋 Información del Ejercicio

| Campo | Detalle |
|-------|---------|
| **Duración** | 35 minutos |
| **Dificultad** | Intermedia |
| **Prerrequisitos** | Lección 02 - GitHub Environments |
| **Objetivos** | Crear y configurar environments con secrets y variables |

---

## 🎯 Objetivos

Al completar este ejercicio, habrás:

- [ ] Creado 3 environments: development, staging, production
- [ ] Configurado secrets específicos por environment
- [ ] Configurado variables por environment
- [ ] Implementado un workflow que use los environments

---

## 📝 Escenario

Tu equipo necesita configurar un pipeline de deployment con tres etapas. Cada environment tendrá sus propias credenciales y configuraciones.

---

## 🚀 Instrucciones

### Parte 1: Crear el Repositorio (5 min)

```bash
# EJERCICIO: Crear repositorio para environments
# ¿QUÉ VAMOS A HACER?: Inicializar un repo con estructura básica
# ¿POR QUÉ LO HACEMOS?: Necesitamos un repo para configurar environments
# ¿PARA QUÉ SIRVE?: Base para practicar configuración de environments

# Paso 1: Crear directorio del proyecto
mkdir environments-demo
cd environments-demo

# Paso 2: Inicializar Git
git init

# Paso 3: Crear archivo de aplicación simulada
cat > app.js << 'EOF'
// Simulación de aplicación
const config = {
  env: process.env.APP_ENV || 'unknown',
  apiKey: process.env.API_KEY ? '***configured***' : 'not-set',
  dbUrl: process.env.DATABASE_URL ? '***configured***' : 'not-set'
};

console.log('Application Configuration:');
console.log(JSON.stringify(config, null, 2));
EOF

# Paso 4: Crear directorio de workflows
mkdir -p .github/workflows

# Paso 5: Commit inicial
git add .
git commit -m "feat: initial project setup"
```

### Parte 2: Crear Environments en GitHub (10 min)

#### 2.1 Crear Environment "development"

1. Ve a tu repositorio en GitHub
2. **Settings** → **Environments** → **New environment**
3. Name: `development`
4. Click **Configure environment**

**Agregar Secrets:**
| Secret | Valor (simulado) |
|--------|------------------|
| `API_KEY` | `dev_key_abc123` |
| `DATABASE_URL` | `postgres://dev:pass@localhost:5432/dev_db` |

**Agregar Variables:**
| Variable | Valor |
|----------|-------|
| `APP_ENV` | `development` |
| `LOG_LEVEL` | `debug` |
| `FEATURE_NEW_UI` | `true` |

#### 2.2 Crear Environment "staging"

1. **Settings** → **Environments** → **New environment**
2. Name: `staging`
3. Click **Configure environment**

**Agregar Secrets:**
| Secret | Valor (simulado) |
|--------|------------------|
| `API_KEY` | `stg_key_def456` |
| `DATABASE_URL` | `postgres://staging:pass@staging.db:5432/staging_db` |

**Agregar Variables:**
| Variable | Valor |
|----------|-------|
| `APP_ENV` | `staging` |
| `LOG_LEVEL` | `info` |
| `FEATURE_NEW_UI` | `true` |

#### 2.3 Crear Environment "production"

1. **Settings** → **Environments** → **New environment**
2. Name: `production`
3. Click **Configure environment**

**Agregar Secrets:**
| Secret | Valor (simulado) |
|--------|------------------|
| `API_KEY` | `prod_key_ghi789` |
| `DATABASE_URL` | `postgres://prod:pass@prod.db:5432/prod_db` |

**Agregar Variables:**
| Variable | Valor |
|----------|-------|
| `APP_ENV` | `production` |
| `LOG_LEVEL` | `warn` |
| `FEATURE_NEW_UI` | `false` |

### Parte 3: Crear Workflow Multi-Environment (15 min)

```bash
# EJERCICIO: Crear workflow que deploya a los 3 environments
# ¿QUÉ VAMOS A HACER?: Workflow con jobs para cada environment
# ¿POR QUÉ LO HACEMOS?: Demostrar cómo los secrets/variables cambian por env
# ¿PARA QUÉ SIRVE?: Entender el flujo de deployment multi-stage
```

Crea el archivo `.github/workflows/deploy.yml`:

```yaml
# ¿QUÉ HACE?: Pipeline de deployment a múltiples environments
# ¿POR QUÉ?: Cada environment tiene su propia configuración
# ¿PARA QUÉ SIRVE?: Demostrar uso de secrets y variables por environment

name: Multi-Environment Deploy

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  # ═══════════════════════════════════════════════════════════
  # JOB 1: BUILD
  # ═══════════════════════════════════════════════════════════
  build:
    name: 🔨 Build
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Build info
        run: |
          echo "📦 Building commit: ${{ github.sha }}"
          echo "🌿 Branch: ${{ github.ref_name }}"
      
      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: app-build
          path: app.js

  # ═══════════════════════════════════════════════════════════
  # JOB 2: DEPLOY TO DEVELOPMENT
  # ═══════════════════════════════════════════════════════════
  deploy-dev:
    name: 🚀 Deploy Development
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: development
      url: https://dev.example.com
    
    steps:
      - name: Download artifact
        uses: actions/download-artifact@v4
        with:
          name: app-build
      
      - name: Show environment config
        env:
          # Variables (no sensibles, visibles en logs)
          APP_ENV: ${{ vars.APP_ENV }}
          LOG_LEVEL: ${{ vars.LOG_LEVEL }}
          FEATURE_NEW_UI: ${{ vars.FEATURE_NEW_UI }}
          # Secrets (enmascarados en logs)
          API_KEY: ${{ secrets.API_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: |
          echo "════════════════════════════════════════"
          echo "🌍 DEVELOPMENT ENVIRONMENT"
          echo "════════════════════════════════════════"
          echo ""
          echo "📋 Variables (públicas):"
          echo "   APP_ENV: $APP_ENV"
          echo "   LOG_LEVEL: $LOG_LEVEL"
          echo "   FEATURE_NEW_UI: $FEATURE_NEW_UI"
          echo ""
          echo "🔐 Secrets (enmascarados):"
          echo "   API_KEY configured: $([ -n "$API_KEY" ] && echo 'yes' || echo 'no')"
          echo "   DATABASE_URL configured: $([ -n "$DATABASE_URL" ] && echo 'yes' || echo 'no')"
          echo ""
          echo "▶️ Simulating deploy to development..."
          node app.js
      
      - name: Verify deployment
        run: |
          echo "✅ Development deployment complete"

  # ═══════════════════════════════════════════════════════════
  # JOB 3: DEPLOY TO STAGING
  # ═══════════════════════════════════════════════════════════
  deploy-staging:
    name: 🚀 Deploy Staging
    needs: deploy-dev
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.example.com
    
    steps:
      - name: Download artifact
        uses: actions/download-artifact@v4
        with:
          name: app-build
      
      - name: Show environment config
        env:
          APP_ENV: ${{ vars.APP_ENV }}
          LOG_LEVEL: ${{ vars.LOG_LEVEL }}
          FEATURE_NEW_UI: ${{ vars.FEATURE_NEW_UI }}
          API_KEY: ${{ secrets.API_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: |
          echo "════════════════════════════════════════"
          echo "🎭 STAGING ENVIRONMENT"
          echo "════════════════════════════════════════"
          echo ""
          echo "📋 Variables (públicas):"
          echo "   APP_ENV: $APP_ENV"
          echo "   LOG_LEVEL: $LOG_LEVEL"
          echo "   FEATURE_NEW_UI: $FEATURE_NEW_UI"
          echo ""
          echo "🔐 Secrets (enmascarados):"
          echo "   API_KEY configured: $([ -n "$API_KEY" ] && echo 'yes' || echo 'no')"
          echo "   DATABASE_URL configured: $([ -n "$DATABASE_URL" ] && echo 'yes' || echo 'no')"
          echo ""
          echo "▶️ Simulating deploy to staging..."
          node app.js
      
      - name: Run integration tests
        run: |
          echo "🧪 Running integration tests..."
          sleep 2
          echo "✅ All tests passed"

  # ═══════════════════════════════════════════════════════════
  # JOB 4: DEPLOY TO PRODUCTION
  # ═══════════════════════════════════════════════════════════
  deploy-prod:
    name: 🚀 Deploy Production
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    
    steps:
      - name: Download artifact
        uses: actions/download-artifact@v4
        with:
          name: app-build
      
      - name: Show environment config
        env:
          APP_ENV: ${{ vars.APP_ENV }}
          LOG_LEVEL: ${{ vars.LOG_LEVEL }}
          FEATURE_NEW_UI: ${{ vars.FEATURE_NEW_UI }}
          API_KEY: ${{ secrets.API_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: |
          echo "════════════════════════════════════════"
          echo "🏭 PRODUCTION ENVIRONMENT"
          echo "════════════════════════════════════════"
          echo ""
          echo "📋 Variables (públicas):"
          echo "   APP_ENV: $APP_ENV"
          echo "   LOG_LEVEL: $LOG_LEVEL"
          echo "   FEATURE_NEW_UI: $FEATURE_NEW_UI"
          echo ""
          echo "🔐 Secrets (enmascarados):"
          echo "   API_KEY configured: $([ -n "$API_KEY" ] && echo 'yes' || echo 'no')"
          echo "   DATABASE_URL configured: $([ -n "$DATABASE_URL" ] && echo 'yes' || echo 'no')"
          echo ""
          echo "▶️ Deploying to production..."
          node app.js
      
      - name: Production smoke test
        run: |
          echo "🔥 Running smoke tests..."
          sleep 2
          echo "✅ Production deployment verified"
```

### Parte 4: Ejecutar y Verificar (5 min)

```bash
# EJERCICIO: Push y verificar el workflow
# ¿QUÉ VAMOS A HACER?: Subir cambios y ver el pipeline ejecutarse
# ¿POR QUÉ LO HACEMOS?: Verificar que los environments funcionan
# ¿PARA QUÉ SIRVE?: Confirmar que cada job usa sus propios secrets/variables

# Paso 1: Agregar remote (reemplaza con tu repo)
git remote add origin https://github.com/TU-USUARIO/environments-demo.git

# Paso 2: Push
git add .
git commit -m "feat: add multi-environment deploy workflow"
git push -u origin main

# Paso 3: Ir a Actions en GitHub y observar:
# - Cada job muestra su environment
# - Las variables son diferentes por environment
# - Los secrets están enmascarados pero configurados
```

---

## ✅ Verificación

### Checklist de Completado

- [ ] Los 3 environments existen en Settings → Environments
- [ ] Cada environment tiene sus propios secrets
- [ ] Cada environment tiene sus propias variables
- [ ] El workflow ejecuta los 3 deployments en secuencia
- [ ] Las variables muestran valores diferentes por environment
- [ ] Los secrets muestran "***" en los logs (enmascarados)

### Output Esperado

En cada job deberías ver algo como:

```
════════════════════════════════════════
🌍 DEVELOPMENT ENVIRONMENT
════════════════════════════════════════

📋 Variables (públicas):
   APP_ENV: development
   LOG_LEVEL: debug
   FEATURE_NEW_UI: true

🔐 Secrets (enmascarados):
   API_KEY configured: yes
   DATABASE_URL configured: yes
```

---

## 🎯 Desafío Extra

1. Agrega un 4º environment llamado `preview` para Pull Requests
2. Modifica el workflow para que `preview` use una URL dinámica
3. Agrega una variable `VERSION` que muestre el SHA del commit

---

## 📚 Recursos

- [GitHub Docs: Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
- [GitHub Docs: Environment Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-an-environment)

---

**Siguiente ejercicio**: [02 - Protection Rules](../ejercicio-02-protection-rules/README.md)
