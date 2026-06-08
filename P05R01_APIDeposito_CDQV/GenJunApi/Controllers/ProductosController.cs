using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using GenJunApi.Models;
using Microsoft.AspNetCore.Http.HttpResults;

namespace GenJunApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        List<Producto> products = new List<Producto>()
            {
                new Producto { Id = 1, Nombre = "Leon", Precio = 460.00M, Categoria = "Carton" },
                new Producto { Id = 2, Nombre = "Victoria", Precio = 560.00M, Categoria = "Laton" },
                new Producto { Id = 3, Nombre = "Corona", Precio = 460.00m, Categoria = "Mediana" }
            };
        [HttpGet]
        public ActionResult<IEnumerable<Producto>> GetProductos()
        {


            return Ok(products);

        }

        [HttpGet("{id}")]
        public ActionResult<Producto> GetProducto(int id)
        {
            var products = new Producto
            {
                Id = id,
                Nombre = "Producto" + id,
                Precio = 460.00M + id,
                Categoria = "Categoria" + id,
            };
            return Ok(products);

        }

        //POST: api/productos
        [HttpPost]
        public ActionResult Crear(Producto producto)
        {
            products.Add(producto);
            return CreatedAtAction(nameof(GetProducto),
                new { id = producto.Id }, producto);
        }


        //PUT: api/productos/5
        [HttpPut("{id}")]
        public IActionResult Actualizar(int id, Producto producto)
        {
            var existe = products.Find(p => p.Id == id);
            if (existe == null)
                return NotFound();
            return NoContent();
        }

        //DELETE:api/productos/5
        [HttpDelete("{id}")]
        public IActionResult Eliminar(int id)
        {
            var producto = products.Find(p => p.Id == id);
            if (producto == null)
                return NotFound();
            products.Remove(producto);
            return NoContent();
        }
    }
}
