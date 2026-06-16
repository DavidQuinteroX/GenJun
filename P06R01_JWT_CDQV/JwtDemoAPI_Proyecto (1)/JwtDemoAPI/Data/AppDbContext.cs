using JwtDemoAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace JwtDemoAPI.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<Usuario>      Usuarios      => Set<Usuario>();
    public DbSet<Producto>     Productos     => Set<Producto>();
    public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Relacion Usuario -> RefreshTokens
        modelBuilder.Entity<RefreshToken>()
            .HasOne(rt => rt.Usuario)
            .WithMany(u => u.RefreshTokens)
            .HasForeignKey(rt => rt.UsuarioId);

        // Seed: usuario Admin inicial (password: Admin123!)
        modelBuilder.Entity<Usuario>().HasData(new Usuario
        {
            Id           = 1,
            Nombre       = "Administrador",
            Email        = "admin@demo.com",
            PasswordHash = BCrypt.Net.BCrypt.HashPassword("Admin123!"),
            Rol          = "Admin",
            Activo       = true,
            CreadoEn     = new DateTime(2025, 1, 1, 0, 0, 0, DateTimeKind.Utc)
        });

        // Seed: productos de ejemplo
        modelBuilder.Entity<Producto>().HasData(
            new Producto { Id=1, Nombre="Laptop HP",    Descripcion="Laptop 15 pulgadas i7",  Precio=15000m, Stock=10 },
            new Producto { Id=2, Nombre="Monitor 27\"", Descripcion="Monitor Full HD 27 in",  Precio=5500m,  Stock=25 },
            new Producto { Id=3, Nombre="Teclado Mec.", Descripcion="Teclado mecanico RGB",    Precio=1200m,  Stock=50 }
        );
    }
}
