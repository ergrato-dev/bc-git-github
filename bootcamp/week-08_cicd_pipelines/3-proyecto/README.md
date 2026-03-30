# 🚀 Proyecto Semanal: Full CI/CD Pipeline

## 📋 Descripción

Construir un pipeline CI/CD completo para una aplicación web que incluya todas las fases: lint, test, build, y deploy a múltiples environments con aprobaciones.

---

## 🎯 Objetivos de Aprendizaje

Al completar este proyecto podrás:

- ✅ Diseñar pipelines CI/CD profesionales
- ✅ Implementar caching y artifacts para optimización
- ✅ Configurar environments con protecciones
- ✅ Manejar secrets de forma segura
- ✅ Crear deploys progresivos (staging → production)

---

## 📋 Información del Proyecto

| Aspecto | Detalle |
|---------|---------|
| **Duración** | 2 horas |
| **Modalidad** | Individual |
| **Dificultad** | ⭐⭐⭐ Avanzada |
| **Peso en evaluación** | 25 puntos |
| **Entrega** | Repositorio GitHub con workflow funcional |

---

## 🎬 Escenario

Eres el **DevOps Engineer** de una startup que lanza su primera aplicación web. Tu CEO necesita que configures un pipeline CI/CD que:

1. **Valide cada commit** con linting y tests
2. **Genere builds optimizados** listos para producción
3. **Despliegue automáticamente** a staging
4. **Requiera aprobación** para producción
5. **Notifique al equipo** del estado de cada deploy

---

## 📊 Arquitectura del Pipeline

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           FULL CI/CD PIPELINE                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  push/PR to main                                                            │
│       │                                                                     │
│       ▼                                                                     │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐                                 │
│  │  LINT   │───▶│  TEST   │───▶│  BUILD  │                                 │
│  │ ESLint  │    │  Jest   │    │ webpack │                                 │
│  └─────────┘    └─────────┘    └────┬────┘                                 │
│                                     │                                       │
│                              upload artifact                                │
│                                     │                                       │
│                                     ▼                                       │
│                    ┌────────────────────────────────┐                       │
│                    │         STAGING                │                       │
│                    │  • Auto deploy                 │                       │
│                    │  • Smoke tests                 │                       │
│                    │  • E2E tests                   │                       │
│                    └────────────────┬───────────────┘                       │
│                                     │                                       │
│                              ⏸️ Wait for approval                           │
│                                     │                                       │
│                                     ▼                                       │
│                    ┌────────────────────────────────┐                       │
│                    │        PRODUCTION              │                       │
│                    │  • Manual approval required    │                       │
│                    │  • Wait timer: 5 min           │                       │
│                    │  • Rollback ready              │                       │
│                    └────────────────────────────────┘                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 📁 Estructura del Proyecto

```text
mi-proyecto-cicd/
├── .github/
│   └── workflows/
│       └── cicd.yml              # 👈 Pipeline principal
├── src/
│   ├── index.js                  # Aplicación principal
│   └── utils.js                  # Funciones auxiliares
├── tests/
│   ├── index.test.js             # Tests unitarios
│   └── e2e.test.js               # Tests E2E (simulated)
├── .eslintrc.json                # Configuración ESLint
├── package.json                  # Dependencias y scripts
└── README.md                     # Documentación del proyecto
```

---

## 🚀 Requerimientos Funcionales

### RF01: Fase de CI (Integración Continua)

| ID | Requerimiento | Criterio de Aceptación |
|----|---------------|------------------------|
| RF01.1 | Job de Lint | ESLint ejecuta sin errores |
| RF01.2 | Job de Test | Jest ejecuta con 80%+ coverage |
| RF01.3 | Job de Build | Genera carpeta `dist/` con bundle |
| RF01.4 | Dependencias | Jobs usan `needs` correctamente |
| RF01.5 | Caching | npm dependencies cacheadas |

### RF02: Fase de CD (Entrega Continua)

| ID | Requerimiento | Criterio de Aceptación |
|----|---------------|------------------------|
| RF02.1 | Artifacts | Build subido como artifact |
| RF02.2 | Staging auto | Deploy sin intervención manual |
| RF02.3 | Smoke tests | Verificación post-deploy |
| RF02.4 | Production manual | Requiere 1+ approver |
| RF02.5 | Wait timer | 5 minutos antes de producción |

### RF03: Configuración de Seguridad

| ID | Requerimiento | Criterio de Aceptación |
|----|---------------|------------------------|
| RF03.1 | Repository secrets | DEPLOY_TOKEN configurado |
| RF03.2 | Environment secrets | URLs por environment |
| RF03.3 | Variables | APP_NAME, VERSION como vars |
| RF03.4 | GITHUB_TOKEN | Permisos mínimos necesarios |

