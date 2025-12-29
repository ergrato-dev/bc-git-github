# Leccion 02: Anatomia de los Marcadores de Conflicto

## Objetivos de Aprendizaje

Al finalizar esta leccion seras capaz de:

- Identificar los marcadores de conflicto en un archivo
- Entender que representa cada seccion del conflicto
- Leer correctamente la informacion de los marcadores
- Distinguir entre la version actual (HEAD) y la entrante

---

## Los Tres Marcadores

Cuando Git detecta un conflicto, inserta tres marcadores especiales en el archivo:

```
<<<<<<< HEAD
(contenido de tu branch actual)
=======
(contenido del branch que intentas merge)
>>>>>>> nombre-del-branch
```

---

## Anatomia Detallada

![Anatomia de un conflicto](../0-assets/01-anatomia-conflicto.svg)

### Marcador de Inicio: `<<<<<<<`

```javascript
<<<<<<< HEAD
```

- **Que indica**: Inicio de la seccion en conflicto
- **Contenido despues**: Tu version actual (el branch donde estas)
- **HEAD significa**: El commit actual de tu branch

### Separador: `=======`

```javascript
=======
```

- **Que indica**: Divide las dos versiones en conflicto
- **Antes del separador**: Tu version (current/ours)
- **Despues del separador**: Version entrante (incoming/theirs)

### Marcador de Fin: `>>>>>>>`

```javascript
>>>>>>> feature/nueva-funcionalidad
```

- **Que indica**: Fin de la seccion en conflicto
- **Nombre despues**: El branch que intentaste merge

---

## Ejemplo Completo

### Archivo Original (antes del conflicto)

```javascript
// archivo.js
function greet(name) {
  return "Hello, " + name;
}
```

### Despues de Modificaciones en Ambos Branches

**En main:**
```javascript
function greet(name) {
  return "Hola, " + name + "!";
}
```

**En feature:**
```javascript
function greet(name) {
  return "Hi there, " + name + "!";
}
```

### Archivo con Marcadores de Conflicto

```javascript
// archivo.js
function greet(name) {
<<<<<<< HEAD
  return "Hola, " + name + "!";
=======
  return "Hi there, " + name + "!";
>>>>>>> feature/saludo
}
```

---

## Interpretando el Conflicto

```javascript
<<<<<<< HEAD
  return "Hola, " + name + "!";    // <-- TU codigo (donde estas ahora)
=======
  return "Hi there, " + name + "!"; // <-- CODIGO ENTRANTE (del merge)
>>>>>>> feature/saludo
```

| Seccion | Contenido | Origen |
|---------|-----------|--------|
| Entre `<<<<<<<` y `=======` | Tu version | Branch actual (HEAD) |
| Entre `=======` y `>>>>>>>` | Version entrante | Branch del merge |

---

## Conflictos Multiples en un Archivo

Un archivo puede tener varios conflictos:

```javascript
// config.js
const config = {
<<<<<<< HEAD
  theme: "dark",
=======
  theme: "light",
>>>>>>> feature/ui
  
  language: "es",
  
<<<<<<< HEAD
  timeout: 5000,
=======
  timeout: 3000,
>>>>>>> feature/ui
};
```

**Nota**: Debes resolver TODOS los conflictos antes de hacer commit.

---

## Conflictos Multilinea

Los conflictos pueden abarcar multiples lineas:

```javascript
<<<<<<< HEAD
function calculateTotal(items) {
  let total = 0;
  for (const item of items) {
    total += item.price * item.quantity;
  }
  return total;
}
=======
function calculateTotal(items) {
  return items.reduce((sum, item) => {
    return sum + (item.price * item.quantity);
  }, 0);
}
>>>>>>> feature/refactor
```

---

## Visualizacion de Tipos de Conflictos

![Tipos de conflictos](../0-assets/02-tipos-conflictos.svg)

---

## Errores Comunes de Interpretacion

### Error 1: Confundir Current con Incoming

```javascript
<<<<<<< HEAD
// ESTO es TU codigo (current)
=======
// ESTO es el codigo ENTRANTE (incoming)
>>>>>>>
```

### Error 2: Dejar Marcadores en el Archivo

```javascript
// MAL: Marcadores no eliminados
<<<<<<< HEAD
  color: red;
=======

// BIEN: Marcadores eliminados, codigo limpio
  color: red;
```

### Error 3: No Resolver Todos los Conflictos

```bash
# Git no permite commit si quedan marcadores
git commit -m "fix merge"

# Error:
error: commit is not possible because you have unmerged files
```

---

## Verificar Marcadores Pendientes

```bash
# Buscar marcadores en archivos
git diff --check

# O buscar manualmente
grep -r "<<<<<<" .
grep -r "======" .
grep -r ">>>>>>" .
```

---

## Terminologia

| Termino | Significado | Comando relacionado |
|---------|-------------|---------------------|
| **Current** | Tu branch actual | `--ours` |
| **HEAD** | Commit actual de tu branch | - |
| **Incoming** | Branch que intentas merge | `--theirs` |
| **Ours** | Nuestra version (current) | `git checkout --ours` |
| **Theirs** | Su version (incoming) | `git checkout --theirs` |

---

## Resumen Visual

```
<<<<<<< HEAD          <-- "Aqui empieza TU version"
  [tu codigo]
=======               <-- "Aqui divide las versiones"
  [codigo entrante]
>>>>>>> branch        <-- "Aqui termina, branch: [nombre]"
```

---

## Ejercicio de Verificacion

Dado el siguiente conflicto:

```javascript
<<<<<<< HEAD
const API_URL = "https://api.miapp.com";
=======
const API_URL = "https://staging.miapp.com";
>>>>>>> feature/staging
```

1. ¿Cual es la URL en tu branch actual?
2. ¿Cual es la URL en el branch feature/staging?
3. ¿Que branch estabas intentando merge?
4. Si quieres conservar "https://api.miapp.com", ¿que debes hacer?

---

## Proximos Pasos

En la siguiente leccion aprenderemos:

- Como resolver conflictos manualmente
- Eliminar marcadores correctamente
- Completar el merge despues de resolver

---

*Leccion 02 de 04 | Week 04: Merge Conflicts*
