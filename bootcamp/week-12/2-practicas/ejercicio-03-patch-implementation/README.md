# 🔧 Ejercicio 03: Patch Implementation

> **Duración**: 35 minutos
>
> **Objetivo**: Implementar un fix de seguridad siguiendo mejores prácticas.

---

## 🎯 Objetivos de Aprendizaje

Al completar este ejercicio serás capaz de:

- ✅ Usar **private forks** para desarrollo seguro
- ✅ Implementar fixes que **resuelvan la vulnerabilidad**
- ✅ Escribir **tests de regresión**
- ✅ Preparar **commits** apropiados para security fixes

---

## 📋 Escenario

Continuando con la vulnerabilidad SQL Injection, ahora debes implementar el fix. El código vulnerable está en el archivo `auth/login.js`.

---

## 🔨 Parte 1: Analizar Código Vulnerable (10 min)

### Código Vulnerable

```javascript
// auth/login.js - VULNERABLE CODE (DO NOT USE IN PRODUCTION)

const db = require('../database');

async function authenticateUser(username, password) {
  // ❌ VULNERABLE: Concatenación directa de user input
  const query = `
    SELECT id, username, email, role 
    FROM users 
    WHERE username = '${username}' 
    AND password = '${password}'
  `;
  
  const result = await db.query(query);
  
  if (result.rows.length > 0) {
    return {
      success: true,
      user: result.rows[0]
    };
  }
  
  return {
    success: false,
    error: 'Invalid credentials'
  };
}

module.exports = { authenticateUser };
```

### Tarea 1: Identificar los Problemas

```markdown
# Análisis de Vulnerabilidad

## Problemas identificados:

1. ________________________________
   # Hint: ¿Cómo se construye la query?

2. ________________________________
   # Hint: ¿Qué pasa con caracteres especiales?

3. ________________________________
   # Hint: ¿El password se almacena seguro?

## Vector de ataque:

Username: ________________
Password: ________________

Query resultante:
________________
```

---

## 🛡️ Parte 2: Implementar el Fix (15 min)

### Tarea 2: Escribe el Código Corregido

```javascript
// auth/login.js - SECURE VERSION

const db = require('../database');
const bcrypt = require('bcrypt');

async function authenticateUser(username, password) {
  // ✅ FIX: Implementa la versión segura
  
  // TODO: Usa parameterized query
  const query = `
    ________________________________
    ________________________________
    ________________________________
  `;
  
  // TODO: Usa parámetros seguros
  const params = [________________________________];
  
  const result = await db.query(query, params);
  
  if (result.rows.length > 0) {
    const user = result.rows[0];
    
    // TODO: Verifica password con bcrypt
    const passwordMatch = ________________________________;
    
    if (passwordMatch) {
      return {
        success: true,
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          role: user.role
        }
      };
    }
  }
  
  return {
    success: false,
    error: 'Invalid credentials'
  };
}

module.exports = { authenticateUser };
```

### Mejoras Adicionales

```javascript
// TODO: Implementa estas mejoras adicionales

// 1. Input validation
function validateInput(username, password) {
  // ¿Qué validaciones agregarías?
  ________________________________
  ________________________________
}

// 2. Rate limiting (pseudocódigo)
// ¿Cómo prevendrías brute force?
________________________________

// 3. Logging seguro
// ¿Qué logearías y qué NO?
________________________________
```

---

## 🧪 Parte 3: Tests de Regresión (10 min)

### Tarea 3: Escribe Tests de Seguridad

```javascript
// auth/login.test.js

const { authenticateUser } = require('./login');

describe('authenticateUser - Security Tests', () => {
  
  // Test 1: SQL Injection Prevention
  test('should prevent SQL injection in username', async () => {
    // TODO: Intenta inyectar SQL
    const maliciousUsername = "________________________________";
    const password = "anything";
    
    const result = await authenticateUser(maliciousUsername, password);
    
    // ¿Qué debería retornar?
    expect(result.success).toBe(________________________________);
  });
  
  // Test 2: SQL Injection with comment
  test('should prevent SQL injection with comment syntax', async () => {
    const maliciousUsername = "admin'--";
    const password = "anything";
    
    const result = await authenticateUser(maliciousUsername, password);
    
    expect(result.success).toBe(________________________________);
  });
  
  // Test 3: SQL Injection with UNION
  test('should prevent UNION-based SQL injection', async () => {
    const maliciousUsername = "' UNION SELECT * FROM users--";
    const password = "anything";
    
    const result = await authenticateUser(maliciousUsername, password);
    
    expect(result.success).toBe(________________________________);
  });
  
  // Test 4: Valid authentication still works
  test('should authenticate valid user', async () => {
    // Assuming test user exists with hashed password
    const username = "testuser";
    const password = "correctpassword";
    
    const result = await authenticateUser(username, password);
    
    expect(result.success).toBe(________________________________);
    expect(result.user).toBeDefined();
  });
  
  // Test 5: Invalid password is rejected
  test('should reject invalid password', async () => {
    const username = "testuser";
    const password = "wrongpassword";
    
    const result = await authenticateUser(username, password);
    
    expect(result.success).toBe(________________________________);
  });
  
});
```

---

## 📝 Parte 4: Commit Message (5 min)

### Tarea 4: Escribe el Commit Message

```bash
# Formato: Conventional Commits
# IMPORTANTE: No revelar detalles del exploit en commits públicos

git commit -m "________________________________"

# El mensaje debe:
# - Indicar que es un fix de seguridad
# - NO detallar cómo explotar la vulnerabilidad
# - Referenciar el advisory (después de publicado)
```

