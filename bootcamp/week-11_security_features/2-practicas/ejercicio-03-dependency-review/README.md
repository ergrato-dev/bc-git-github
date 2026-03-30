# 📋 Ejercicio 03: Dependency Review

> **Duración**: 35 minutos
> 
> **Objetivo**: Implementar Dependency Review Action para bloquear PRs con dependencias vulnerables.

---

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio serás capaz de:

- ✅ Configurar dependency-review-action en workflows
- ✅ Bloquear PRs con dependencias vulnerables
- ✅ Configurar severidades y licencias
- ✅ Interpretar resultados del análisis

---

## 📋 Requisitos Previos

- Repository con dependencias (npm, pip, etc.)
- Conocimiento básico de GitHub Actions
- Acceso para crear workflows

---

## 🤔 ¿Qué es Dependency Review?

**Dependency Review** analiza las dependencias en cada Pull Request y muestra:
- Nuevas dependencias agregadas
- Dependencias removidas
- Vulnerabilidades en nuevas dependencias
- Licencias de las dependencias

```
┌─────────────────────────────────────────────────────────┐
│              DEPENDENCY REVIEW FLOW                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  PR Created/Updated                                     │
│        ↓                                               │
│  Dependency Review Action runs                         │
│        ↓                                               │
│  Compara base branch vs PR branch                      │
│        ↓                                               │
│  Detecta: + adds, - removes, ⚠️ vulnerables            │
│        ↓                                               │
│  ❌ Fail si hay critical/high CVEs                     │
│  ✅ Pass si está limpio                                │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🏗️ Parte 1: Preparar Repository (8 min)

### Paso 1.1: Usar repository existente o crear nuevo

```bash
# Opción A: Usar el repo del ejercicio anterior
cd security-lab-dependabot

# Opción B: Crear nuevo
mkdir security-lab-dependency-review
cd security-lab-dependency-review
git init
```

### Paso 1.2: Asegurar package.json base (seguro)

```json
{
  "name": "security-lab-dependency-review",
  "version": "1.0.0",
  "description": "Lab para Dependency Review",
  "dependencies": {
    "express": "4.18.2",
    "lodash": "4.17.21"
  },
  "devDependencies": {
    "jest": "29.7.0"
  }
}
```

### Paso 1.3: Commit inicial a main

```bash
git add .
git commit -m "feat: initial secure dependencies"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/security-lab-dependency-review.git
git push -u origin main
```

---

## 🔧 Parte 2: Configurar Dependency Review Action (10 min)

### Paso 2.1: Crear workflow básico

Crea `.github/workflows/dependency-review.yml`:

```yaml
# ¿Qué hace?: Analiza dependencias en cada Pull Request
# ¿Por qué?: Prevenir merge de dependencias vulnerables
# ¿Para qué sirve?: Detectar problemas ANTES del merge

name: "Dependency Review"

on:
  pull_request:
    branches: [main, develop]

permissions:
  contents: read
  pull-requests: write

jobs:
  dependency-review:
    name: "🔍 Review Dependencies"
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Dependency Review
        uses: actions/dependency-review-action@v4
        with:
          # ¿Qué hace?: Falla si hay vulnerabilidades high o critical
          fail-on-severity: moderate
          
          # ¿Qué hace?: Permite algunas licencias comunes
          allow-licenses: MIT, Apache-2.0, BSD-2-Clause, BSD-3-Clause, ISC
          
          # ¿Qué hace?: Bloquea licencias problemáticas
          deny-licenses: GPL-3.0, AGPL-3.0
          
          # ¿Qué hace?: Comenta en el PR con los resultados
          comment-summary-in-pr: always
```

### Paso 2.2: Commit del workflow

```bash
git add .github/workflows/dependency-review.yml
git commit -m "ci: add dependency review workflow"
git push origin main
```

---

## 🧪 Parte 3: Probar con PR Vulnerable (10 min)

### Paso 3.1: Crear branch con dependencia vulnerable

```bash
# ¿Qué hace?: Crea branch para agregar dependencia vulnerable
git checkout -b add-vulnerable-dep
```

### Paso 3.2: Agregar dependencia vulnerable

Edita `package.json` para agregar una versión vulnerable:

```json
{
  "name": "security-lab-dependency-review",
  "version": "1.0.0",
  "description": "Lab para Dependency Review",
  "dependencies": {
    "express": "4.18.2",
    "lodash": "4.17.21",
    "axios": "0.21.0",
    "minimist": "1.2.0"
  },
  "devDependencies": {
    "jest": "29.7.0"
  }
}
```

> **Nota**: `axios@0.21.0` y `minimist@1.2.0` tienen vulnerabilidades conocidas.

### Paso 3.3: Commit y push

```bash
git add package.json
git commit -m "feat: add axios and minimist dependencies"
git push origin add-vulnerable-dep
```

### Paso 3.4: Crear Pull Request

```
Repository → Pull requests → New pull request
Base: main ← Compare: add-vulnerable-dep
→ Create pull request
```

### Paso 3.5: Observar resultado del workflow

El workflow debería **FALLAR** con un mensaje similar a:

```
❌ Dependency Review

Found vulnerabilities in new dependencies:

| Package   | Version | Severity | Advisory |
|-----------|---------|----------|----------|
| axios     | 0.21.0  | High     | GHSA-... |
| minimist  | 1.2.0   | Critical | GHSA-... |

