using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Inventario
    {
        D_Inventario datos = new D_Inventario();
        public string InsertarInventario(E_Inventario inv)
        {
            return datos.InsertarInventario(inv);
        }
        public E_Inventario ObtenerInventarioPorId(int id)
        {
            return datos.ObtenerInventarioPorId(id);
        }
        public List<E_Inventario> ListarInventario()
        {
            return datos.ListarInventario();
        }
        public bool ActualizarInventario(E_Inventario inv)
        {
            return datos.ActualizarInventario(inv);
        }
        public bool EliminarInventario(int id)
        {
            return datos.EliminarInventario(id);
        }

    }
}
