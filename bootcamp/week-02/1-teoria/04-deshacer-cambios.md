# ↩️ Lección 04: Deshacer Cambios

## 🎯 Objetivos de Aprendizaje

Al finalizar esta lección serás capaz de:

- [ ] Distinguir entre `restore`, `reset` y `revert`
- [ ] Deshacer cambios en el working directory
- [ ] Quitar archivos del staging area
- [ ] Modificar o deshacer commits
- [ ] Recuperarte de errores comunes

---

## 📚 Conceptos Teóricos

### La Importancia de Poder Deshacer

Git es un sistema de control de versiones, y su mayor poder está en permitirte **volver atrás**. Saber deshacer cambios te da confianza para experimentar.

> 💡 **Regla de Oro**: Casi todo en Git se puede deshacer... si no has pusheado aún.

### Mapa de Opciones para Deshacer

| Situación | Solución | Riesgo |
|-----------|----------|--------|
| Cambios en working directory | `git restore` | Bajo |
| Archivos en staging | `git restore --staged` | Bajo |
| Modificar último commit | `git commit --amend` | Medio |
| Deshacer commits locales | `git reset` | Alto |
| Deshacer commits pusheados | `git revert` | Bajo |

---

## ⌨️ Comandos Principales

### 1. `git restore` - Deshacer cambios en archivos

```bash
# ¿Qué hace?: Restaura archivos a un estado anterior
# ¿Por qué?: Para descartar cambios no deseados
# ¿Para qué sirve?: Volver archivos a su última versión committeada

# Descartar cambios en working directory
git restore archivo.txt

# Descartar cambios en todos los archivos
git restore .

# Quitar archivo del staging (mantiene cambios en working)
git restore --staged archivo.txt

# Quitar todos los archivos del staging
git restore --staged .

# Restaurar archivo desde un commit específico
git restore --source=HEAD~2 archivo.txt
```

**⚠️ ADVERTENCIA**: `git restore archivo.txt` **borra permanentemente** tus cambios no guardados.

### 2. `git checkout` (método antiguo)

```bash
# ¿Qué hace?: Lo mismo que restore (forma antigua)
# ¿Por qué?: Aún funciona pero es menos intuitivo
# ¿Para qué sirve?: Compatibilidad con tutoriales antiguos

# Descartar cambios (equivalente a git restore)
git checkout -- archivo.txt

# Restaurar desde commit (equivalente a git restore --source)
git checkout HEAD~2 -- archivo.txt
```

> 📝 **Nota**: Git 2.23+ introdujo `git restore` y `git switch` para separar las múltiples funciones de `git checkout`.

### 3. `git reset` - Mover HEAD y modificar historial

```bash
# ¿Qué hace?: Mueve HEAD a un commit anterior
# ¿Por qué?: Para deshacer commits o reorganizar
# ¿Para qué sirve?: Reescribir historial local

# --soft: Mantiene cambios en staging
git reset --soft HEAD~1
# Resultado: Commit deshecho, cambios listos para re-commit

# --mixed (default): Mantiene cambios en working directory
git reset HEAD~1
git reset --mixed HEAD~1
# Resultado: Commit deshecho, cambios en working (no staged)

# --hard: BORRA TODO (peligroso)
git reset --hard HEAD~1
# Resultado: Commit y cambios eliminados permanentemente
```

**Visualización de los modos de reset:**

```
                    HEAD~1        HEAD
                      │            │
                      ▼            ▼
Commits:         [commit A] ← [commit B]
                                  │
                    ┌─────────────┴─────────────┐
                    ▼             ▼             ▼
                 --soft       --mixed        --hard
                    │             │             │
                    ▼             ▼             ▼
Staging:      ✅ Mantiene    ❌ Vacía      ❌ Vacía
Working:      ✅ Mantiene    ✅ Mantiene   ❌ BORRA
```

### 4. `git revert` - Deshacer commit de forma segura

```bash
# ¿Qué hace?: Crea un NUEVO commit que revierte los cambios
# ¿Por qué?: Es seguro para commits ya pusheados
# ¿Para qué sirve?: Deshacer cambios sin reescribir historial

# Revertir el último commit
git revert HEAD

# Revertir un commit específico
git revert abc1234

# Revertir sin auto-commit (para revisar primero)
git revert --no-commit abc1234

# Revertir múltiples commits
git revert HEAD~3..HEAD
```

**Diferencia Reset vs Revert:**

| Aspecto | `git reset` | `git revert` |
|---------|-------------|--------------|
| Historial | Reescribe (elimina commits) | Preserva (agrega nuevo commit) |
| Seguro para push | ❌ No | ✅ Sí |
| Colaboración | ❌ Problemas si compartido | ✅ Seguro |
| Resultado | Elimina el commit | Agrega commit inverso |

---

## 🔨 Escenarios Prácticos

### Escenario 1: "Hice cambios que no quiero"

```bash
# Situación: Editaste archivo.txt y quieres descartarlo

# Ver qué cambió
git diff archivo.txt

# Descartar los cambios
git restore archivo.txt

# Verificar
git status  # archivo.txt ya no aparece como modified
```

### Escenario 2: "Agregué algo al staging por error"

```bash
# Situación: Hiciste git add pero no querías

# Ver qué está en staging
git status

# Quitar del staging (mantener cambios)
git restore --staged archivo.txt

# Verificar
git status  # archivo.txt aparece como modified (no staged)
```

