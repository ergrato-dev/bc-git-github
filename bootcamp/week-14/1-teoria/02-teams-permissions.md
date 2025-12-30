# Lección 02: Teams & Permissions

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección, serás capaz de:

- Crear y estructurar Teams jerárquicos
- Asignar permisos granulares a repositories
- Implementar CODEOWNERS
- Aplicar el principio de least privilege

---

## 📚 Conceptos Teóricos

### ¿Qué son los Teams?

Los **Teams** son grupos de miembros dentro de una Organization que:

- Simplifican la gestión de permisos
- Reflejan la estructura organizacional
- Facilitan comunicación (@mentions)
- Permiten jerarquías (nested teams)

![Teams & Permissions](../0-assets/02-teams-permissions.svg)

---

## 🏗️ Estructura de Teams

### Diseño de Jerarquía

```yaml
# Ejemplo de estructura típica

engineering (Parent Team)
├── frontend
│   ├── web-team
│   └── mobile-team
├── backend
│   ├── api-team
│   └── data-team
└── platform
    ├── devops
    └── sre

product
├── design
└── pm

security
├── appsec
└── infrasec
```

### Nested Teams (Child Teams)

```yaml
Beneficios:
  - Herencia de permisos
  - Estructura organizacional clara
  - Mentions en cascada (@engineering notifica a todos)

Reglas:
  - Child hereda permisos del parent
  - Child puede tener permisos adicionales
  - Child NO puede tener menos permisos que parent
```

---

## 👥 Crear Teams

### Via GitHub UI

```yaml
Pasos:
  1. Organization → Teams → New team
  2. Configurar:
     Team name: "backend"
     Description: "Backend development team"
     Parent team: "engineering" (opcional)
     Visibility: Visible (o Secret)
  3. Add members
  4. Asignar repositories
```

### Via GitHub CLI

```bash
# Crear team
gh api \
  --method POST \
  /orgs/NOMBRE-ORG/teams \
  -f name='backend' \
  -f description='Backend development team' \
  -f privacy='closed' \
  -f parent_team_id=123456  # Opcional

# Listar teams
gh api orgs/NOMBRE-ORG/teams --jq '.[].name'

# Ver miembros de un team
gh api orgs/NOMBRE-ORG/teams/backend/members --jq '.[].login'

# Agregar miembro a team
gh api \
  --method PUT \
  /orgs/NOMBRE-ORG/teams/backend/memberships/USERNAME \
  -f role='member'  # o 'maintainer'
```

---

## 🔐 Permission Levels

### Repository Permission Levels

```yaml
Read:
  - Clone y fetch
  - Ver issues y PRs
  - Comentar
  - Crear issues
  
Triage:
  - Todo de Read +
  - Manage issues y PRs
  - Apply labels
  - Close/reopen issues
  
Write:
  - Todo de Triage +
  - Push a branches
  - Merge PRs
  - Manage branches

Maintain:
  - Todo de Write +
  - Manage repository settings
  - Push to protected branches (con approval)
  - Manage webhooks
  
Admin:
  - Todo de Maintain +
  - Manage team access
  - Delete repository
  - Manage security settings
```

### Asignar Permissions a Teams

```bash
# Via UI: Repository → Settings → Collaborators and teams

# Via API: Agregar team a repo con permiso específico
gh api \
  --method PUT \
  /orgs/NOMBRE-ORG/teams/backend/repos/NOMBRE-ORG/api-service \
  -f permission='push'  # read, triage, push, maintain, admin
```

### Matriz de Permisos Típica

```yaml
Repository: api-service
Teams:
  backend: write       # Desarrollan activamente
  frontend: read       # Consultan API specs
  platform: maintain   # CI/CD y deploys
  security: read       # Code review de seguridad
  
Repository: infrastructure  
Teams:
  platform: admin      # Owners del repo
  backend: read        # Consultan configs
  security: maintain   # Security policies
  
Repository: web-app
Teams:
  frontend: write      # Desarrollan activamente
  backend: read        # Consultan
  design: triage       # Pueden manejar issues
```

---

## 👑 Team Roles

### Member vs Maintainer

```yaml
Team Member:
  - Permisos del team en repos
  - Puede ver otros miembros
  - Recibe mentions del team
  
Team Maintainer:
  - Todo de Member +
  - Agregar/remover miembros
  - Editar team settings
  - Responder a review requests del team
  - Gestionar nested teams
```

### Asignar Maintainers

```bash
# Via API
gh api \
  --method PUT \
  /orgs/NOMBRE-ORG/teams/backend/memberships/USERNAME \
  -f role='maintainer'

# Listar maintainers
gh api \
  orgs/NOMBRE-ORG/teams/backend/members?role=maintainer \
  --jq '.[].login'
```

---

## 📄 CODEOWNERS

### ¿Qué es CODEOWNERS?

Archivo que define quién debe revisar cambios en diferentes partes del código.

### Ubicación del Archivo

```yaml
Ubicaciones válidas (en orden de prioridad):
  1. .github/CODEOWNERS
  2. docs/CODEOWNERS
  3. CODEOWNERS (raíz)
```

### Sintaxis

