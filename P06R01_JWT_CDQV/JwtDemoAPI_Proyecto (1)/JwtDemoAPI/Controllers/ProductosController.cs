using JwtDemoAPI.Data;
using JwtDemoAPI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace JwtDemoAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]   // <-- TODA la API requiere JWT valido
public class ProductosController : ControllerBase
{
    private readonly AppDbContext _db;
    public ProductosController(AppDbContext db) => _db = db;

    // ── GET /api/productos  →  Cualquier usuario autenticado ────────────────
    [HttpGet]
    public async Task<IActionResult> GetTodos()
    {
        var productos = await _db.Productos
            .Where(p => p.Activo)
            .ToListAsync();
        return Ok(productos);
    }

    // ── GET /api/productos/{id}  →  Cualquier usuario autenticado ───────────
    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var producto = await _db.Productos.FindAsync(id);
        if (producto == null || !producto.Activo)
            return NotFound(new { mensaje = $"Producto {id} no encontrado" });
        return Ok(producto);
    }

    // ── GET /api/productos/publico  →  Sin autenticacion ────────────────────
    [HttpGet("publico")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPublico()
    {
        // Solo nombre y precio, sin stock ni detalles internos
        var productos = await _db.Productos
            .Where(p => p.Activo)
            .Select(p => new { p.Id, p.Nombre, p.Precio })
            .ToListAsync();
        return Ok(new { mensaje = "Endpoint publico - sin JWT requerido", productos });
    }

    // ── POST /api/productos  →  Solo Admin ──────────────────────────────────
    [HttpPost]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> Crear([FromBody] ProductoRequest req)
    {
        var producto = new Producto
        {
            Nombre      = req.Nombre,
            Descripcion = req.Descripcion,
            Precio      = req.Precio,
            Stock       = req.Stock,
        };
        _db.Productos.Add(producto);
        await _db.SaveChangesAsync();
        return CreatedAtAction(nameof(GetById), new { id = producto.Id }, producto);
    }

    // ── PUT /api/productos/{id}  →  Solo Admin ───────────────────────────────
    [HttpPut("{id:int}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> Editar(int id, [FromBody] ProductoRequest req)
    {
        var producto = await _db.Productos.FindAsync(id);
        if (producto == null) return NotFound();

        producto.Nombre      = req.Nombre;
        producto.Descripcion = req.Descripcion;
        producto.Precio      = req.Precio;
        producto.Stock       = req.Stock;

        await _db.SaveChangesAsync();
        return Ok(producto);
    }

    // ── DELETE /api/productos/{id}  →  Solo Admin (soft delete) ─────────────
    [HttpDelete("{id:int}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> Eliminar(int id)
    {
        var producto = await _db.Productos.FindAsync(id);
        if (producto == null) return NotFound();

        producto.Activo = false;  // Soft delete — no borramos el registro
        await _db.SaveChangesAsync();
        return Ok(new { mensaje = $"Producto {id} desactivado correctamente" });
    }

    // ── GET /api/productos/yo  →  Info del usuario autenticado ──────────────
    [HttpGet("yo")]
    public IActionResult MiInfo()
    {
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
        var email  = User.FindFirstValue(ClaimTypes.Email);
        var nombre = User.FindFirstValue("nombre");
        var rol    = User.FindFirstValue(ClaimTypes.Role);
        return Ok(new { userId, email, nombre, rol, mensaje = "Claims leidos del JWT" });
    }
}
