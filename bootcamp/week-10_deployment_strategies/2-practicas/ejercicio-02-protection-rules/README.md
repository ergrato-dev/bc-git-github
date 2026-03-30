# 🛡️ Ejercicio 02: Protection Rules

## 📋 Información del Ejercicio

| Campo | Detalle |
|-------|---------|
| **Duración** | 35 minutos |
| **Dificultad** | Intermedia |
| **Prerrequisitos** | Ejercicio 01 - Environments |
| **Objetivos** | Configurar required reviewers, wait timer y deployment branches |

---

## 🎯 Objetivos

Al completar este ejercicio, habrás:

- [ ] Configurado required reviewers para production
- [ ] Implementado wait timer para staging
- [ ] Restringido deployment branches
- [ ] Probado el flujo de aprobación manual

---

## 📝 Escenario

Tu equipo necesita agregar controles de seguridad:
- **Staging**: Esperar 2 minutos antes de deployar (tiempo para cancelar)
- **Production**: Requiere aprobación de un reviewer, solo desde `main`

---

## 🚀 Instrucciones

### Parte 1: Configurar Wait Timer en Staging (5 min)

```bash
# EJERCICIO: Agregar wait timer a staging
# ¿QUÉ VAMOS A HACER?: Configurar delay de 2 minutos antes del deploy
# ¿POR QUÉ LO HACEMOS?: Dar tiempo para detectar problemas y cancelar
# ¿PARA QUÉ SIRVE?: Reducir riesgo de deployments problemáticos
```

1. Ve a **Settings** → **Environments** → `staging`
2. En **Environment protection rules**:
   - ✅ Marca **Wait timer**
   - Ingresa: `2` (minutos)
3. Click **Save protection rules**

### Parte 2: Configurar Required Reviewers en Production (10 min)

```bash
# EJERCICIO: Agregar aprobación requerida para production
# ¿QUÉ VAMOS A HACER?: Configurar que alguien debe aprobar el deploy
# ¿POR QUÉ LO HACEMOS?: Evitar deployments accidentales a producción
# ¿PARA QUÉ SIRVE?: Control de cambios y auditoría
```

1. Ve a **Settings** → **Environments** → `production`
2. En **Environment protection rules**:
   - ✅ Marca **Required reviewers**
   - Agrega tu propio usuario (para pruebas)
   - En un equipo real: agregar `@tech-leads` o reviewers designados
3. Click **Save protection rules**

### Parte 3: Configurar Deployment Branches (5 min)

```bash
# EJERCICIO: Restringir qué branches pueden deployar a production
# ¿QUÉ VAMOS A HACER?: Limitar deployments solo desde main
# ¿POR QUÉ LO HACEMOS?: Evitar deployar código no revisado
# ¿PARA QUÉ SIRVE?: Asegurar que solo código aprobado llega a producción
```

1. Ve a **Settings** → **Environments** → `production`
2. En **Deployment branches**:
   - Selecciona **Selected branches**
   - Click **Add deployment branch rule**
   - Ingresa: `main`
3. Click **Save protection rules**

### Parte 4: Actualizar Workflow con Información de Protection (10 min)

Actualiza `.github/workflows/deploy.yml` para mostrar información sobre las protecciones:

