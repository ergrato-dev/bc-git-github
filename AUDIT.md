# AUDIT.md — bc-git-github

Auditoría de completitud, pertinencia, seguridad, estándares de repo y tooling. Repo 100% documentación (bootcamp Git/GitHub), sin código de producción Python/Node.

## 1. Resumen ejecutivo

| Categoría | Estado |
|---|---|
| Completitud de contenido | ~90% real y desarrollado — bloqueado por enlaces internos rotos, no por contenido faltante |
| Pertinencia/relevancia | OK — 100% enfocado en Git/GitHub, progresión coherente |
| Actualidad | Gap: cero cobertura de GitHub Copilot |
| Seguridad / CVEs | Sin riesgo real — únicos "CVEs" son ejemplos didácticos intencionados |
| Estándares familia `bc-*` | Por debajo de repos hermanos maduros (bc-docker, bc-python) |
| CLAUDE.md | Ausente, pero consistente con la familia (usan `copilot-instructions.md`) |
| Python → uv | No usado — `uv` no aparece en ningún archivo |
| Node → pnpm | Mayormente cumplido — 1 ejemplo suelto en npm |

## 2. Completitud (contenido real vs placeholders)

16 semanas completas (`week-01` a `week-16`), contenido teórico extenso (200-580 líneas/archivo), sin `TODO`/`Lorem ipsum`/placeholders textuales.

Problemas concretos:

- **`bootcamp/README.md`**: dice "bootcamp de 14 semanas", describe estructura de carpetas que no coincide con la real (`2-ejercicios/` vs real `2-practicas/`), no menciona weeks 15-16. Enlaces rotos: `../estudiantes/README.md`, `../admin/README.md` (no existen).
- **`docs/README.md`**: desactualizado — tabla de semanas solo cubre 1-14, mapea mal week-13 ("Enterprise Administration" vs carpeta real `week-13_security_policies_compliance`). Todos los enlaces `./week-01/` a `./week-14/` están rotos: apuntan a `docs/week-XX/` (no existe); el contenido real vive en `bootcamp/week-XX_slug/`.
- **105 enlaces markdown rotos** sistémicos en todo el repo: casi todo README de semana enlaza a la anterior/siguiente con `../week-01/` en vez de `../week-01_fundamentos_de_git/` (falta el slug). Afecta weeks 01,02,03,04,05,06,07,08,11,12,13,14. `week-10` y `week-15` usan naming legacy en español: `../semana-09/`, `../semana-14/`.
- `bootcamp/week-14_enterprise_administration/1-teoria/03-authentication-sso.md` enlaza a `2-practicas/ejercicio-04-sso-configuration/`, que no existe (el ejercicio real es `ejercicio-04-security-policies/`).
- Archivos casi vacíos (1 línea, solo encabezado): `week-15_github_administration_avanzado/0-assets/README.md`, `week-15.../1-teoria/README.md`, `week-16_proyecto_final_certificaciones/0-assets/README.md`, `week-16.../1-teoria/README.md`.
- Desde `week-09` en adelante se pierden las subcarpetas `ebooks-free/`, `videografia/`, `webgrafia/` dentro de `4-recursos/` (sí presentes en weeks 01-08) — queda solo un README inline.
- `week-14_enterprise_administration/4-recursos/README.md` (25 líneas) y `week-16.../2-practicas/README.md` (37 líneas) notablemente más delgados que sus pares.
- Naming inconsistente: `rubrica-evaluacion.md` (minúsculas, weeks 01-14) vs `RUBRICA_EVALUACION.md` (mayúsculas, weeks 15-16).

## 3. Pertinencia y relevancia

Contenido específico de Git/GitHub en todo momento, sin desvíos de tema. Progresión coherente: semanas 1-6 fundamentos de Git + GitHub Foundations, 7-10 Actions/CI-CD, 11-13 Security, 14-16 Administration/Enterprise + proyecto final — apropiado para preparación de certificaciones GitHub.

