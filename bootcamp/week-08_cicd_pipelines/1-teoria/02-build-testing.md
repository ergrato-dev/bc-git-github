# 📚 Lección 02: Build y Testing en CI/CD

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- [ ] Configurar jobs de build en GitHub Actions
- [ ] Implementar diferentes niveles de testing (unit, integration, e2e)
- [ ] Entender la pirámide de testing
- [ ] Configurar code coverage y reportes
- [ ] Optimizar tiempos de build y test

---

## 📋 Contenido

1. [Build en CI/CD](#1-build-en-cicd)
2. [La Pirámide de Testing](#2-la-pirámide-de-testing)
3. [Unit Tests](#3-unit-tests)
4. [Integration Tests](#4-integration-tests)
5. [E2E Tests](#5-e2e-tests)
6. [Code Coverage](#6-code-coverage)
7. [Testing en GitHub Actions](#7-testing-en-github-actions)

---

## 1. Build en CI/CD

### ¿Qué es el Build?

El **build** es el proceso de transformar código fuente en un artefacto ejecutable o desplegable.

```
Source Code → [Build Process] → Deployable Artifact
     │                              │
     ├── .ts, .jsx                 ├── .js bundles
     ├── .scss                     ├── .css minified
     └── dependencies              └── node_modules bundled
```

### Tipos de Build

| Tipo | Descripción | Herramientas |
|------|-------------|--------------|
| **Transpilación** | TypeScript → JavaScript | tsc, babel |
| **Bundling** | Múltiples archivos → uno | Webpack, Vite, esbuild |
| **Minificación** | Reducir tamaño | terser, uglify |
| **Compilación** | Código → binario | gcc, go build, cargo |
| **Containerización** | App → Docker image | docker build |

### Build en GitHub Actions

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Build
        run: npm run build
        env:
          NODE_ENV: production
      
      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: build
          path: dist/
          retention-days: 7
```

### Build para Diferentes Lenguajes

#### Node.js / JavaScript
```yaml
- run: npm ci
- run: npm run build
```

#### Python
```yaml
- run: pip install -r requirements.txt
- run: python -m build  # Para packages
```

#### Go
```yaml
- run: go build -o bin/app ./cmd/app
```

#### Java / Maven
```yaml
- run: mvn clean package -DskipTests
```

#### Docker
```yaml
- name: Build Docker image
  run: |
    docker build \
      -t myapp:${{ github.sha }} \
      -f Dockerfile .
```

---

## 2. La Pirámide de Testing

### Concepto

La **pirámide de testing** es un modelo que sugiere cómo distribuir los diferentes tipos de tests en un proyecto.

![Testing Pyramid](../0-assets/02-testing-pyramid.svg)

### Distribución Recomendada

| Nivel | Proporción | Velocidad | Costo | Confianza |
|-------|------------|-----------|-------|-----------|
| **Unit Tests** | 70% | Muy rápida | Bajo | Función |
| **Integration Tests** | 20% | Media | Medio | Módulos |
| **E2E Tests** | 10% | Lenta | Alto | Sistema |

### Por qué esta Distribución

```
                    ┌───────────┐
                   ╱             ╲
                  ╱   E2E (10%)   ╲  ← Pocos pero críticos
                 ╱─────────────────╲
                ╱                   ╲
               ╱  Integration (20%)  ╲  ← Validar interacciones
              ╱───────────────────────╲
             ╱                         ╲
            ╱      Unit Tests (70%)     ╲  ← Muchos y rápidos
           ╱─────────────────────────────╲
```

**Razonamiento:**
- Unit tests son baratos y rápidos → más cantidad
- E2E tests son caros y lentos → solo flujos críticos
- Integration tests balancean costo/valor

---

## 3. Unit Tests

### Características

| Aspecto | Descripción |
|---------|-------------|
| **Scope** | Una función o método |
| **Aislamiento** | Sin dependencias externas (mocks) |
| **Velocidad** | Milisegundos |
| **Ejecución** | En cada commit |

### Ejemplo con Jest (Node.js)

```javascript
// calculator.js
class Calculator {
  add(a, b) {
    return a + b;
  }
  
  divide(a, b) {
    if (b === 0) throw new Error('Division by zero');
    return a / b;
  }
}

// calculator.test.js
describe('Calculator', () => {
  let calc;
  
  beforeEach(() => {
    calc = new Calculator();
  });
  
  describe('add()', () => {
    test('adds two positive numbers', () => {
      expect(calc.add(2, 3)).toBe(5);
    });
    
    test('adds negative numbers', () => {
      expect(calc.add(-1, -2)).toBe(-3);
    });
  });
  
  describe('divide()', () => {
    test('divides two numbers', () => {
      expect(calc.divide(10, 2)).toBe(5);
    });
    
    test('throws on division by zero', () => {
      expect(() => calc.divide(10, 0)).toThrow('Division by zero');
    });
  });
});
```

### Unit Tests en GitHub Actions

```yaml
jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - run: npm ci
      
      - name: Run unit tests
        run: npm test -- --coverage --testPathPattern="unit"
      
      - name: Upload coverage
        uses: actions/upload-artifact@v4
        with:
          name: unit-coverage
          path: coverage/
```

---

## 4. Integration Tests

### Características

| Aspecto | Descripción |
|---------|-------------|
| **Scope** | Múltiples componentes interactuando |
| **Aislamiento** | Puede usar DBs, APIs reales o contenedores |
| **Velocidad** | Segundos |
| **Ejecución** | En PRs y push a main |

### Ejemplo: API Integration Test

```javascript
// api.integration.test.js
const request = require('supertest');
const app = require('../src/app');
const db = require('../src/database');

describe('Users API', () => {
  beforeAll(async () => {
    await db.connect();
  });
  
  afterAll(async () => {
    await db.disconnect();
  });
  
  beforeEach(async () => {
    await db.collection('users').deleteMany({});
  });
  
  test('POST /users creates a new user', async () => {
    const response = await request(app)
      .post('/users')
      .send({ name: 'John', email: 'john@example.com' })
      .expect(201);
    
    expect(response.body).toHaveProperty('id');
    expect(response.body.name).toBe('John');
  });
  
  test('GET /users returns all users', async () => {
    await db.collection('users').insertMany([
      { name: 'Alice' },
      { name: 'Bob' }
    ]);
    
    const response = await request(app)
      .get('/users')
      .expect(200);
    
    expect(response.body).toHaveLength(2);
  });
});
```

### Integration Tests con Service Containers

```yaml
jobs:
  integration-tests:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_USER: test
          POSTGRES_PASSWORD: test
          POSTGRES_DB: testdb
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
      
      redis:
        image: redis:7
        ports:
          - 6379:6379
    
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - run: npm ci
      
      - name: Run integration tests
        run: npm test -- --testPathPattern="integration"
        env:
          DATABASE_URL: postgres://test:test@localhost:5432/testdb
          REDIS_URL: redis://localhost:6379
```

---

## 5. E2E Tests

### Características

| Aspecto | Descripción |
|---------|-------------|
| **Scope** | Flujo completo del usuario |
| **Aislamiento** | Sistema completo corriendo |
| **Velocidad** | Minutos |
| **Ejecución** | Antes de deploy a staging/prod |

### Herramientas Populares

| Herramienta | Lenguaje | Browsers |
|-------------|----------|----------|
| **Playwright** | JS/TS, Python | Chromium, Firefox, WebKit |
| **Cypress** | JavaScript | Chrome, Firefox, Edge |
| **Selenium** | Multi-lenguaje | Todos |
| **Puppeteer** | JavaScript | Chrome |

### Ejemplo con Playwright

```javascript
// tests/e2e/login.spec.js
const { test, expect } = require('@playwright/test');

test.describe('Login Flow', () => {
  test('user can login successfully', async ({ page }) => {
    // Navegar a la página de login
    await page.goto('/login');
    
    // Llenar formulario
    await page.fill('[data-testid="email"]', 'user@example.com');
    await page.fill('[data-testid="password"]', 'password123');
    
    // Click en submit
    await page.click('[data-testid="login-button"]');
    
    // Verificar redirección al dashboard
    await expect(page).toHaveURL('/dashboard');
    await expect(page.locator('h1')).toContainText('Welcome');
  });
  
  test('shows error on invalid credentials', async ({ page }) => {
    await page.goto('/login');
    
    await page.fill('[data-testid="email"]', 'wrong@example.com');
    await page.fill('[data-testid="password"]', 'wrongpassword');
    await page.click('[data-testid="login-button"]');
    
    await expect(page.locator('.error-message')).toBeVisible();
    await expect(page.locator('.error-message')).toContainText('Invalid credentials');
  });
});
```

### E2E Tests en GitHub Actions

```yaml
jobs:
  e2e-tests:
    runs-on: ubuntu-latest
    needs: [build]
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - run: npm ci
      
      - name: Install Playwright browsers
        run: npx playwright install --with-deps
      
      - name: Download build artifact
        uses: actions/download-artifact@v4
        with:
          name: build
          path: dist/
      
      - name: Start application
        run: npm run preview &
        env:
          PORT: 3000
      
      - name: Wait for app to be ready
        run: npx wait-on http://localhost:3000
      
      - name: Run E2E tests
        run: npx playwright test
        env:
          BASE_URL: http://localhost:3000
      
      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report
          path: playwright-report/

  # Matrix para múltiples browsers
  e2e-matrix:
    runs-on: ubuntu-latest
    needs: [build]
    strategy:
      matrix:
        browser: [chromium, firefox, webkit]
    
    steps:
      - uses: actions/checkout@v4
      # ... setup steps ...
      
      - name: Run E2E tests - ${{ matrix.browser }}
        run: npx playwright test --project=${{ matrix.browser }}
```

---

## 6. Code Coverage

### ¿Qué es Code Coverage?

**Code coverage** mide qué porcentaje del código es ejecutado por los tests.

### Métricas de Coverage

| Métrica | Descripción |
|---------|-------------|
| **Line Coverage** | % de líneas ejecutadas |
| **Branch Coverage** | % de branches (if/else) ejecutadas |
| **Function Coverage** | % de funciones llamadas |
| **Statement Coverage** | % de statements ejecutados |

### Ejemplo de Reporte

```
--------------------|---------|----------|---------|---------|
File                | % Stmts | % Branch | % Funcs | % Lines |
--------------------|---------|----------|---------|---------|
All files           |   85.71 |       75 |     100 |   85.71 |
 calculator.js      |     100 |      100 |     100 |     100 |
 utils.js           |   66.67 |       50 |     100 |   66.67 |
--------------------|---------|----------|---------|---------|
```

### Configurar Coverage en Jest

```javascript
// jest.config.js
module.exports = {
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  collectCoverageFrom: [
    'src/**/*.{js,ts}',
    '!src/**/*.d.ts',
    '!src/**/index.{js,ts}'
  ]
};
```

### Coverage en GitHub Actions

```yaml
jobs:
  test-coverage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - run: npm ci
      
      - name: Run tests with coverage
        run: npm test -- --coverage
      
      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v4
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
          files: ./coverage/lcov.info
          fail_ci_if_error: true
      
      - name: Check coverage threshold
        run: |
          COVERAGE=$(cat coverage/coverage-summary.json | jq '.total.lines.pct')
          if (( $(echo "$COVERAGE < 80" | bc -l) )); then
            echo "Coverage is below 80%: $COVERAGE%"
            exit 1
          fi
```

---

## 7. Testing en GitHub Actions

### Pipeline de Testing Completo

```yaml
name: Test Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  # ============================================
  # Unit Tests - Rápidos, primero
  # ============================================
  unit-tests:
    name: 🧪 Unit Tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run test:unit -- --coverage
      - uses: actions/upload-artifact@v4
        with:
          name: unit-coverage
          path: coverage/

  # ============================================
  # Integration Tests - Con servicios
  # ============================================
  integration-tests:
    name: 🔗 Integration Tests
    runs-on: ubuntu-latest
    needs: unit-tests
    
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: test
        ports:
          - 5432:5432
    
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run test:integration
        env:
          DATABASE_URL: postgres://postgres:test@localhost:5432/postgres

  # ============================================
  # E2E Tests - Matrix de browsers
  # ============================================
  e2e-tests:
    name: 🌐 E2E Tests (${{ matrix.browser }})
    runs-on: ubuntu-latest
    needs: [unit-tests, integration-tests]
    
    strategy:
      fail-fast: false
      matrix:
        browser: [chromium, firefox]
    
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npx playwright install --with-deps ${{ matrix.browser }}
      - run: npm run build
      - run: npm run test:e2e -- --project=${{ matrix.browser }}
      - uses: actions/upload-artifact@v4
        if: always()
        with:
          name: e2e-report-${{ matrix.browser }}
          path: playwright-report/

  # ============================================
  # Coverage Report
  # ============================================
  coverage-report:
    name: 📊 Coverage Report
    runs-on: ubuntu-latest
    needs: [unit-tests]
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: unit-coverage
          path: coverage/
      
      - name: Coverage Summary
        run: |
          echo "## Coverage Report" >> $GITHUB_STEP_SUMMARY
          echo "" >> $GITHUB_STEP_SUMMARY
          cat coverage/coverage-summary.json | jq -r '
            "| Metric | Coverage |",
            "|--------|----------|",
            "| Lines | \(.total.lines.pct)% |",
            "| Branches | \(.total.branches.pct)% |",
            "| Functions | \(.total.functions.pct)% |",
            "| Statements | \(.total.statements.pct)% |"
          ' >> $GITHUB_STEP_SUMMARY
```

---

## 📝 Resumen

| Tipo de Test | Cuándo Ejecutar | Herramientas |
|--------------|-----------------|--------------|
| **Unit** | Cada commit | Jest, Mocha, PyTest |
| **Integration** | PRs, push main | Supertest, TestContainers |
| **E2E** | Pre-deploy | Playwright, Cypress |

### Best Practices

1. **Fail fast** - Unit tests primero
2. **Parallelizar** - Matrix para E2E
3. **Coverage gates** - Mínimo 80%
4. **Artifacts** - Guardar reportes siempre

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | ➡️ Siguiente |
|:-----------:|:---------:|:------------:|
| [Fundamentos CI/CD](01-fundamentos-cicd.md) | [Semana 08](../README.md) | [Artifacts y Caching](03-artifacts-caching.md) |
