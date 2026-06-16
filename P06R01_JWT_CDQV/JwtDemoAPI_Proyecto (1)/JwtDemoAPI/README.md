# JWT Demo API — Guia de instalacion y uso

## Requisitos previos
- Visual Studio Community 2022 (workload: ASP.NET and web development)
- .NET 8 SDK
- SQL Server 2019 (instancia local `.` o `localhost`)
- SQL Server Management Studio (SSMS)

---

## Pasos para correr el proyecto

### 1. Abrir en Visual Studio Community
```
File → Open → Project/Solution → JwtDemoAPI.csproj
```

### 2. Instalar paquetes NuGet (si no estan)
Herramientas → Administrador de paquetes NuGet → Consola:
```powershell
Install-Package BCrypt.Net-Next
Install-Package Microsoft.AspNetCore.Authentication.JwtBearer -Version 8.0.0
Install-Package Microsoft.EntityFrameworkCore.SqlServer -Version 8.0.0
Install-Package Microsoft.EntityFrameworkCore.Tools -Version 8.0.0
Install-Package Swashbuckle.AspNetCore
```

### 3. Verificar cadena de conexion en appsettings.json
```json
"DefaultConnection": "Server=.;Database=JwtDemoDB;Trusted_Connection=True;TrustServerCertificate=True;"
```
- Si tu SQL Server tiene nombre de instancia: `Server=.\SQLEXPRESS`
- Si usas usuario SQL: `Server=.;Database=JwtDemoDB;User Id=sa;Password=tuPassword;TrustServerCertificate=True;`

### 4. Crear la base de datos (Consola del Administrador de paquetes)
```powershell
Add-Migration InitialCreate
Update-Database
```
Esto creara en SQL Server 2019:
- Base de datos: `JwtDemoDB`
- Tablas: `Usuarios`, `Productos`, `RefreshTokens`
- Datos iniciales: 1 admin + 3 productos de ejemplo

### 5. Correr el proyecto
```
F5 o Ctrl+F5
```
Se abrira Swagger UI en: `https://localhost:7XXX/swagger`

---

## Probando con Swagger

### Login (obtener token)
1. Expandir `POST /api/auth/login`
2. Click "Try it out"
3. Ingresar:
```json
{
  "email": "admin@demo.com",
  "password": "Admin123!"
}
```
4. Copiar el valor de `accessToken` de la respuesta

### Autenticarse en Swagger
1. Click el boton **Authorize** (candado arriba a la derecha)
2. Escribir: `Bearer eyJhbGci...` (pegar tu token)
3. Click "Authorize" → "Close"

### Probar endpoints protegidos
- `GET /api/productos` → 200 OK con lista
- `POST /api/productos` → Solo si eres Admin
- `GET /api/productos/yo` → Muestra tus claims del JWT
- `GET /api/productos/publico` → No requiere token

---

## Probando con Postman

### 1. Login
```
POST https://localhost:7XXX/api/auth/login
Content-Type: application/json

{ "email": "admin@demo.com", "password": "Admin123!" }
```

### 2. Usar el token en siguientes requests
```
Headers:
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

### 3. Registrar nuevo usuario
```
POST https://localhost:7XXX/api/auth/register
Content-Type: application/json

{
  "nombre": "Juan Lopez",
  "email": "juan@demo.com",
  "password": "Juan123!",
  "rol": "User"
}
```

### 4. Renovar token (Refresh)
```
POST https://localhost:7XXX/api/auth/refresh
Content-Type: application/json

{ "refreshToken": "el_refresh_token_recibido_en_el_login" }
```

### 5. Logout
```
POST https://localhost:7XXX/api/auth/logout
Content-Type: application/json

{ "refreshToken": "el_refresh_token_a_revocar" }
```

---

## Endpoints disponibles

| Metodo | Ruta                      | Auth          | Descripcion              |
|--------|---------------------------|---------------|--------------------------|
| POST   | /api/auth/register        | Publico       | Registrar usuario        |
| POST   | /api/auth/login           | Publico       | Login, devuelve JWT      |
| POST   | /api/auth/refresh         | Publico       | Renovar Access Token     |
| POST   | /api/auth/logout          | Publico       | Revocar Refresh Token    |
| GET    | /api/productos/publico    | Publico       | Lista publica            |
| GET    | /api/productos            | JWT valido    | Lista completa           |
| GET    | /api/productos/{id}       | JWT valido    | Detalle de producto      |
| GET    | /api/productos/yo         | JWT valido    | Claims del usuario       |
| POST   | /api/productos            | Admin         | Crear producto           |
| PUT    | /api/productos/{id}       | Admin         | Editar producto          |
| DELETE | /api/productos/{id}       | Admin         | Desactivar producto      |

---

## Codigos de respuesta HTTP

| Codigo | Significado                          |
|--------|--------------------------------------|
| 200    | OK                                   |
| 201    | Created (recurso creado)             |
| 401    | Unauthorized (sin token o invalido)  |
| 403    | Forbidden (sin el rol requerido)     |
| 404    | Not Found                            |
| 409    | Conflict (email ya existe)           |

---

## Estructura del JWT generado

```
Header:  { "alg": "HS256", "typ": "JWT" }
Payload: {
  "sub": "1",
  "email": "admin@demo.com",
  "jti": "uuid-unico",
  "nombre": "Administrador",
  "role": "Admin",
  "nbf": 1720000000,
  "exp": 1720003600,
  "iss": "https://mi-api.com",
  "aud": "https://mi-cliente.com"
}
```

Puedes verificar/decodificar cualquier token en: https://jwt.io

---

## Notas de seguridad importantes

1. **SecretKey**: Cambia la clave del appsettings.json por una tuya de minimo 32 caracteres.
   En produccion usa variables de entorno o Azure Key Vault.

2. **HTTPS**: Siempre usa HTTPS en produccion. Los tokens NO estan cifrados.

3. **Expiracion**: El Access Token expira en 60 minutos (configurable en appsettings.json).

4. **Refresh Token**: Implementado con rotacion — al renovar, el token anterior queda revocado.

5. **Passwords**: Se almacenan con BCrypt (hash unidireccional), nunca en texto plano.
