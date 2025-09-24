# 🎨 Configuración VS Code - Bootcamp Git & GitHub

## 📋 Descripción

Esta carpeta contiene la configuración específica de VS Code para el proyecto del Bootcamp Git & GitHub, incluyendo la personalización con Peacock y extensiones recomendadas.

## 🎯 Color Theme - Peacock

### Color Principal

- **Color:** `#f1502f` (Git Orange)
- **Color Remoto:** `#ff6b35` (Git Orange Light)

Este color representa la identidad visual del bootcamp y coincide con:

- 🔶 Los colores oficiales de Git
- 🎨 El logo del bootcamp
- 📊 La paleta de colores del proyecto

### Colores Favoritos Configurados

| Color            | Hex       | Uso                            |
| ---------------- | --------- | ------------------------------ |
| Git Orange       | `#f1502f` | Color principal del workspace  |
| Git Orange Light | `#ff6b35` | Color secundario/remoto        |
| GitHub Dark      | `#24292e` | Alternativo para temas oscuros |
| GitHub Blue      | `#0366d6` | Para proyectos de Actions      |
| GitHub Green     | `#28a745` | Para proyectos de Security     |

## 🛠️ Extensiones Recomendadas

### Git & GitHub

- **GitLens** - Superpowers para Git en VS Code
- **GitHub Pull Requests** - Manejo completo de PRs
- **Git Graph** - Visualización del historial de Git

### GitHub Copilot

- **GitHub Copilot** - AI pair programming
- **GitHub Copilot Chat** - Conversational AI coding

### Markdown

- **Markdown All in One** - Herramientas completas para Markdown
- **Markdown Preview Enhanced** - Vista previa avanzada
- **markdownlint** - Linter para Markdown

### Utilidades

- **Peacock** - Colorización del workspace
- **Live Server** - Servidor local para testing
- **Tailwind CSS** - Intellisense para CSS

## 📂 Archivos de Configuración

```text
.vscode/
├── settings.json          # Configuraciones del workspace
├── extensions.json        # Extensiones recomendadas
└── README.md             # Este archivo

bootcamp-git-github.code-workspace  # Archivo de workspace
```

## 🚀 Cómo Usar

### Opción 1: Abrir como Workspace

```bash
# Abrir el archivo de workspace directamente
code bootcamp-git-github.code-workspace
```

### Opción 2: Abrir carpeta

```bash
# Abrir la carpeta del proyecto
code .
```

### Opción 3: Desde VS Code

1. `File` → `Open Workspace from File...`
2. Seleccionar `bootcamp-git-github.code-workspace`

## 🎨 Personalización Adicional

### Cambiar Color Peacock

1. Abrir Command Palette (`Ctrl+Shift+P`)
2. Ejecutar: `Peacock: Change to a Favorite Color`
3. Seleccionar de los colores predefinidos

### Colores Disponibles

- **Git Orange** - Color principal del bootcamp
- **Git Orange Light** - Variante más clara
- **GitHub Dark** - Para trabajo nocturno
- **GitHub Blue** - Para módulos de Actions
- **GitHub Green** - Para módulos de Security

## 📝 Configuraciones Aplicadas

### Visual

- Barra de título personalizada con color Git Orange
- Barra de estado con colores del proyecto
- Activity bar con theme coherente
- Bordes personalizados para paneles

### Funcionalidad

- Linting automático para Markdown
- Git integrado con GitLens
- Copilot activado para asistencia AI
- Live reload para desarrollo web

## 🔧 Troubleshooting

### Peacock no está funcionando

1. Instalar la extensión: `ext install johnpapa.vscode-peacock`
2. Recargar VS Code: `Ctrl+Shift+P` → `Developer: Reload Window`
3. Activar Peacock: `Ctrl+Shift+P` → `Peacock: Enter a Color`

### Extensiones no se instalan automáticamente

1. Abrir Extensions (`Ctrl+Shift+X`)
2. Buscar "Show Recommended Extensions"
3. Instalar las recomendadas manualmente

### Configuración no se aplica

1. Verificar que estás en el workspace correcto
2. Comprobar que el archivo `settings.json` existe
3. Reiniciar VS Code completamente

---

**💡 Tip:** Usa `Ctrl+Shift+P` → `Peacock: Surprise Me` para cambios rápidos de color durante las sesiones de coding!
