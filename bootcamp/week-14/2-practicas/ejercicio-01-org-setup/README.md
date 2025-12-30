# Ejercicio 01: Organization Setup

## 🎯 Objetivo

Crear y configurar una organización GitHub desde cero, estableciendo todas las configuraciones básicas de seguridad y administración.

**Duración**: 40 minutos

---

## 📋 Escenario

Eres el nuevo administrador de DevOps en "TechStartup Inc." y necesitas crear la organización GitHub de la empresa con todas las configuraciones de seguridad apropiadas.

---

## 🛠️ Parte 1: Crear Organization (10 min)

### Paso 1.1: Crear nueva Organization

```bash
# ¿QUÉ VAMOS A HACER?: Crear una nueva organización en GitHub
# ¿POR QUÉ?: Las organizaciones permiten gestionar equipos, permisos
#            y repositorios de forma centralizada
# ¿PARA QUÉ SIRVE?: Colaboración empresarial estructurada

# Ir a: https://github.com/organizations/plan
# Seleccionar plan: Free (para este ejercicio)
```

### Paso 1.2: Configuración inicial

```yaml
# Completar formulario:
Organization name: techstartup-bootcamp-TUNOMBRE
  # Usar tu nombre para hacerlo único

Billing email: tu-email@ejemplo.com

Organization belongs to:
  - My personal account (seleccionar)
```

### Paso 1.3: Verificar creación

```bash
# ¿QUÉ VAMOS A HACER?: Verificar que la org se creó correctamente
# ¿POR QUÉ?: Confirmar acceso y configuración inicial
# ¿PARA QUÉ SIRVE?: Asegurar que podemos continuar con la configuración

gh api orgs/techstartup-bootcamp-TUNOMBRE

# Resultado esperado: JSON con información de la org
```

---

## 🔧 Parte 2: Profile Settings (10 min)

### Paso 2.1: Configurar perfil público

```yaml
# Settings → Profile

Display name: TechStartup Bootcamp
Description: |
  🚀 Organización de práctica para el Bootcamp Git/GitHub
  Administración Enterprise - Semana 14

URL: https://github.com/techstartup-bootcamp-TUNOMBRE

Location: Ciudad, País

Verified domains:
  # Saltar para ejercicio (requiere dominio real)
```

### Paso 2.2: Upload avatar (opcional)

```bash
# ¿QUÉ VAMOS A HACER?: Agregar logo/avatar a la org
# ¿POR QUÉ?: Identidad visual profesional
# ¿PARA QUÉ SIRVE?: Branding y reconocimiento

# Settings → Profile → Upload new picture
# Usar imagen cuadrada, mínimo 200x200px
```

---

## 👥 Parte 3: Member Settings (10 min)

### Paso 3.1: Configurar permisos base

```yaml
# Settings → Member privileges

Base permissions: Read
  # ¿POR QUÉ?: Principio de mínimo privilegio
  # Miembros nuevos solo lectura por default

Repository creation:
  Members can create repositories: ❌
  # ¿POR QUÉ?: Control centralizado de repos
  
  Members can fork private repositories: ❌
  # ¿POR QUÉ?: Evitar fuga de código privado

Repository forking:
  Allow forking of private repositories: ❌
  
Pages creation:
  Members can create public pages: ✅
  Members can create private pages: ❌
```

### Paso 3.2: Verificar con CLI

```bash
# ¿QUÉ VAMOS A HACER?: Verificar configuración de miembros via API
# ¿POR QUÉ?: Confirmar que la configuración se aplicó
# ¿PARA QUÉ SIRVE?: Automatización y auditoría

gh api orgs/techstartup-bootcamp-TUNOMBRE \
  --jq '{
    default_repo_permission: .default_repository_permission,
    members_can_create_repos: .members_can_create_repositories,
    members_can_fork_private: .members_can_fork_private_repositories
  }'

# Resultado esperado:
# {
#   "default_repo_permission": "read",
#   "members_can_create_repos": false,
#   "members_can_fork_private": false
# }
```

---

## 🔐 Parte 4: Security Settings (10 min)

### Paso 4.1: Habilitar 2FA requirement

```yaml
# Settings → Authentication security

Two-factor authentication:
  Require two-factor authentication: ✅
  
  # ⚠️ IMPORTANTE: Asegúrate de tener 2FA habilitado
  # en tu cuenta antes de habilitar esto
```

### Paso 4.2: Configurar Secrets

```yaml
# Settings → Secrets and variables → Actions

Organization secrets:
  # Crear secret de ejemplo
  Name: ORG_SECRET_EXAMPLE
  Value: example-value-for-bootcamp
  Repository access: All repositories
```

```bash
# ¿QUÉ VAMOS A HACER?: Verificar secrets via CLI
# ¿POR QUÉ?: Confirmar que los secrets están configurados
# ¿PARA QUÉ SIRVE?: Gestión segura de credenciales

gh secret list --org techstartup-bootcamp-TUNOMBRE

# Resultado: Lista de secrets (sin valores, solo nombres)
```

### Paso 4.3: Revisar Audit Log

```bash
# ¿QUÉ VAMOS A HACER?: Revisar el audit log de la org
# ¿POR QUÉ?: Ver todas las acciones administrativas
# ¿PARA QUÉ SIRVE?: Compliance, troubleshooting, seguridad

# Via UI: Settings → Logs → Audit log
# Filtrar por: action:org

# Via CLI (si tienes Enterprise):
# gh api orgs/techstartup-bootcamp-TUNOMBRE/audit-log
```

---

## ✅ Checklist de Verificación

```markdown
## Organization Setup - Verificación

### Creación
- [ ] Org creada con nombre único
- [ ] Puedo acceder como Owner

### Profile
- [ ] Display name configurado
- [ ] Description agregada
- [ ] (Opcional) Avatar subido

### Member Privileges
- [ ] Base permissions: Read
- [ ] Members cannot create repos
- [ ] Members cannot fork private repos

### Security
- [ ] 2FA requirement habilitado
- [ ] Al menos un secret creado
- [ ] Audit log accesible

### Verificación CLI
- [ ] `gh api orgs/NOMBRE` funciona
- [ ] `gh secret list --org NOMBRE` funciona
```

---

## 🔧 Troubleshooting

### Error: "You're not authorized"

```bash
# Problema: No tienes permisos de owner
# Solución: Verificar que eres owner de la org

gh api orgs/techstartup-bootcamp-TUNOMBRE/memberships/$USER \
  --jq '.role'

# Debe mostrar: "admin"
```

### Error: "Organization name taken"

```bash
# Problema: Nombre ya existe
# Solución: Agregar sufijo único (fecha, iniciales)

# Ejemplo: techstartup-bootcamp-jdoe-2024
```

---

## 📚 Recursos

- [Creating Organization](https://docs.github.com/en/organizations/collaborating-with-groups-in-organizations/creating-a-new-organization-from-scratch)
- [Organization Settings](https://docs.github.com/en/organizations/managing-organization-settings)
- [Member Privileges](https://docs.github.com/en/organizations/managing-organization-settings/setting-permissions-for-adding-outside-collaborators)

---

## ➡️ Siguiente Ejercicio

Continúa con [Ejercicio 02 - Teams & Structure](../ejercicio-02-teams-structure/README.md)
