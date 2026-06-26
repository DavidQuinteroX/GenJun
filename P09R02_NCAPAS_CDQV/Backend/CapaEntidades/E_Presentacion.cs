using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Presentacion
    {
        public int IdPresentacion { get; set; }


        public int IdProducto { get; set; }


        public string Producto { get; set; }


        public string Nombre { get; set; }


        public int Cantidad { get; set; }

        public string Presentacion { get; set; }
        public string Descripcion
        {
            get
            {
                return Producto + " - " + Presentacion;
            }
        }

    }
}