Git Flow se presenta correctamente contextualizado junto a GitHub Flow y Trunk-Based (no como único estándar impuesto). Usa `main` consistentemente; sin referencias a `master` obsoleto.

## 4. Actualidad del bootcamp

- **Gap notable**: cero menciones de **GitHub Copilot** (Copilot en PRs, code review asistido, Copilot en Actions/workflows) pese a ser funcionalidad central de GitHub en 2024-2026.
- El resto del contenido (Actions, Security features — Dependabot/Code Scanning/Secret Scanning, Enterprise Administration) sí refleja el estado actual de la plataforma.

## 5. Seguridad (auditoría CVEs)

- Repo sin dependencias reales instaladas — no hay `package.json`, `requirements.txt` ni `pyproject.toml` de producción en ningún lado.
- Vulnerabilidades mencionadas son ejemplos didácticos intencionados para las lecciones de Dependabot/Dependency Review (week-11): `axios@0.21.0`, `lodash@4.17.15`/`4.17.21`, `express@4.17.1`/`4.18.2`, `django==2.2.0`, `requests==2.20.0` en `bootcamp/week-11_security_features/2-practicas/ejercicio-02-dependabot/README.md` y `ejercicio-03-dependency-review/README.md`. Son versiones correctamente vulnerables (CVEs reales conocidos) para el propósito pedagógico — no representan riesgo real del repo.
- Sin secretos reales hardcodeados. Hits de patrones tipo `ghp_xxxx`, `AKIAIOSFODNN7EXAMPLE`, `password="anything"` son ejemplos didácticos dentro de lecciones de secret-scanning (week-11/12).
- `scripts/`: 3 shell scripts (`auto-commit.sh`, `setup-cron.sh`, `remove-cron.sh`), sin `eval`, sin `curl | bash`, piden confirmación y hacen backup antes de tocar crontab. `.github/workflows/close-prs.yml` usa `actions/github-script` pinneado por SHA (buena práctica), permisos mínimos.
- **Hallazgo**: `scripts/auto-commit.sh:33` tiene ruta hardcodeada `REPO_DIR="/home/epti/Documents/epti-dev/bc-channel/bc-git-github"` — rompe portabilidad para cualquier otro usuario/máquina y expone un alias de usuario (`epti`) distinto al del repo (`ergrato-dev`). Recomendado: resolver `REPO_DIR` relativo al script (`$(dirname "$(readlink -f "$0")")/..`) o variable de entorno.
- `SECURITY.md` completo y adecuado al contexto educativo: reporte por email (no issue público), SLA 48h acuse/7d evaluación, recomienda SSH+2FA, prohíbe commitear credenciales.

## 6. Estándares de repos github.com/ergrato-dev/bc-*

Comparado contra la familia real de ~45 repos `bc-*` vía `gh api users/ergrato-dev/repos`.

