# Rubrica de Evaluacion - Week 05: Remote Repositories

## Informacion General

| Campo | Valor |
|-------|-------|
| Semana | 05 |
| Tema | Remote Repositories |
| Puntuacion Maxima | 100 puntos |
| Puntuacion Minima Aprobatoria | 70 puntos |

---

## Criterios de Evaluacion

### 1. Configuracion de Remotes (20 puntos)

| Criterio | Puntos | Descripcion |
|----------|--------|-------------|
| Remote origin configurado | 5 | `git remote add origin` ejecutado correctamente |
| Remote upstream configurado | 5 | Configuracion de segundo remote para fork workflow |
| URLs correctas | 5 | SSH o HTTPS configurados apropiadamente |
| Verificacion de remotes | 5 | Uso de `git remote -v` para confirmar |

**Niveles de desempeno:**

| Nivel | Puntos | Descripcion |
|-------|--------|-------------|
| Excelente | 18-20 | Multiples remotes configurados perfectamente |
| Bueno | 14-17 | Remote principal configurado, upstream parcial |
| Suficiente | 10-13 | Solo origin configurado basicamente |
| Insuficiente | 0-9 | Errores en configuracion de remotes |

---

### 2. Operaciones Push (25 puntos)

| Criterio | Puntos | Descripcion |
|----------|--------|-------------|
| Push inicial | 7 | Primer push con `-u` para establecer upstream |
| Push de branches | 6 | Enviar diferentes branches al remoto |
| Push de tags | 6 | Enviar tags al repository remoto |
| Manejo de errores | 6 | Resolver rechazos de push correctamente |

**Niveles de desempeno:**

| Nivel | Puntos | Descripcion |
|-------|--------|-------------|
| Excelente | 22-25 | Push completo con branches, tags y resolucion de errores |
| Bueno | 17-21 | Push funcional con manejo basico de errores |
| Suficiente | 12-16 | Solo push basico a main |
| Insuficiente | 0-11 | Errores frecuentes o push incompleto |

---

### 3. Operaciones Pull y Fetch (25 puntos)

| Criterio | Puntos | Descripcion |
|----------|--------|-------------|
| Git fetch | 8 | Uso correcto de fetch para obtener cambios |
| Git pull | 8 | Pull con merge automatico |
| Fetch + merge manual | 5 | Separar fetch de merge para control |
| Pull con rebase | 4 | Uso de `git pull --rebase` |

**Niveles de desempeno:**

| Nivel | Puntos | Descripcion |
|-------|--------|-------------|
| Excelente | 22-25 | Dominio de fetch, pull, y estrategias de merge |
| Bueno | 17-21 | Pull y fetch funcionales, merge manual parcial |
| Suficiente | 12-16 | Solo pull basico sin entender fetch |
| Insuficiente | 0-11 | Confusion entre pull y fetch |

---

### 4. Proyecto Team Sync (30 puntos)

| Criterio | Puntos | Descripcion |
|----------|--------|-------------|
| Simulacion de equipo | 8 | Crear multiples "desarrolladores" simulados |
| Sincronizacion | 8 | Push/pull entre diferentes clones |
| Resolucion de divergencias | 8 | Manejar cuando local y remoto divergen |
| Documentacion | 6 | README con flujo de trabajo documentado |

**Niveles de desempeno:**

| Nivel | Puntos | Descripcion |
|-------|--------|-------------|
| Excelente | 27-30 | Proyecto completo con documentacion clara |
| Bueno | 21-26 | Simulacion funcional, documentacion basica |
| Suficiente | 15-20 | Sincronizacion parcial, falta documentacion |
| Insuficiente | 0-14 | Proyecto incompleto o no funcional |

---

## Tabla de Puntuacion

| Categoria | Puntos Posibles | Puntos Obtenidos |
|-----------|-----------------|------------------|
| Configuracion de Remotes | 20 | |
| Operaciones Push | 25 | |
| Operaciones Pull/Fetch | 25 | |
| Proyecto Team Sync | 30 | |
| **TOTAL** | **100** | |

---

## Escala de Calificacion

| Rango | Calificacion | Descripcion |
|-------|--------------|-------------|
| 90-100 | A | Excelente - Dominio completo de remotes |
| 80-89 | B | Bueno - Manejo solido de operaciones remotas |
| 70-79 | C | Suficiente - Comprension basica de sincronizacion |
| 60-69 | D | Insuficiente - Requiere practica adicional |
| 0-59 | F | Reprobado - Debe repetir la semana |

---

## Errores Comunes a Evitar

### Configuracion

- No verificar remotes con `git remote -v`
- Usar HTTP cuando SSH esta configurado (o viceversa)
- Nombres de remote incorrectos

### Push

- Hacer `push --force` sin entender consecuencias
- No establecer upstream con `-u`
- Ignorar errores de rechazo

### Pull/Fetch

- Confundir pull con fetch
- No hacer fetch antes de crear branches
- Pull sin resolver conflictos locales primero

### Proyecto

- No documentar el flujo de trabajo
- Simular solo un desarrollador
- No probar sincronizacion bidireccional

---

## Comandos Evaluados

```bash
# Configuracion - 20 pts
git remote add origin <url>
git remote add upstream <url>
git remote -v
git remote remove <name>

# Push - 25 pts
git push -u origin main
git push origin feature-branch
git push origin --tags
git push --force-with-lease

# Pull/Fetch - 25 pts
git fetch origin
git fetch --all
git pull origin main
git pull --rebase origin main

# Tracking - Proyecto
git branch -vv
git branch -u origin/main
git clone <url>
```

---

## Retroalimentacion

### Fortalezas

1. _____________________________________
2. _____________________________________
3. _____________________________________

### Areas de Mejora

1. _____________________________________
2. _____________________________________
3. _____________________________________

### Recomendaciones

_____________________________________
_____________________________________

---

## Firmas

| Rol | Nombre | Firma | Fecha |
|-----|--------|-------|-------|
| Estudiante | | | |
| Instructor | | | |

---

*Week 05 | Bootcamp Git/GitHub*