---

## 📝 Instrucciones Detalladas

### Paso 1: Crear el Repositorio (15 min)

```bash
# Crear y configurar repositorio
mkdir mi-proyecto-cicd && cd mi-proyecto-cicd
git init
npm init -y

# Instalar dependencias
npm install --save-dev eslint jest

# Crear estructura
mkdir -p src tests .github/workflows
```

### Paso 2: Código de la Aplicación (10 min)

**`src/index.js`:**
```javascript
const { greet, calculate } = require('./utils');

function main() {
  console.log(greet('CI/CD'));
  console.log('Sum:', calculate.add(5, 3));
  console.log('Product:', calculate.multiply(4, 7));
}

module.exports = { main };

if (require.main === module) {
  main();
}
```

**`src/utils.js`:**
```javascript
const greet = (name) => `Hello, ${name}! Welcome to automated deployments.`;

const calculate = {
  add: (a, b) => a + b,
  subtract: (a, b) => a - b,
  multiply: (a, b) => a * b,
  divide: (a, b) => {
    if (b === 0) throw new Error('Division by zero');
    return a / b;
  }
};

module.exports = { greet, calculate };
```

### Paso 3: Tests (10 min)

**`tests/index.test.js`:**
```javascript
const { greet, calculate } = require('../src/utils');

describe('Utils', () => {
  describe('greet', () => {
    test('returns greeting with name', () => {
      expect(greet('World')).toContain('World');
    });
  });

  describe('calculate', () => {
    test('add returns correct sum', () => {
      expect(calculate.add(2, 3)).toBe(5);
    });

    test('multiply returns correct product', () => {
      expect(calculate.multiply(4, 5)).toBe(20);
    });

    test('divide throws on zero', () => {
      expect(() => calculate.divide(10, 0)).toThrow('Division by zero');
    });
  });
});
```

**`tests/e2e.test.js`:**
```javascript
// Simulated E2E tests for staging environment
describe('E2E Tests', () => {
  test('application starts successfully', () => {
    const { main } = require('../src/index');
    expect(() => main()).not.toThrow();
  });

  test('smoke test: core functions work', () => {
    const { greet, calculate } = require('../src/utils');
    expect(greet('Test')).toBeTruthy();
    expect(calculate.add(1, 1)).toBe(2);
  });
});
```

### Paso 4: Configuración (5 min)

**`.eslintrc.json`:**
```json
{
  "env": {
    "node": true,
    "jest": true,
    "es2021": true
  },
  "extends": "eslint:recommended",
  "rules": {
    "semi": ["error", "always"],
    "quotes": ["error", "single"]
  }
}
```

**Actualizar `package.json`:**
```json
{
  "scripts": {
    "lint": "eslint src/ tests/",
    "test": "jest --coverage",
    "test:e2e": "jest tests/e2e.test.js",
    "build": "mkdir -p dist && cp -r src/* dist/ && echo 'Build $(date)' > dist/build.txt"
  }
}
```

### Paso 5: El Pipeline CI/CD (40 min)

**`.github/workflows/cicd.yml`:**

