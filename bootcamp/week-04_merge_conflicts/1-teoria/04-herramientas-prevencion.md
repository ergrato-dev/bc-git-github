# Leccion 04: Herramientas y Estrategias de Prevencion

## Objetivos de Aprendizaje

Al finalizar esta leccion seras capaz de:

- Usar VS Code para resolver conflictos visualmente
- Configurar y usar git mergetool
- Aplicar estrategias para prevenir conflictos
- Manejar situaciones complejas con multiples conflictos

---

## Herramientas Visuales

![Herramientas de merge](../0-assets/04-herramientas-merge.svg)

---

## VS Code: Resolucion Visual

VS Code detecta automaticamente los conflictos y muestra opciones inline:

### Opciones en la Interfaz

Cuando abres un archivo con conflicto, VS Code muestra:

```
Accept Current Change | Accept Incoming Change | Accept Both Changes | Compare Changes
```

### Acciones Disponibles

| Opcion | Descripcion | Equivalente |
|--------|-------------|-------------|
| **Accept Current** | Conserva tu version (HEAD) | `--ours` |
| **Accept Incoming** | Conserva version entrante | `--theirs` |
| **Accept Both** | Mantiene ambas versiones | Manual |
| **Compare Changes** | Muestra diferencias lado a lado | `git diff` |

### Usando VS Code

```bash
# 1. Despues de un merge con conflicto
git merge feature

# 2. Abrir VS Code
code .

# 3. Los archivos con conflicto aparecen marcados
# 4. Hacer clic en las opciones inline
# 5. Guardar el archivo

# 6. En terminal
git add archivo.js
git commit
```

---

## Configurar Git Mergetool

### Configuracion para VS Code

```bash
# Configurar VS Code como mergetool
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'

# Configurar VS Code como difftool (opcional)
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
```

### Verificar Configuracion

```bash
# Ver configuracion actual
git config --global --list | grep -E "(merge|diff)"

# Salida esperada:
merge.tool=vscode
mergetool.vscode.cmd=code --wait $MERGED
```

### Usar Mergetool

```bash
# Despues de un conflicto
git merge feature
# CONFLICT detectado

# Abrir herramienta configurada
git mergetool

# VS Code se abre con el archivo
# Resolver y guardar
# Cerrar VS Code

# Git pregunta si se resolvio
Was the merge of 'archivo.js' successful [y/n]? y

# Continuar con el commit
git commit
```

---

## Otras Herramientas de Merge

### Meld (Linux/Windows)

```bash
# Instalar en Ubuntu/Debian
sudo apt install meld

# Configurar
git config --global merge.tool meld
git config --global mergetool.meld.cmd 'meld $LOCAL $MERGED $REMOTE --output $MERGED'
```

### KDiff3 (Multiplataforma)

```bash
# Configurar
git config --global merge.tool kdiff3
```

### P4Merge (Multiplataforma - Gratuito)

```bash
# Configurar
git config --global merge.tool p4merge
git config --global mergetool.p4merge.cmd 'p4merge $BASE $LOCAL $REMOTE $MERGED'
```

---

## Comandos Utiles Durante Conflictos

### Ver Diferencias

```bash
# Ver todos los cambios pendientes
git diff

# Ver solo archivos en conflicto
git diff --name-only --diff-filter=U

# Verificar marcadores de conflicto
git diff --check
```

### Informacion del Merge

```bash
# Ver commits involucrados en el conflicto
git log --merge

# Ver el merge en progreso
git log --oneline HEAD MERGE_HEAD
```

### Resolver Rapidamente

```bash
# Aceptar TODOS los cambios de tu branch
git checkout --ours .
git add .

# Aceptar TODOS los cambios entrantes
git checkout --theirs .
git add .
```

**Advertencia:** Usar con cuidado, pierdes los cambios de la otra version.

---

## Estrategias de Prevencion

### 1. Sincronizar Frecuentemente

```bash
# Antes de empezar a trabajar
git pull origin main

# Antes de crear un branch
git checkout main
git pull origin main
git checkout -b feature/nueva

# Periodicamente mientras trabajas
git fetch origin
git merge origin/main  # o git rebase origin/main
```

### 2. Branches de Corta Duracion

