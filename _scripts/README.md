# 🤖 Scripts de Automatización - Bootcamp Git/GitHub

Este directorio contiene scripts para automatizar commits durante el desarrollo del material educativo del bootcamp.

## 📁 Archivos

| Archivo          | Descripción                                      | Uso                           |
| ---------------- | ------------------------------------------------ | ----------------------------- |
| `auto-commit.sh` | Script principal que realiza commits automáticos | Ejecutado por cron cada 5 min |
| `setup-cron.sh`  | Configurador interactivo del cron job            | `./setup-cron.sh`             |
| `remove-cron.sh` | Removedor del cron job                           | `./remove-cron.sh`            |

## 🚀 Configuración Rápida

```bash
# 1. Configurar auto-commits
./_scripts/setup-cron.sh

# 2. Ver logs en tiempo real
tail -f _scripts/auto-commit.log

# 3. Testear manualmente
./_scripts/auto-commit.sh
```

## 📋 Características del Auto-commit

### 📝 Formato de Commits

Todos los commits generados siguen estas reglas:

| Regla | Descripción |
|-------|-------------|
| **Estándar** | [Conventional Commits](https://www.conventionalcommits.org/) |
| **Idioma** | Inglés |
| **Estructura** | `type(scope): what - for - impact` |

#### Estructura del Mensaje

```
type(scope): what - for - impact
│     │       │      │      └── IMPACT: ¿Qué beneficio o resultado tiene?
│     │       │      └── FOR: ¿Para qué se hace? (objetivo)
│     │       └── WHAT: ¿Qué se hizo? (acción concreta)
│     └── SCOPE: Área afectada (docs, exercises, scripts, etc.)
└── TYPE: Tipo de cambio (feat, fix, docs, chore, etc.)
```

#### Componentes Explicados

| Componente | Pregunta | Descripción | Ejemplo |
|------------|----------|-------------|----------|
| **WHAT?** | ¿Qué se hizo? | Acción concreta realizada | `add git branching lesson` |
| **FOR?** | ¿Para qué? | Objetivo o propósito del cambio | `for week-03 curriculum` |
| **IMPACT?** | ¿Qué impacto tiene? | Beneficio o resultado esperado | `enables hands-on practice` |

#### Ejemplos Completos

```bash
# Añadir nueva lección
feat(docs): add git branching lesson - for week-03 curriculum - enables hands-on practice

# Corregir error en ejercicio
fix(exercises): correct typo in exercise-02 - for clarity - improves student experience

# Actualizar documentación
docs(readme): update installation steps - for linux users - reduces setup friction

# Añadir recursos
feat(resources): add git cheatsheet PDF - for quick reference - accelerates learning

# Mantenimiento general
chore(config): update gitignore patterns - for cleaner repo - excludes temp files
```

### Tipos de Commit Detectados

El script analiza automáticamente los cambios y genera commits:

| Cambios Detectados       | Tipo    | Scope       | Mensaje Generado (what - for - impact)                              |
| ------------------------ | ------- | ----------- | ------------------------------------------------------------------- |
| Nuevos archivos `.md`    | `feat`  | `docs`      | `add new documentation content - for bootcamp curriculum - enhances learning materials`     |
| Modificar archivos `.md` | `docs`  | `content`   | `update documentation content - for accuracy - ensures correct information`   |
| Nuevos scripts           | `feat`  | `scripts`   | `add automation scripts - for workflow optimization - improves development efficiency`         |
| Modificar scripts        | `fix`   | `scripts`   | `update automation scripts - for reliability - ensures stable execution`       |
| Nuevos ejercicios        | `feat`  | `exercises` | `add new practice exercises - for hands-on learning - enables skill development`   |
| Modificar ejercicios     | `docs`  | `exercises` | `update practice exercises - for clarity - improves student experience`    |
| Nuevos recursos          | `feat`  | `resources` | `add educational resources - for reference materials - accelerates learning`    |
| Modificar recursos       | `docs`  | `resources` | `update educational resources - for relevance - maintains content quality` |
| Otros cambios            | `chore` | `content`   | `update bootcamp materials - for maintenance - keeps repository current`     |

### Configuración del Cron Job

```bash
# Ejecuta cada 5 minutos
*/5 * * * * /path/to/auto-commit.sh >> /path/to/cron.log 2>&1
```

## 📊 Logging

### Archivos de Log

- **`auto-commit.log`**: Log detallado del script de commits
- **`cron.log`**: Output del cron job (errores y salida estándar)

### Ejemplo de Log

```text
[2024-09-24 10:15:01] Commit created: a1b2c3d - feat(docs): add new documentation content
[2024-09-24 10:20:01] No changes detected - skipping commit
[2024-09-24 10:25:01] Commit created: e4f5g6h - docs(exercises): update practice exercises
```

## 🛠️ Comandos Útiles

### Gestión de Cron Jobs

```bash
# Ver cron jobs actuales
crontab -l

# Editar cron jobs manualmente
crontab -e

# Remover todos los cron jobs (¡CUIDADO!)
crontab -r
```

### Monitoreo

```bash
# Ver logs en tiempo real
tail -f _scripts/auto-commit.log
tail -f _scripts/cron.log

# Ver últimos commits
git log --oneline -10

# Ver estado del repository
git status
```

### Testing

```bash
# Ejecutar auto-commit manualmente
./_scripts/auto-commit.sh

# Simular cambios para testing
touch _docs/test-file.md
echo "Test content" > _docs/test-file.md
```

## ⚠️ Consideraciones Importantes

### Seguridad

- **Push automático deshabilitado**: Por seguridad, el push automático está comentado
- **Backup automático**: Los scripts crean backups del crontab antes de modificarlo
- **Logs detallados**: Toda actividad queda registrada para auditoría

### Mejores Prácticas

1. **Revisar commits**: Aunque son automáticos, revisar periódicamente los commits generados
2. **Limpiar después**: Usar `remove-cron.sh` al finalizar el desarrollo
3. **Monitorear logs**: Verificar que no haya errores en los logs
4. **Testing local**: Probar el script manualmente antes de activar el cron

## 🚨 Solución de Problemas

### El cron job no se ejecuta

```bash
# Verificar que el servicio cron esté activo
sudo systemctl status cron

# Verificar permisos del script
ls -la _scripts/auto-commit.sh

# Verificar sintaxis del crontab
crontab -l | grep auto-commit
```

### Errores de Git

```bash
# Verificar configuración de Git
git config --list

# Verificar estado del repository
git status
git log --oneline -5
```

### Problemas de permisos

```bash
# Corregir permisos de scripts
chmod +x _scripts/*.sh

# Verificar propiedad de archivos
ls -la _scripts/
```

## 📚 Referencias

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Cron Expression Generator](https://crontab.guru/)
- [Git Documentation](https://git-scm.com/docs)

---

**⚡ Tip**: Para un desarrollo más eficiente, combina los auto-commits con un workflow que incluya push automático solo en branch de desarrollo, manteniendo el main branch con commits manuales y revisados.