- **Raíz** (`README.md`, `README_EN.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `LICENSE` CC BY-NC-SA 4.0, `.gitignore`, `.code-workspace`): todos presentes y con contenido real, no genérico.
- **`CONTRIBUTING.md`** referencia `.github/ISSUE_TEMPLATE/` (bug_report, feature_request, question.md) y `PULL_REQUEST_TEMPLATE.md` que **no existen** en este repo — guía rota.
- **`.github/`** solo contiene `copilot-instructions.md` (completo, 312 líneas) y `workflows/close-prs.yml`. Faltan `ISSUE_TEMPLATE/`, `PULL_REQUEST_TEMPLATE.md`, `CODEOWNERS`, `dependabot.yml`, `FUNDING.yml`.
- **`bc-docker`** (repo hermano más maduro) sí tiene `ISSUE_TEMPLATE/` completo + `PULL_REQUEST_TEMPLATE.md`. **`bc-python`** añade `FUNDING.yml` y `dependabot.yml`. `bc-devops` es más minimalista (sin CONTRIBUTING/LICENSE/SECURITY) — el estándar de familia no es 100% uniforme, pero `bc-git-github` queda por debajo del patrón más completo.
- Inconsistencia de nomenclatura entre repos: `README_EN.md` (guion bajo, este repo) vs `README-EN.md` (guion, `bc-docker`).
- **`.github/workflows/close-prs.yml`** cierra automáticamente cualquier PR externo (`pull_request_target: opened/reopened`) — contradice la sección "Crear un Pull Request" de `CONTRIBUTING.md`, que da pasos detallados como si fueran a aceptarse.
- Dogfooding de commits: el `git log` sigue mayormente Conventional Commits (`feat(week-XX)`, `docs:`, `ci:`, `security:`) como exige `CONTRIBUTING.md`; un commit ("Update branch best practices...") rompe el patrón.

## 7. CLAUDE.md

No existe en `bc-git-github` ni en los repos hermanos muestreados (`bc-docker`, `bc-python`, `bc-devops`, `bc-nodejs`) — usan `.github/copilot-instructions.md` en su lugar. Es consistente con el estándar de la familia, no una desviación.

Recomendación: si se quiere soporte first-class para Claude Code sin duplicar contenido, añadir un `CLAUDE.md` mínimo en raíz que referencie `@.github/copilot-instructions.md`.

## 8. Python → uv / Node → pnpm

Sin código real; solo ejemplos ilustrativos en Markdown dentro de lecciones de CI/CD.

- **`uv` no se menciona en ningún archivo del repo.** Ejemplos que usan `pip install -r requirements.txt` en vez de `uv`:
  - `bootcamp/week-08_cicd_pipelines/1-teoria/02-build-testing.md:92`
  - `CONTRIBUTING.md:119-127`
  - `.github/copilot-instructions.md:123-131`
- **`pnpm`** ya es el estándar exigido para versiones pinneadas en `CONTRIBUTING.md:68` y `.github/copilot-instructions.md:109`. Único ejemplo suelto en `npm`:
  - `docs/ejercicios/ejercicio-01-instalacion.md:257-258` (`npm install` / `npm run`)

## 9. Recomendaciones priorizadas

| Prioridad | Hallazgo | Archivo(s) | Acción sugerida |
|---|---|---|---|
| Alta | 105 enlaces internos rotos por desajuste de slug de carpeta | Todo README de semana, `docs/README.md`, `bootcamp/README.md` | Normalizar todas las referencias `../week-NN/` → `../week-NN_slug/`; script de verificación de enlaces en CI |
| Alta | READMEs raíz desactualizados (14 vs 16 semanas, estructura de carpetas) | `bootcamp/README.md`, `docs/README.md` | Reescribir para reflejar las 16 semanas y la estructura real (`2-practicas/`, `3-proyecto/`, `4-recursos/`) |
| Media | Templates de GitHub referenciados pero ausentes | `.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md`, `.github/CODEOWNERS` | Crear siguiendo el patrón de `bc-docker` |
| Media | Cero cobertura de GitHub Copilot | Contenido de weeks 07-10 (Actions/CI-CD) | Añadir sección/ejercicio sobre Copilot en PRs, code review y Actions |
| Media | Ejemplos pip/npm sin alinear a uv/pnpm | `week-08.../02-build-testing.md:92`, `CONTRIBUTING.md:119-127`, `copilot-instructions.md:123-131`, `docs/ejercicios/ejercicio-01-instalacion.md:257-258` | Migrar ejemplos a `uv sync`/`uv run` y `pnpm install`/`pnpm run` |
| Baja | `close-prs.yml` contradice guía de PR de `CONTRIBUTING.md` | `.github/workflows/close-prs.yml`, `CONTRIBUTING.md` | Aclarar en CONTRIBUTING que PRs externos se cierran automáticamente y se pide abrir Issue |
| Baja | Ruta hardcodeada de otro usuario | `scripts/auto-commit.sh:33` | Resolver `REPO_DIR` de forma relativa al script |
| Baja | Naming inconsistente `rubrica-evaluacion.md` vs `RUBRICA_EVALUACION.md` | weeks 15-16 vs 01-14 | Unificar a minúsculas |
| Baja | `FUNDING.yml` / `dependabot.yml` ausentes | raíz / `.github/` | Opcional, presente en `bc-python` |

## 10. Estado de aplicación (remediación)

Todos los hallazgos accionables de este audit fueron aplicados directamente sobre el repo, salvo dos excepciones documentadas abajo.

**Aplicado:**
- 105+ enlaces internos rotos corregidos en todo `bootcamp/` y `docs/` (slug de carpeta faltante, naming legacy `semana-NN`, profundidad de `../` incorrecta), incluyendo casos adicionales no listados originalmente (`README.md`/`README_EN.md` raíz, `docs/README.md`, `docs/ejercicios/`, `docs/recursos/certificaciones-github.md`, y un salto de lección "SSH" inexistente en `week-01/1-teoria/03-configuracion.md` — se agregó contenido real de configuración SSH en lugar de dejar el enlace roto).
- `bootcamp/README.md` y `docs/README.md` reescritos: 16 semanas, fases correctas (GHAS 11-13, Administration 14-15, Final 16), enlaces apuntando a `bootcamp/` en vez de rutas inexistentes.
- Enlace roto de `week-14` (`ejercicio-04-sso-configuration` → `ejercicio-04-security-policies`) corregido.
- Mojibake de encabezados rotos (`�`) corregido en `README.md` y `CONTRIBUTING.md`.
- Creados `.github/ISSUE_TEMPLATE/{bug_report,feature_request,question}.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `.github/CODEOWNERS`, `.github/dependabot.yml` (ecosystem `github-actions`), `.github/FUNDING.yml`.
- `CONTRIBUTING.md` y `.github/copilot-instructions.md`: sección Python actualizada para exigir `uv` (`uv add`, `uv sync --frozen`) en vez de pip/poetry/conda; nota agregada sobre auto-cierre de PRs externos.
- Ejemplos sueltos `pip install`/`npm install` fuera de contexto migrados a `uv`/`uvx`/`pnpm` en `week-08`, `week-09`, `week-13`, `docs/ejercicios/ejercicio-01-instalacion.md`.
- `scripts/auto-commit.sh` y `scripts/setup-cron.sh`: `REPO_DIR` hardcodeado (`/home/epti/...`) reemplazado por resolución relativa al script.
- `rubrica-evaluacion.md` unificado a minúsculas en weeks 15-16 (antes `RUBRICA_EVALUACION.md`), referencias actualizadas.
- READMEs casi vacíos de `week-15`/`week-16` (`0-assets/`, `1-teoria/`) rellenados con índices reales (extraídos del contenido ya existente en cada semana, sin inventar lecciones nuevas).

**No aplicado — deferido intencionalmente:**
- **Gap de GitHub Copilot** (sección 4): no se agregó una lección nueva. Es contenido curricular sustancial (objetivos de aprendizaje, ejercicios, rúbrica) que requiere decisión pedagógica del instructor, no un fix mecánico.
- **Subcarpetas `ebooks-free/`, `videografia/`, `webgrafia/` faltantes desde week-09** (sección 2): no se crearon. Poblarlas requeriría inventar títulos de libros, videos o URLs externas — va contra la política de no generar/adivinar URLs. Requiere curación humana con recursos reales.
- Los ejemplos `npm`/`npm ci` usados extensamente en el currículo de CI/CD (weeks 07-10) para enseñar conceptos genéricos de GitHub Actions (caching, artifacts, matrix strategy) **no se migraron en bloque a `pnpm`** — son ejemplos pedagógicos neutros de gestor de paquetes, no código propio del proyecto; migrarlos todos sería una reescritura curricular fuera del alcance del audit original, que solo señaló un caso puntual (ya corregido).
