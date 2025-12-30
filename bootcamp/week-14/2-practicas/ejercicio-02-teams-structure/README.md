# Ejercicio 02: Teams & Structure

## 🎯 Objetivo

Diseñar e implementar una estructura de equipos jerárquica en GitHub con permisos diferenciados y archivo CODEOWNERS.

**Duración**: 40 minutos

---

## 📋 Escenario

TechStartup Inc. tiene la siguiente estructura organizacional:

```
TechStartup Inc.
├── Engineering (departamento)
│   ├── Backend Team
│   ├── Frontend Team
│   └── DevOps Team
├── Product
│   └── Product Managers
└── Security
    └── Security Team
```

Necesitas crear esta estructura en GitHub con permisos apropiados.

---

## 👥 Parte 1: Crear Teams Padre (10 min)

### Paso 1.1: Crear team Engineering

```bash
# ¿QUÉ VAMOS A HACER?: Crear el team padre "Engineering"
# ¿POR QUÉ?: Agrupar todos los equipos de desarrollo
# ¿PARA QUÉ SIRVE?: Gestión jerárquica de permisos

gh api \
  --method POST \
  orgs/techstartup-bootcamp-TUNOMBRE/teams \
  -f name='Engineering' \
  -f description='Engineering Department - All development teams' \
  -f privacy='closed'

# Resultado esperado: JSON con datos del team creado
```

### Paso 1.2: Crear team Product

```bash
# ¿QUÉ VAMOS A HACER?: Crear team "Product"
# ¿POR QUÉ?: Separar producto de engineering
# ¿PARA QUÉ SIRVE?: Product managers con acceso diferenciado

gh api \
  --method POST \
  orgs/techstartup-bootcamp-TUNOMBRE/teams \
  -f name='Product' \
  -f description='Product Management team' \
  -f privacy='closed'
```

### Paso 1.3: Crear team Security

```bash
# ¿QUÉ VAMOS A HACER?: Crear team "Security"
# ¿POR QUÉ?: Equipo de seguridad separado
# ¿PARA QUÉ SIRVE?: Acceso a security features y auditoría

gh api \
  --method POST \
  orgs/techstartup-bootcamp-TUNOMBRE/teams \
  -f name='Security' \
  -f description='Security team - vulnerability management' \
  -f privacy='closed'
```

---

## 🏗️ Parte 2: Crear Teams Hijos (10 min)

### Paso 2.1: Obtener ID del team padre

```bash
# ¿QUÉ VAMOS A HACER?: Obtener el ID del team Engineering
# ¿POR QUÉ?: Necesitamos el ID para crear teams hijos
# ¿PARA QUÉ SIRVE?: Establecer jerarquía de teams

ENGINEERING_ID=$(gh api \
  orgs/techstartup-bootcamp-TUNOMBRE/teams/engineering \
  --jq '.id')

echo "Engineering Team ID: $ENGINEERING_ID"
```

### Paso 2.2: Crear Backend Team (hijo de Engineering)

```bash
# ¿QUÉ VAMOS A HACER?: Crear team Backend como hijo de Engineering
# ¿POR QUÉ?: Estructura jerárquica
# ¿PARA QUÉ SIRVE?: Herencia de permisos + permisos específicos

gh api \
  --method POST \
  orgs/techstartup-bootcamp-TUNOMBRE/teams \
  -f name='Backend' \
  -f description='Backend development team' \
  -f privacy='closed' \
  -F parent_team_id=$ENGINEERING_ID
```

### Paso 2.3: Crear Frontend Team

```bash
gh api \
  --method POST \
  orgs/techstartup-bootcamp-TUNOMBRE/teams \
  -f name='Frontend' \
  -f description='Frontend development team' \
  -f privacy='closed' \
  -F parent_team_id=$ENGINEERING_ID
```

### Paso 2.4: Crear DevOps Team

```bash
gh api \
  --method POST \
  orgs/techstartup-bootcamp-TUNOMBRE/teams \
  -f name='DevOps' \
  -f description='DevOps and infrastructure team' \
  -f privacy='closed' \
  -F parent_team_id=$ENGINEERING_ID
```

### Paso 2.5: Verificar estructura

