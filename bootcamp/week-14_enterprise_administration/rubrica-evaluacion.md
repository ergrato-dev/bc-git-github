# 📋 Rúbrica de Evaluación - Week 14

## Enterprise Administration

**Total: 100 puntos**

---

## 📖 Teoría (15 puntos)

### Quiz de Conceptos

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Organizations | 4 | Configuración y settings |
| Teams & Permissions | 4 | Roles y access levels |
| Authentication | 4 | SSO, 2FA, tokens |
| Policies | 3 | Rulesets y protection |

---

## 💻 Ejercicios Prácticos (60 puntos)

### Ejercicio 1: Organization Setup (15 puntos)

| Criterio | Puntos | Excelente | Satisfactorio | Necesita Mejora |
|----------|--------|-----------|---------------|-----------------|
| Organization creada | 3 | Nombre y settings correctos | Configuración básica | Incompleto |
| Profile configurado | 3 | Avatar, descripción, URL | Parcialmente completo | Sin configurar |
| Base permissions | 3 | Read para miembros | Configurado básico | Default sin cambiar |
| Member privileges | 3 | Restricciones apropiadas | Algunas restricciones | Sin restricciones |
| Security settings | 3 | 2FA, alerts habilitados | Algunos habilitados | Sin configurar |

### Ejercicio 2: Teams Structure (15 puntos)

| Criterio | Puntos | Excelente | Satisfactorio | Necesita Mejora |
|----------|--------|-----------|---------------|-----------------|
| Teams creados | 3 | Jerarquía completa | Teams básicos | Pocos teams |
| Nested teams | 3 | Parent/child correcto | Algunos nested | Sin jerarquía |
| Permisos asignados | 3 | Granular por repo | Permisos básicos | Sin permisos |
| Team maintainers | 3 | Roles definidos | Algunos maintainers | Sin maintainers |
| CODEOWNERS | 3 | Configurado correctamente | Básico | No configurado |

### Ejercicio 3: Branch Protection (15 puntos)

| Criterio | Puntos | Excelente | Satisfactorio | Necesita Mejora |
|----------|--------|-----------|---------------|-----------------|
| Ruleset creado | 3 | Nombre y targeting correcto | Configuración básica | Incompleto |
| Required reviews | 3 | 2+ reviewers, dismiss stale | 1 reviewer | Sin reviews |
| Status checks | 3 | Checks requeridos configurados | Algunos checks | Sin checks |
| Merge requirements | 3 | Linear history, signed | Algunos requisitos | Sin requisitos |
| Bypass rules | 3 | Admins con justificación | Admins solo | Sin control |

### Ejercicio 4: SSO Configuration (15 puntos)

| Criterio | Puntos | Excelente | Satisfactorio | Necesita Mejora |
|----------|--------|-----------|---------------|-----------------|
| 2FA enforcement | 3 | Org-wide mandatory | Recomendado | No habilitado |
| PAT policies | 3 | Fine-grained requerido | Algunas restricciones | Sin políticas |
| SSH key policies | 3 | Expiration configurada | Básico | Sin políticas |
| SSO understanding | 3 | Documentación SAML | Conceptos básicos | Sin documentar |
| Session policies | 3 | Timeout configurado | Básico | Sin configurar |

---

## 🎯 Proyecto Semanal (25 puntos)

### Enterprise Organization Setup

| Criterio | Puntos | Excelente | Satisfactorio | Necesita Mejora |
|----------|--------|-----------|---------------|-----------------|
| **Organization Config** | 5 | Settings completos y documentados | Configuración funcional | Básico/incompleto |
| **Teams Structure** | 5 | Jerarquía lógica, permisos correctos | Teams funcionales | Estructura básica |
| **Repository Rulesets** | 5 | Múltiples rulesets, bien targetted | Rulesets básicos | Minimal protection |
| **Security Policies** | 5 | 2FA, tokens, audit ready | Algunas políticas | Pocas políticas |
| **Documentation** | 5 | README completo, diagramas | Documentación básica | Sin documentación |

---

## 📊 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐ Excelente | Dominio completo de administración |
| 80-89 | ✅ Muy Bien | Buen manejo de conceptos y prácticas |
| 70-79 | 👍 Bien | Comprensión adecuada con áreas a mejorar |
| 60-69 | ⚠️ Suficiente | Conocimiento básico, necesita práctica |
| < 60 | ❌ Insuficiente | Requiere refuerzo significativo |

---

## 🎓 Competencias Evaluadas

### Técnicas
- [ ] Crear y configurar GitHub Organizations
- [ ] Diseñar estructura de Teams con permisos
- [ ] Implementar Branch Protection y Rulesets
- [ ] Configurar políticas de autenticación
- [ ] Gestionar accesos y roles

### Profesionales
- [ ] Documentación clara de configuraciones
- [ ] Aplicación de principio de least privilege
- [ ] Consideración de compliance y seguridad
- [ ] Planificación de estructura organizacional

---

## 📝 Notas para Evaluadores

### Organization Setup
- Verificar que base permissions sea restrictivo (Read o None)
- Confirmar 2FA enforcement habilitado
- Revisar member privileges apropiados

### Teams Structure
- Validar que la jerarquía tenga sentido
- Confirmar permisos siguiendo least privilege
- Verificar CODEOWNERS si aplica

### Branch Protection
- Comprobar que main/develop estén protegidos
- Verificar required reviews > 0
- Confirmar status checks configurados

### SSO/Authentication
- Verificar documentación de proceso SAML
- Confirmar políticas de PAT documentadas
- Revisar políticas de session management

---

## ✅ Checklist de Entrega

```markdown
## Entrega Week 14

### Ejercicios
- [ ] Ejercicio 1: Organization configurada
- [ ] Ejercicio 2: Teams estructura exportada/documentada
- [ ] Ejercicio 3: Rulesets configurados
- [ ] Ejercicio 4: Políticas de auth documentadas

### Proyecto
- [ ] Organization completa
- [ ] Teams con permisos
- [ ] Rulesets activos
- [ ] Security policies
- [ ] README documentación

### Reflexión
- [ ] Lecciones aprendidas
- [ ] Desafíos encontrados
- [ ] Áreas de mejora
```

---

## 🔗 Recursos de Apoyo

- [Organization Best Practices](https://docs.github.com/en/organizations)
- [Repository Permission Levels](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories)
- [Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)

---

*Rúbrica v1.0 - Week 14: Enterprise Administration*
