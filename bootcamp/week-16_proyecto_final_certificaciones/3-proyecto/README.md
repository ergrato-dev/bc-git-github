# 🚀 Proyecto Final: GitHub Portfolio

## 📋 Descripción

Crear un repositorio profesional que demuestre todas las habilidades adquiridas durante el bootcamp, funcionando como tu portfolio de GitHub.

**Duración**: 180 minutos (3 horas)  
**Puntos**: 50 (50% de la evaluación semanal)

---

## 🎯 Objetivo

Demostrar dominio de:

- ✅ Git workflow profesional
- ✅ GitHub features (Issues, PRs, Projects)
- ✅ GitHub Actions (CI/CD)
- ✅ Security (branch protection, scanning)
- ✅ Documentation profesional

---

## 📦 Requisitos del Proyecto

### Estructura Mínima

```
tu-proyecto-final/
├── .github/
│   ├── workflows/
│   │   ├── ci.yml              # CI pipeline
│   │   └── cd.yml              # CD pipeline (opcional)
│   ├── ISSUE_TEMPLATE/
│   │   └── bug_report.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── CODEOWNERS
├── src/                         # Tu código
├── tests/                       # Tests
├── docs/                        # Documentación adicional
├── README.md                    # README profesional
├── CONTRIBUTING.md              # Guía de contribución
├── CODE_OF_CONDUCT.md           # Código de conducta
├── LICENSE                      # Licencia
├── CHANGELOG.md                 # Historial de cambios
└── SECURITY.md                  # Política de seguridad
```

---

## 🔧 Entregables

### 1. Repository Structure (10 pts)

```markdown
## Checklist
- [ ] README.md profesional con badges
- [ ] CONTRIBUTING.md
- [ ] LICENSE (MIT, Apache, etc.)
- [ ] .gitignore apropiado
- [ ] Estructura de carpetas clara
```

### 2. Git Workflow (10 pts)

```markdown
## Checklist
- [ ] Mínimo 10 commits con Conventional Commits
- [ ] Al menos 2 branches (main + feature)
- [ ] Al menos 1 Pull Request mergeado
- [ ] Tags/releases (v1.0.0)
- [ ] Historial limpio (no "fix typo" x10)
```

### 3. GitHub Actions (10 pts)

```yaml
# .github/workflows/ci.yml mínimo
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup
        # Tu setup (Node, Python, etc.)
        
      - name: Install
        run: # install dependencies
        
      - name: Test
        run: # run tests
        
      - name: Lint
        run: # run linter
```

**Checklist:**
- [ ] CI workflow funcional
- [ ] Tests ejecutándose
- [ ] Badge de status en README
- [ ] (Bonus) CD workflow

### 4. Security (10 pts)

```markdown
## Checklist
- [ ] Branch protection en main
  - [ ] Require PR
  - [ ] Require review
  - [ ] Require status checks
- [ ] SECURITY.md presente
- [ ] CODEOWNERS configurado
- [ ] (Bonus) Code scanning habilitado
```

### 5. Documentation (10 pts)

```markdown
## README.md debe incluir:
- [ ] Título y descripción clara
- [ ] Badges (CI, license, version)
- [ ] Screenshots/GIFs (si aplica)
- [ ] Instalación paso a paso
- [ ] Uso con ejemplos
- [ ] Tech stack
- [ ] Cómo contribuir
- [ ] Licencia
```

---

## 📝 Template de README

```markdown
# 🚀 Nombre del Proyecto

[![CI](https://github.com/USER/REPO/workflows/CI/badge.svg)](...)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

> Descripción breve y atractiva.

## ✨ Features

- 🔥 Feature principal
- 🎯 Otra feature
- 🚀 Más features

## 📦 Instalación

\`\`\`bash
git clone https://github.com/USER/REPO.git
cd REPO
npm install  # o tu comando
\`\`\`

## 🚀 Uso

\`\`\`bash
npm start  # o tu comando
\`\`\`

## 🛠️ Tech Stack

- Lenguaje/Framework
- Herramientas
- CI/CD: GitHub Actions

## 🤝 Contribuir

Ver [CONTRIBUTING.md](CONTRIBUTING.md)

## 📄 Licencia

MIT - ver [LICENSE](LICENSE)

## 👤 Autor

- GitHub: [@tuusuario](https://github.com/tuusuario)
- LinkedIn: [Tu Nombre](https://linkedin.com/in/tunombre)
```

---

## 💡 Ideas de Proyecto

### Opción 1: CLI Tool
```yaml
Descripción: Herramienta de línea de comandos
Stack: Node.js, Python, o Go
Features:
  - Comandos útiles
  - Tests con coverage
  - Publicación en npm/pip
```

### Opción 2: API REST
```yaml
Descripción: API con endpoints documentados
Stack: Express, FastAPI, o similar
Features:
  - CRUD operations
  - Authentication
  - Swagger docs
```

### Opción 3: Automation Scripts
```yaml
Descripción: Scripts de automatización
Stack: Bash, Python
Features:
  - GitHub API integration
  - Útil para DevOps
  - Bien documentado
```

### Opción 4: Static Site
```yaml
Descripción: Sitio web personal/portfolio
Stack: HTML/CSS/JS, o framework
Features:
  - Deploy con GitHub Pages
  - Responsive design
  - CI para build
```

---

## ✅ Checklist Final

```markdown
## Antes de entregar

### Estructura
- [ ] Todos los archivos requeridos presentes
- [ ] Código organizado en carpetas

### Git
- [ ] 10+ commits con conventional commits
- [ ] Branch protection configurado
- [ ] Al menos 1 PR mergeado

### Actions
- [ ] CI workflow pasa ✅
- [ ] Badge en README

### Security
- [ ] SECURITY.md presente
- [ ] Branch protection activo

### Documentation
- [ ] README completo y profesional
- [ ] CONTRIBUTING.md
- [ ] LICENSE

### Presentación
- [ ] Puedo explicar cada parte
- [ ] Demo lista
```

---

## 📊 Evaluación

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Repository Structure | 10 | Organización y archivos |
| Git Workflow | 10 | Commits, branches, PRs |
| GitHub Actions | 10 | CI/CD funcional |
| Security | 10 | Protection y policies |
| Documentation | 10 | README y docs |
| **Total** | **50** | |

---

## 🎤 Presentación

Prepara una demo de 10-15 minutos:

1. **Intro** (2 min): Qué hace tu proyecto
2. **Demo** (5 min): Mostrar funcionando
3. **Código** (3 min): Estructura y highlights
4. **CI/CD** (3 min): Workflows y security
5. **Q&A** (2 min): Preguntas

---

## 🔗 Recursos

- [README Templates](https://github.com/othneildrew/Best-README-Template)
- [Badges](https://shields.io/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)

---

**¡Éxito con tu proyecto final! 🎓**