### Ejemplo de Mensaje Apropiado

```bash
# ✅ BIEN
git commit -m "fix: sanitize user input in authentication

- Use parameterized queries for database access
- Add bcrypt password verification
- Add input validation

Security: GHSA-xxxx-xxxx-xxxx"

# ❌ MAL
git commit -m "fix: prevent SQL injection by filtering quotes

The old code was vulnerable to admin'-- attack which bypassed
the password check. Now we escape single quotes."
# ⚠️ Este mensaje revela cómo explotar la vulnerabilidad!
```

---

## ✅ Entregables

Al finalizar este ejercicio debes tener:

1. **Análisis** de la vulnerabilidad
2. **Código corregido** con parameterized queries
3. **Tests de regresión** para SQL injection
4. **Commit message** apropiado

---

## ✅ Checklist de Completado

- [ ] Identifiqué los problemas en el código vulnerable
- [ ] Implementé parameterized queries
- [ ] Agregué verificación de password con bcrypt
- [ ] Escribí tests de seguridad
- [ ] Preparé commit message apropiado

---

## 📝 Solución

<details>
<summary>Ver solución (después de intentar)</summary>

### Código Corregido

```javascript
// auth/login.js - SECURE VERSION

const db = require('../database');
const bcrypt = require('bcrypt');

/**
 * Authenticates a user with username and password
 * @param {string} username - The username
 * @param {string} password - The plain text password
 * @returns {Promise<{success: boolean, user?: object, error?: string}>}
 */
async function authenticateUser(username, password) {
  // Input validation
  if (!username || !password) {
    return {
      success: false,
      error: 'Username and password are required'
    };
  }
  
  if (typeof username !== 'string' || typeof password !== 'string') {
    return {
      success: false,
      error: 'Invalid input type'
    };
  }
  
  // ✅ FIX: Parameterized query prevents SQL injection
  const query = `
    SELECT id, username, email, role, password_hash 
    FROM users 
    WHERE username = $1
  `;
  
  // ✅ FIX: Parameters are safely escaped by the database driver
  const params = [username];
  
  try {
    const result = await db.query(query, params);
    
    if (result.rows.length > 0) {
      const user = result.rows[0];
      
      // ✅ FIX: Verify password with bcrypt (timing-safe comparison)
      const passwordMatch = await bcrypt.compare(password, user.password_hash);
      
      if (passwordMatch) {
        // Don't return password_hash in response
        return {
          success: true,
          user: {
            id: user.id,
            username: user.username,
            email: user.email,
            role: user.role
          }
        };
      }
    }
    
    // Same error message for invalid username OR password
    // Prevents username enumeration
    return {
      success: false,
      error: 'Invalid credentials'
    };
    
  } catch (error) {
    // Log error internally but don't expose details
    console.error('Authentication error:', error.message);
    return {
      success: false,
      error: 'Authentication failed'
    };
  }
}

module.exports = { authenticateUser };
```

### Tests Completos

```javascript
// auth/login.test.js

const { authenticateUser } = require('./login');

describe('authenticateUser - Security Tests', () => {
  
  test('should prevent SQL injection in username', async () => {
    const maliciousUsername = "admin' OR '1'='1";
    const password = "anything";
    
    const result = await authenticateUser(maliciousUsername, password);
    
    expect(result.success).toBe(false);
  });
  
  test('should prevent SQL injection with comment syntax', async () => {
    const maliciousUsername = "admin'--";
    const password = "anything";
    
    const result = await authenticateUser(maliciousUsername, password);
    
    expect(result.success).toBe(false);
  });
  
  test('should prevent UNION-based SQL injection', async () => {
    const maliciousUsername = "' UNION SELECT * FROM users--";
    const password = "anything";
    
    const result = await authenticateUser(maliciousUsername, password);
    
    expect(result.success).toBe(false);
  });
  
  test('should authenticate valid user', async () => {
    const username = "testuser";
    const password = "correctpassword";
    
    const result = await authenticateUser(username, password);
    
    expect(result.success).toBe(true);
    expect(result.user).toBeDefined();
    expect(result.user.password_hash).toBeUndefined(); // No leak
  });
  
  test('should reject invalid password', async () => {
    const username = "testuser";
    const password = "wrongpassword";
    
    const result = await authenticateUser(username, password);
    
    expect(result.success).toBe(false);
  });
  
  test('should reject empty inputs', async () => {
    expect((await authenticateUser('', 'pass')).success).toBe(false);
    expect((await authenticateUser('user', '')).success).toBe(false);
    expect((await authenticateUser(null, 'pass')).success).toBe(false);
  });
  
});
```

### Commit Message

```bash
git commit -m "fix: use parameterized queries in authentication

- Replace string concatenation with parameterized queries
- Add bcrypt password verification
- Add input validation and type checking
- Prevent information leakage in error messages

Security: GHSA-xxxx-xxxx-xxxx
Fixes: #123"
```

</details>

---

## 📚 Recursos

- [OWASP Query Parameterization](https://cheatsheetseries.owasp.org/cheatsheets/Query_Parameterization_Cheat_Sheet.html)
- [bcrypt.js](https://github.com/kelektiv/node.bcrypt.js)
- [Parameterized Queries in Node.js](https://node-postgres.com/features/queries#parameterized-query)

---

[⬅️ Anterior: Security Advisory](../ejercicio-02-security-advisory/) | [Siguiente: Incident Simulation ➡️](../ejercicio-04-incident-simulation/)
