# 🚀 Ejercicio 03: Tu Primer Repository

## 🎯 Objetivo

Crear tu primer repository Git local, hacer commits y explorar el historial.

**⏱️ Tiempo estimado**: 60 minutos  
**Dificultad**: ⭐⭐ (Principiante-Intermedio)

---

## 📋 Prerrequisitos

- ✅ Git instalado (Ejercicio 01)
- ✅ Git configurado (Ejercicio 02)
- ✅ Terminal disponible

---

## 📁 Parte 1: Crear el Proyecto

```bash
# ¿QUÉ VAMOS A HACER?: Crear carpeta para nuestro proyecto
# ¿POR QUÉ LO HACEMOS?: Necesitamos un directorio para el repository
# ¿PARA QUÉ SIRVE?: Organizar nuestro código en un lugar específico

mkdir mi-primer-repo
cd mi-primer-repo
```

---

## 🎬 Parte 2: Inicializar Repository

```bash
# ¿QUÉ VAMOS A HACER?: Convertir esta carpeta en un repository Git
# ¿POR QUÉ LO HACEMOS?: Para que Git empiece a trackear cambios
# ¿PARA QUÉ SIRVE?: Habilitar control de versiones en este proyecto

git init

# Salida esperada:
# Initialized empty Git repository in /ruta/mi-primer-repo/.git/
```

```bash
# ¿QUÉ VAMOS A HACER?: Verificar el estado del repository
# ¿POR QUÉ LO HACEMOS?: Confirmar que Git está funcionando
# ¿PARA QUÉ SIRVE?: Ver qué archivos están trackeados

git status
```

---

## 📝 Parte 3: Crear Primer Archivo

```bash
# ¿QUÉ VAMOS A HACER?: Crear archivo README.md
# ¿POR QUÉ LO HACEMOS?: Todo proyecto debe tener documentación
# ¿PARA QUÉ SIRVE?: Explicar qué hace el proyecto

echo "# Mi Primer Repository" > README.md
echo "" >> README.md
echo "Este es mi primer proyecto con Git." >> README.md
echo "" >> README.md
echo "## Autor" >> README.md
echo "Tu Nombre" >> README.md
```

---

## ➕ Parte 4: Staging y Primer Commit

```bash
# ¿QUÉ VAMOS A HACER?: Agregar archivo al staging area
# ¿POR QUÉ LO HACEMOS?: Preparar el archivo para el commit
# ¿PARA QUÉ SIRVE?: Seleccionar qué cambios incluir en el commit

git add README.md

# Verificar que está en staging
git status
```

```bash
# ¿QUÉ VAMOS A HACER?: Crear nuestro primer commit
# ¿POR QUÉ LO HACEMOS?: Guardar el estado actual en el historial
# ¿PARA QUÉ SIRVE?: Crear punto de restauración y documentar cambio

git commit -m "feat: crear README inicial del proyecto"
```

---

## 📄 Parte 5: Crear .gitignore

```bash
# ¿QUÉ VAMOS A HACER?: Crear archivo para ignorar archivos innecesarios
# ¿POR QUÉ LO HACEMOS?: Evitar trackear archivos temporales o sensibles
# ¿PARA QUÉ SIRVE?: Mantener el repository limpio

echo "# Archivos del sistema" > .gitignore
echo ".DS_Store" >> .gitignore
echo "Thumbs.db" >> .gitignore
echo "" >> .gitignore
echo "# Archivos temporales" >> .gitignore
echo "*.log" >> .gitignore
echo "*.tmp" >> .gitignore
echo "" >> .gitignore
echo "# Dependencias" >> .gitignore
echo "node_modules/" >> .gitignore
```

```bash
# Agregar y commit
git add .gitignore
git commit -m "chore: agregar .gitignore con exclusiones básicas"
```

---

## 📂 Parte 6: Agregar Más Archivos

Crea una estructura básica:

```bash
# Crear carpeta src
mkdir src

# Crear archivo de ejemplo
echo "// Mi primer archivo de código" > src/main.js
echo "console.log('Hola desde Git!');" >> src/main.js

# Agregar y commit
git add src/
git commit -m "feat: agregar estructura src con archivo inicial"
```

---

## 📜 Parte 7: Explorar el Historial

```bash
# ¿QUÉ VAMOS A HACER?: Ver el historial de commits
# ¿POR QUÉ LO HACEMOS?: Revisar qué cambios se han hecho
# ¿PARA QUÉ SIRVE?: Auditoría y navegación del proyecto

git log

# Versión compacta
git log --oneline

# Con gráfico
git log --oneline --graph
```

---

## ✅ Verificación Final

Tu repository debe tener:

```bash
$ git log --oneline
abc1234 feat: agregar estructura src con archivo inicial
def5678 chore: agregar .gitignore con exclusiones básicas
ghi9012 feat: crear README inicial del proyecto
```

```bash
$ ls -la
.git/
.gitignore
README.md
src/
```

---

## 📝 Entregable

1. Captura de `git log --oneline` mostrando mínimo 3 commits
2. Captura de la estructura de carpetas
3. Contenido del README.md

---

## 🏆 Desafío Extra

Agrega 2 commits más con:
- Un archivo `CHANGELOG.md`
- Una carpeta `docs/` con un archivo `guia.md`

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Proyecto ➡️ |
|:------------|:------------:|-----------:|
| [Ejercicio 02](../ejercicio-02-configuracion/) | [README](../README.md) | [Proyecto](../../3-proyecto/) |
