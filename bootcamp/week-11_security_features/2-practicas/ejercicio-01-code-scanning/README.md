# 🔍 Ejercicio 01: Code Scanning con CodeQL

> **Duración**: 40 minutos
>
> **Objetivo**: Configurar Code Scanning con CodeQL y corregir vulnerabilidades detectadas.

---

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio serás capaz de:

- ✅ Habilitar Code Scanning en un repository
- ✅ Configurar un workflow de CodeQL
- ✅ Interpretar alertas de seguridad
- ✅ Corregir vulnerabilidades detectadas

---

## 📋 Requisitos Previos

- Repository con código JavaScript o Python
- Acceso a Settings del repository
- Conocimiento básico de GitHub Actions

---

## 🏗️ Parte 1: Crear Repository de Prueba (10 min)

### Paso 1.1: Crear nuevo repository

```bash
# ¿Qué hace?: Crea un nuevo repository para el ejercicio
# ¿Por qué?: Necesitamos código vulnerable para analizar
# ¿Para qué sirve?: Practicar Code Scanning de forma segura

mkdir security-lab-codeql
cd security-lab-codeql
git init
```

### Paso 1.2: Crear archivo vulnerable (intencionalmente)

Crea `app.js` con vulnerabilidades intencionales:

```javascript
// app.js
// ⚠️ ARCHIVO CON VULNERABILIDADES INTENCIONALES PARA APRENDIZAJE
// NO USAR EN PRODUCCIÓN

const express = require("express");
const mysql = require("mysql");
const app = express();

// Conexión a base de datos
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password123", // ❌ Hardcoded credential
  database: "myapp",
});

// ❌ VULNERABILIDAD 1: SQL Injection
app.get("/user", (req, res) => {
  const userId = req.query.id;
  // Concatenación directa - VULNERABLE
  const query = `SELECT * FROM users WHERE id = ${userId}`;
  db.query(query, (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

// ❌ VULNERABILIDAD 2: XSS (Cross-Site Scripting)
app.get("/search", (req, res) => {
  const searchTerm = req.query.q;
  // Respuesta sin sanitizar - VULNERABLE
  res.send(`<h1>Resultados para: ${searchTerm}</h1>`);
});

// ❌ VULNERABILIDAD 3: Path Traversal
app.get("/file", (req, res) => {
  const filename = req.query.name;
  // Sin validación de path - VULNERABLE
  res.sendFile(`/uploads/${filename}`);
});

// ❌ VULNERABILIDAD 4: Command Injection
const { exec } = require("child_process");
app.get("/ping", (req, res) => {
  const host = req.query.host;
  // Ejecución de comando sin sanitizar - VULNERABLE
  exec(`ping -c 1 ${host}`, (err, stdout) => {
    res.send(stdout);
  });
});

app.listen(3000);
```

### Paso 1.3: Crear package.json

> **⚠️ Lab de seguridad**: Las versiones a continuación están **intencionalmente pinneadas** a releases con CVEs conocidos para que CodeQL y Dependabot las detecten como parte del ejercicio.
>
> - `express@4.18.2`: vulnerable a CVE-2024-29041 (open redirect) y CVE-2024-43796 (XSS). Parchado en 4.19.2+.
> - `mysql@2.18.1`: paquete **abandonado** sin mantenimiento desde 2014. Sustituir por `mysql2` en código real.
>
> **Regla de oro**: versiones SIEMPRE exactas (sin `^` ni `>=`). Aquí se pinen a versiones vulnerables a propósito para el lab.

```json
{
  "name": "security-lab-codeql",
  "version": "1.0.0",
  "description": "Lab para practicar Code Scanning",
  "main": "app.js",
  "dependencies": {
    "express": "4.18.2",
    "mysql": "2.18.1"
  }
}
```

### Paso 1.4: Push al repository

```bash
# ¿Qué hace?: Sube el código al repository remoto
git add .
git commit -m "feat: add vulnerable code for security lab"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/security-lab-codeql.git
git push -u origin main
```

---

## 🔧 Parte 2: Habilitar Code Scanning (10 min)