```bash
# ¿QUÉ VAMOS A HACER?: Verificar todos los teams creados
# ¿POR QUÉ?: Confirmar estructura correcta
# ¿PARA QUÉ SIRVE?: Validación antes de asignar permisos

gh api orgs/techstartup-bootcamp-TUNOMBRE/teams \
  --jq '.[] | "\(.name) (parent: \(.parent.name // "none"))"'

# Resultado esperado:
# Engineering (parent: none)
# Product (parent: none)
# Security (parent: none)
# Backend (parent: Engineering)
# Frontend (parent: Engineering)
# DevOps (parent: Engineering)
```

---

## 📁 Parte 3: Crear Repository de Prueba (5 min)

### Paso 3.1: Crear repositorio

```bash
# ¿QUÉ VAMOS A HACER?: Crear repo para probar permisos
# ¿POR QUÉ?: Necesitamos un repo para asignar team permissions
# ¿PARA QUÉ SIRVE?: Práctica de permisos de teams

gh repo create techstartup-bootcamp-TUNOMBRE/webapp \
  --private \
  --description "Main web application" \
  --add-readme
```

### Paso 3.2: Crear más repos

```bash
# Crear repo de backend
gh repo create techstartup-bootcamp-TUNOMBRE/api-service \
  --private \
  --description "Backend API service" \
  --add-readme

# Crear repo de infra
gh repo create techstartup-bootcamp-TUNOMBRE/infrastructure \
  --private \
  --description "Infrastructure as Code" \
  --add-readme
```

---

## 🔐 Parte 4: Asignar Permisos (10 min)

### Paso 4.1: Permisos para webapp

```bash
# ¿QUÉ VAMOS A HACER?: Asignar permisos a teams en webapp
# ¿POR QUÉ?: Cada team necesita nivel de acceso apropiado
# ¿PARA QUÉ SIRVE?: Control de acceso basado en roles

# Engineering: Write (todos pueden contribuir)
gh api \
  --method PUT \
  orgs/techstartup-bootcamp-TUNOMBRE/teams/engineering/repos/techstartup-bootcamp-TUNOMBRE/webapp \
  -f permission='push'

# Product: Read (pueden ver, no modificar código)
gh api \
  --method PUT \
  orgs/techstartup-bootcamp-TUNOMBRE/teams/product/repos/techstartup-bootcamp-TUNOMBRE/webapp \
  -f permission='pull'

# Security: Triage (gestión de issues, security advisories)
gh api \
  --method PUT \
  orgs/techstartup-bootcamp-TUNOMBRE/teams/security/repos/techstartup-bootcamp-TUNOMBRE/webapp \
  -f permission='triage'
```

### Paso 4.2: Permisos para infrastructure

```bash
# ¿QUÉ VAMOS A HACER?: Solo DevOps con write en infra
# ¿POR QUÉ?: Infraestructura es crítica, acceso limitado
# ¿PARA QUÉ SIRVE?: Seguridad de infraestructura

# DevOps: Admin (control total de infra repo)
gh api \
  --method PUT \
  orgs/techstartup-bootcamp-TUNOMBRE/teams/devops/repos/techstartup-bootcamp-TUNOMBRE/infrastructure \
  -f permission='admin'

# Engineering padre: Read (pueden ver, no modificar)
gh api \
  --method PUT \
  orgs/techstartup-bootcamp-TUNOMBRE/teams/engineering/repos/techstartup-bootcamp-TUNOMBRE/infrastructure \
  -f permission='pull'

# Security: Write (pueden actualizar security configs)
gh api \
  --method PUT \
  orgs/techstartup-bootcamp-TUNOMBRE/teams/security/repos/techstartup-bootcamp-TUNOMBRE/infrastructure \
  -f permission='push'
```

### Paso 4.3: Verificar permisos

```bash
# ¿QUÉ VAMOS A HACER?: Listar permisos de un repo
# ¿POR QUÉ?: Verificar asignación correcta
# ¿PARA QUÉ SIRVE?: Auditoría de accesos

gh api repos/techstartup-bootcamp-TUNOMBRE/webapp/teams \
  --jq '.[] | "\(.name): \(.permission)"'

# Resultado esperado:
# Engineering: push
# Product: pull
# Security: triage
```

---

## 📝 Parte 5: CODEOWNERS (5 min)

### Paso 5.1: Crear archivo CODEOWNERS

