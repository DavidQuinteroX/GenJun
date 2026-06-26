using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Producto
    {
        public int IdProducto { get; set; }

        public string Nombre { get; set; }


        public int IdMarca { get; set; }

        public string Marca { get; set; }


        public int IdCategoria { get; set; }

        public string Categoria { get; set; }


        public int ContenidoML { get; set; }

        public bool Activo { get; set; }
    }
}