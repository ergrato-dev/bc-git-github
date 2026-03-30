# Proyecto: Team Sync Simulation

## Descripcion

Simular un entorno de trabajo en equipo donde multiples "desarrolladores" trabajan en el mismo proyecto, realizando push, pull y fetch para mantener sincronizacion, y manejando situaciones de divergencia.

**Duracion estimada:** 2 horas

---

## Objetivos de Aprendizaje

Al completar este proyecto seras capaz de:

- Simular flujo de trabajo en equipo con repositorios remotos
- Manejar sincronizacion entre multiples copias de un proyecto
- Resolver situaciones de divergencia entre local y remoto
- Documentar flujo de trabajo con remotes

---

## Escenario

Eres parte de un equipo de 3 desarrolladores trabajando en una aplicacion web:

- **Developer A** (tu): Trabajas en tu computadora principal
- **Developer B** (simulado): Trabajas desde otra ubicacion (clon separado)
- **Developer C** (simulado): Hace cambios directamente en GitHub

Todos trabajan en el mismo repositorio y deben mantenerse sincronizados.

---

## Requisitos

- Cuenta de GitHub activa
- Git instalado y configurado
- Completar ejercicios de la semana
- SSH configurado con GitHub

---

## Parte 1: Setup del Proyecto (15 min)

### 1.1 Crear repositorio en GitHub

