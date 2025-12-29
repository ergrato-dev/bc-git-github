# 🔍 Lección 02: Code Scanning con CodeQL

> **Duración**: 25 minutos
> 
> **Objetivos**: Configurar Code Scanning, entender CodeQL y interpretar resultados SARIF.

---

## 📋 Tabla de Contenidos

1. [¿Qué es Code Scanning?](#-qué-es-code-scanning)
2. [CodeQL: El Motor de Análisis](#-codeql-el-motor-de-análisis)
3. [Configuración del Workflow](#-configuración-del-workflow)
4. [Interpretando Resultados](#-interpretando-resultados)
5. [Custom Queries](#-custom-queries)
6. [SARIF y Terceros](#-sarif-y-terceros)

---

## 🎯 ¿Qué es Code Scanning?

**Code Scanning** es la feature de análisis estático de seguridad (SAST) de GitHub que encuentra vulnerabilidades en tu código fuente antes de que lleguen a producción.

### Tipos de Vulnerabilidades Detectadas

| Categoría | Ejemplos |
|-----------|----------|
| **Injection** | SQL Injection, Command Injection, XSS |
| **Authentication** | Weak crypto, hardcoded credentials |
| **Data Exposure** | Information disclosure, logging secrets |
| **Path Traversal** | Directory traversal, file access |
| **Deserialization** | Unsafe deserialization |
| **SSRF** | Server-Side Request Forgery |

### Flujo de Code Scanning

![Code Scanning Flow](../0-assets/02-code-scanning-flow.svg)

---

## 🧬 CodeQL: El Motor de Análisis

**CodeQL** es el motor de análisis semántico que potencia Code Scanning. Trata el código como datos consultables.

### ¿Cómo Funciona?

```
┌─────────────────────────────────────────────────────────┐
│                   CodeQL Pipeline                        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. Source Code    →   Extractor                        │
│                         ↓                               │
│  2. CodeQL DB      ←   Database (relational)            │
│                         ↓                               │
│  3. Queries        →   Analysis Engine                  │
│                         ↓                               │
│  4. Results        ←   SARIF Output                     │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Lenguajes Soportados

| Lenguaje | Status | Build Required |
|----------|--------|----------------|
| JavaScript/TypeScript | ✅ Full | No |
| Python | ✅ Full | No |
| Ruby | ✅ Full | No |
| Java/Kotlin | ✅ Full | Sí |
| C/C++ | ✅ Full | Sí |
| C# | ✅ Full | Sí |
| Go | ✅ Full | Sí |
| Swift | ✅ Full | Sí |

---

## ⚙️ Configuración del Workflow

### Opción 1: Default Setup (Recomendado)

```
Repository → Settings → Security → Code scanning
→ Set up → Default
```

GitHub configura automáticamente:
- Detecta lenguajes
- Crea workflow
- Ejecuta en push y PR

### Opción 2: Advanced Setup (Manual)

Crea `.github/workflows/codeql.yml`:

```yaml
# ¿Qué hace?: Ejecuta análisis CodeQL en push y PRs
# ¿Por qué?: Detectar vulnerabilidades antes del merge
# ¿Para qué sirve?: Mantener código seguro automáticamente

name: "CodeQL Analysis"

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    # ¿Qué hace?: Ejecuta análisis semanal
    # ¿Por qué?: Detectar nuevas vulnerabilidades en queries
    - cron: '30 1 * * 1'  # Lunes 1:30 AM

jobs:
  analyze:
    name: Analyze (${{ matrix.language }})
    runs-on: ubuntu-latest
    
    permissions:
      # ¿Qué hace?: Permisos mínimos necesarios
      security-events: write  # Para subir resultados
      packages: read          # Para dependencias privadas
      actions: read           # Para checkout
      contents: read          # Para leer código
    
    strategy:
      fail-fast: false
      matrix:
        # ¿Qué hace?: Analiza múltiples lenguajes
        language: ['javascript', 'python']
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v3
        with:
          languages: ${{ matrix.language }}
          # ¿Qué hace?: Usa query suites predefinidos
          # security-extended: más queries, más tiempo
          # security-and-quality: incluye code quality
          queries: security-extended

      # Para lenguajes compilados (Java, C++, C#, Go, Swift)
      # - name: Autobuild
      #   uses: github/codeql-action/autobuild@v3
      
      # O build manual:
      # - name: Build
      #   run: |
      #     make build

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v3
        with:
          category: "/language:${{ matrix.language }}"
```

### Query Suites Disponibles

| Suite | Descripción | Tiempo |
|-------|-------------|--------|
| `security-queries` | Solo vulnerabilidades (default) | Rápido |
| `security-extended` | Más vulnerabilidades | Medio |
| `security-and-quality` | Security + code quality | Lento |

---

## 📊 Interpretando Resultados

### Dónde Ver Resultados

```
Repository → Security → Code scanning alerts
```

### Anatomía de una Alerta

```
┌─────────────────────────────────────────────────────────┐
│  ⚠️ SQL Injection vulnerability                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Severity: 🔴 Critical (9.8)                           │
│  CWE: CWE-89                                           │
│  File: src/database.py:45                              │
│  Rule: py/sql-injection                                │
│                                                         │
│  ┌─ Code Path ────────────────────────────────────┐    │
│  │ Source: request.args.get('id')          L:23   │    │
│  │    ↓                                           │    │
│  │ Sink: cursor.execute(query)             L:45   │    │
│  └────────────────────────────────────────────────┘    │
│                                                         │
│  💡 Recommendation:                                    │
│  Use parameterized queries instead of string concat    │
│                                                         │
│  [Dismiss] [Create Issue] [Show paths]                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Severidad de Alertas

| Nivel | CVSS Score | Acción |
|-------|------------|--------|
| 🔴 Critical | 9.0 - 10.0 | Fix inmediato |
| 🟠 High | 7.0 - 8.9 | Fix en días |
| 🟡 Medium | 4.0 - 6.9 | Fix en sprint |
| ⚪ Low | 0.1 - 3.9 | Backlog |

### Estados de Alertas

| Estado | Descripción |
|--------|-------------|
| **Open** | Sin resolver |
| **Closed** | Resuelta |
| **Dismissed** | Descartada (falso positivo, won't fix) |
| **Fixed** | Código corregido |

### Ejemplo: Corregir SQL Injection

```python
# ❌ VULNERABLE - Concatenación de strings
def get_user(user_id):
    query = f"SELECT * FROM users WHERE id = {user_id}"
    cursor.execute(query)
    return cursor.fetchone()

# ✅ SEGURO - Parameterized query
def get_user(user_id):
    query = "SELECT * FROM users WHERE id = %s"
    cursor.execute(query, (user_id,))
    return cursor.fetchone()
```

---

## 🔧 Custom Queries

### ¿Cuándo Usar Custom Queries?

- Reglas específicas de tu organización
- Patrones de código prohibidos
- Detección de APIs deprecated
- Compliance requirements

### Estructura de una Query CodeQL

```ql
/**
 * @name Hardcoded password in variable
 * @description Finds variables named 'password' with hardcoded values
 * @kind problem
 * @problem.severity warning
 * @id custom/hardcoded-password
 * @tags security
 */

import javascript

from VariableDeclarator v
where
  v.getBindingPattern().(VarRef).getName().toLowerCase().matches("%password%")
  and exists(v.getInit().(StringLiteral))
select v, "Hardcoded password found in variable declaration"
```

### Agregar Custom Queries al Workflow

```yaml
- name: Initialize CodeQL
  uses: github/codeql-action/init@v3
  with:
    languages: javascript
    # ¿Qué hace?: Agrega queries personalizadas
    queries: |
      security-extended
      ./custom-queries/
```

### Crear Query Pack

```
custom-queries/
├── qlpack.yml
└── queries/
    └── hardcoded-password.ql
```

```yaml
# qlpack.yml
name: my-org/custom-security-queries
version: 1.0.0
dependencies:
  codeql/javascript-all: "*"
```

---

## 📄 SARIF y Terceros

### ¿Qué es SARIF?

**SARIF** (Static Analysis Results Interchange Format) es un formato JSON estándar para resultados de análisis estático.

```json
{
  "$schema": "https://json.schemastore.org/sarif-2.1.0.json",
  "version": "2.1.0",
  "runs": [{
    "tool": {
      "driver": {
        "name": "CodeQL",
        "rules": [...]
      }
    },
    "results": [{
      "ruleId": "js/sql-injection",
      "message": { "text": "SQL injection vulnerability" },
      "locations": [{
        "physicalLocation": {
          "artifactLocation": { "uri": "src/db.js" },
          "region": { "startLine": 45 }
        }
      }]
    }]
  }]
}
```

### Integrar Herramientas de Terceros

Cualquier herramienta que genere SARIF puede integrarse:

```yaml
# Ejemplo: ESLint con output SARIF
- name: Run ESLint
  run: npx eslint . --format @microsoft/sarif --output-file eslint.sarif
  continue-on-error: true

- name: Upload SARIF
  uses: github/codeql-action/upload-sarif@v3
  with:
    sarif_file: eslint.sarif
    category: eslint
```

### Herramientas Compatibles

| Herramienta | Tipo | Lenguajes |
|-------------|------|-----------|
| Semgrep | SAST | Multi |
| Snyk | SAST + SCA | Multi |
| Trivy | Container | Docker |
| Checkov | IaC | Terraform, K8s |
| Bandit | SAST | Python |

---

## 🛡️ Branch Protection con Code Scanning

```yaml
# ¿Qué hace?: Requiere que pasen los checks de CodeQL
# Settings → Branches → Branch protection rules

Required status checks:
  ✅ CodeQL / Analyze (javascript)
  ✅ CodeQL / Analyze (python)
```

### Bloquear PRs con Alertas

```
Settings → Code security → Code scanning
→ Check failures: "Only critical" / "Any"
```

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **Code Scanning** | Feature de SAST en GitHub |
| **CodeQL** | Motor de análisis semántico |
| **SARIF** | Formato de resultados |
| **Query Suites** | Colecciones de reglas |
| **Custom Queries** | Reglas personalizadas |

### Workflow Mínimo

```yaml
name: "CodeQL"
on: [push, pull_request]
jobs:
  analyze:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v3
        with:
          languages: javascript
      - uses: github/codeql-action/analyze@v3
```

---

## 🔗 Recursos

- [CodeQL Documentation](https://codeql.github.com/docs/)
- [CodeQL Query Help](https://codeql.github.com/codeql-query-help/)
- [SARIF Specification](https://sarifweb.azurewebsites.net/)
- [Code Scanning API](https://docs.github.com/en/rest/code-scanning)

---

## ⏭️ Siguiente Lección

[03 - Dependabot →](03-dependabot.md)

---

[⬅️ Volver a Week 11](../README.md)