```bash
# .github/CODEOWNERS

# Default owners para todo
* @org/engineering

# Frontend específico
/src/frontend/ @org/frontend
*.tsx @org/frontend
*.css @org/design

# Backend
/src/api/ @org/backend
/src/services/ @org/backend @org/security

# Infrastructure
/terraform/ @org/platform
/.github/workflows/ @org/devops
Dockerfile @org/devops

# Security-sensitive files
/src/auth/ @org/security @org/backend
*.pem @org/security
*secret* @org/security

# Documentation
/docs/ @org/product
*.md @org/product
README.md @org/engineering

# Specific files
package.json @org/frontend @org/devops
go.mod @org/backend
```

### CODEOWNERS con Branch Protection

```yaml
Branch Protection Rule:
  Require review from Code Owners: ✅
  
Efecto:
  - PRs que tocan archivos en CODEOWNERS
  - REQUIEREN approval de los code owners
  - No se puede mergear sin su approval
```

---

## 🛡️ Principio de Least Privilege

### Implementación

```yaml
Reglas:
  1. Base permissions org = None o Read
  2. Permisos específicos via teams
  3. Admin solo cuando es necesario
  4. Review periódico de accesos

Ejemplo:
  Junior Developer:
    - Team: frontend → Write en web-app
    - Team: docs → Write en documentation
    # No acceso a infrastructure
  
  Senior Developer:
    - Team: frontend → Write
    - Team: backend → Write  
    - Team: architecture → Read en todos
  
  Tech Lead:
    - Team: engineering → Maintain
    - Team: releases → Admin en repos de release
  
  Security Engineer:
    - Team: security → Maintain en security-tools
    - Team: all-repos → Read (audit access)
```

### Access Review Process

```yaml
Quarterly Review:
  1. Export team memberships
  2. Review with team leads
  3. Remove stale access
  4. Document changes
  5. Audit log verification
```

---

## 🔄 Team Sync (Enterprise)

### SCIM Provisioning

```yaml
Con SCIM puedes:
  - Sync teams desde IdP (Okta, Azure AD)
  - Auto-provision nuevos empleados
  - Auto-deprovision al despedir
  - Mantener grupos sincronizados

Configuración:
  1. Enterprise → Settings → Authentication security
  2. Enable SCIM
  3. Configurar en IdP:
     - SCIM endpoint: https://api.github.com/scim/v2/enterprises/ENTERPRISE
     - Bearer token
  4. Map grupos de IdP a GitHub teams
```

### Team Sync con IdP

```yaml
# Enterprise feature

Mapeo típico:
  IdP Group: "Engineering-Frontend"
  GitHub Team: "@acme-corp/frontend"
  
  IdP Group: "Engineering-Backend"  
  GitHub Team: "@acme-corp/backend"

Comportamiento:
  - Agregar a grupo IdP → agrega a GitHub team
  - Remover de grupo IdP → remueve de GitHub team
  - Automático y en tiempo real
```

---

## 📊 Visualizar Permisos

### Audit de Permisos

```bash
# Listar repos donde un team tiene acceso
gh api \
  orgs/NOMBRE-ORG/teams/backend/repos \
  --jq '.[] | "\(.name): \(.role_name)"'

# Output:
# api-service: push
# shared-libs: pull
# infrastructure: pull

# Listar teams con acceso a un repo
gh api \
  repos/NOMBRE-ORG/api-service/teams \
  --jq '.[] | "\(.name): \(.permission)"'

# Output:
# backend: push
# security: pull
# platform: maintain
```

### Dashboard de Permisos

```bash
#!/bin/bash
# Script: audit-permissions.sh

ORG="nombre-org"

echo "=== Permission Audit ==="
echo ""

for repo in $(gh repo list $ORG --json name -q '.[].name'); do
  echo "Repository: $repo"
  gh api repos/$ORG/$repo/teams --jq '.[] | "  - \(.name): \(.permission)"'
  echo ""
done
```

---

## ✅ Best Practices

### Team Structure

```yaml
Do:
  - Reflejar estructura organizacional
  - Usar nested teams para herencia
  - Nombres descriptivos (lowercase-dashes)
  - Un maintainer por team mínimo
  - Documentar propósito de cada team

Don't:
  - Teams demasiado granulares
  - Permisos individuales (usar teams)
  - Teams sin maintainer
  - Admin permissions por default
```

### Permission Checklist

```markdown
## Permission Review Checklist

### Teams
- [ ] Estructura refleja organización
- [ ] Cada team tiene maintainer
- [ ] Nested teams para herencia
- [ ] No teams huérfanos

### Repositories
- [ ] Permisos via teams (no individuales)
- [ ] Principio least privilege
- [ ] CODEOWNERS configurado
- [ ] No admin innecesario

### Members
- [ ] Todos en al menos un team
- [ ] No outside collaborators sin justificación
- [ ] Acceso temporal documentado
```

---

## 🔗 Recursos Adicionales

- [Managing Teams](https://docs.github.com/en/organizations/organizing-members-into-teams)
- [Repository Permission Levels](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles)
- [About CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)

---

## 📝 Resumen

| Concepto | Descripción |
|----------|-------------|
| **Teams** | Grupos para gestión de permisos |
| **Nested Teams** | Jerarquía con herencia |
| **Permission Levels** | Read → Triage → Write → Maintain → Admin |
| **CODEOWNERS** | Required reviewers por path |
| **Least Privilege** | Mínimo acceso necesario |

---

**Siguiente**: [Lección 03 - Authentication & SSO](03-authentication-sso.md)
