# Glosario - Week 05: Remote Repositories

Terminos clave relacionados con repositorios remotos y colaboracion en Git.

---

## Indice Alfabetico

[C](#c) | [D](#d) | [F](#f) | [H](#h) | [O](#o) | [P](#p) | [R](#r) | [S](#s) | [T](#t) | [U](#u)

---

## C

### Clone

Crear una copia completa de un repositorio remoto en tu maquina local, incluyendo todo el historial de commits.

```bash
git clone git@github.com:usuario/repo.git
```

---

## D

### Distributed Version Control System (DVCS)

Sistema de control de versiones donde cada desarrollador tiene una copia completa del repositorio, no solo los archivos actuales. Git es un DVCS.

### Downstream

Direccion de flujo de datos desde el repositorio remoto hacia el local. Operaciones como `fetch` y `pull` son downstream.

---

## F

### Fast-forward

Tipo de merge donde Git simplemente mueve el puntero de la branch porque no hay divergencia. Ocurre cuando la branch local no tiene commits que el remote no tenga.

### Fetch

Descargar commits, archivos y referencias de un repositorio remoto sin integrarlos automaticamente en tu trabajo local.

```bash
git fetch origin
```

### Fork

Copia de un repositorio en tu cuenta de GitHub. Permite trabajar en un proyecto sin afectar el original.

---

## H

### HTTPS

Protocolo para conectarse a repositorios remotos usando URLs que comienzan con `https://`. Requiere autenticacion con usuario/password o token.

---

## O

### Origin

Nombre por defecto del remote que se crea al clonar un repositorio. Apunta al repositorio desde donde clonaste.

```bash
git remote -v
# origin  git@github.com:usuario/repo.git (fetch)
# origin  git@github.com:usuario/repo.git (push)
```

---

## P

### Pull

Combina `fetch` y `merge` en un solo comando. Descarga cambios del remote y los integra en tu branch actual.

```bash
git pull origin main
```

### Push

Enviar commits locales a un repositorio remoto.

```bash
git push origin main
```

### Push Rejection

Error que ocurre cuando intentas hacer push pero el remote tiene commits que tu local no tiene. Solucion: hacer pull primero.

---

## R

### Refspec

Formato que especifica como mapear referencias entre local y remote. Por ejemplo: `+refs/heads/*:refs/remotes/origin/*`.

### Remote

Repositorio alojado en un servidor (como GitHub) que sirve como punto central de colaboracion.

### Remote Branch

Branch que existe en el repositorio remoto. Se referencia como `remote/branch`, por ejemplo `origin/main`.

### Remote Tracking Branch

Branch local que sigue el estado de una branch remota. Permite ver que tan adelante o atras estas respecto al remote.

---

## S

### SSH (Secure Shell)

Protocolo seguro para conectarse a repositorios remotos usando claves criptograficas en lugar de passwords.

```bash
git clone git@github.com:usuario/repo.git
```

### Sync

Proceso de mantener tu repositorio local actualizado con el remoto. Involucra operaciones de push y pull.

---

## T

### Tracking Branch

Branch local configurada para seguir automaticamente una branch remota. Permite usar `git push` y `git pull` sin especificar el remote.

```bash
git push -u origin main  # Configura tracking
git push                  # Funciona sin especificar origin
```

---

## U

### Upstream

1. El repositorio original del cual hiciste fork
2. Direccion de flujo de datos desde local hacia remoto (push)
3. La branch remota que una branch local esta trackeando

```bash
git remote add upstream git@github.com:original/repo.git
```

### URL

Direccion del repositorio remoto. Puede ser HTTPS o SSH:

- HTTPS: `https://github.com/usuario/repo.git`
- SSH: `git@github.com:usuario/repo.git`

---

## Comandos Relacionados

| Comando | Descripcion |
|---------|-------------|
| `git remote` | Gestionar conexiones remotas |
| `git clone` | Clonar repositorio |
| `git fetch` | Descargar sin integrar |
| `git pull` | Descargar e integrar |
| `git push` | Enviar commits |
| `git branch -vv` | Ver tracking branches |

---

## Recursos Adicionales

- [Git Remote Documentation](https://git-scm.com/docs/git-remote)
- [GitHub Docs](https://docs.github.com/)
- [Pro Git Book - Chapter 2.5](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)

---

[Volver a la semana](../README.md)
