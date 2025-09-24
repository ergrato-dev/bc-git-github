# 📋 Proyecto Semana 1: Instrucciones Detalladas

## 🎯 Mi Primer Repositorio Git - Paso a Paso

Este proyecto te guiará para crear tu primer repositorio Git aplicando todo lo aprendido en la semana 1.

---

## 🚀 Parte 1: Preparación y Configuración

### ✅ **Paso 1.1: Verificar Instalación de Git**

```bash
# EJERCICIO: VERIFICACIÓN PREVIA
# ¿QUÉ VAMOS A HACER?: Confirmar que Git está correctamente instalado
# ¿POR QUÉ LO HACEMOS?: Asegurar que tenemos las herramientas necesarias
# ¿PARA QUÉ SIRVE?: Evitar problemas durante el desarrollo del proyecto

git --version

# Salida esperada: git version 2.20+ o superior
```

### ✅ **Paso 1.2: Configurar Identidad (si no lo has hecho)**

```bash
# EJERCICIO: CONFIGURACIÓN DE IDENTIDAD
# ¿QUÉ VAMOS A HACER?: Establecer nombre y email para los commits
# ¿POR QUÉ LO HACEMOS?: Git requiere identificar al autor de cada cambio
# ¿PARA QUÉ SIRVE?: Trazabilidad y colaboración efectiva

git config --global user.name "Tu Nombre Completo"
git config --global user.email "tu.email@ejemplo.com"

# Verificar configuración
git config --list | grep user
```

---

## 📁 Parte 2: Creación del Repositorio

### ✅ **Paso 2.1: Crear Directorio del Proyecto**

```bash
# EJERCICIO: PREPARACIÓN DEL WORKSPACE
# ¿QUÉ VAMOS A HACER?: Crear la carpeta donde vivirá nuestro repositorio
# ¿POR QUÉ LO HACEMOS?: Organización clara de nuestros archivos
# ¿PARA QUÉ SIRVE?: Tener un espacio dedicado para el proyecto

# Navegar a la carpeta de entregables del bootcamp
cd [ruta-bootcamp]/semana-01/4-proyecto/entregables/

# Crear directorio para tu repositorio
mkdir mi-primer-repo

# Entrar al directorio
cd mi-primer-repo
```

### ✅ **Paso 2.2: Inicializar Repositorio Git**

```bash
# EJERCICIO: INICIALIZACIÓN DE GIT
# ¿QUÉ VAMOS A HACER?: Convertir la carpeta en un repositorio Git
# ¿POR QUÉ LO HACEMOS?: Activar el tracking de cambios con Git
# ¿PARA QUÉ SIRVE?: Poder usar todos los comandos de control de versiones

git init

# Verificar que se creó el repositorio
ls -la
# Debes ver una carpeta .git/ (es donde Git guarda toda su información)

# Verificar estado inicial
git status
```

---

## 📝 Parte 3: Contenido del Proyecto

### ✅ **Paso 3.1: Crear Archivo README.md Principal**

Crea un archivo `README.md` con el siguiente contenido (personalízalo con tu información):

````markdown
# 🎯 Mi Primer Repositorio Git

## 👋 Sobre Mí

**Nombre:** [Tu nombre]  
**Bootcamp:** Git/GitHub - Semana 1  
**Fecha:** [Fecha actual]

## 📚 ¿Qué es este Repositorio?

Este es mi primer repositorio Git creado como parte del **Bootcamp Git/GitHub**. Aquí estoy aplicando los conceptos fundamentales aprendidos sobre control de versiones.

## 🎯 Objetivos del Proyecto

- [x] ✅ Instalar y configurar Git
- [x] ✅ Crear mi primer repositorio
- [x] ✅ Realizar commits con mensajes descriptivos
- [x] ✅ Gestionar archivos con Git
- [ ] 🚧 Conectar con repositorio remoto (próxima semana)

## 🛠️ Tecnologías Utilizadas

- **Git**: Control de versiones distribuido
- **Markdown**: Para documentación
- **Terminal**: Interfaz de línea de comandos

## 📈 Mi Progreso en Git

### Semana 1: Fundamentos ⭐⭐⭐⚪⚪

- Configuración inicial ✅
- Primer repositorio ✅
- Commits básicos ✅
- Gestión de archivos ✅

## 🔧 Comandos Git Aprendidos

```bash
git init          # Inicializar repositorio
git add           # Agregar archivos al staging area
git commit        # Confirmar cambios
git status        # Ver estado del repositorio
git log           # Ver historial de commits
```
````

