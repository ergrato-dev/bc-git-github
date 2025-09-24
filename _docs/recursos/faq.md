# ❓ FAQ - Preguntas Frecuentes del Bootcamp Git/GitHub

## 🎯 Preguntas Generales

### ¿Qué nivel de conocimiento necesito para empezar?

**Respuesta**: Necesitas conocimientos básicos de programación y familiaridad con la línea de comandos. No es necesario tener experiencia previa con Git.

### ¿Qué sistema operativo recomiendan?

**Respuesta**: Git funciona en todos los sistemas operativos principales:

- **Linux**: Experiencia nativa excelente
- **macOS**: Muy buena experiencia, especialmente con Homebrew
- **Windows**: Recomendamos usar Git Bash o WSL2 para mejor compatibilidad

### ¿Puedo usar herramientas gráficas en lugar de línea de comandos?

**Respuesta**: Sí, pero recomendamos aprender primero la línea de comandos porque:

- Entenderás mejor los conceptos fundamentales
- Tendrás más control y flexibilidad
- Es el estándar en la industria
- Las herramientas gráficas a veces ocultan detalles importantes

## 🔧 Problemas Técnicos Comunes

### Git no está instalado o no se reconoce

**Síntomas**:

- `git: command not found` (Linux/macOS)
- `'git' is not recognized as an internal or external command` (Windows)

**Soluciones**:

1. **Verificar instalación**:

   ```bash
   which git    # Linux/macOS
   where git    # Windows
   ```

2. **Reinstalar Git**:

   - Linux: `sudo apt install git` (Ubuntu/Debian)
   - macOS: `brew install git` o descargar de git-scm.com
   - Windows: Descargar de git-scm.com y reinstalar

3. **Verificar PATH**: Asegurarse que Git esté en el PATH del sistema

### Error de configuración de usuario

**Error**: `Please tell me who you are` al hacer commit

**Solución**:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### Problemas con saltos de línea

**Síntomas**: Archivos aparecen como modificados sin cambios visibles

**Solución**:

```bash
# Windows
git config --global core.autocrlf true

# Linux/macOS
git config --global core.autocrlf input
```

### Error de permisos al hacer git init

**Error**: `Permission denied`

**Solución**:

1. Verificar permisos del directorio
2. Usar directorio en tu carpeta home
3. En Linux/macOS, evitar usar `sudo` con Git

## 📚 Dudas sobre Conceptos

### ¿Cuál es la diferencia entre Git y GitHub?

**Git**: Sistema de control de versiones (software local)

- Funciona sin internet
- Se instala en tu computadora
- Maneja el historial de cambios

**GitHub**: Servicio en la nube que usa Git

- Requiere internet
- Hospeda repositorios remotos
- Añade características sociales (issues, pull requests, etc.)

### ¿Cuándo usar git add . vs git add -A?

**`git add .`**: Añade archivos nuevos y modificados en el directorio actual

**`git add -A`**: Añade TODO (incluyendo archivos eliminados) en todo el repositorio

**Recomendación**: Usa `git add -A` para mayor claridad y consistencia.

### ¿Qué va en .gitignore?

Incluye archivos que NO quieres versionar:

- Archivos generados automáticamente
- Dependencias (node_modules, venv)
- Archivos de configuración personal (.env)
- Archivos temporales (.tmp, .log)
- Archivos del sistema (.DS_Store)

### ¿Cuándo hacer commit?

**Buenas prácticas**:

- Commits frecuentes y pequeños
- Cada commit debe representar una unidad lógica de cambio
- Antes de cambiar de tarea o al final del día
- Cuando una característica está completa

## 🚨 Errores Frecuentes

### "I accidentally committed the wrong files"

**Si no has hecho push aún**:

```bash
# Deshacer último commit pero mantener cambios
git reset --soft HEAD~1

# Deshacer último commit y cambios
git reset --hard HEAD~1
```

### "I can't remember what I changed"

**Solución**:

```bash
# Ver cambios no añadidos al staging
git diff

# Ver cambios en staging
git diff --staged

# Ver historial
git log --oneline
```

### "My .gitignore is not working"

**Problema**: Archivos ya estaban siendo tracked

**Solución**:

```bash
# Dejar de trackear archivo pero no eliminarlo
git rm --cached archivo_a_ignorar

# Aplicar .gitignore a archivos ya trackeados
git rm -r --cached .
git add .
git commit -m "fix: aplicar .gitignore correctamente"
```

### "I made too many changes in one commit"

**Prevención**:

- Hacer commits más frecuentes
- Usar `git add` archivo por archivo
- Revisar cambios con `git diff` antes del commit

## 💡 Consejos y Mejores Prácticas

### Mensajes de Commit

**❌ Malos ejemplos**:

- "cambios"
- "fix"
- "wip" (work in progress)
- "asdfjkl"

**✅ Buenos ejemplos**:

- "feat: añadir formulario de login"
- "fix: corregir validación de email"
- "docs: actualizar README con instrucciones"

### Flujo de Trabajo Diario

1. `git status` - Ver estado actual
2. `git add` - Añadir cambios específicos
3. `git commit -m "mensaje descriptivo"` - Confirmar cambios
4. Repetir según necesidad
5. `git log --oneline` - Revisar historial

### Comandos Útiles para Debug

```bash
# Ver configuración actual
git config --list

# Ver último commit
git show HEAD

# Ver archivos ignorados
git ls-files --others --ignored --exclude-standard

# Ver qué archivos está tracking git
git ls-files
```

## 🆘 ¿Necesitas Más Ayuda?

### Recursos Adicionales

- [Pro Git Book (Español)](https://git-scm.com/book/es/v2)
- [Git Documentation](https://git-scm.com/docs)
- [GitHub Learning Lab](https://lab.github.com/)

### Durante el Bootcamp

- **Horario de consultas**: Lunes a Viernes 17:00-18:00
- **Foro del curso**: Disponible 24/7
- **Sesiones de dudas**: Viernes al final de cada semana

### Contacto

- **Instructor principal**: [instructor@bootcamp.com]
- **Asistente técnico**: [tech@bootcamp.com]
- **Coordinación académica**: [academic@bootcamp.com]

---

💡 **Recuerda**: No hay preguntas tontas. Es mejor preguntar que quedarse con dudas.