```
MAL:
main ----*----*----*----*----*----*----*----*----*----
          \                                          /
feature    *----*----*----*----*----*----*----*----*
           (3 semanas de divergencia = muchos conflictos)

BIEN:
main ----*----*----*----*----*----*----*----*----*----
          \     /    \     /    \     /
feature1   *--*      |     |     |     |
feature2        *--*       |     |
feature3              *--*       |
feature4                    *--*
           (branches cortos = menos conflictos)
```

### 3. Comunicacion con el Equipo

```bash
# Antes de modificar archivos criticos
# Comunicar al equipo:
# "Voy a refactorizar utils.js"
# "Trabajando en el modulo de autenticacion"

# Esto evita que otros modifiquen lo mismo simultaneamente
```

### 4. Commits Pequenos y Frecuentes

```bash
# MAL: Un commit gigante
git commit -m "Implementar feature completa"  # 500 lineas

# BIEN: Varios commits pequenos
git commit -m "feat: agregar estructura base"
git commit -m "feat: implementar logica principal"
git commit -m "feat: agregar validaciones"
git commit -m "test: agregar tests unitarios"
```

### 5. Dividir Trabajo por Archivos/Modulos

```
Desarrollador A: trabaja en /src/auth/
Desarrollador B: trabaja en /src/payments/
Desarrollador C: trabaja en /src/notifications/

= Menos probabilidad de conflictos
```

---

## Manejo de Situaciones Complejas

### Conflictos en Muchos Archivos

```bash
# Ver cuantos archivos tienen conflicto
git diff --name-only --diff-filter=U | wc -l

# Listar archivos
git diff --name-only --diff-filter=U

# Resolver uno por uno, priorizando los criticos
git mergetool archivo-critico.js
git add archivo-critico.js

# Continuar con el resto
git mergetool
```

### Conflictos en Archivos Binarios

```bash
# Git no puede mostrar diff de binarios
# Debes elegir una version

# Usar tu version
git checkout --ours imagen.png
git add imagen.png

# Usar version entrante
git checkout --theirs imagen.png
git add imagen.png
```

### Reintentar con Diferente Estrategia

```bash
# Abortar merge actual
git merge --abort

# Intentar con estrategia recursiva favoreciendo ours
git merge -X ours feature

# O favoreciendo theirs
git merge -X theirs feature
```

---

## Workflow Recomendado para Equipos

```bash
# 1. Siempre trabajar en branches
git checkout -b feature/mi-feature

# 2. Commits frecuentes
git commit -m "feat: progreso parcial"

# 3. Sincronizar con main regularmente
git fetch origin
git merge origin/main  # resolver conflictos aqui, no en main

# 4. Antes del merge final
git checkout main
git pull origin main
git checkout feature/mi-feature
git merge main  # asegurar que esta actualizado

# 5. Merge a main
git checkout main
git merge feature/mi-feature  # deberia ser sin conflictos

# 6. Push
git push origin main
```

---

## Checklist de Prevencion

- [ ] `git pull` antes de empezar cada dia
- [ ] Branches de maximo 1-2 dias de duracion
- [ ] Comunicar cuando modificas archivos compartidos
- [ ] Commits pequenos y descriptivos
- [ ] Sincronizar con main durante desarrollo
- [ ] Resolver conflictos en tu branch, no en main
- [ ] Code review antes de merge

---

## Resumen

| Estrategia | Descripcion |
|------------|-------------|
| **VS Code** | Interfaz visual con botones inline |
| **git mergetool** | Abre herramienta externa configurada |
| **Sincronizar** | `git pull` frecuente |
| **Branches cortos** | Menos divergencia = menos conflictos |
| **Comunicacion** | Coordinar trabajo en archivos compartidos |
| **Commits pequenos** | Facilita identificar y resolver |

---

## Comandos Clave

```bash
# Herramientas
git mergetool                    # Abrir herramienta visual
git diff --check                 # Verificar marcadores

# Resolver rapido
git checkout --ours archivo      # Tu version
git checkout --theirs archivo    # Version entrante

# Abortar
git merge --abort                # Cancelar merge

# Estrategias
git merge -X ours branch         # Favorecer tu version
git merge -X theirs branch       # Favorecer entrante
```

---

*Leccion 04 de 04 | Week 04: Merge Conflicts*
