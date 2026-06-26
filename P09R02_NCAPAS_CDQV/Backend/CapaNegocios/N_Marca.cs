using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Marca
    {
        D_Marca datos = new D_Marca();

        // INSERTAR
        public string InsertarMarca(E_Marca marca)
        {

            return datos.InsertarMarca(marca);

        }
        // OBTENER POR ID
        public E_Marca ObtenerMarcaPorId(int idMarca)
        {

            return datos.ObtenerMarcaPorId(idMarca);

        }
        // LISTAR
        public List<E_Marca> ListarMarcas()
        {

            return datos.ListarMarcas();

        }

        // ACTUALIZAR
        public bool ActualizarMarca(E_Marca marca)
        {

            return datos.ActualizarMarca(marca);

        }

        // ELIMINAR
        public bool EliminarMarca(int idMarca)
        {

            return datos.EliminarMarca(idMarca);

        }
    }
}