```bash
# ¿QUÉ VAMOS A HACER?: Crear CODEOWNERS en webapp
# ¿POR QUÉ?: Automatizar asignación de reviewers
# ¿PARA QUÉ SIRVE?: PRs van al equipo correcto automáticamente

# Clonar repo primero
gh repo clone techstartup-bootcamp-TUNOMBRE/webapp
cd webapp

# Crear directorio .github
mkdir -p .github

# Crear CODEOWNERS
cat > .github/CODEOWNERS << 'EOF'
# CODEOWNERS para TechStartup webapp
# https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners

# Default owners para todo
* @techstartup-bootcamp-TUNOMBRE/engineering

# Frontend específico
/src/frontend/**    @techstartup-bootcamp-TUNOMBRE/frontend
/public/**          @techstartup-bootcamp-TUNOMBRE/frontend
*.css               @techstartup-bootcamp-TUNOMBRE/frontend
*.html              @techstartup-bootcamp-TUNOMBRE/frontend

# Backend específico
/src/api/**         @techstartup-bootcamp-TUNOMBRE/backend
/src/services/**    @techstartup-bootcamp-TUNOMBRE/backend
/src/database/**    @techstartup-bootcamp-TUNOMBRE/backend

# DevOps (CI/CD, Docker, Infra)
/.github/**         @techstartup-bootcamp-TUNOMBRE/devops
/Dockerfile         @techstartup-bootcamp-TUNOMBRE/devops
/docker-compose.*   @techstartup-bootcamp-TUNOMBRE/devops
/.gitlab-ci.yml     @techstartup-bootcamp-TUNOMBRE/devops

# Security team para archivos sensibles
/security/**        @techstartup-bootcamp-TUNOMBRE/security
**/security*        @techstartup-bootcamp-TUNOMBRE/security
.env.example        @techstartup-bootcamp-TUNOMBRE/security

# Docs - Product puede aprobar
/docs/**            @techstartup-bootcamp-TUNOMBRE/product
*.md                @techstartup-bootcamp-TUNOMBRE/product
EOF
```

### Paso 5.2: Commit y Push

```bash
# ¿QUÉ VAMOS A HACER?: Subir CODEOWNERS al repo
# ¿POR QUÉ?: Activar la funcionalidad
# ¿PARA QUÉ SIRVE?: GitHub usará este archivo para asignar reviewers

git add .github/CODEOWNERS
git commit -m "chore: add CODEOWNERS for automated review assignment"
git push origin main
```

### Paso 5.3: Verificar funcionamiento

```yaml
# En Settings → Branches → Branch protection rules
# Para branch main:
  
Require a pull request before merging: ✅
  Require approvals: 1
  Require review from Code Owners: ✅  # <-- Esto activa CODEOWNERS
```

---

## ✅ Checklist de Verificación

```markdown
## Teams & Structure - Verificación

### Teams Creados
- [ ] Engineering (padre)
- [ ] Product (padre)
- [ ] Security (padre)
- [ ] Backend (hijo de Engineering)
- [ ] Frontend (hijo de Engineering)
- [ ] DevOps (hijo de Engineering)

### Repositorios
- [ ] webapp creado
- [ ] api-service creado
- [ ] infrastructure creado

### Permisos Asignados
- [ ] Engineering → webapp: write
- [ ] Product → webapp: read
- [ ] Security → webapp: triage
- [ ] DevOps → infrastructure: admin

### CODEOWNERS
- [ ] Archivo creado en .github/CODEOWNERS
- [ ] Pushado a main
- [ ] (Opcional) Branch protection con code owners habilitado
```

---

## 🔧 Troubleshooting

### Error: "Team not found"

```bash
# Verificar que el team existe
gh api orgs/techstartup-bootcamp-TUNOMBRE/teams --jq '.[].slug'

# Los slugs usan lowercase y guiones
# "Backend Team" → "backend-team"
```

### Error: "Repository not found"

```bash
# Verificar repos de la org
gh repo list techstartup-bootcamp-TUNOMBRE

# Asegurar formato correcto: org/repo
```

---

## 📚 Recursos

- [Creating Teams](https://docs.github.com/en/organizations/organizing-members-into-teams/creating-a-team)
- [Team Permissions](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/repository-roles-for-an-organization)
- [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)

---

## ➡️ Siguiente Ejercicio

Continúa con [Ejercicio 03 - Branch Protection](../ejercicio-03-branch-protection/README.md)