```yaml
# =============================================================================
# PROYECTO: Full CI/CD Pipeline
# =============================================================================
# Autor: [Tu nombre]
# Fecha: [Fecha]
# Descripción: Pipeline completo con CI + CD a staging y production
# =============================================================================

name: 🚀 Full CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:
    inputs:
      skip_tests:
        description: 'Skip tests (emergency deploy)'
        required: false
        default: 'false'
        type: boolean

env:
  APP_NAME: ${{ vars.APP_NAME || 'mi-app-cicd' }}
  NODE_VERSION: '20'

jobs:
  # ===========================================================================
  # FASE CI: LINT
  # ===========================================================================
  lint:
    name: 🔍 Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      
      - run: npm ci
      - run: npm run lint
      
      - name: Lint Summary
        run: |
          echo "## 🔍 Lint Results" >> $GITHUB_STEP_SUMMARY
          echo "✅ No linting errors found" >> $GITHUB_STEP_SUMMARY

  # ===========================================================================
  # FASE CI: TEST
  # ===========================================================================
  test:
    name: 🧪 Test
    runs-on: ubuntu-latest
    needs: lint
    if: ${{ github.event.inputs.skip_tests != 'true' }}
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      
      - run: npm ci
      - run: npm test
      
      - name: Upload coverage
        uses: actions/upload-artifact@v4
        with:
          name: coverage-report
          path: coverage/
          retention-days: 7
      
      - name: Test Summary
        run: |
          echo "## 🧪 Test Results" >> $GITHUB_STEP_SUMMARY
          echo "✅ All tests passed" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "### Coverage" >> $GITHUB_STEP_SUMMARY
          cat coverage/coverage-summary.json | jq -r '.total | "- Lines: \(.lines.pct)%\n- Statements: \(.statements.pct)%\n- Functions: \(.functions.pct)%\n- Branches: \(.branches.pct)%"' >> $GITHUB_STEP_SUMMARY || echo "Coverage data not available" >> $GITHUB_STEP_SUMMARY

  # ===========================================================================
  # FASE CI: BUILD
  # ===========================================================================
  build:
    name: 🏗️ Build
    runs-on: ubuntu-latest
    needs: [lint, test]
    if: always() && needs.lint.result == 'success' && (needs.test.result == 'success' || needs.test.result == 'skipped')
    
    outputs:
      build_version: ${{ steps.version.outputs.version }}
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      
      - run: npm ci
      - run: npm run build
      
      - name: Generate version
        id: version
        run: |
          VERSION="${{ github.sha }}-$(date +%Y%m%d%H%M%S)"
          echo "version=$VERSION" >> $GITHUB_OUTPUT
          echo "$VERSION" > dist/version.txt
      
      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: dist/
          retention-days: 30
      
      - name: Build Summary
        run: |
          echo "## 🏗️ Build Results" >> $GITHUB_STEP_SUMMARY
          echo "✅ Build successful" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "**Version:** \`${{ steps.version.outputs.version }}\`" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "**Artifact:** build-${{ github.sha }}" >> $GITHUB_STEP_SUMMARY

  # ===========================================================================
  # FASE CD: DEPLOY STAGING
  # ===========================================================================
  deploy-staging:
    name: 🚀 Deploy Staging
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    
    environment:
      name: staging
      url: https://staging.example.com
    
    steps:
      - name: Download build
        uses: actions/download-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: dist/
      
      - name: Deploy to Staging
        env:
          DEPLOY_URL: ${{ secrets.DEPLOY_URL }}
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
        run: |
          echo "🚀 Deploying to Staging..."
          echo "Target: $DEPLOY_URL"
          echo "Version: $(cat dist/version.txt)"
          
          # Simular deploy (reemplazar con comando real)
          # rsync -avz dist/ user@staging:/var/www/app/
          # curl -X POST "$DEPLOY_URL/deploy" -H "Authorization: $DEPLOY_TOKEN"
          
          sleep 2
          echo "✅ Deploy to staging complete"
      
      - name: Run Smoke Tests
        run: |
          echo "🔥 Running smoke tests..."
          # curl -f https://staging.example.com/health || exit 1
          echo "✅ Smoke tests passed"
      
      - name: Run E2E Tests
        run: |
          echo "🧪 Running E2E tests against staging..."
          # npm run test:e2e -- --env=staging
          echo "✅ E2E tests passed"
      
      - name: Staging Summary
        run: |
          echo "## 🚀 Staging Deployment" >> $GITHUB_STEP_SUMMARY
          echo "✅ Successfully deployed to staging" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "**URL:** https://staging.example.com" >> $GITHUB_STEP_SUMMARY
          echo "**Version:** $(cat dist/version.txt)" >> $GITHUB_STEP_SUMMARY

  # ===========================================================================
  # FASE CD: DEPLOY PRODUCTION
  # ===========================================================================
  deploy-production:
    name: 🚀 Deploy Production
    runs-on: ubuntu-latest
    needs: deploy-staging
    
    environment:
      name: production
      url: https://prod.example.com
    
    steps:
      - name: Download build
        uses: actions/download-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: dist/
      
      - name: Pre-deployment checks
        run: |
          echo "🔒 Running pre-deployment checks..."
          echo "- Staging tests: ✅ Passed"
          echo "- Manual approval: ✅ Received"
          echo "- Wait timer: ✅ Completed"
      
      - name: Deploy to Production
        env:
          DEPLOY_URL: ${{ secrets.DEPLOY_URL }}
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
        run: |
          echo "🚀 Deploying to PRODUCTION..."
          echo "⚠️  This is a PRODUCTION deployment"
          echo "Target: $DEPLOY_URL"
          echo "Version: $(cat dist/version.txt)"
          
          # Simular deploy
          sleep 2
          echo "✅ Production deployment complete"
      
      - name: Verify Production
        run: |
          echo "✅ Production verification passed"
          # curl -f https://prod.example.com/health
      
      - name: Production Summary
        run: |
          echo "## 🚀 Production Deployment" >> $GITHUB_STEP_SUMMARY
          echo "✅ Successfully deployed to production" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "**URL:** https://prod.example.com" >> $GITHUB_STEP_SUMMARY
          echo "**Version:** $(cat dist/version.txt)" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "### Approvals" >> $GITHUB_STEP_SUMMARY
          echo "- Required reviewers: ✅" >> $GITHUB_STEP_SUMMARY
          echo "- Wait timer: ✅" >> $GITHUB_STEP_SUMMARY

  # ===========================================================================
  # NOTIFICACIÓN FINAL
  # ===========================================================================
  notify:
    name: 📢 Notify
    runs-on: ubuntu-latest
    needs: [deploy-production]
    if: always()
    
    steps:
      - name: Send notification
        run: |
          if [ "${{ needs.deploy-production.result }}" == "success" ]; then
            echo "🎉 Deployment successful!"
            # Aquí enviarías notificación a Slack, Teams, etc.
          else
            echo "❌ Deployment failed or skipped"
          fi
      
      - name: Final Summary
        run: |
          echo "## 📢 Pipeline Complete" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          echo "| Stage | Status |" >> $GITHUB_STEP_SUMMARY
          echo "|-------|--------|" >> $GITHUB_STEP_SUMMARY
          echo "| Lint | ${{ needs.lint.result == 'success' && '✅' || '❌' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Test | ${{ needs.test.result == 'success' && '✅' || '⏭️' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Build | ${{ needs.build.result == 'success' && '✅' || '❌' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Staging | ${{ needs.deploy-staging.result == 'success' && '✅' || '⏭️' }} |" >> $GITHUB_STEP_SUMMARY
          echo "| Production | ${{ needs.deploy-production.result == 'success' && '✅' || '⏭️' }} |" >> $GITHUB_STEP_SUMMARY
```

