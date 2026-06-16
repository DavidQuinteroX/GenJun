namespace JwtDemoAPI.Models;

public class Usuario
{
    public int    Id           { get; set; }
    public string Nombre       { get; set; } = string.Empty;
    public string Email        { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string Rol          { get; set; } = "User";   // "Admin" o "User"
    public bool   Activo       { get; set; } = true;
    public DateTime CreadoEn   { get; set; } = DateTime.UtcNow;

    // Refresh tokens asociados
    public ICollection<RefreshToken> RefreshTokens { get; set; } = new List<RefreshToken>();
}

public class RefreshToken
{
    public int      Id         { get; set; }
    public string   Token      { get; set; } = string.Empty;
    public DateTime Expira     { get; set; }
    public bool     Revocado   { get; set; } = false;
    public DateTime CreadoEn   { get; set; } = DateTime.UtcNow;
    public int      UsuarioId  { get; set; }
    public Usuario  Usuario    { get; set; } = null!;
}
