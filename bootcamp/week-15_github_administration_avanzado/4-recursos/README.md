# 📚 Recursos - Semana 15

## Administración Avanzada de GitHub

---

## 📖 Documentación Oficial

### Audit Log
- [Reviewing the Audit Log](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-settings-for-your-organization/reviewing-the-audit-log-for-your-organization)
- [Audit Log Events](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-settings-for-your-organization/audit-log-events-for-your-organization)
- [Streaming Audit Logs](https://docs.github.com/en/enterprise-cloud@latest/admin/monitoring-activity-in-your-enterprise/reviewing-audit-logs-for-your-enterprise/streaming-the-audit-log-for-your-enterprise)

### API & GraphQL
- [REST API Documentation](https://docs.github.com/en/rest)
- [GraphQL API Documentation](https://docs.github.com/en/graphql)
- [GraphQL Explorer](https://docs.github.com/en/graphql/overview/explorer)
- [Rate Limiting](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting)

### Migration
- [GitHub Enterprise Importer](https://docs.github.com/en/migrations/using-github-enterprise-importer)
- [Planning Your Migration](https://docs.github.com/en/migrations/overview/planning-your-migration-to-github)

### Backup
- [Archiving Repositories](https://docs.github.com/en/repositories/archiving-a-github-repository)
- [Git Clone Mirror](https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---mirror)

---

## 🛠️ Herramientas

| Herramienta | Uso | Instalación |
|-------------|-----|-------------|
| GitHub CLI | API automation | `brew install gh` |
| GEI | Migration | `gh extension install github/gh-gei` |
| jq | JSON processing | `brew install jq` |
| yq | YAML processing | `brew install yq` |

---

## 📋 Cheatsheets

### Audit Log Queries
```bash
# Por fecha
created:>=2024-01-15

# Por actor
actor:username

# Por acción
action:repo.create
action:team.*
```

### API Endpoints Comunes
```bash
GET /orgs/{org}/audit-log
GET /orgs/{org}/members
GET /orgs/{org}/repos
```

---

## 🎓 Certificación

### GitHub Administration - Temas Semana 15
- ✅ Audit log management
- ✅ API automation
- ✅ Migration planning
- ✅ Backup strategies

---

## 🔗 Enlaces Rápidos

| Recurso | URL |
|---------|-----|
| GitHub API Status | https://www.githubstatus.com/ |
| GitHub Support | https://support.github.com/ |
| GitHub Changelog | https://github.blog/changelog/ |