The following vulnerabilities were found:
- axios@0.21.0: Regular Expression Denial of Service
- minimist@1.2.0: Prototype Pollution
```

---

## ⚙️ Parte 4: Configuración Avanzada (7 min)

### Paso 4.1: Configuración con más opciones

Actualiza `.github/workflows/dependency-review.yml`:

```yaml
name: "Dependency Review"

on:
  pull_request:
    branches: [main, develop]

permissions:
  contents: read
  pull-requests: write

jobs:
  dependency-review:
    name: "🔍 Review Dependencies"
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Dependency Review
        uses: actions/dependency-review-action@v4
        with:
          # ════════════════════════════════════════════════
          # CONFIGURACIÓN DE VULNERABILIDADES
          # ════════════════════════════════════════════════
          
          # ¿Qué hace?: Nivel mínimo de severidad para fallar
          # Opciones: low, moderate, high, critical
          fail-on-severity: moderate
          
          # ¿Qué hace?: Permite vulnerabilidades específicas (por GHSA ID)
          # Usar cuando hay falso positivo o no aplica a tu uso
          # allow-ghsas: GHSA-xxxx-xxxx-xxxx, GHSA-yyyy-yyyy-yyyy
          
          # ════════════════════════════════════════════════
          # CONFIGURACIÓN DE LICENCIAS
          # ════════════════════════════════════════════════
          
          # ¿Qué hace?: Solo permite estas licencias
          allow-licenses: >-
            MIT,
            Apache-2.0,
            BSD-2-Clause,
            BSD-3-Clause,
            ISC,
            0BSD,
            CC0-1.0,
            Unlicense
          
          # ¿Qué hace?: Bloquea explícitamente estas licencias
          deny-licenses: >-
            GPL-3.0,
            AGPL-3.0,
            LGPL-3.0,
            SSPL-1.0
          
          # ¿Qué hace?: Falla si hay licencias desconocidas
          # fail-on-unknown-licenses: true
          
          # ════════════════════════════════════════════════
          # CONFIGURACIÓN DE SCOPES
          # ════════════════════════════════════════════════
          
          # ¿Qué hace?: Solo analiza dependencias de producción
          # Opciones: unknown, runtime, development
          # deny-scopes: development
          
          # ════════════════════════════════════════════════
          # CONFIGURACIÓN DE OUTPUT
          # ════════════════════════════════════════════════
          
          # ¿Qué hace?: Comenta resultados en el PR
          # Opciones: always, on-failure, never
          comment-summary-in-pr: always
          
          # ¿Qué hace?: Muestra paquetes permitidos para auditoría
          # show-openssf-scorecard: true
          
          # ¿Qué hace?: Alerta sobre nuevas dependencias (no solo vulnerables)
          warn-only: false
```

### Paso 4.2: Commit actualización

```bash
git checkout main
git add .github/workflows/dependency-review.yml
git commit -m "ci: enhance dependency review configuration"
git push origin main
```

---

## ✅ Parte 5: Resolver y Mergear (5 min)

### Paso 5.1: Actualizar dependencias en el PR

En el branch `add-vulnerable-dep`, actualiza las versiones:

```bash
git checkout add-vulnerable-dep
```

Edita `package.json` con versiones seguras:

```json
{
  "dependencies": {
    "express": "4.18.2",
    "lodash": "4.17.21",
    "axios": "1.6.0",
    "minimist": "1.2.8"
  }
}
```

### Paso 5.2: Commit y push fix

```bash
git add package.json
git commit -m "fix: update to secure versions of axios and minimist"
git push origin add-vulnerable-dep
```

### Paso 5.3: Verificar que el workflow pasa

El workflow ahora debería **PASAR**:

```
✅ Dependency Review

No vulnerabilities found in dependency changes.

New dependencies:
- axios@1.6.0 (MIT)
- minimist@1.2.8 (MIT)
```

### Paso 5.4: Mergear el PR

Una vez que el check pasa, mergea el PR.

---

## 🛡️ Bonus: Branch Protection

### Requerir Dependency Review para merge

```
Settings → Branches → Branch protection rules → main
→ Require status checks to pass
→ Search: "Dependency Review"
→ ✅ Seleccionar
→ Save changes
```

Ahora los PRs no podrán mergearse si tienen dependencias vulnerables.

---

## ✅ Verificación Final

### Checklist de Completado

- [ ] Workflow de dependency-review creado
- [ ] PR con dependencias vulnerables creado
- [ ] Workflow falló correctamente
- [ ] Dependencias actualizadas a versiones seguras
- [ ] Workflow pasó después del fix
- [ ] PR mergeado exitosamente
- [ ] (Bonus) Branch protection configurada

---

## 📝 Preguntas de Reflexión

1. ¿Por qué revisar dependencias en PRs y no solo en main?
2. ¿Cuándo usarías `allow-ghsas` para ignorar una vulnerabilidad?
3. ¿Por qué bloquear licencias como GPL-3.0 en proyectos comerciales?
4. ¿Qué diferencia hay entre `fail-on-severity: high` vs `moderate`?

---

## 🔗 Recursos

- [Dependency Review Action](https://github.com/actions/dependency-review-action)
- [SPDX License List](https://spdx.org/licenses/)
- [GitHub Advisory Database](https://github.com/advisories)

---

[⬅️ Ejercicio 02](../ejercicio-02-dependabot/README.md) | [Siguiente: Ejercicio 04 →](../ejercicio-04-secret-scanning/README.md)
