# 🖼️ Logo del Bootcamp - Instrucciones

## 📋 Problema Identificado

El logo SVG puede no renderizarse correctamente en GitHub. Aquí tienes varias alternativas:

### ✅ **Solución 1: URL Absoluta (Recomendada)**

Reemplaza en el README principal:

```markdown
<p align="center">
  <img src="https://raw.githubusercontent.com/TU_USUARIO/TU_REPOSITORIO/main/assets/logo-bootcamp.svg" alt="Bootcamp Git & GitHub Logo" width="400">
</p>
```

**Cambiar:**

- `TU_USUARIO` por tu nombre de usuario de GitHub
- `TU_REPOSITORIO` por el nombre de tu repositorio

### ✅ **Solución 2: Convertir a PNG**

Si sigues teniendo problemas, convierte el SVG a PNG:

```bash
# Usando ImageMagick (si tienes instalado)
convert assets/logo-bootcamp.svg assets/logo-bootcamp.png

# O usando un convertidor online:
# https://convertio.co/svg-png/
```

### ✅ **Solución 3: Usar Alternativa con Emojis**

Si prefieres no usar imagen, hay una versión con emojis comentada en el README:

```markdown
# 🎓 BOOTCAMP GIT & GITHUB 📚

## 🚀 14 Semanas Intensivas 💻
```

### ✅ **Solución 4: Mover a `.github` (GitHub especial)**

Crear la carpeta especial de GitHub:

```bash
mkdir -p .github/images/
cp assets/logo-bootcamp.svg .github/images/
```

Luego usar:

```markdown
![Logo](./.github/images/logo-bootcamp.svg)
```

## 🔍 **Verificar**

Después de hacer push al repositorio, el logo debería verse correctamente en la página principal de GitHub.

## 🎯 **Resultado Esperado**

Un logo profesional y visible que represente el bootcamp de Git & GitHub de manera llamativa en la página principal del repositorio.
