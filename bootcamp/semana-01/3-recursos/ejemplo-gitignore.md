# 🚫 Ejemplos de .gitignore para Diferentes Contextos

El archivo `.gitignore` es crucial para mantener tu repositorio limpio y profesional.

## 📋 .gitignore Básico (Proyecto Simple)

```text
# Archivos temporales del sistema
*.tmp
*.log
*~
.DS_Store
Thumbs.db

# Archivos de respaldo
*.backup
*.bak
backup/

# Archivos privados y sensibles
secrets/
.env
*.key
*.pem
config.local.*
```

---

## 💻 .gitignore para Desarrollo Web

```text
# Dependencias
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Archivos de build
build/
dist/
.next/
out/

# Variables de entorno
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
logs/
*.log
npm-debug.log*

# Archivos del sistema
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDEs y editores
.vscode/
.idea/
*.swp
*.swo
*~
```

---

## 🐍 .gitignore para Python

```text
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual environments
env/
venv/
ENV/
env.bak/
venv.bak/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
```

---

## ☕ .gitignore para Java

```text
# Compiled class file
*.class

# Log file
*.log

# Package Files
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# Virtual machine crash logs
hs_err_pid*

# IDE
.idea/
.vscode/
*.iml
*.ipr
*.iws

# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties

# Gradle
.gradle/
build/
```

---

## 🎯 .gitignore Específico para Bootcamp

```text
# ================================
# Bootcamp Git/GitHub - .gitignore
# ================================

# Archivos de estudiantes (mantener privado)
notas-personales/
mi-progreso/
entregas-borrador/

# Archivos temporales de aprendizaje
*.tmp
*.temp
ejercicio-*.backup

# Archivos de configuración local
config.local
.env.local

# Documentos privados
reflexiones-privadas.md
notas-instructor/

# Archivos del sistema
.DS_Store
Thumbs.db
*~

# Editores
.vscode/settings.json
*.swp
*.swo

# Logs de práctica
debug.log
test.log
practica-*.log
```

---

## 🛠️ .gitignore Universal (Completo)

```text
# ================================
# Universal .gitignore
# ================================

# Archivos del Sistema Operativo
# macOS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Windows
Thumbs.db
ehthumbs.db
Desktop.ini
$RECYCLE.BIN/

# Linux
*~
.fuse_hidden*
.directory
.Trash-*

# Editores de Texto
# VS Code
.vscode/
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json

# Vim
[._]*.s[a-v][a-z]
[._]*.sw[a-p]
[._]s[a-rt-v][a-z]
[._]ss[a-gi-z]
[._]sw[a-p]

# Emacs
*~
\#*\#
/.emacs.desktop
/.emacs.desktop.lock
*.elc

# Sublime Text
*.sublime-workspace
*.sublime-project

# JetBrains
.idea/
*.iml
*.ipr
*.iws

# Archivos Temporales
*.tmp
*.temp
*.log
*.swp
*.swo
*.bak
*.backup

# Archivos Sensibles
.env
*.key
*.pem
secrets/
credentials.*
config.local.*

# Archivos de Respaldo
backup/
*.backup
old/
archive/
```

---

## 💡 Tips para .gitignore Efectivo

### 🎯 **Mejores Prácticas**

1. **Crear desde el inicio**: Configura .gitignore antes del primer commit
2. **Ser específico**: Mejor ser explícito que general
3. **Comentar secciones**: Organiza por categorías con comentarios
4. **Mantener actualizado**: Revisa y actualiza según evolucione el proyecto

### 🚨 **Errores Comunes**

```text
# ❌ MALO: Muy general
*

# ✅ BUENO: Específico
*.log
*.tmp
build/
```

### 🔧 **Comandos Útiles**

```bash
# Ver qué archivos Git está ignorando
git status --ignored

# Forzar agregar un archivo ignorado (si realmente lo necesitas)
git add -f archivo-ignorado.txt

# Ver si un archivo específico está siendo ignorado
git check-ignore archivo.txt

# Verificar reglas de .gitignore
git check-ignore -v archivo.txt
```

### 🌐 **Generadores Online**

- [gitignore.io](https://gitignore.io/) - Genera .gitignore por tecnología
- [GitHub .gitignore templates](https://github.com/github/gitignore) - Templates oficiales
- [Toptal .gitignore generator](https://gitignore.io/) - Interfaz amigable

---

## 🎓 Para Este Proyecto del Bootcamp

Para tu proyecto de la Semana 1, usa este .gitignore básico:

```text
# Archivos temporales
*.tmp
*.log
*~

# Sistema operativo
.DS_Store
Thumbs.db

# Archivos privados del aprendizaje
notas-privadas/
borradores/
*.backup

# Editores
.vscode/settings.json
*.swp
*.swo
```

---

**💡 Recuerda**: Un buen .gitignore es como una buena organización: previene problemas antes de que ocurran.
