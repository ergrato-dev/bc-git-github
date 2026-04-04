# 🚀 Proyecto Semana 07: Pipeline CI Básico para Aplicación Node.js

## 📋 Descripción General

En este proyecto crearás un **pipeline de Integración Continua (CI) completo** para una aplicación Node.js. Implementarás un workflow de GitHub Actions que automatice el proceso de lint, testing y build, aplicando todas las técnicas aprendidas durante la semana.

**Escenario:** Eres el DevOps Engineer de un equipo de desarrollo. Te han asignado configurar la automatización CI para un nuevo proyecto Node.js que el equipo comenzará a desarrollar.

---

## 🎯 Objetivos de Aprendizaje

Al completar este proyecto serás capaz de:

- [ ] Crear workflows de GitHub Actions desde cero
- [ ] Configurar múltiples triggers (push, pull_request, schedule)
- [ ] Implementar matrix strategy para testing multi-versión
- [ ] Usar actions del Marketplace (checkout, setup-node, cache)
- [ ] Configurar artifacts para almacenar resultados
- [ ] Aplicar buenas prácticas de CI/CD

---

## 📁 Estructura del Proyecto

```text
3-proyecto/
├── README.md              # Este archivo (instrucciones)
├── starter/               # Archivos iniciales del proyecto
│   ├── package.json       # Configuración npm del proyecto
│   ├── src/
│   │   └── calculator.js  # Módulo a testear
│   ├── tests/
│   │   └── calculator.test.js
│   └── .eslintrc.json     # Configuración ESLint
└── solution/              # Solución de referencia (solo instructores)
    └── README.md
```

---

## ⏰ Información del Proyecto

| Aspecto                | Detalle                  |
| ---------------------- | ------------------------ |
| **Duración estimada**  | 2 horas                  |
| **Modalidad**          | Individual               |
| **Dificultad**         | Intermedia               |
| **Requisitos previos** | Completar ejercicios 1-4 |

---

## 📦 Starter Files

### `package.json`

```json
{
  "name": "ci-project-week07",
  "version": "1.0.0",
  "description": "Proyecto CI para bootcamp Git/GitHub",
  "main": "src/calculator.js",
  "scripts": {
    "lint": "eslint src/ tests/",
    "lint:fix": "eslint src/ tests/ --fix",
    "test": "jest --coverage",
    "test:watch": "jest --watch",
    "build": "echo 'Build completado' && mkdir -p dist && cp -r src/* dist/"
  },
  "devDependencies": {
    "eslint": "8.57.1",
    "jest": "29.7.0"
  },
  "keywords": ["ci", "github-actions", "bootcamp"],
  "license": "MIT"
}
```

### `src/calculator.js`

```javascript
/**
 * Módulo Calculator - Operaciones matemáticas básicas
 * Este módulo será validado por el pipeline CI
 */

class Calculator {
  add(a, b) {
    return a + b;
  }

  subtract(a, b) {
    return a - b;
  }

  multiply(a, b) {
    return a * b;
  }

  divide(a, b) {
    if (b === 0) {
      throw new Error("División por cero no permitida");
    }
    return a / b;
  }
}

module.exports = Calculator;
```

### `tests/calculator.test.js`

```javascript
const Calculator = require("../src/calculator");

describe("Calculator", () => {
  let calc;

  beforeEach(() => {
    calc = new Calculator();
  });

  describe("add()", () => {
    test("suma dos números positivos", () => {
      expect(calc.add(2, 3)).toBe(5);
    });

    test("suma números negativos", () => {
      expect(calc.add(-1, -2)).toBe(-3);
    });
  });

  describe("subtract()", () => {
    test("resta dos números", () => {
      expect(calc.subtract(5, 3)).toBe(2);
    });
  });

  describe("multiply()", () => {
    test("multiplica dos números", () => {
      expect(calc.multiply(4, 3)).toBe(12);
    });
  });

  describe("divide()", () => {
    test("divide dos números", () => {
      expect(calc.divide(10, 2)).toBe(5);
    });

    test("lanza error al dividir por cero", () => {
      expect(() => calc.divide(10, 0)).toThrow("División por cero");
    });
  });
});
```

### `.eslintrc.json`

