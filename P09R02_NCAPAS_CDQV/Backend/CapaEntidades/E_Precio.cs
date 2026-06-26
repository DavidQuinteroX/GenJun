using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Precio
    {
        public int IdPrecio { get; set; }

        public int IdPresentacion { get; set; }

        public string Producto { get; set; }

        public string Presentacion { get; set; }
        public decimal Precio { get; set; }

        public DateTime FechaInicio { get; set; }

        public DateTime? FechaFin { get; set; }
    }
}