## 🎓 Reflexión Personal

[Escribe aquí tus reflexiones sobre lo aprendido esta semana]

## 📫 Contacto

- **Email:** [tu-email@ejemplo.com]
- **GitHub:** [tu-usuario] (cuando lo tengas)

---

**🚀 Bootcamp Git/GitHub - Mi viaje de aprendizaje**

````

### ✅ **Paso 3.2: Primer Add y Commit**

```bash
# EJERCICIO: PRIMER COMMIT
# ¿QUÉ VAMOS A HACER?: Agregar el README al repositorio
# ¿POR QUÉ LO HACEMOS?: Crear nuestro primer snapshot del proyecto
# ¿PARA QUÉ SIRVE?: Establecer un punto de referencia en el historial

# Verificar estado antes del add
git status

# Agregar README.md al staging area
git add README.md

# Verificar que está en staging
git status

# Crear el primer commit
git commit -m "feat: agregar README inicial del proyecto

- Crear estructura básica del README
- Incluir objetivos y progreso personal
- Documentar comandos Git aprendidos"

# Verificar el commit
git log --oneline
````

---

## 📄 Parte 4: Agregando Más Contenido

### ✅ **Paso 4.1: Crear Archivo .gitignore**

```bash
# EJERCICIO: CONFIGURAR GITIGNORE
# ¿QUÉ VAMOS A HACER?: Crear archivo para ignorar archivos innecesarios
# ¿POR QUÉ LO HACEMOS?: Mantener el repositorio limpio y profesional
# ¿PARA QUÉ SIRVE?: Evitar trackear archivos temporales o privados

# Crear .gitignore
touch .gitignore
```

Contenido para `.gitignore`:

```text
# Archivos temporales del sistema
*.tmp
*.log
*~
.DS_Store
Thumbs.db

# Archivos privados
notas-privadas.txt
secrets/
credenciales.*

# Carpetas de respaldo
backup/
*.backup

# Archivos de editores
.vscode/settings.json
*.swp
*.swo
```

### ✅ **Paso 4.2: Commit del .gitignore**

```bash
# EJERCICIO: SEGUNDO COMMIT
# ¿QUÉ VAMOS A HACER?: Agregar .gitignore al repositorio
# ¿POR QUÉ LO HACEMOS?: Establecer reglas de exclusión desde el inicio
# ¿PARA QUÉ SIRVE?: Mantener repositorio profesional y limpio

git add .gitignore
git commit -m "docs: agregar .gitignore para archivos temporales

- Excluir archivos del sistema (.DS_Store, Thumbs.db)
- Ignorar archivos temporales y backups
- Configurar exclusiones para editores"
```

---

## 🗂️ Parte 5: Estructura del Proyecto

### ✅ **Paso 5.1: Crear Estructura de Carpetas**

```bash
# EJERCICIO: ORGANIZACIÓN DEL PROYECTO
# ¿QUÉ VAMOS A HACER?: Crear estructura profesional del repositorio
# ¿POR QUÉ LO HACEMOS?: Demostrar buenas prácticas de organización
# ¿PARA QUÉ SIRVE?: Facilitar mantenimiento y colaboración futuras

# Crear carpetas del proyecto
mkdir docs
mkdir src
mkdir ejemplos

# Crear archivos de ejemplo
touch src/hola-mundo.txt
touch ejemplos/comandos-git.md
touch docs/aprendizajes.md
```

### ✅ **Paso 5.2: Agregar Contenido a los Archivos**

#### **src/hola-mundo.txt**

```text
¡Hola, mundo Git!

Este es mi primer archivo en un repositorio Git.

Fecha de creación: [fecha actual]
Autor: [tu nombre]
Propósito: Aprender Git paso a paso
```

#### **ejemplos/comandos-git.md**

```markdown
# 🛠️ Comandos Git Que He Aprendido

## Configuración

- `git config --global user.name "Nombre"` - Configurar nombre
- `git config --global user.email "email"` - Configurar email
- `git config --list` - Ver configuración actual

## Repositorio

- `git init` - Inicializar repositorio
- `git status` - Ver estado actual
- `git log` - Ver historial de commits

## Workflow Básico

- `git add <archivo>` - Agregar archivo específico
- `git add .` - Agregar todos los archivos
- `git commit -m "mensaje"` - Crear commit con mensaje

## Próximos comandos a aprender

