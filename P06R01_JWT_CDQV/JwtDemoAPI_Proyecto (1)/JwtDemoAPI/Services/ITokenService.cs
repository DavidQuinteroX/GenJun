using JwtDemoAPI.Models;

namespace JwtDemoAPI.Services;

public interface ITokenService
{
    string  GenerarAccessToken(Usuario usuario);
    string  GenerarRefreshToken();
    int     ObtenerUserIdDesdeToken(string token);
}
