# 🔀 Ejercicio 03: Merge con Commit (Three-Way)

## 📋 Información

| Campo | Valor |
|-------|-------|
| **Duración** | 40 minutos |
| **Dificultad** | ⭐⭐ Intermedio |
| **Prerrequisitos** | Ejercicio 02 completado |
| **Temas** | Three-way merge, merge commit, `--no-ff`, historial ramificado |

---

## 🎯 Objetivos

Al completar este ejercicio serás capaz de:

- ✅ Entender cuándo ocurre un three-way merge
- ✅ Crear un merge commit intencionalmente
- ✅ Usar `--no-ff` para forzar commit de merge
- ✅ Visualizar e interpretar historial ramificado

---

## 📖 Concepto Clave

Un **three-way merge** (merge con commit) ocurre cuando:
- Ambos branches tienen commits nuevos (divergencia)
- Git crea un **commit de merge** con dos padres
- El historial queda **ramificado** (no lineal)

```
ANTES:                      DESPUÉS:
main ─●─●─●                 main ─●─●─●─────●
          \                           \     /
           ●─● feature                 ●───● feature
                                       (merge commit M)
```

---

## 📝 Instrucciones

### Parte 1: Setup del Repositorio (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 1: Crear directorio del ejercicio
# ══════════════════════════════════════════════════════════════

mkdir ejercicio-merge-commit && cd ejercicio-merge-commit
git init

# ══════════════════════════════════════════════════════════════
# PASO 2: Crear estructura inicial
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea los archivos base
# ¿Por qué?: Simular un proyecto existente
# ¿Para qué sirve?: Tener un punto de partida

echo "# E-Commerce App" > README.md
echo "body { margin: 0; }" > styles.css
echo "console.log('App ready');" > app.js

git add .
git commit -m "chore: initial e-commerce setup"

# Verificar
git log --oneline
```

---

### Parte 2: Crear Divergencia (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 3: Crear feature branch
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea branch para carrito de compras
# ¿Por qué?: Desarrollar feature en paralelo
# ¿Para qué sirve?: Simular trabajo de un desarrollador

git switch -c feature/shopping-cart

# Commit 1 en feature
cat > cart.js << 'EOF'
class ShoppingCart {
    constructor() {
        this.items = [];
    }
    
    addItem(product) {
        this.items.push(product);
    }
}
EOF

git add cart.js
git commit -m "feat: add ShoppingCart class"

# Commit 2 en feature
cat >> cart.js << 'EOF'

    removeItem(productId) {
        this.items = this.items.filter(item => item.id !== productId);
    }
    
    getTotal() {
        return this.items.reduce((sum, item) => sum + item.price, 0);
    }
}
EOF

git add cart.js
git commit -m "feat: add remove and total methods to cart"

# ══════════════════════════════════════════════════════════════
# PASO 4: Volver a main y hacer commits (crear divergencia)
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Añade commits en main mientras feature se desarrollaba
# ¿Por qué?: Simular que otro desarrollador trabajó en main
# ¿Para qué sirve?: Crear la divergencia necesaria para three-way merge

git switch main

# Commit 1 en main: actualizar README
cat >> README.md << 'EOF'

## Features
- Product catalog
- User authentication
- Shopping cart (coming soon)
EOF

git add README.md
git commit -m "docs: update README with features list"

# Commit 2 en main: añadir configuración
cat > config.js << 'EOF'
const CONFIG = {
    API_URL: 'https://api.example.com',
    CURRENCY: 'USD',
    TAX_RATE: 0.21
};
module.exports = CONFIG;
EOF

git add config.js
git commit -m "feat: add configuration file"
```

---

### Parte 3: Visualizar la Divergencia (5 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 5: Ver el estado de los branches
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra el historial gráfico
# ¿Por qué?: Para ver la divergencia entre branches
# ¿Para qué sirve?: Entender por qué se necesita three-way merge

git log --oneline --graph --all

# Resultado esperado (divergencia visible):
# * abc1234 (HEAD -> main) feat: add configuration file
# * def5678 docs: update README with features list
# | * ghi9012 (feature/shopping-cart) feat: add remove and total methods
# | * jkl3456 feat: add ShoppingCart class
# |/
# * mno7890 chore: initial e-commerce setup

