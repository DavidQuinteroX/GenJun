using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Detalle_Compra
    {
        public int IdDetalleCompra { get; set; }
        public int IdCompra { get; set; }
        public int IdPresentacion { get; set; }
        public int Cantidad { get; set; }
        public decimal Costo { get; set; }
    }
}
