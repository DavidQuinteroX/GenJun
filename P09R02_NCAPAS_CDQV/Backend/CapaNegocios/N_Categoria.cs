using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Categoria
    {
        D_Categoria datos = new D_Categoria();

        // INSERTAR
        public string InsertarCategoria(E_Categoria categoria)
        {
            return datos.InsertarCategoria(categoria);
        }
        // OBTENER POR ID
        public E_Categoria ObtenerCategoriaPorId(int idCategoria)
        {
            return datos.ObtenerCategoriaPorId(idCategoria);
        }

        // LISTAR
        public List<E_Categoria> ListarCategorias()
        {
            return datos.ListarCategorias();
        }

        // ACTUALIZAR
        public bool ActualizarCategoria(E_Categoria categoria)
        {
            return datos.ActualizarCategoria(categoria);
        }

        // ELIMINAR
        public bool EliminarCategoria(int idCategoria)
        {
            return datos.EliminarCategoria(idCategoria);
        }

    }
}
