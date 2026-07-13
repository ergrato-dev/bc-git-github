# 🖥️ Guía Rápida: Git en Equipos Compartidos

> **Para estudiantes que usan laboratorios, bootcamps, o cualquier PC compartida**

---

## ⚡ Checklist Rápido (30 segundos)

Ejecuta ANTES de empezar a trabajar:

```bash
# 1. ¿Quién está configurado?
git whoami
# o si no tienes el alias:
git config user.name && git config user.email

# 2. Si NO eres tú → Configura LOCAL:
cd tu-proyecto/
git config --local user.name "Tu Nombre"
git config --local user.email "tu@email.com"

# 3. Verificar:
git config user.name
```

---

## 🚨 Regla de Oro

```text
┌────────────────────────────────────────────────┐
│   EN EQUIPOS COMPARTIDOS:                      │
│                                                │
│   ❌ NUNCA:  git config --global               │
│   ✅ SIEMPRE: git config --local               │
│                                                │
└────────────────────────────────────────────────┘
```

---

## 📋 Comandos Esenciales

### Verificar identidad actual

```bash
git config user.name
git config user.email
```

### Configurar identidad LOCAL (en tu proyecto)

```bash
cd mi-proyecto/
git config --local user.name "Tu Nombre Completo"
git config --local user.email "tu.email@ejemplo.com"
```

### Crear alias de verificación rápida

```bash
git config --global alias.whoami '!echo "Usuario: $(git config user.name)" && echo "Email: $(git config user.email)"'
```

### Forzar que Git pida identidad

```bash
git config --global user.useConfigOnly true
```

---

## 🔧 Solución Rápida: Commits con Nombre Incorrecto

### Último commit:

```bash
git config --local user.name "Tu Nombre Real"
git config --local user.email "tu@email.com"
git commit --amend --reset-author --no-edit
```

### Varios commits (si NO hiciste push):

```bash
git rebase -i HEAD~3  # Cambia 3 por el número de commits
# Cambia "pick" por "edit", guarda
git commit --amend --reset-author --no-edit
git rebase --continue
# Repite para cada commit
```

---

## 🛡️ Antes de Irte

```bash
# Limpiar credenciales cacheadas
git credential-cache exit

# Cerrar sesión de GitHub en el browser
# (hacerlo manualmente)
```

---

## 📊 Tabla de Decisión Rápida

| ¿Es TU computadora personal? | Comando a usar |
|------------------------------|----------------|
| **SÍ** (tu laptop, tu PC) | `--global` |
| **NO** (lab, bootcamp, café) | `--local` |

---

## 🆘 Ayuda Rápida

| Problema | Solución |
|----------|----------|
| "Hice commit con otro nombre" | `git commit --amend --reset-author` |
| "No sé quién está configurado" | `git config user.name` |
| "Quiero protegerme de errores" | `git config --global user.useConfigOnly true` |

---

**💡 Pro Tip**: Imprime esta página y tenla cerca del equipo compartido.

---

[⬅️ Volver a Recursos](../README.md) | [📚 Lección completa](../1-teoria/03-configuracion.md)
