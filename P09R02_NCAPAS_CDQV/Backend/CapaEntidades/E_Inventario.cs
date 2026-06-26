using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Inventario
    {

        public int IdInventario { get; set; }

        public int IdPresentacion { get; set; }

        // Datos del JOIN
        public string Producto { get; set; }
        public string Marca { get; set; }
        public string Presentacion { get; set; }

        public int Existencia { get; set; }
    }
}
