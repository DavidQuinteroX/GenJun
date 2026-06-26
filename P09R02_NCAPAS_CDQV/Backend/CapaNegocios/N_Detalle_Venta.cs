using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Detalle_Venta
    {
        D_Detalle_Venta datos =
          new D_Detalle_Venta();



        public string InsertarDetalle(
     E_Detalle_Venta detalle)
        {

            return datos.InsertarDetalle(detalle);

        }


        public List<E_Detalle_Venta> ObtenerDetallePorVenta(
            int idVenta)
        {
            return datos.ObtenerDetallePorVenta(idVenta);
        }



        public bool ActualizarDetalleVenta(
            E_Detalle_Venta detalle)
        {
            return datos.ActualizarDetalleVenta(detalle);
        }



        public bool EliminarDetalleVenta(
            int idDetalle)
        {
            return datos.EliminarDetalleVenta(idDetalle);
        }
    }
}
