using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Precio
    {
        D_Precio datos = new D_Precio();

        // INSERTAR
        public string InsertarPrecio(E_Precio precio)
        {
            return datos.InsertarPrecio(precio);
        }
        // BUSCAR POR ID

        public E_Precio ObtenerPrecioPorId(int idPrecio)
        {
            return datos.ObtenerPrecioPorId(idPrecio);
        }
        // LISTAR

        public List<E_Precio> ListarPrecios()
        {
            return datos.ListarPrecios();
        }
        // ACTUALIZAR

        public bool ActualizarPrecio(E_Precio precio)
        {
            return datos.ActualizarPrecio(precio);
        }

        // ELIMINAR

        public bool EliminarPrecio(int idPrecio)
        {
            return datos.EliminarPrecio(idPrecio);
        }

        public DataTable ObtenerPresentacionesCombo()
        {
            return datos.ObtenerPresentacionesCombo();
        }
    }
}