### Paso 2.1: Opción A - Default Setup (Recomendado)

```
Repository → Settings → Security → Code security and analysis
→ Code scanning → Set up → Default
```

GitHub automáticamente:

- Detecta lenguaje (JavaScript)
- Crea workflow de CodeQL
- Ejecuta primer análisis

### Paso 2.2: Opción B - Advanced Setup (Manual)

Si prefieres control total, crea `.github/workflows/codeql.yml`:

```yaml
# ¿Qué hace?: Ejecuta análisis de seguridad CodeQL
# ¿Por qué?: Detectar vulnerabilidades automáticamente
# ¿Para qué sirve?: Mantener código seguro en cada push/PR

name: "CodeQL Analysis"

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: "0 6 * * 1" # Lunes 6:00 AM

jobs:
  analyze:
    name: Analyze JavaScript
    runs-on: ubuntu-latest

    permissions:
      security-events: write
      actions: read
      contents: read

    steps:
      # Paso 1: Checkout del código
      - name: Checkout repository
        uses: actions/checkout@v4

      # Paso 2: Inicializar CodeQL
      - name: Initialize CodeQL
        uses: github/codeql-action/init@v3
        with:
          languages: javascript
          # Query suites disponibles:
          # - security-queries (default, rápido)
          # - security-extended (más queries)
          # - security-and-quality (incluye code quality)
          queries: security-extended

      # Paso 3: Ejecutar análisis
      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v3
        with:
          category: "/language:javascript"
```

### Paso 2.3: Commit y push del workflow

```bash
# ¿Qué hace?: Sube el workflow de CodeQL
git add .github/workflows/codeql.yml
git commit -m "ci: add CodeQL analysis workflow"
git push origin main
```

---

## 📊 Parte 3: Analizar Resultados (10 min)

### Paso 3.1: Verificar ejecución del workflow

```
Repository → Actions → CodeQL Analysis
```

Espera a que el workflow complete (~2-5 minutos para JavaScript).

### Paso 3.2: Ver alertas de seguridad

```
Repository → Security → Code scanning alerts
```

### Paso 3.3: Analizar una alerta

Deberías ver alertas similares a:

| Alerta            | Severidad   | Archivo   |
| ----------------- | ----------- | --------- |
| SQL Injection     | 🔴 Critical | app.js:19 |
| XSS               | 🟠 High     | app.js:28 |
| Path Traversal    | 🟠 High     | app.js:35 |
| Command Injection | 🔴 Critical | app.js:43 |

### Paso 3.4: Examinar detalles de alerta

Haz clic en "SQL Injection" para ver:

```
Source: req.query.id (línea 18)
   ↓
Sink: db.query(query) (línea 20)

El input del usuario fluye directamente al query SQL
sin sanitización.
```

---

## 🔧 Parte 4: Corregir Vulnerabilidades (10 min)

### Paso 4.1: Corregir SQL Injection

```javascript
// ❌ ANTES - Vulnerable
app.get("/user", (req, res) => {
  const userId = req.query.id;
  const query = `SELECT * FROM users WHERE id = ${userId}`;
  db.query(query, (err, results) => {
    res.json(results);
  });
});

// ✅ DESPUÉS - Seguro (parameterized query)
app.get("/user", (req, res) => {
  const userId = req.query.id;
  // ¿Qué hace?: Usa placeholder ? para parámetros
  // ¿Por qué?: Evita SQL injection
  // ¿Para qué sirve?: El driver escapa automáticamente
  const query = "SELECT * FROM users WHERE id = ?";
  db.query(query, [userId], (err, results) => {
    if (err) {
      res.status(500).json({ error: "Database error" });
      return;
    }
    res.json(results);
  });
});
```

### Paso 4.2: Corregir XSS

