using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Cliente
    {
        D_Cliente datos =
           new D_Cliente();


        public string InsertarCliente(
            E_Cliente cliente)
        {
            return datos.InsertarCliente(cliente);
        }


        public E_Cliente ObtenerClientePorId(
            int idCliente)
        {
            return datos.ObtenerClientePorId(idCliente);
        }


        public List<E_Cliente> ListarClientes()
        {
            return datos.ListarClientes();
        }


        public bool ActualizarCliente(
            E_Cliente cliente)
        {
            return datos.ActualizarCliente(cliente);
        }


        public bool EliminarCliente(
            int idCliente)
        {
            return datos.EliminarCliente(idCliente);
        }
    }
}