1. Ve a [github.com/new](https://github.com/new)
2. Nombre: `team-sync-project`
3. Descripcion: "Proyecto de sincronizacion de equipo"
4. Publico
5. Inicializar con README
6. Agregar .gitignore: Node
7. Click "Create repository"

### 1.2 Clonar como Developer A

```bash
# Crear directorio de trabajo
mkdir -p ~/proyecto-week05
cd ~/proyecto-week05

# Clonar repositorio (Developer A)
git clone git@github.com:TU-USUARIO/team-sync-project.git developer-a
cd developer-a

# Verificar remote
git remote -v
```

### 1.3 Clonar como Developer B (segunda ubicacion)

```bash
# En otra carpeta, simular Developer B
cd ~/proyecto-week05
git clone git@github.com:TU-USUARIO/team-sync-project.git developer-b
cd developer-b

# Verificar que son copias independientes
ls ~/proyecto-week05/
# developer-a/  developer-b/
```

---

## Parte 2: Trabajo Inicial de Developer A (20 min)

### 2.1 Crear estructura del proyecto

```bash
cd ~/proyecto-week05/developer-a

# Crear estructura
mkdir -p src css js

# Crear archivo principal
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Team Sync App</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Team Sync Application</h1>
        <p>Desarrollado por el equipo</p>
    </header>
    
    <main>
        <section id="features">
            <h2>Caracteristicas</h2>
            <ul>
                <li>Feature 1: Pendiente</li>
                <li>Feature 2: Pendiente</li>
            </ul>
        </section>
    </main>
    
    <footer>
        <p>Team Sync v1.0.0</p>
    </footer>
    
    <script src="js/app.js"></script>
</body>
</html>
EOF

# Crear CSS
cat > css/styles.css << 'EOF'
/* Team Sync Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    background-color: #f4f4f4;
}

header {
    background-color: #333;
    color: white;
    padding: 1rem;
    text-align: center;
}

main {
    max-width: 800px;
    margin: 2rem auto;
    padding: 1rem;
}

footer {
    text-align: center;
    padding: 1rem;
    background-color: #333;
    color: white;
    position: fixed;
    bottom: 0;
    width: 100%;
}
EOF

# Crear JS
cat > js/app.js << 'EOF'
// Team Sync Application
const app = {
    name: "Team Sync",
    version: "1.0.0",
    
    init: function() {
        console.log(`${this.name} v${this.version} iniciado`);
    }
};

document.addEventListener("DOMContentLoaded", function() {
    app.init();
});
EOF
```

### 2.2 Commit y push de Developer A

```bash
git add .
git commit -m "feat: crear estructura inicial del proyecto"
git push origin main

# Verificar en GitHub que los archivos estan
```

---

## Parte 3: Developer B se Sincroniza (15 min)

### 3.1 Pull de cambios

```bash
cd ~/proyecto-week05/developer-b

# Ver estado antes de pull
git log --oneline
# Solo el commit inicial de GitHub

# Traer cambios de Developer A
git pull origin main

# Verificar archivos
ls -la
# Ahora tiene index.html, css/, js/
```

### 3.2 Developer B hace cambios

```bash
# Developer B agrega feature
cat >> js/app.js << 'EOF'

// Feature agregada por Developer B
app.greet = function(name) {
    console.log(`Hola, ${name}! Bienvenido a ${this.name}`);
};
EOF

git add js/app.js
git commit -m "feat: agregar funcion de saludo (Dev B)"
git push origin main
```

---

## Parte 4: Divergencia y Sincronizacion (25 min)

### 4.1 Developer A hace cambios (sin pull)

```bash
cd ~/proyecto-week05/developer-a

# Developer A agrega feature SIN hacer pull primero
cat >> css/styles.css << 'EOF'

/* Estilos agregados por Developer A */
.highlight {
    background-color: yellow;
    padding: 0.5rem;
}

.btn {
    padding: 0.5rem 1rem;
    border: none;
    cursor: pointer;
}
EOF

git add css/styles.css
git commit -m "feat: agregar estilos adicionales (Dev A)"
```

### 4.2 Intentar push (fallara)

```bash
git push origin main

# ERROR esperado:
# ! [rejected]        main -> main (fetch first)
# error: failed to push some refs
```

### 4.3 Resolver con fetch + merge

```bash
# Opcion 1: Fetch y revisar
git fetch origin

# Ver que hay de nuevo
git log main..origin/main --oneline

# Ver diferencias
git diff main origin/main

# Hacer merge
git merge origin/main

# Ahora push funciona
git push origin main
```

---

## Parte 5: Developer C (GitHub Web) (15 min)

### 5.1 Simular Developer C en GitHub

1. Ve a tu repositorio en GitHub
2. Click en `README.md`
3. Click en el lapiz (Edit)
4. Agrega contenido:

```markdown
# Team Sync Project

## Descripcion

Aplicacion web desarrollada en equipo para practicar sincronizacion con Git.

## Equipo

- Developer A: Estructura inicial, estilos
- Developer B: Funcionalidades JS
- Developer C: Documentacion

## Como ejecutar

1. Clonar el repositorio
2. Abrir index.html en el navegador

## Tecnologias

- HTML5
- CSS3
- JavaScript
```

5. Commit message: "docs: actualizar README con info del proyecto (Dev C)"
6. Commit changes

### 5.2 Sincronizar todos los developers

```bash
# Developer A
cd ~/proyecto-week05/developer-a
git pull origin main
git log --oneline -5

# Developer B
cd ~/proyecto-week05/developer-b
git pull origin main
git log --oneline -5

# Ambos deben tener los mismos commits
```

---

## Parte 6: Documentacion Final (20 min)

### 6.1 Crear SYNC_LOG.md

Developer A crea documentacion del flujo:

```bash
cd ~/proyecto-week05/developer-a

cat > SYNC_LOG.md << 'EOF'
# Log de Sincronizacion

## Registro de Operaciones

### Developer A
| Fecha | Operacion | Descripcion |
|-------|-----------|-------------|
| [HOY] | clone | Clonar repositorio inicial |
| [HOY] | push | Estructura inicial del proyecto |
| [HOY] | fetch | Obtener cambios de Dev B |
| [HOY] | merge | Integrar cambios de Dev B |
| [HOY] | push | Subir merge + mis cambios |
| [HOY] | pull | Sincronizar con Dev C |

### Developer B
| Fecha | Operacion | Descripcion |
|-------|-----------|-------------|
| [HOY] | clone | Clonar repositorio |
| [HOY] | pull | Obtener estructura de Dev A |
| [HOY] | push | Agregar funcion de saludo |
| [HOY] | pull | Sincronizar con Dev A y C |

### Developer C
| Fecha | Operacion | Descripcion |
|-------|-----------|-------------|
| [HOY] | web edit | Actualizar README desde GitHub |

---

## Lecciones Aprendidas

1. **Siempre hacer pull antes de push** para evitar rechazos
2. **Usar fetch primero** para revisar cambios antes de merge
3. **Comunicacion es clave** - saber que estan haciendo los demas
4. **Commits frecuentes** - cambios pequenos son mas faciles de integrar

---

## Comandos Mas Usados

```bash
git pull origin main     # Sincronizar
git fetch origin         # Ver cambios sin aplicar
git push origin main     # Enviar cambios
git log --oneline -5     # Ver historial reciente
git status               # Estado actual
```
EOF

git add SYNC_LOG.md
git commit -m "docs: agregar log de sincronizacion"
git push origin main
```

### 6.2 Verificar historial final

```bash
git log --oneline --graph --all

# Deberia mostrar todos los commits de los 3 developers
```

---

## Entregables

1. **Repositorio en GitHub** con todos los archivos
2. **Historial de commits** mostrando trabajo de 3 "developers"
3. **SYNC_LOG.md** documentando el flujo
4. **README.md** actualizado con info del proyecto

---

## Criterios de Evaluacion

| Criterio | Puntos |
|----------|--------|
| Setup correcto (2 clones + GitHub) | 10 |
| Push/pull funcionando | 15 |
| Manejo de divergencia | 15 |
| Historial de commits limpio | 10 |
| Documentacion (SYNC_LOG.md) | 20 |
| README completo | 10 |
| Todos sincronizados al final | 20 |
| **Total** | **100** |

---

## Reflexion Final

Responde estas preguntas en tu SYNC_LOG.md:

1. ¿Que sucede si dos developers modifican el mismo archivo?
2. ¿Por que es importante hacer pull antes de push?
3. ¿Cuando usarias fetch en vez de pull?
4. ¿Como mejoraria la comunicacion del equipo?

---

## Limpieza

```bash
# Si quieres eliminar el proyecto de practica
cd ~
rm -rf proyecto-week05
# Y eliminar el repo en GitHub si quieres
```

---

*Proyecto Week 05 | Bootcamp Git/GitHub*