- `git push` - Subir cambios a repositorio remoto
- `git pull` - Bajar cambios de repositorio remoto
- `git branch` - Crear y gestionar branches
```

#### **docs/aprendizajes.md**

```markdown
# 📚 Mis Aprendizajes - Semana 1

## ¿Qué Aprendí?

### Conceptos Fundamentales

1. **Control de Versiones**: [Explica con tus palabras qué entendiste]
2. **Repositorio**: [Tu definición]
3. **Commit**: [¿Qué representa un commit para ti?]

### Comandos Más Útiles

- **git status**: [¿Por qué es importante?]
- **git add**: [¿Qué hace exactamente?]
- **git commit**: [¿Cuándo usarlo?]

## ¿Qué Me Resultó Más Difícil?

[Reflexiona sobre los aspectos más desafiantes]

## ¿Cómo Aplicaré Git en el Futuro?

[Ideas de uso personal/profesional]

## Objetivos para la Próxima Semana

- [ ] Aprender sobre repositorios remotos
- [ ] Conectar mi repo local con GitHub
- [ ] Practicar más mensajes de commit descriptivos
```

### ✅ **Paso 5.3: Commit de la Estructura**

```bash
# EJERCICIO: COMMIT MASIVO DE ARCHIVOS
# ¿QUÉ VAMOS A HACER?: Agregar todos los archivos nuevos de una vez
# ¿POR QUÉ LO HACEMOS?: Demostrar uso de git add . y commits descriptivos
# ¿PARA QUÉ SIRVE?: Crear snapshot completo del estado del proyecto

# Ver todos los archivos nuevos
git status

# Agregar todos los archivos
git add .

# Verificar staging area
git status

# Commit con mensaje descriptivo
git commit -m "feat: agregar estructura completa del proyecto

- Crear carpetas organizacionales (src/, docs/, ejemplos/)
- Añadir archivo hola-mundo.txt con saludo inicial
- Documentar comandos Git aprendidos
- Crear template para reflexiones de aprendizaje"
```

---

## 📊 Parte 6: Explorando el Historial

### ✅ **Paso 6.1: Revisar Historial**

```bash
# EJERCICIO: EXPLORACIÓN DEL HISTORIAL
# ¿QUÉ VAMOS A HACER?: Ver diferentes formatos del historial de commits
# ¿POR QUÉ LO HACEMOS?: Aprender a navegar y entender el historial
# ¿PARA QUÉ SIRVE?: Debugging, auditoría y comprensión del proyecto

# Ver historial completo
git log

# Ver historial compacto
git log --oneline

# Ver historial con archivos modificados
git log --stat

# Ver historial gráfico (si tienes múltiples branches)
git log --oneline --graph --all
```

### ✅ **Paso 6.2: Hacer Modificación y Nuevo Commit**

```bash
# EJERCICIO: MODIFICACIÓN Y COMMIT
# ¿QUÉ VAMOS A HACER?: Editar un archivo existente y crear un nuevo commit
# ¿POR QUÉ LO HACEMOS?: Practicar el workflow completo de modificaciones
# ¿PARA QUÉ SIRVE?: Entender cómo Git trackea cambios en archivos

# Editar README.md (agregar una sección nueva al final)
echo "

## 🎉 ¡Proyecto Completado!

Este README fue actualizado al finalizar el proyecto de la Semana 1.
Ahora tengo un repositorio Git funcional con varios commits." >> README.md

# Ver las diferencias
git diff README.md

# Agregar y commitear el cambio
git add README.md
git commit -m "docs: actualizar README con mensaje de finalización

- Agregar sección de proyecto completado
- Confirmar finalización exitosa del ejercicio"
```

---

## ✅ Parte 7: Verificación Final

### 🎯 **Checklist de Completitud**

Verifica que tienes todo lo siguiente:

```bash
# EJERCICIO: VERIFICACIÓN FINAL
# ¿QUÉ VAMOS A HACER?: Revisar que el proyecto cumple todos los requisitos
# ¿POR QUÉ LO HACEMOS?: Asegurar calidad y completitud del entregable
# ¿PARA QUÉ SIRVE?: Auto-evaluación y preparación para assessment

# 1. Verificar estructura de archivos
ls -la
# Debe mostrar: .git/, README.md, .gitignore, src/, docs/, ejemplos/

# 2. Verificar historial de commits
git log --oneline
# Debe mostrar al menos 4-5 commits con mensajes descriptivos

# 3. Verificar estado limpio
git status
# Debe mostrar "working tree clean"

