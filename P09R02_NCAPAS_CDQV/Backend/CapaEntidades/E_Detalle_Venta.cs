using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    [Serializable]
    public class E_Detalle_Venta
    {
        public int IdDetalleVenta { get; set; }

        public int IdVenta { get; set; }

        public int IdPresentacion { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnitario { get; set; }

        public decimal Subtotal
        {
            get
            {
                return Cantidad * PrecioUnitario;
            }
        }


        // para mostrar
        public string Producto { get; set; }

        public string Presentacion { get; set; }

    }
}