### Escenario 3: "Mi último commit tiene un error"

```bash
# Situación: Quieres cambiar el mensaje o agregar un archivo

# Opción A: Cambiar mensaje
git commit --amend -m "feat: mensaje corregido"

# Opción B: Agregar archivo olvidado
git add archivo_olvidado.txt
git commit --amend --no-edit

# ⚠️ Solo si NO has pusheado
```

### Escenario 4: "Quiero deshacer mi último commit"

```bash
# Situación: El commit está mal y quieres rehacerlo

# Opción A: Mantener cambios para re-commit
git reset --soft HEAD~1
# Ahora puedes hacer nuevos commits con los mismos cambios

# Opción B: Mantener cambios sin staging
git reset HEAD~1
# Cambios en working directory, puedes editar antes de commit

# Opción C: Borrar todo (CUIDADO)
git reset --hard HEAD~1
# ⚠️ Cambios perdidos permanentemente
```

### Escenario 5: "Necesito deshacer un commit ya pusheado"

```bash
# Situación: Commit compartido con el equipo, necesitas deshacer

# NUNCA usar reset en commits pusheados
# Usar revert en su lugar

git revert abc1234
# Git abre editor para mensaje del revert
# Guardar y cerrar

# Ahora puedes pushear el revert
git push
```

### Escenario 6: "Quiero ver cómo estaba un archivo antes"

```bash
# Situación: Quieres comparar con versiones anteriores

# Ver archivo en commit anterior (sin modificar)
git show HEAD~3:ruta/archivo.txt

# Restaurar temporalmente para ver
git stash                              # Guardar cambios actuales
git checkout HEAD~3 -- archivo.txt     # Traer versión antigua
# ... revisar ...
git restore archivo.txt                # Volver al estado actual
git stash pop                          # Recuperar cambios guardados
```

---

## ⚠️ Comandos Peligrosos

### 🔴 Alto Riesgo - Pueden Perder Trabajo

```bash
# PELIGRO: Borra cambios sin posibilidad de recuperar
git reset --hard HEAD~1

# PELIGRO: Borra cambios no commiteados
git restore archivo.txt

# PELIGRO: Borra TODO lo no commiteado
git restore .
git checkout -- .
```

### Recomendaciones de Seguridad

1. **Siempre hacer `git status`** antes de comandos destructivos
2. **Usar `git stash`** para guardar cambios temporalmente
3. **Nunca `reset --hard`** sin verificar dos veces
4. **Nunca `reset`** en commits ya pusheados

---

## 🛟 Recuperación de Emergencia

### El Reflog - Tu Red de Seguridad

```bash
# ¿Qué hace?: Muestra historial de TODOS los movimientos de HEAD
# ¿Para qué sirve?: Recuperar commits "perdidos"

# Ver reflog
git reflog

# Output ejemplo:
# abc1234 HEAD@{0}: reset: moving to HEAD~1
# def5678 HEAD@{1}: commit: feat: algo importante  ← El commit "perdido"
# ghi9012 HEAD@{2}: commit: docs: actualizar README

# Recuperar el commit "perdido"
git reset --hard def5678
# o
git checkout def5678
```

> 💡 **Tip**: Los commits "borrados" con reset permanecen en el reflog por ~30 días. ¡Casi siempre puedes recuperar!

### Si Borraste Algo por Error

```bash
# 1. No entres en pánico
# 2. Ver el reflog
git reflog

# 3. Encontrar el punto antes del error
# 4. Volver a ese punto
git reset --hard HEAD@{X}
```

---

## 📝 Resumen de Comandos

| Comando | Qué Deshace | Riesgo |
|---------|-------------|--------|
| `git restore <file>` | Cambios en working | 🟡 Medio |
| `git restore --staged <file>` | Staging | 🟢 Bajo |
| `git commit --amend` | Último commit | 🟡 Medio |
| `git reset --soft HEAD~1` | Commit (mantiene staged) | 🟡 Medio |
| `git reset HEAD~1` | Commit (mantiene working) | 🟡 Medio |
| `git reset --hard HEAD~1` | Commit + cambios | 🔴 Alto |
| `git revert <commit>` | Commit (nuevo commit) | 🟢 Bajo |
| `git reflog` | Ver historial de HEAD | 🟢 Bajo |

---

## 🎯 Diagrama de Decisión

```
¿Qué quieres deshacer?
│
├─► Cambios en archivo (no staged)
│   └─► git restore archivo.txt
│
├─► Archivo en staging
│   └─► git restore --staged archivo.txt
│
├─► Último commit (no pusheado)
│   ├─► Solo mensaje → git commit --amend
│   ├─► Agregar archivo → git add + git commit --amend --no-edit
│   └─► Deshacer completo → git reset --soft HEAD~1
│
└─► Commit ya pusheado
    └─► git revert <commit>
```

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Semana | Siguiente ➡️ |
|:------------|:---------:|-------------:|
| [Historial Git](03-historial-git.md) | [Week 02](../README.md) | [Prácticas](../2-practicas/README.md) |

---

## 📚 Recursos Adicionales

- [Git Book - Undoing Things](https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things)
- [Git Documentation - git-reset](https://git-scm.com/docs/git-reset)
- [Git Documentation - git-restore](https://git-scm.com/docs/git-restore)
- [Git Documentation - git-revert](https://git-scm.com/docs/git-revert)

---

_Lección 04 Week 02 | Bootcamp Git/GitHub | 2025_