### Paso 6: Configurar GitHub (20 min)

#### 6.1 Crear Repository Secrets

```
Settings → Secrets and variables → Actions → Secrets

1. DEPLOY_TOKEN = "mi-token-seguro-123"
```

#### 6.2 Crear Repository Variables

```
Settings → Secrets and variables → Actions → Variables

1. APP_NAME = "mi-app-cicd"
```

#### 6.3 Crear Environment: staging

```
Settings → Environments → New environment

Name: staging

Environment secrets:
- DEPLOY_URL = "https://staging.example.com"
- DEPLOY_TOKEN = "staging-token-456"

No protection rules (deploy automático)
```

#### 6.4 Crear Environment: production

```
Settings → Environments → New environment

Name: production

Environment secrets:
- DEPLOY_URL = "https://prod.example.com"
- DEPLOY_TOKEN = "prod-token-789"

Protection rules:
☑ Required reviewers: [tu-usuario]
☑ Wait timer: 5 minutes
☑ Deployment branches: Selected branches → main
```

---

## 📦 Entregables

### Obligatorios

| # | Entregable | Descripción |
|---|------------|-------------|
| 1 | **Repositorio** | GitHub repo con código y workflow |
| 2 | **Workflow funcional** | CI/CD ejecuta correctamente |
| 3 | **Environments** | staging y production configurados |
| 4 | **README.md** | Documentación del proyecto |
| 5 | **Evidencia** | Screenshots de ejecución exitosa |

### Opcionales (Puntos Extra)

| # | Extra | Puntos |
|---|-------|--------|
| 1 | Badge de CI en README | +2 |
| 2 | Notificación a Slack/Discord | +3 |
| 3 | Rollback automático | +5 |
| 4 | Matrix testing (Node 18, 20, 22) | +3 |

---

## 🏆 Rúbrica de Evaluación

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **Pipeline CI** | 8 | Lint + Test + Build funcionando |
| **Caching** | 4 | npm dependencies cacheadas |
| **Artifacts** | 4 | Build compartido entre jobs |
| **Staging** | 4 | Deploy automático funcional |
| **Production** | 3 | Requiere aprobación |
| **Documentación** | 2 | README completo |
| **Total** | **25** | |

---

## 📚 Recursos de Apoyo

- [Teoría 01: Fundamentos CI/CD](../1-teoria/01-fundamentos-cicd.md)
- [Teoría 02: Build y Testing](../1-teoria/02-build-testing.md)
- [Teoría 03: Artifacts y Caching](../1-teoria/03-artifacts-caching.md)
- [Teoría 04: Secrets y Variables](../1-teoria/04-secrets-variables.md)
- [Ejercicios de la semana](../2-practicas/)

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | ➡️ Siguiente |
|:-----------:|:---------:|:------------:|
| [Prácticas](../2-practicas/) | [Week 08](../README.md) | [Recursos](../4-recursos/) |
- Preguntar en el foro o Discord del bootcamp

---

**💡 Tip:** Comienza temprano y no dudes en pedir ayuda si te atascas. El objetivo es aprender, no solo entregar.