```json
{
  "env": {
    "node": true,
    "jest": true,
    "es2021": true
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaVersion": "latest"
  },
  "rules": {
    "no-unused-vars": "error",
    "no-console": "warn",
    "semi": ["error", "always"],
    "quotes": ["error", "single"]
  }
}
```

---

## 📝 Requerimientos del Proyecto

### Fase 1: Configuración Básica (30 min)

#### 1.1 Preparar Repositorio

```bash
# ¿QUÉ HACER?: Crear repository para el proyecto
# ¿POR QUÉ?: Necesitamos un repo donde configurar GitHub Actions
# ¿PARA QUÉ?: Tener un entorno real de CI/CD

# Opción A: Crear nuevo repository en GitHub
# 1. Ir a github.com → New repository
# 2. Nombre: "ci-project-bootcamp"
# 3. Público, con README

# Opción B: Usar repository existente del bootcamp
# Crear una carpeta para este proyecto
```

#### 1.2 Crear Estructura de Archivos

```bash
# Crear estructura del proyecto
mkdir -p .github/workflows
mkdir -p src tests

# Copiar archivos starter (del README anterior)
# O crearlos manualmente
```

#### 1.3 Instalar Dependencias Localmente (Opcional)

```bash
# Para probar localmente antes del CI
npm install
npm run lint
npm test
```

---

### Fase 2: Workflow Principal (45 min)

#### 2.1 Crear el Workflow CI

Crear archivo `.github/workflows/ci.yml` con los siguientes requerimientos:

| Requerimiento            | Descripción                                 | Puntos |
| ------------------------ | ------------------------------------------- | ------ |
| **Nombre descriptivo**   | `name: CI Pipeline`                         | 2      |
| **Trigger push**         | En branches main y develop                  | 3      |
| **Trigger pull_request** | En branch main                              | 3      |
| **Job lint**             | Ejecutar ESLint                             | 5      |
| **Job test**             | Ejecutar Jest con coverage                  | 5      |
| **Job build**            | Crear distribución                          | 5      |
| **Dependencias**         | test depende de lint, build depende de test | 5      |
| **Cache npm**            | Cachear node_modules                        | 5      |

#### 2.2 Estructura Esperada del Workflow

```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  # TODO: Configurar triggers

jobs:
  lint:
    # TODO: Implementar job de linting

  test:
    # TODO: Implementar job de testing
    # Debe depender de lint

  build:
    # TODO: Implementar job de build
    # Debe depender de test
```

---

### Fase 3: Matrix Strategy (30 min)

#### 3.1 Agregar Testing Multi-versión

Modificar el job `test` para usar matrix strategy:

| Versión Node.js | Sistema Operativo |
| --------------- | ----------------- |
| 18              | ubuntu-latest     |
| 20              | ubuntu-latest     |
| 22              | ubuntu-latest     |

#### 3.2 Configuración Matrix

```yaml
test:
  needs: lint
  runs-on: ubuntu-latest
  strategy:
    matrix:
      node-version: [18, 20, 22]
    fail-fast: false
  # ... resto del job
```

---

### Fase 4: Features Avanzados (15 min)

#### 4.1 Agregar Artifacts

Configurar upload de:

- Reporte de coverage (carpeta `coverage/`)
- Build output (carpeta `dist/`)

#### 4.2 Agregar Status Badge

```markdown
<!-- En el README.md del proyecto -->

![CI Status](https://github.com/TU_USUARIO/TU_REPO/actions/workflows/ci.yml/badge.svg)
```

---

## ✅ Checklist de Entregables

### Archivos Requeridos

- [ ] `.github/workflows/ci.yml` - Workflow principal
- [ ] `package.json` - Configuración del proyecto
- [ ] `src/calculator.js` - Código fuente
- [ ] `tests/calculator.test.js` - Tests
- [ ] `.eslintrc.json` - Configuración ESLint
- [ ] `README.md` - Con badge de status

### Funcionalidades Requeridas

- [ ] Pipeline ejecuta en push a main/develop
- [ ] Pipeline ejecuta en pull requests a main
- [ ] Job lint ejecuta correctamente
- [ ] Job test ejecuta con matrix (3 versiones)
- [ ] Job build crea artifacts
- [ ] Dependencias entre jobs configuradas
- [ ] Cache de npm funcionando

---

## 🏆 Criterios de Evaluación

