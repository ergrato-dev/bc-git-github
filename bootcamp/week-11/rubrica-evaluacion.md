# 📋 Rúbrica de Evaluación - Semana 11

## 🔒 Security Features

**Total de puntos posibles: 100**

---

## 📊 Distribución de Puntos

| Categoría | Puntos | Porcentaje |
|-----------|--------|------------|
| Comprensión de GHAS | 15 pts | 15% |
| Code Scanning | 20 pts | 20% |
| Dependabot | 15 pts | 15% |
| Dependency Review | 15 pts | 15% |
| Secret Scanning | 10 pts | 10% |
| Proyecto Security Hardening | 25 pts | 25% |
| **Total** | **100 pts** | **100%** |

---

## 📝 Criterios Detallados

### 1. Comprensión de GHAS (15 puntos)

| Criterio | Excelente (15) | Bueno (12) | Satisfactorio (9) | Necesita Mejora (5) |
|----------|----------------|------------|-------------------|---------------------|
| **Conocimiento** | Explica todos los componentes de GHAS y sus relaciones | Explica la mayoría de componentes | Conoce componentes básicos | Confunde componentes |
| **Público vs Privado** | Sabe exactamente qué features están disponibles en cada tipo | Conoce las diferencias principales | Conocimiento parcial | No distingue |
| **Licensing** | Comprende modelo de licenciamiento completo | Entiende conceptos básicos | Conocimiento limitado | No comprende |

### 2. Code Scanning con CodeQL (20 puntos)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Workflow configurado | 5 pts | codeql.yml funcional con triggers correctos |
| Lenguajes detectados | 3 pts | Análisis de lenguajes del proyecto |
| Resultados interpretados | 5 pts | Capacidad de leer y entender alerts |
| Vulnerabilidades corregidas | 5 pts | Al menos 1 vulnerabilidad corregida |
| Custom queries (bonus) | 2 pts | Implementación de queries personalizadas |

**Rúbrica de calidad:**
```
✅ Excelente (18-20): Workflow optimizado, interpreta SARIF, corrige issues
✅ Bueno (14-17): Workflow funcional, entiende resultados básicos
✅ Satisfactorio (10-13): Workflow básico, necesita ayuda con resultados
⚠️ Necesita Mejora (<10): Workflow con errores o no funcional
```

### 3. Dependabot (15 puntos)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| dependabot.yml válido | 4 pts | Configuración correcta de ecosistemas |
| Security alerts activos | 3 pts | Alerts habilitados y funcionando |
| Version updates configurado | 3 pts | Actualizaciones automáticas de versiones |
| Auto-merge configurado | 3 pts | Merge automático para patches seguros |
| Estrategia documentada | 2 pts | Explicación de configuración elegida |

**Ejemplo de configuración evaluada:**
```yaml
# Puntuación máxima requiere:
version: 2
updates:
  - package-ecosystem: "npm"  # ✅ Ecosistema correcto
    directory: "/"            # ✅ Directorio correcto
    schedule:
      interval: "weekly"      # ✅ Intervalo razonable
    open-pull-requests-limit: 10
    labels:                   # ✅ Labels organizativos
      - "dependencies"
    groups:                   # ✅ Agrupación de updates
      development-dependencies:
        patterns:
          - "*"
        update-types:
          - "minor"
          - "patch"
```

### 4. Dependency Review (15 puntos)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Action configurada | 5 pts | dependency-review-action en PRs |
| Severidad configurada | 3 pts | fail-on-severity apropiado |
| Licencias verificadas | 3 pts | Bloqueo de licencias incompatibles |
| Workflow integrado | 4 pts | Funciona correctamente en PRs |

**Niveles de severidad esperados:**
| Ambiente | Severidad Mínima | Puntuación |
|----------|------------------|------------|
| Production | `critical` o `high` | Parcial |
| Production | `moderate` | Completa |
| Development | `critical` | Aceptable |

### 5. Secret Scanning (10 puntos)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| Habilitado | 2 pts | Feature activo en repository |
| Push Protection | 3 pts | Bloqueo de commits con secrets |
| Custom patterns (bonus) | 3 pts | Patrones personalizados configurados |
| Alertas revisadas | 2 pts | Histórico de alertas gestionado |

**Tokens que debe detectar:**
- ✅ GitHub tokens (ghp_, gho_, ghu_)
- ✅ AWS Access Keys
- ✅ Azure/GCP credentials
- ✅ API keys de servicios comunes

### 6. Proyecto Security Hardening (25 puntos)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **Implementación** | 15 pts | |
| - Code Scanning activo | 4 pts | CodeQL corriendo en cada PR |
| - Dependabot configurado | 3 pts | Alerts y updates funcionando |
| - Dependency Review | 3 pts | Bloqueo de deps vulnerables |
| - Secret Scanning | 3 pts | Push protection habilitado |
| - SECURITY.md | 2 pts | Política de divulgación |
| **Documentación** | 5 pts | |
| - README actualizado | 2 pts | Badges de seguridad |
| - Proceso documentado | 3 pts | Pasos de implementación |
| **Funcionamiento** | 5 pts | |
| - Sin errores críticos | 3 pts | Todos los workflows pasan |
| - Alertas gestionadas | 2 pts | No hay alertas ignoradas |

---

## 🎯 Escala de Calificación

| Rango | Calificación | Descripción |
|-------|--------------|-------------|
| 90-100 | ⭐ Excelente | Dominio completo de GHAS |
| 80-89 | ✅ Muy Bueno | Implementación sólida |
| 70-79 | 👍 Bueno | Cumple objetivos principales |
| 60-69 | 📝 Satisfactorio | Necesita reforzar conceptos |
| <60 | ⚠️ Necesita Mejora | Requiere trabajo adicional |

---

## 📋 Checklist de Entrega

### Code Scanning
- [ ] Workflow codeql.yml creado y funcional
- [ ] Al menos un análisis completado
- [ ] Resultados revisados en Security tab
- [ ] Al menos 1 issue corregido (si aplica)

### Dependabot
- [ ] dependabot.yml configurado
- [ ] Security alerts habilitados
- [ ] Al menos 1 PR de Dependabot procesado
- [ ] Auto-merge configurado (opcional)

### Dependency Review
- [ ] Workflow con dependency-review-action
- [ ] fail-on-severity configurado
- [ ] Probado en un PR

### Secret Scanning
- [ ] Feature habilitado
- [ ] Push protection activo
- [ ] Alertas revisadas

### Proyecto
- [ ] Todos los features implementados
- [ ] SECURITY.md creado
- [ ] README con badges de seguridad
- [ ] Documentación del proceso

---

## 📎 Ejemplo de SECURITY.md Esperado

```markdown
# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

Para reportar vulnerabilidades:

1. **No crear issue público**
2. Enviar email a: security@example.com
3. Incluir:
   - Descripción de la vulnerabilidad
   - Pasos para reproducir
   - Impacto potencial
4. Respuesta esperada: 48 horas
5. Divulgación coordinada: 90 días

## Security Measures

- ✅ Code Scanning con CodeQL
- ✅ Dependabot alerts activos
- ✅ Secret Scanning habilitado
- ✅ Dependency Review en PRs
```

---

## 🔗 Recursos de Evaluación

- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [CodeQL Documentation](https://codeql.github.com/docs/)
- [Dependabot Configuration](https://docs.github.com/en/code-security/dependabot)
- [Secret Scanning](https://docs.github.com/en/code-security/secret-scanning)

---

[⬅️ Volver a Week 11](README.md)