# 4. Contar commits
git rev-list --count HEAD
# Debe mostrar 4 o más commits
```

### 📋 **Checklist Visual**

- [ ] ✅ Repositorio inicializado con `git init`
- [ ] ✅ Configuración de Git aplicada correctamente
- [ ] ✅ README.md completo y personalizado
- [ ] ✅ .gitignore apropiado configurado
- [ ] ✅ Estructura de carpetas profesional (src/, docs/, ejemplos/)
- [ ] ✅ Al menos 5 commits con mensajes descriptivos
- [ ] ✅ Archivos de contenido creados y commiteados
- [ ] ✅ Reflexión personal documentada
- [ ] ✅ Historial limpio y comprensible

---

## 🏆 Criterios de Evaluación

| Aspecto                  | Excelente (4)                                                       | Bueno (3)                              | Satisfactorio (2)                | Necesita Mejora (1)          |
| ------------------------ | ------------------------------------------------------------------- | -------------------------------------- | -------------------------------- | ---------------------------- |
| **Configuración Git**    | Identidad completa y correcta                                       | Configuración básica correcta          | Configuración parcial            | Sin configurar               |
| **Commits**              | 5+ commits con mensajes descriptivos siguiendo conventional commits | 4-5 commits con mensajes claros        | 3-4 commits con mensajes básicos | <3 commits o mensajes pobres |
| **Estructura**           | Organización profesional, .gitignore completo                       | Estructura básica, .gitignore presente | Archivos organizados             | Sin estructura clara         |
| **Documentación**        | README completo, reflexiones detalladas                             | README básico, algunas reflexiones     | README mínimo                    | Sin documentación            |
| **Aplicación Conceptos** | Demuestra comprensión profunda                                      | Aplica conceptos correctamente         | Uso básico correcto              | Conceptos mal aplicados      |

---

## 📝 Entrega del Proyecto

### 🎯 **Qué Entregar**

1. **Carpeta completa** `mi-primer-repo/` con todo su contenido
2. **Screenshot o texto** del output de `git log --oneline`
3. **Documento de reflexión** (puede estar en docs/aprendizajes.md)

### 📧 **Formato de Entrega**

```text
=== PROYECTO SEMANA 1: MI PRIMER REPOSITORIO GIT ===

Estudiante: [Tu nombre]
Fecha: [Fecha de entrega]

1. UBICACIÓN DEL REPOSITORIO:
   Ruta: [ruta completa a tu carpeta mi-primer-repo]

2. ESTADÍSTICAS DEL REPOSITORIO:
   - Número total de commits: [número]
   - Archivos principales: [listar archivos]
   - Carpetas creadas: [listar carpetas]

3. HISTORIAL DE COMMITS:
   [Pegar aquí el output de 'git log --oneline']

4. APRENDIZAJES CLAVE:
   [Resumir 3-5 aprendizajes principales de esta semana]

5. DESAFÍOS SUPERADOS:
   [¿Qué fue lo más difícil y cómo lo resolviste?]

6. PRÓXIMOS PASOS:
   [¿Qué quieres aprender la próxima semana?]
```

---

## 🔗 Recursos de Apoyo

### 🆘 **Si Tienes Problemas**

1. **Revisar las lecciones**: Volver a `1-teoria/` para conceptos
2. **Consultar ejercicios**: Revisar `2-ejercicios/` para comandos específicos
3. **Usar git help**: `git help <comando>` para ayuda detallada
4. **Verificar configuración**: `git config --list` para debug

### 💡 **Tips Adicionales**

- **Commits frecuentes**: Es mejor hacer muchos commits pequeños que pocos grandes
- **Mensajes claros**: Usa conventional commits (feat:, docs:, fix:, etc.)
- **Verificar siempre**: Usa `git status` constantemente para ver el estado
- **Experimentar**: No tengas miedo de probar comandos, es un repositorio de práctica

---

## 🎉 ¡Felicitaciones!

Al completar este proyecto habrás:

- ✅ Creado tu primer repositorio Git desde cero
- ✅ Aplicado todos los conceptos fundamentales de la semana 1
- ✅ Establecido buenas prácticas de documentación y organización
- ✅ Construido una base sólida para proyectos futuros

**¡Estás listo para la Semana 2: Repositories y Commits Avanzados!**

---

**📝 Nota Final**: Este proyecto es tu primer paso en el mundo del control de versiones. Tómate tu tiempo, experimenta, y no dudes en hacer preguntas. ¡El aprendizaje es un proceso iterativo, como Git mismo!