| Criterio               | Puntos  | Descripción                               |
| ---------------------- | ------- | ----------------------------------------- |
| **Workflow funcional** | 30      | Pipeline completo que ejecuta sin errores |
| **Triggers correctos** | 10      | push y pull_request configurados          |
| **Matrix strategy**    | 15      | Testing en múltiples versiones Node.js    |
| **Cache implementado** | 10      | npm cache funcionando                     |
| **Artifacts**          | 10      | Coverage y build subidos                  |
| **Job dependencies**   | 10      | needs configurado correctamente           |
| **Badge en README**    | 5       | Status badge visible                      |
| **Código limpio**      | 10      | YAML bien formateado y comentado          |
| **TOTAL**              | **100** |                                           |

### Escala de Calificación

| Puntos | Calificación         | Descripción        |
| ------ | -------------------- | ------------------ |
| 90-100 | ⭐⭐⭐⭐⭐ Excelente | Dominio completo   |
| 80-89  | ⭐⭐⭐⭐ Muy Bueno   | Muy buen desempeño |
| 70-79  | ⭐⭐⭐ Bueno         | Cumple objetivos   |
| 60-69  | ⭐⭐ Regular         | Necesita mejorar   |
| <60    | ⭐ Insuficiente      | Requiere repetir   |

---

## 💡 Pistas y Ayuda

<details>
<summary>💡 Pista 1: Estructura básica del workflow</summary>

```yaml
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
      - run: npm ci
      - run: npm run lint
```

</details>

<details>
<summary>💡 Pista 2: Configurar cache de npm</summary>

```yaml
- uses: actions/setup-node@v4
  with:
    node-version: ${{ matrix.node-version }}
    cache: "npm"
```

</details>

<details>
<summary>💡 Pista 3: Upload artifacts</summary>

```yaml
- uses: actions/upload-artifact@v4
  with:
    name: coverage-report
    path: coverage/
    retention-days: 7
```

</details>

<details>
<summary>💡 Pista 4: Job dependencies</summary>

```yaml
test:
  needs: lint # Este job espera a que lint termine

build:
  needs: test # Este job espera a que test termine
```

</details>

---

## 🔗 Recursos de Apoyo

- [Lección 01: Introducción a GitHub Actions](../1-teoria/01-introduccion-actions.md)
- [Lección 02: Sintaxis YAML para Workflows](../1-teoria/02-sintaxis-yaml.md)
- [Lección 03: Events y Triggers](../1-teoria/03-events-triggers.md)
- [Lección 04: Jobs y Runners](../1-teoria/04-jobs-runners.md)
- [Ejercicio 04: Matrix Strategy](../2-practicas/ejercicio-04-matrix-strategy/README.md)

### Documentación Oficial

- [GitHub Actions Quickstart](https://docs.github.com/en/actions/quickstart)
- [Workflow syntax reference](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [actions/setup-node](https://github.com/actions/setup-node)
- [actions/cache](https://github.com/actions/cache)

---

## 📤 Cómo Entregar

1. **Push del código** al repository
2. **Verificar** que el workflow ejecuta correctamente en la pestaña Actions
3. **Captura de pantalla** mostrando:
   - Workflow ejecutado exitosamente
   - Los 3 jobs completados (lint, test, build)
   - Matrix con las 3 versiones de Node.js
4. **Compartir URL** del repository con el instructor

---

## 🎯 Desafíos Extra (Bonus)

Para quienes terminen antes o quieran profundizar:

### Desafío 1: Workflow de Release (+10 pts)

Crear un segundo workflow que se ejecute en tags `v*` y cree un GitHub Release automático.

### Desafío 2: Notificaciones (+5 pts)

Agregar notificación a Slack o Discord cuando el pipeline falle.

### Desafío 3: Code Coverage Badge (+5 pts)

Configurar Codecov o similar para mostrar badge de coverage.

---

## 🔗 Navegación

|                              ⬅️ Anterior                              |       🏠 Semana        |            ➡️ Siguiente             |
| :-------------------------------------------------------------------: | :--------------------: | :---------------------------------: |
| [Ejercicio 04](../2-practicas/ejercicio-04-matrix-strategy/README.md) | [README](../README.md) | [Recursos](../4-recursos/README.md) |

- Preguntar en el foro o Discord del bootcamp

---

**💡 Tip:** Comienza temprano y no dudes en pedir ayuda si te atascas. El objetivo es aprender, no solo entregar.
