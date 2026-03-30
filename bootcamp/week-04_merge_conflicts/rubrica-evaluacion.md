# Rubrica de Evaluacion - Week 04

## Merge Conflicts

**Puntuacion Total: 100 puntos**

---

## 1. Identificacion de Conflictos (20 puntos)

### 1.1 Reconocimiento de Marcadores (10 pts)

| Criterio | Puntos |
|----------|--------|
| Identifica correctamente `<<<<<<<` (current) | 2 |
| Identifica correctamente `=======` (separador) | 2 |
| Identifica correctamente `>>>>>>>` (incoming) | 2 |
| Explica que representa cada seccion | 2 |
| Identifica el nombre del branch en marcadores | 2 |

### 1.2 Tipos de Conflictos (10 pts)

| Criterio | Puntos |
|----------|--------|
| Identifica content conflicts (misma linea modificada) | 3 |
| Identifica rename conflicts (archivo renombrado diferente) | 3 |
| Identifica delete conflicts (modificado vs eliminado) | 2 |
| Distingue entre conflictos automaticos y manuales | 2 |

---

## 2. Resolucion de Conflictos (30 puntos)

### 2.1 Resolucion Manual (15 pts)

| Criterio | Puntos |
|----------|--------|
| Elimina todos los marcadores de conflicto | 3 |
| Conserva el codigo correcto (decision justificada) | 4 |
| El archivo resultante es sintacticamente correcto | 3 |
| Ejecuta `git add` despues de resolver | 2 |
| Completa el merge con `git commit` | 3 |

### 2.2 Uso de Herramientas (15 pts)

| Criterio | Puntos |
|----------|--------|
| Configura mergetool en Git | 3 |
| Usa VS Code para resolver conflictos | 4 |
| Utiliza opciones Accept Current/Incoming/Both | 3 |
| Combina cambios manualmente cuando es necesario | 3 |
| Verifica resultado antes de completar merge | 2 |

---

## 3. Proyecto Collaborative Conflict (30 puntos)

### 3.1 Simulacion de Colaboracion (15 pts)

| Criterio | Puntos |
|----------|--------|
| Crea escenario con multiples branches | 4 |
| Genera conflictos intencionalmente | 3 |
| Resuelve al menos 5 conflictos diferentes | 4 |
| Documenta el proceso de cada resolucion | 4 |

### 3.2 Calidad del Repository (15 pts)

| Criterio | Puntos |
|----------|--------|
| Historial de commits limpio y descriptivo | 4 |
| Merge commits con mensajes claros | 4 |
| Codigo funcional despues de cada merge | 4 |
| README documenta el proceso completo | 3 |

---

## 4. Prevencion y Buenas Practicas (20 puntos)

### 4.1 Estrategias de Prevencion (10 pts)

| Criterio | Puntos |
|----------|--------|
| Demuestra uso de `git pull` antes de trabajar | 3 |
| Aplica commits frecuentes y pequenos | 3 |
| Comunica cambios en archivos compartidos | 2 |
| Usa branches de corta duracion | 2 |

### 4.2 Manejo de Situaciones Complejas (10 pts)

| Criterio | Puntos |
|----------|--------|
| Sabe abortar merge con `git merge --abort` | 3 |
| Recupera estado anterior cuando es necesario | 3 |
| Maneja conflictos en multiples archivos | 2 |
| Usa `git diff` para verificar cambios | 2 |

---

## Resumen de Puntuacion

| Seccion | Puntos Maximos |
|---------|----------------|
| Identificacion de Conflictos | 20 |
| Resolucion de Conflictos | 30 |
| Proyecto Collaborative Conflict | 30 |
| Prevencion y Buenas Practicas | 20 |
| **TOTAL** | **100** |

---

## Escala de Calificacion

| Rango | Calificacion | Descripcion |
|-------|--------------|-------------|
| 90-100 | A | Excelente - Dominio completo de conflictos |
| 80-89 | B | Bueno - Resuelve conflictos con confianza |
| 70-79 | C | Satisfactorio - Resuelve conflictos basicos |
| 60-69 | D | Necesita mejora - Dificultad con conflictos |
| 0-59 | F | Insuficiente - Requiere repetir la semana |

---

## Criterios de Aprobacion

Para aprobar Week 04 el estudiante debe:

1. Obtener minimo 60 puntos totales
2. Resolver al menos 3 conflictos de forma correcta
3. Completar el proyecto semanal
4. Demostrar uso de al menos una herramienta visual

---

## Entregables Requeridos

| Entregable | Formato | Obligatorio |
|------------|---------|-------------|
| Repository con conflictos resueltos | GitHub repo | Si |
| Documentacion de 5 conflictos | Markdown | Si |
| Configuracion de mergetool | `.gitconfig` | Si |
| Proyecto Collaborative Conflict | GitHub repo | Si |
| Capturas de pantalla del proceso | PNG/JPG | Opcional |

---

*Rubrica Week 04 | Bootcamp Git/GitHub*