# Nota: Los branches divergieron después del commit inicial
# main tiene 2 commits nuevos
# feature/shopping-cart tiene 2 commits nuevos
```

---

### Parte 4: Ejecutar Three-Way Merge (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 6: Realizar el merge
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Integra feature/shopping-cart en main
# ¿Por qué?: La feature está lista
# ¿Para qué sirve?: Combinar el trabajo de ambos branches

# Asegurarse de estar en main
git switch main

# Ejecutar merge
git merge feature/shopping-cart

# Git abre el editor con mensaje predeterminado:
# Merge branch 'feature/shopping-cart'
#
# (Guardar y cerrar el editor)

# Resultado esperado:
# Merge made by the 'ort' strategy.
#  cart.js | 15 +++++++++++++++
#  1 file changed, 15 insertions(+)
#  create mode 100644 cart.js

# ══════════════════════════════════════════════════════════════
# PASO 7: Verificar el merge commit
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra el nuevo historial
# ¿Por qué?: Para ver el commit de merge
# ¿Para qué sirve?: Confirmar que es un three-way merge

git log --oneline --graph --all

# Resultado esperado (con merge commit):
# *   xyz1234 (HEAD -> main) Merge branch 'feature/shopping-cart'
# |\
# | * ghi9012 (feature/shopping-cart) feat: add remove and total methods
# | * jkl3456 feat: add ShoppingCart class
# * | abc1234 feat: add configuration file
# * | def5678 docs: update README with features list
# |/
# * mno7890 chore: initial e-commerce setup

# ══════════════════════════════════════════════════════════════
# PASO 8: Examinar el merge commit
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Muestra detalles del commit de merge
# ¿Por qué?: Para ver que tiene DOS padres
# ¿Para qué sirve?: Entender la estructura del merge commit

git show --stat HEAD

# Resultado esperado:
# commit xyz1234...
# Merge: abc1234 ghi9012    # <-- DOS PADRES
# Author: ...
# Date: ...
#
#     Merge branch 'feature/shopping-cart'
#
#  cart.js | 15 +++++++++++++++
#  1 file changed, 15 insertions(+)
```

---

### Parte 5: Practicar --no-ff (10 min)

```bash
# ══════════════════════════════════════════════════════════════
# PASO 9: Limpiar y crear nueva feature
# ══════════════════════════════════════════════════════════════

git branch -d feature/shopping-cart

# Crear nueva feature
git switch -c feature/product-page

# Hacer commits
cat > product.html << 'EOF'
<div class="product">
    <img src="product.jpg" alt="Product">
    <h2>Product Name</h2>
    <p class="price">$99.99</p>
    <button>Add to Cart</button>
</div>
EOF

git add product.html
git commit -m "feat: add product page template"

# ══════════════════════════════════════════════════════════════
# PASO 10: Merge con --no-ff (forzar commit de merge)
# ══════════════════════════════════════════════════════════════

# ¿Qué hace?: Crea commit de merge aunque fast-forward sea posible
# ¿Por qué?: Para preservar el contexto de la feature
# ¿Para qué sirve?: Documentar claramente qué commits fueron parte de qué feature

git switch main

# Sin --no-ff esto sería fast-forward, pero...
git merge --no-ff feature/product-page -m "feat: merge product page feature"

# Resultado esperado:
# Merge made by the 'ort' strategy.
#  product.html | 8 ++++++++
#  1 file changed, 8 insertions(+)

# ══════════════════════════════════════════════════════════════
# PASO 11: Verificar el resultado
# ══════════════════════════════════════════════════════════════

git log --oneline --graph -6

# Resultado esperado (merge commit creado aunque podía ser FF):
# *   pqr5678 (HEAD -> main) feat: merge product page feature
# |\
# | * stu9012 (feature/product-page) feat: add product page template
# |/
# *   xyz1234 Merge branch 'feature/shopping-cart'
# |\
# | * ghi9012 feat: add remove and total methods
# ...

# Nota: --no-ff preserva el historial de la feature
# Esto es útil para revertir toda la feature con un solo comando
```

---

## ✅ Checklist de Verificación

- [ ] Entiendes cuándo Git hace three-way merge (divergencia)
- [ ] Puedes identificar un merge commit (dos padres)
- [ ] Sabes leer el historial gráfico con branches
- [ ] Puedes usar `--no-ff` para forzar commit de merge
- [ ] Entiendes la diferencia entre FF y no-FF en el historial

---

## 🧪 Desafío Extra

```bash
# Investiga cómo revertir un merge commit completo
# Pista:
git revert -m 1 <merge-commit-hash>

# ¿Qué significa el -m 1?
# Investiga la diferencia entre -m 1 y -m 2
```

---

## 🎯 Comparación Visual

### Fast-Forward (Ejercicio 02):
```
main ─●─●─●─●─●  (historial lineal, sin merge commit)
```

### Three-Way Merge (Este ejercicio):
```
main ─●─●─●───●  (merge commit con dos padres)
          \   /
           ●─●   (feature branch)
```

---

## 📊 Cuándo Usar Cada Uno

| Situación | Recomendación |
|-----------|---------------|
| Commits individuales, fixes rápidos | Fast-forward |
| Features completas | `--no-ff` (preservar contexto) |
| Trabajo en equipo | Three-way (inevitable con divergencia) |
| Historial limpio y lineal | Fast-forward |
| Poder revertir features enteras | `--no-ff` |

---

## 🔗 Navegación

| ⬅️ Anterior | 🏠 Prácticas | Siguiente ➡️ |
|:------------|:------------:|-------------:|
| [Ejercicio 02](../ejercicio-02-merge-ff/README.md) | [README](../README.md) | [Ejercicio 04](../ejercicio-04-feature-branch/README.md) |

---

<div align="center">

**Ejercicio 03** | Week 03: Branching Básico | Bootcamp Git/GitHub

</div>
