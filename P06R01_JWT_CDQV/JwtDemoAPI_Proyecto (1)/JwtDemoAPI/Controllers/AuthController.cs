using JwtDemoAPI.Data;
using JwtDemoAPI.Models;
using JwtDemoAPI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace JwtDemoAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly AppDbContext  _db;
    private readonly ITokenService _tokenSvc;
    private readonly IConfiguration _config;

    public AuthController(AppDbContext db, ITokenService tokenSvc, IConfiguration config)
    {
        _db       = db;
        _tokenSvc = tokenSvc;
        _config   = config;
    }

    // ── POST /api/auth/register ──────────────────────────────────────────────
    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterRequest req)
    {
        if (await _db.Usuarios.AnyAsync(u => u.Email == req.Email))
            return Conflict(new { mensaje = "El email ya esta registrado" });

        var usuario = new Usuario
        {
            Nombre       = req.Nombre,
            Email        = req.Email,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(req.Password),
            Rol          = req.Rol == "Admin" ? "Admin" : "User",
        };

        _db.Usuarios.Add(usuario);
        await _db.SaveChangesAsync();

        return Ok(new { mensaje = "Usuario registrado correctamente", email = usuario.Email });
    }

    // ── POST /api/auth/login ─────────────────────────────────────────────────
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginRequest req)
    {
        // 1. Buscar usuario activo
        var usuario = await _db.Usuarios
            .FirstOrDefaultAsync(u => u.Email == req.Email && u.Activo);

        // 2. Verificar password con BCrypt
        if (usuario == null || !BCrypt.Net.BCrypt.Verify(req.Password, usuario.PasswordHash))
            return Unauthorized(new { mensaje = "Credenciales invalidas" });

        // 3. Generar Access Token (JWT) y Refresh Token
        var accessToken  = _tokenSvc.GenerarAccessToken(usuario);
        var refreshToken = _tokenSvc.GenerarRefreshToken();
        var expDias      = int.Parse(_config["Jwt:RefreshExpirationDays"] ?? "7");

        // 4. Guardar Refresh Token en BD
        _db.RefreshTokens.Add(new RefreshToken
        {
            Token      = refreshToken,
            Expira     = DateTime.UtcNow.AddDays(expDias),
            UsuarioId  = usuario.Id
        });
        await _db.SaveChangesAsync();

        return Ok(new AuthResponse
        {
            AccessToken  = accessToken,
            RefreshToken = refreshToken,
            Expira       = DateTime.UtcNow.AddMinutes(60),
            Nombre       = usuario.Nombre,
            Rol          = usuario.Rol,
        });
    }

    // ── POST /api/auth/refresh ───────────────────────────────────────────────
    [HttpPost("refresh")]
    public async Task<IActionResult> Refresh([FromBody] RefreshRequest req)
    {
        // 1. Buscar el Refresh Token en BD
        var rt = await _db.RefreshTokens
            .Include(r => r.Usuario)
            .FirstOrDefaultAsync(r => r.Token == req.RefreshToken);

        if (rt == null || rt.Revocado || rt.Expira < DateTime.UtcNow)
            return Unauthorized(new { mensaje = "Refresh Token invalido o expirado" });

        // 2. Revocar el Refresh Token actual (rotacion)
        rt.Revocado = true;

        // 3. Generar nuevos tokens
        var nuevoAccessToken  = _tokenSvc.GenerarAccessToken(rt.Usuario);
        var nuevoRefreshToken = _tokenSvc.GenerarRefreshToken();
        var expDias           = int.Parse(_config["Jwt:RefreshExpirationDays"] ?? "7");

        _db.RefreshTokens.Add(new RefreshToken
        {
            Token     = nuevoRefreshToken,
            Expira    = DateTime.UtcNow.AddDays(expDias),
            UsuarioId = rt.UsuarioId
        });

        await _db.SaveChangesAsync();

        return Ok(new AuthResponse
        {
            AccessToken  = nuevoAccessToken,
            RefreshToken = nuevoRefreshToken,
            Expira       = DateTime.UtcNow.AddMinutes(60),
            Nombre       = rt.Usuario.Nombre,
            Rol          = rt.Usuario.Rol,
        });
    }

    // ── POST /api/auth/logout ────────────────────────────────────────────────
    [HttpPost("logout")]
    public async Task<IActionResult> Logout([FromBody] RefreshRequest req)
    {
        var rt = await _db.RefreshTokens
            .FirstOrDefaultAsync(r => r.Token == req.RefreshToken);

        if (rt != null)
        {
            rt.Revocado = true;
            await _db.SaveChangesAsync();
        }

        return Ok(new { mensaje = "Sesion cerrada correctamente" });
    }
}