```yaml
name: Protected Deploy Pipeline

on:
  push:
    branches: [main, develop]    # Trigger en ambas branches
  workflow_dispatch:

jobs:
  build:
    name: 🔨 Build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build info
        run: |
          echo "📦 Building from: ${{ github.ref_name }}"
          echo "🔖 Commit: ${{ github.sha }}"

  deploy-dev:
    name: 🌍 Development
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: development
      url: https://dev.example.com
    steps:
      - name: Deploy to Development
        run: |
          echo "════════════════════════════════════════"
          echo "🌍 DEVELOPMENT - No Protection Rules"
          echo "════════════════════════════════════════"
          echo "✅ Deploy automático sin restricciones"
          echo "📌 Branch: ${{ github.ref_name }}"

  deploy-staging:
    name: 🎭 Staging (⏱️ Wait Timer)
    needs: deploy-dev
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.example.com
    steps:
      - name: Deploy to Staging
        run: |
          echo "════════════════════════════════════════"
          echo "🎭 STAGING - Wait Timer Protection"
          echo "════════════════════════════════════════"
          echo "⏱️ Este job esperó 2 minutos antes de ejecutarse"
          echo "📌 El timer da tiempo para:"
          echo "   - Detectar problemas en development"
          echo "   - Cancelar el deployment si es necesario"
          echo "   - Revisar los cambios antes de staging"
          echo ""
          echo "✅ Timer completado, deployando..."

  deploy-prod:
    name: 🏭 Production (👤 Review + 🌿 Branch)
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://app.example.com
    steps:
      - name: Check branch
        run: |
          echo "════════════════════════════════════════"
          echo "🏭 PRODUCTION - Multiple Protections"
          echo "════════════════════════════════════════"
          echo ""
          echo "🔐 Protection Rules activas:"
          echo "   1. 👤 Required Reviewers: 1 persona"
          echo "   2. 🌿 Deployment Branches: solo 'main'"
          echo ""
          echo "📌 Branch actual: ${{ github.ref_name }}"
          
          if [ "${{ github.ref_name }}" != "main" ]; then
            echo "❌ ERROR: Solo se puede deployar desde 'main'"
            echo "   Branch actual '${{ github.ref_name }}' no permitido"
            exit 1
          fi
          
          echo "✅ Branch válido para production"
      
      - name: Deploy to Production
        run: |
          echo ""
          echo "🚀 Deployment aprobado y ejecutándose..."
          echo "📌 Este job requirió:"
          echo "   - ✅ Aprobación manual de un reviewer"
          echo "   - ✅ Push desde branch 'main'"
          echo ""
          echo "🎉 Production deployment complete!"
```

### Parte 5: Probar las Protection Rules (5 min)

#### Test 1: Verificar Wait Timer en Staging

```bash
# Push a main para triggear el workflow
git add .
git commit -m "test: verify protection rules"
git push origin main
```

**Observar en Actions:**
1. `build` y `deploy-dev` se ejecutan inmediatamente
2. `deploy-staging` muestra "⏳ Waiting" por 2 minutos
3. Después del timer, `deploy-staging` se ejecuta

#### Test 2: Verificar Required Reviewers en Production

**En el workflow run:**
1. `deploy-prod` muestra "⏸️ Waiting for review"
2. Ve a la página del workflow run
3. Click en **Review pending deployments**
4. Selecciona `production`
5. Click **Approve and deploy**
6. El job `deploy-prod` se ejecuta

#### Test 3: Verificar Branch Restriction

```bash
# Crear branch de prueba
git checkout -b feature/test-branch

# Hacer un cambio
echo "test" >> test.txt
git add .
git commit -m "test: branch restriction"
git push origin feature/test-branch

# Observar en Actions:
# - El job deploy-prod debería fallar con error de branch
```

---

## ✅ Verificación

### Checklist de Completado

- [ ] Staging tiene wait timer de 2 minutos configurado
- [ ] Production tiene required reviewers configurado
- [ ] Production solo permite deployments desde main
- [ ] El workflow muestra "Waiting" durante el timer
- [ ] El workflow muestra "Waiting for review" para production
- [ ] Puedes aprobar el deployment desde la UI
- [ ] Deployments desde otras branches fallan para production

### Screenshots Esperados

**Durante Wait Timer:**
```
┌────────────────────────────────────────┐
│ 🟡 deploy-staging                      │
│    ⏳ Waiting (1:23 remaining)         │
│    Environment: staging                │
└────────────────────────────────────────┘
```

**Durante Required Review:**
```
┌────────────────────────────────────────┐
│ 🟡 deploy-prod                         │
│    ⏸️ Waiting for review               │
│    Environment: production             │
│                                        │
│    [Review pending deployments]        │
└────────────────────────────────────────┘
```

---

## 🎯 Desafío Extra

1. Agrega un segundo reviewer a production
2. Configura que **todos** los reviewers deben aprobar
3. Aumenta el wait timer de staging a 5 minutos
4. Agrega `release/*` como branches permitidos para production

---

## 📚 Recursos

- [GitHub Docs: Required reviewers](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#required-reviewers)
- [GitHub Docs: Wait timer](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#wait-timer)

---

**Siguiente ejercicio**: [03 - Approval Workflow](../ejercicio-03-approval-workflow/README.md)
