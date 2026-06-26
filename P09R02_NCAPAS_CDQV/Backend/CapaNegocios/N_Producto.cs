using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Producto
    {
        D_Producto datos = new D_Producto();

        // INSERTAR
        public string InsertarProducto(E_Producto producto)
        {

            return datos.InsertarProducto(producto);

        }
        // OBTENER POR ID
        public E_Producto ObtenerProductoPorId(int idProducto)
        {

            return datos.ObtenerProductoPorId(idProducto);

        }
        // LISTAR
        public List<E_Producto> ListarProductos()
        {

            return datos.ListarProductos();

        }

        // ACTUALIZAR
        public bool ActualizarProducto(E_Producto producto)
        {

            return datos.ActualizarProducto(producto);

        }

        // ELIMINAR
        public bool EliminarProducto(int idProducto)
        {

            return datos.EliminarProducto(idProducto);

        }
        public DataTable ListarProductosCombo()
        {
            return datos.ListarProductosCombo();
        }

    }
}
