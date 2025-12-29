# Evidence Collection Guide - NexaCloud Technologies

## 📋 Overview

Este documento define los procedimientos para recolectar evidencia de controles de seguridad para auditorías de compliance (SOC 2, GDPR, ISO 27001).

---

## 🗓️ Collection Schedule

| Frequency | Evidence Type | Automation |
|-----------|---------------|------------|
| Real-time | Audit logs | ✅ Streaming |
| Daily | Security alerts | ✅ Automated |
| Weekly | Metrics dashboards | ✅ Automated |
| Monthly | Access reviews | ⚠️ Semi-auto |
| Quarterly | Control assessments | ❌ Manual |

---

## 📊 Automated Evidence Collection

### 1. Organization Membership & 2FA Status

```bash
# Script: collect-org-membership.sh
#!/bin/bash

DATE=$(date +%Y-%m-%d)
ORG="nexacloud"
OUTPUT_DIR="evidence/$DATE"

mkdir -p $OUTPUT_DIR

# Get all members with 2FA status
gh api "/orgs/$ORG/members" \
  --paginate \
  -H "Accept: application/vnd.github+json" \
  --jq '.[] | {login, id, type}' \
  > "$OUTPUT_DIR/org-members.json"

# Get 2FA disabled members (should be empty)
gh api "/orgs/$ORG/members?filter=2fa_disabled" \
  --paginate \
  > "$OUTPUT_DIR/2fa-disabled.json"

echo "Evidence collected: $OUTPUT_DIR"
```

**Storage**: `s3://nexacloud-compliance/evidence/org-membership/`
**Retention**: 3 years

---

### 2. Repository Security Settings

```bash
# Script: collect-repo-security.sh
#!/bin/bash

DATE=$(date +%Y-%m-%d)
ORG="nexacloud"
OUTPUT_DIR="evidence/$DATE"

# Get all repos with security features status
gh api "/orgs/$ORG/repos" \
  --paginate \
  -H "Accept: application/vnd.github+json" \
  --jq '.[] | {
    name,
    private,
    security_and_analysis: .security_and_analysis
  }' > "$OUTPUT_DIR/repo-security.json"

# Get branch protection rules
for repo in $(gh repo list $ORG --json name -q '.[].name'); do
  gh api "/repos/$ORG/$repo/branches/main/protection" \
    2>/dev/null > "$OUTPUT_DIR/protection-$repo.json"
done
```

**Storage**: `s3://nexacloud-compliance/evidence/repo-security/`
**Retention**: 3 years

---

### 3. Security Alerts Summary

```bash
# Script: collect-security-alerts.sh
#!/bin/bash

DATE=$(date +%Y-%m-%d)
ORG="nexacloud"
OUTPUT_DIR="evidence/$DATE"

# Code scanning alerts summary
gh api "/orgs/$ORG/code-scanning/alerts" \
  --paginate \
  -H "Accept: application/vnd.github+json" \
  --jq 'group_by(.state) | 
    map({state: .[0].state, count: length})' \
  > "$OUTPUT_DIR/code-scanning-summary.json"

# Secret scanning alerts
gh api "/orgs/$ORG/secret-scanning/alerts" \
  --paginate \
  -H "Accept: application/vnd.github+json" \
  --jq 'group_by(.state) | 
    map({state: .[0].state, count: length})' \
  > "$OUTPUT_DIR/secret-scanning-summary.json"

# Dependabot alerts
gh api "/orgs/$ORG/dependabot/alerts" \
  --paginate \
  -H "Accept: application/vnd.github+json" \
  --jq 'group_by(.state) | 
    map({state: .[0].state, count: length})' \
  > "$OUTPUT_DIR/dependabot-summary.json"
```

**Storage**: `s3://nexacloud-compliance/evidence/security-alerts/`
**Retention**: 3 years

---

### 4. Audit Log Export

```bash
# Script: export-audit-log.sh
#!/bin/bash

DATE=$(date +%Y-%m-%d)
ENTERPRISE="nexacloud-enterprise"

# Export audit log (last 24 hours)
gh api "/enterprises/$ENTERPRISE/audit-log" \
  --paginate \
  -H "Accept: application/vnd.github+json" \
  -f phrase="created:>=$(date -d 'yesterday' +%Y-%m-%d)" \
  > "evidence/$DATE/audit-log.json"
```

**Primary Storage**: Splunk (streaming)
**Backup**: `s3://nexacloud-compliance/evidence/audit-logs/`
**Retention**: 7 years

---

## 📝 Manual Evidence Collection

### Quarterly Access Review

| Step | Action | Owner | Evidence |
|------|--------|-------|----------|
| 1 | Export current access | Security | `access-export.csv` |
| 2 | Send to managers | Security | Email records |
| 3 | Manager review | Managers | Approval emails |
| 4 | Revoke stale access | Security | Change tickets |
| 5 | Document exceptions | Security | Exception log |

**Template**: `templates/access-review-template.xlsx`

---

### Annual Penetration Test

| Deliverable | Source | Storage |
|-------------|--------|---------|
| Engagement Letter | Vendor | Legal folder |
| Scope Document | Security + Vendor | Project folder |
| Test Report | Vendor | Compliance folder |
| Remediation Plan | Security | Project folder |
| Retest Results | Vendor | Compliance folder |

---

## 📁 Evidence Storage Structure

```
s3://nexacloud-compliance/
├── evidence/
│   ├── 2025-12-29/
│   │   ├── org-members.json
│   │   ├── repo-security.json
│   │   ├── code-scanning-summary.json
│   │   └── audit-log.json
│   └── ...
├── reports/
│   ├── quarterly/
│   │   └── Q4-2025-security-report.pdf
│   └── annual/
│       └── 2025-soc2-evidence-package.zip
└── templates/
    └── access-review-template.xlsx
```

---

## ✅ Evidence Checklist by Control

### SOC 2 - Security Trust Principle

| Control | Evidence Required | Collection Method |
|---------|-------------------|-------------------|
| CC6.1 (Access) | 2FA status, SSO logs | Automated |
| CC6.3 (RBAC) | Team membership | Automated |
| CC7.1 (Vuln Mgmt) | Alert dashboards | Automated |
| CC7.2 (Monitoring) | Audit logs | Streaming |
| CC8.1 (Change Mgmt) | PR history, approvals | Automated |

---

## 🔐 Evidence Integrity

All evidence files are:

1. **Timestamped**: ISO 8601 format in filename
2. **Hashed**: SHA-256 checksum stored
3. **Signed**: GPG signature for critical evidence
4. **Versioned**: S3 versioning enabled

```bash
# Generate checksum
sha256sum evidence/2025-12-29/*.json > evidence/2025-12-29/checksums.txt

# Sign evidence package
gpg --sign --armor evidence/2025-12-29/checksums.txt
```

---

*Last Updated: December 2025*
*Owner: NexaCloud Compliance Team*
