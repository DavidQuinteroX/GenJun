using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using JwtDemoAPI.Models;
using Microsoft.IdentityModel.Tokens;

namespace JwtDemoAPI.Services;

public class TokenService : ITokenService
{
    private readonly IConfiguration _config;

    public TokenService(IConfiguration config) => _config = config;

    // ── 1. Generar Access Token (JWT) ────────────────────────────────────────
    public string GenerarAccessToken(Usuario usuario)
    {
        // Claims que viajan dentro del token
        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub,   usuario.Id.ToString()),
            new Claim(JwtRegisteredClaimNames.Email, usuario.Email),
            new Claim(JwtRegisteredClaimNames.Jti,   Guid.NewGuid().ToString()), // ID unico del token
            new Claim("nombre",                      usuario.Nombre),
            new Claim(ClaimTypes.Role,               usuario.Rol),
        };

        // Clave y algoritmo de firma
        var key  = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:SecretKey"]!));
        var cred = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var exp  = int.Parse(_config["Jwt:ExpirationMinutes"] ?? "60");

        // Construir el token
        var token = new JwtSecurityToken(
            issuer:             _config["Jwt:Issuer"],
            audience:           _config["Jwt:Audience"],
            claims:             claims,
            notBefore:          DateTime.UtcNow,
            expires:            DateTime.UtcNow.AddMinutes(exp),
            signingCredentials: cred
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    // ── 2. Generar Refresh Token (opaco, random) ─────────────────────────────
    public string GenerarRefreshToken()
    {
        var bytes = new byte[64];
        RandomNumberGenerator.Fill(bytes);
        return Convert.ToBase64String(bytes);
    }

    // ── 3. Extraer UserId de un token expirado ───────────────────────────────
    public int ObtenerUserIdDesdeToken(string token)
    {
        var handler    = new JwtSecurityTokenHandler();
        var key        = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:SecretKey"]!));
        var parameters = new TokenValidationParameters
        {
            ValidateIssuerSigningKey = true,
            IssuerSigningKey         = key,
            ValidateIssuer           = false,
            ValidateAudience         = false,
            ValidateLifetime         = false, // ignorar expiracion para refresh
        };

        var principal = handler.ValidateToken(token, parameters, out _);
        var sub       = principal.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
                        ?? throw new SecurityTokenException("Token invalido");
        return int.Parse(sub);
    }
}