```javascript
// ❌ ANTES - Vulnerable
app.get("/search", (req, res) => {
  const searchTerm = req.query.q;
  res.send(`<h1>Resultados para: ${searchTerm}</h1>`);
});

// ✅ DESPUÉS - Seguro (sanitización)
const escapeHtml = require("escape-html");

app.get("/search", (req, res) => {
  const searchTerm = req.query.q;
  // ¿Qué hace?: Escapa caracteres HTML especiales
  // ¿Por qué?: Evita ejecución de scripts maliciosos
  const safeTerm = escapeHtml(searchTerm);
  res.send(`<h1>Resultados para: ${safeTerm}</h1>`);
});
```

### Paso 4.3: Corregir Path Traversal

```javascript
// ❌ ANTES - Vulnerable
app.get("/file", (req, res) => {
  const filename = req.query.name;
  res.sendFile(`/uploads/${filename}`);
});

// ✅ DESPUÉS - Seguro (validación de path)
const path = require("path");

app.get("/file", (req, res) => {
  const filename = req.query.name;
  // ¿Qué hace?: Obtiene solo el nombre del archivo
  // ¿Por qué?: Evita ../../../etc/passwd
  const safeName = path.basename(filename);
  const uploadDir = path.resolve(__dirname, "uploads");
  const filePath = path.join(uploadDir, safeName);

  // Verificar que está dentro del directorio permitido
  if (!filePath.startsWith(uploadDir)) {
    return res.status(403).send("Access denied");
  }

  res.sendFile(filePath);
});
```

### Paso 4.4: Corregir Command Injection

```javascript
// ❌ ANTES - Vulnerable
app.get("/ping", (req, res) => {
  const host = req.query.host;
  exec(`ping -c 1 ${host}`, (err, stdout) => {
    res.send(stdout);
  });
});

// ✅ DESPUÉS - Seguro (validación + execFile)
const { execFile } = require("child_process");
const validator = require("validator");

app.get("/ping", (req, res) => {
  const host = req.query.host;

  // ¿Qué hace?: Valida que sea IP o dominio válido
  // ¿Por qué?: Evita ; rm -rf / u otros comandos
  if (!validator.isIP(host) && !validator.isFQDN(host)) {
    return res.status(400).send("Invalid host");
  }

  // ¿Qué hace?: execFile no usa shell, pasa args como array
  // ¿Para qué sirve?: Imposible inyectar comandos
  execFile("ping", ["-c", "1", host], (err, stdout) => {
    if (err) {
      return res.status(500).send("Ping failed");
    }
    res.send(stdout);
  });
});
```

### Paso 4.5: Commit y push de correcciones

```bash
# ¿Qué hace?: Sube las correcciones de seguridad
git add app.js
git commit -m "fix: resolve CodeQL security vulnerabilities

- Fix SQL injection with parameterized queries
- Fix XSS with HTML escaping
- Fix path traversal with basename validation
- Fix command injection with execFile and validation"

git push origin main
```

---

## ✅ Verificación Final

### Checklist de Completado

- [ ] Repository creado con código vulnerable
- [ ] CodeQL workflow configurado y ejecutado
- [ ] Al menos 3 alertas identificadas
- [ ] Al menos 2 vulnerabilidades corregidas
- [ ] Nuevo análisis muestra menos alertas

### Ver Alertas Cerradas

```
Security → Code scanning alerts → Closed
```

Las alertas corregidas aparecerán como "Fixed in [commit]".

---

## 📝 Preguntas de Reflexión

1. ¿Por qué SQL Injection es considerada "Critical"?
2. ¿Qué diferencia hay entre `exec` y `execFile`?
3. ¿Cómo podría un atacante explotar XSS?
4. ¿Por qué es importante ejecutar CodeQL en PRs?

---

## 🎁 Bonus: Branch Protection

Configura que PRs no puedan mergearse si tienen alertas críticas:

```
Settings → Branches → Branch protection rules → main
→ Require status checks → CodeQL
```

---

## 🔗 Recursos

- [CodeQL for JavaScript](https://codeql.github.com/docs/codeql-language-guides/codeql-for-javascript/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Database](https://cwe.mitre.org/)

---

[⬅️ Volver a Ejercicios](../README.md) | [Siguiente: Ejercicio 02 →](../ejercicio-02-dependabot/README.md)
