using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Ventas
    {
        D_Ventas datos = new D_Ventas();

        public string InsertarVenta(E_Ventas venta)
        {
            return datos.InsertarVenta(venta);
        }

        public E_Ventas ObtenerVentaPorId(int idVenta)
        {
            return datos.ObtenerVentaPorId(idVenta);
        }

        public List<E_Ventas> ListarVentas()
        {
            return datos.ListarVentas();
        }

        public bool ActualizarVenta(E_Ventas venta)
        {
            return datos.ActualizarVenta(venta);
        }
        public int InsertarVentaRetornaId(E_Ventas venta)
        {

            D_Ventas datos =
            new D_Ventas();


            return datos.InsertarVentaRetornaId(venta);

        }
        public bool EliminarVenta(int idVenta)
        {
            return datos.EliminarVenta(idVenta);
        }
    }
}
