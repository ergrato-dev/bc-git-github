# Ejercicio 01: Crear SECURITY.md Profesional

## 🎯 Objetivo

Crear un archivo `SECURITY.md` completo y profesional para un proyecto de software, incluyendo todos los componentes necesarios para una política de seguridad efectiva.

## ⏱️ Duración

40 minutos

## 📋 Contexto

Eres el Security Lead de **TechCorp**, una empresa que desarrolla una aplicación SaaS llamada **DataSync Pro**. El proyecto tiene:

- Versiones 3.x (actual), 2.x (legacy), 1.x (deprecated)
- API pública en `api.datasync.io`
- Aplicaciones móviles iOS y Android
- Repositorios open source en GitHub

Tu tarea es crear una política de seguridad completa que:
- Defina claramente las versiones soportadas
- Establezca canales de reporte seguros
- Incluya SLAs de respuesta
- Proporcione safe harbor para researchers

---

## 📝 Instrucciones

### Parte 1: SECURITY.md (25 minutos)

Crea el archivo `SECURITY.md` con las siguientes secciones:

#### 1.1 Header y Compromiso

```markdown
# Security Policy

## Our Commitment

[Escribe 2-3 párrafos sobre el compromiso de TechCorp con la seguridad]
```

**Requisitos**:
- Mencionar el compromiso con la seguridad de usuarios
- Agradecer a la comunidad de security researchers
- Establecer el tono profesional del documento

#### 1.2 Supported Versions

Crea una tabla con las versiones soportadas:

| Version | Status | Support Level | End of Life |
|---------|--------|---------------|-------------|
| 3.x.x | Current | Full security updates | Active |
| 2.x.x | Legacy | Critical patches only | Dec 2025 |
| 1.x.x | Deprecated | No support | June 2024 |
| < 1.0 | N/A | Never supported | N/A |

**Requisitos**:
- Usar emojis o símbolos para indicar soporte (✅/❌)
- Incluir fechas de End of Life
- Explicar qué significa cada nivel de soporte

#### 1.3 Reporting a Vulnerability

**Requisitos**:
- Método preferido: GitHub Private Vulnerability Reporting
- Alternativa: Email con PGP encryption
- Lista de información a incluir en el reporte
- Qué NO hacer (no publicar públicamente, no explotar)

#### 1.4 Response Process

Crea una tabla de SLAs:

| Severity | Initial Response | Status Update | Resolution Target |
|----------|------------------|---------------|-------------------|
| Critical | 24 hours | Daily | 7 days |
| High | 48 hours | Weekly | 30 days |
| Medium | 5 days | Bi-weekly | 90 days |
| Low | 7 days | Monthly | Best effort |

#### 1.5 Safe Harbor

**Requisitos**:
- Declaración clara de no acción legal
- Condiciones que deben cumplirse
- Qué se compromete TechCorp a hacer
- Referencia a estándares (ISO 29147, ISO 30111)

#### 1.6 Scope

Define el alcance del programa:

**In Scope**:
- *.datasync.io
- api.datasync.io
- DataSync Pro iOS/Android apps
- Open source repos: github.com/techcorp/*

**Out of Scope**:
- Third-party integrations
- Social engineering
- Physical attacks
- DoS/DDoS testing

#### 1.7 Recognition

- Hall of Fame reference
- Tipo de reconocimiento ofrecido
- Proceso para solicitar anonimato

---

### Parte 2: security.txt (10 minutos)

Crea el archivo `security.txt` siguiendo RFC 9116:

```text
# TechCorp Security Contact
# https://securitytxt.org/

Contact: [método de contacto]
Expires: [fecha de expiración]
Encryption: [URL de clave PGP]
Acknowledgments: [URL del hall of fame]
Preferred-Languages: [idiomas]
Canonical: [URL canónica]
Policy: [URL de la política]
Hiring: [URL de trabajos de seguridad]
```

**Requisitos**:
- Todos los campos obligatorios (Contact, Expires)
- Al menos 3 campos opcionales
- Fecha de expiración no mayor a 1 año
- Comentarios explicativos

---

### Parte 3: Validación (5 minutos)

Valida tu trabajo con este checklist:

```markdown
## SECURITY.md Checklist
- [ ] Versiones soportadas documentadas
- [ ] Canal de reporte principal definido
- [ ] Canal alternativo con encryption
- [ ] SLAs de respuesta especificados
- [ ] Safe harbor statement incluido
- [ ] Scope claramente definido
- [ ] Exclusiones documentadas
- [ ] Información de reconocimiento

## security.txt Checklist
- [ ] Contact field presente
- [ ] Expires field con fecha válida
- [ ] Canonical URL incluida
- [ ] Policy URL apunta a SECURITY.md
- [ ] Formato correcto (sin errores de sintaxis)
```

---

## 📦 Entregables

1. **SECURITY.md** - Archivo completo de política de seguridad
2. **security.txt** - Archivo para .well-known/
3. **checklist-validation.md** - Checklist completado

---

## ✅ Criterios de Éxito

| Criterio | Puntos |
|----------|--------|
| SECURITY.md completo con todas las secciones | 40 |
| SLAs realistas y bien definidos | 15 |
| Safe harbor claro y protector | 15 |
| security.txt válido según RFC 9116 | 20 |
| Documentación clara y profesional | 10 |
| **Total** | **100** |

---

## 💡 Tips

1. **Sé específico**: Evita lenguaje vago como "lo antes posible"
2. **Sé realista**: No prometas SLAs que no puedas cumplir
3. **Sé inclusivo**: Considera researchers de diferentes backgrounds
4. **Sé legal**: El safe harbor debe ser revisado por legal en producción
5. **Sé actualizado**: Incluye fechas de última revisión

---

## 🔗 Recursos

- [GitHub Security Policy Template](https://docs.github.com/en/code-security/getting-started/adding-a-security-policy-to-your-repository)
- [RFC 9116 - security.txt](https://www.rfc-editor.org/rfc/rfc9116)
- [securitytxt.org Generator](https://securitytxt.org/)
- [Disclose.io Safe Harbor](https://disclose.io/terms)

---

## 📁 Estructura de Archivos

```
ejercicio-01-security-md/
├── README.md                    # Este archivo
├── starter/
│   └── SECURITY-template.md     # Plantilla inicial
└── solution/
    ├── SECURITY.md              # Solución completa
    ├── security.txt             # security.txt válido
    └── checklist-validation.md  # Checklist completado
```
