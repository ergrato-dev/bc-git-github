# Ejercicio 01: Gestion de Issues

## Descripcion

Crear y gestionar Issues completos con labels, milestones, assignees y templates.

**Duracion estimada:** 35 minutos

---

## Objetivos

- Crear Issues bien documentados
- Usar labels para categorizar
- Configurar milestones
- Crear issue templates

---

## Requisitos Previos

- Repositorio en GitHub
- Permisos de escritura en el repositorio
- GitHub CLI instalado (opcional)

---

## Parte 1: Crear Repositorio de Practica (5 min)

### Paso 1.1: Crear repositorio

```bash
# Crear directorio local
mkdir issue-practice && cd issue-practice

# Inicializar Git
git init

# Crear archivo inicial
echo "# Issue Practice Project" > README.md
echo "Proyecto para practicar gestion de Issues" >> README.md

# Commit inicial
git add README.md
git commit -m "docs: initial README"
```

### Paso 1.2: Crear repositorio en GitHub

```bash
# Con GitHub CLI
gh repo create issue-practice --public --source=. --push

# O manualmente:
# 1. Crear repo en github.com
# 2. git remote add origin git@github.com:TU-USUARIO/issue-practice.git
# 3. git push -u origin main
```

---

## Parte 2: Crear Labels Personalizados (10 min)

### Paso 2.1: Ver labels existentes

Ve a tu repositorio > **Issues** > **Labels**

### Paso 2.2: Crear nuevos labels

Crear los siguientes labels:

| Label | Color | Descripcion |
|-------|-------|-------------|
| `priority: high` | #d73a4a | Prioridad alta |
| `priority: medium` | #fbca04 | Prioridad media |
| `priority: low` | #0e8a16 | Prioridad baja |
| `area: frontend` | #1d76db | Relacionado con frontend |
| `area: backend` | #5319e7 | Relacionado con backend |
| `status: blocked` | #b60205 | Bloqueado por dependencia |

### Paso 2.3: Crear labels con CLI (alternativa)

```bash
# Crear label de prioridad alta
gh label create "priority: high" --color "d73a4a" --description "Prioridad alta"

# Crear label de area frontend
gh label create "area: frontend" --color "1d76db" --description "Relacionado con frontend"

# Verificar labels
gh label list
```

---

## Parte 3: Crear Milestone (5 min)

### Paso 3.1: Crear milestone "v1.0 Release"

1. Ir a **Issues** > **Milestones** > **New milestone**
2. Completar:
   - Title: `v1.0 Release`
   - Due date: (2 semanas desde hoy)
   - Description: `Primera version del proyecto con funcionalidades basicas`
3. Click **Create milestone**

### Paso 3.2: Verificar con CLI

```bash
# Ver milestones (requiere gh extension)
gh api repos/:owner/:repo/milestones
```

---

## Parte 4: Crear Issues Completos (10 min)

### Issue 1: Bug Report

1. Click **New issue**
2. Completar:

```markdown
Title: Bug: Formulario no valida email correctamente

## Descripcion

El formulario de contacto acepta emails invalidos como "test@" o "@domain.com".

## Pasos para Reproducir

1. Ir a la pagina de contacto
2. Ingresar "invalido@" en el campo email
3. Click en enviar
4. El formulario se envia sin error

## Comportamiento Esperado

El formulario debe mostrar error: "Email invalido"

## Comportamiento Actual

El formulario se envia con email invalido

## Ambiente

- Browser: Chrome 120
- OS: Windows 11

## Screenshots

(Adjuntar si aplica)
```

3. Agregar:
   - Labels: `bug`, `priority: high`, `area: frontend`
   - Assignee: Tu usuario
   - Milestone: v1.0 Release

4. Click **Submit new issue**

### Issue 2: Feature Request

