using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using GenJunApi.Models;
namespace GenJunApi.Controllers
{
    [Route("api/[controller]")]//Define la ruta base del controlador
    [ApiController]//Atributo que habilita ccaracteristicas automaticas de API como validacion de modelos
    public class ProductosController : ControllerBase

    {            //GET:api/productos
        [HttpGet]//Atributo que indica que el metodo responde a solicitudes HTTP GET
        public ActionResult<IEnumerable<Producto>> GetProductos ()
        {
            var productos = new List<Producto>
            {
                new Producto { Id = 1,Nombre = "Laptop",Precio=15000.00M},
                new Producto { Id = 2,Nombre = "Mouse",Precio=250.00M},
                new Producto { Id = 3,Nombre = "Teclado",Precio=450.00M}
            };

            return Ok(productos);//devuelve la respuesta HTTP 200(Succes) con los datos
        }

        [HttpGet("{id}")]
        public ActionResult<Producto> GetProducto(int id)
        {
            var producto = new Producto
            {
                Id = id,
                Nombre = "Producto" + id,
                Precio = 100.00M * id,
            };
            return Ok(producto);
        }

    }
}
