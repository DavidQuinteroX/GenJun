namespace JwtDemoAPI.Models;

public class Producto
{
    public int     Id          { get; set; }
    public string  Nombre      { get; set; } = string.Empty;
    public string  Descripcion { get; set; } = string.Empty;
    public decimal Precio      { get; set; }
    public int     Stock       { get; set; }
    public bool    Activo      { get; set; } = true;
}

// ── DTOs ────────────────────────────────────────────────────────────────────
public class LoginRequest
{
    public string Email    { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}

public class RegisterRequest
{
    public string Nombre   { get; set; } = string.Empty;
    public string Email    { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string Rol      { get; set; } = "User";
}

public class RefreshRequest
{
    public string RefreshToken { get; set; } = string.Empty;
}

public class AuthResponse
{
    public string   AccessToken  { get; set; } = string.Empty;
    public string   RefreshToken { get; set; } = string.Empty;
    public DateTime Expira       { get; set; }
    public string   Nombre       { get; set; } = string.Empty;
    public string   Rol          { get; set; } = string.Empty;
}

public class ProductoRequest
{
    public string  Nombre      { get; set; } = string.Empty;
    public string  Descripcion { get; set; } = string.Empty;
    public decimal Precio      { get; set; }
    public int     Stock       { get; set; }
}