```markdown
Title: Feat: Agregar modo oscuro

## Descripcion

Implementar opcion de tema oscuro para mejor experiencia de usuario.

## Motivacion

Los usuarios han solicitado modo oscuro para reducir fatiga visual.

## Solucion Propuesta

1. Agregar toggle en navbar
2. Guardar preferencia en localStorage
3. CSS variables para colores

## Alternativas Consideradas

- Detectar preferencia del sistema automaticamente
- Usar libreria de temas

## Checklist

- [ ] Disenar UI del toggle
- [ ] Implementar CSS variables
- [ ] Agregar logica de toggle
- [ ] Persistir preferencia
- [ ] Tests
```

Labels: `enhancement`, `priority: medium`, `area: frontend`

### Issue 3: Tarea de Documentacion

```markdown
Title: Docs: Crear guia de contribucion

## Descripcion

Crear archivo CONTRIBUTING.md con guias para contribuidores.

## Contenido Requerido

- [ ] Como reportar bugs
- [ ] Como proponer features
- [ ] Guia de estilo de codigo
- [ ] Proceso de Pull Request
- [ ] Codigo de conducta

## Referencias

- [GitHub Contributing Guide](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions)
```

Labels: `documentation`, `good first issue`, `priority: low`

---

## Parte 5: Crear Issue Template (5 min)

### Paso 5.1: Crear estructura de templates

```bash
mkdir -p .github/ISSUE_TEMPLATE
```

### Paso 5.2: Crear Bug Report template

```bash
cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug Report
about: Reportar un bug para ayudarnos a mejorar
title: '[BUG] '
labels: 'bug'
assignees: ''
---

## Descripcion del Bug

Descripcion clara y concisa del bug.

## Pasos para Reproducir

1. Ir a '...'
2. Click en '...'
3. Ver error

## Comportamiento Esperado

Que deberia suceder.

## Screenshots

Si aplica, adjuntar capturas de pantalla.

## Ambiente

- OS: [ej: Windows 11]
- Browser: [ej: Chrome 120]
- Version: [ej: 1.0.0]

## Contexto Adicional

Cualquier otro contexto sobre el problema.
EOF
```

### Paso 5.3: Crear Feature Request template

```bash
cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature Request
about: Sugerir una idea para este proyecto
title: '[FEAT] '
labels: 'enhancement'
assignees: ''
---

## Problema Relacionado

Descripcion clara del problema. Ej: Me frustra cuando [...]

## Solucion Propuesta

Descripcion clara de lo que quieres que suceda.

## Alternativas Consideradas

Otras soluciones que hayas considerado.

## Contexto Adicional

Cualquier otro contexto, mockups o screenshots.
EOF
```

### Paso 5.4: Commit y push templates

```bash
git add .github/
git commit -m "docs: add issue templates"
git push origin main
```

### Paso 5.5: Verificar templates

1. Ir a **Issues** > **New issue**
2. Deberian aparecer las opciones de template

---

## Verificacion Final

### Checklist

- [ ] 3+ Issues creados con diferentes tipos
- [ ] Labels personalizados creados
- [ ] Milestone configurado
- [ ] Issues asignados al milestone
- [ ] Issue templates funcionando

### Comandos de Verificacion

```bash
# Listar Issues
gh issue list

# Ver Issue especifico
gh issue view 1

# Ver labels
gh label list

# Filtrar Issues
gh issue list --label "priority: high"
gh issue list --milestone "v1.0 Release"
```

---

## Reto Extra

1. Crear un Issue que referencie otro:
   ```markdown
   Blocked by #1
   Related to #2
   ```

2. Cerrar un Issue desde la linea de comandos:
   ```bash
   gh issue close 3 --comment "Completado en PR #X"
   ```

3. Crear label con emoji:
   ```bash
   gh label create "🔥 urgent" --color "b60205"
   ```

---

## Recursos

- [GitHub Issues Documentation](https://docs.github.com/en/issues)
- [Creating Issue Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository)

---

[Volver a Ejercicios](../README.md) | [Siguiente: Pull Requests](../ejercicio-02-pull-requests/README.md)
