using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Movimiento_Inventario
    {
        public int IdMovimiento_Inventario { get; set; }

        public int IdPresentacion { get; set; }

        public string Producto { get; set; }

        public string Presentacion { get; set; }

        public string TipoMovimiento { get; set; }

        public int Cantidad { get; set; }

        public DateTime Fecha { get; set; }

        public string Motivo { get; set; }




    }
}
