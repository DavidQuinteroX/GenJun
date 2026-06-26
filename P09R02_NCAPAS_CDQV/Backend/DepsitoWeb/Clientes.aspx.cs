using CapaEntidades;
using CapaNegocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DepsitoWeb
{
    public partial class Clientes : System.Web.UI.Page
    {
        N_Cliente negocio =
            new N_Cliente();

        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
            }
        }


        private void CargarClientes()
        {
            gvClientes.DataSource =
                negocio.ListarClientes();

            gvClientes.DataBind();
        }


        protected void btnGuardar_Click(
            object sender,
            EventArgs e)
        {
            E_Cliente cliente =
                new E_Cliente();

            cliente.Nombre =
                txtNombre.Text;


            if (string.IsNullOrEmpty(
                hfIdCliente.Value))
            {
                negocio.InsertarCliente(
                    cliente);
            }
            else
            {
                cliente.IdCliente =
                    Convert.ToInt32(
                        hfIdCliente.Value);

                negocio.ActualizarCliente(
                    cliente);
            }

            CargarClientes();

            Limpiar();
        }


        protected void btnEditar_Click(
            object sender,
            EventArgs e)
        {
            Button btn =
                (Button)sender;

            int id =
                Convert.ToInt32(
                    btn.CommandArgument);

            E_Cliente cliente =
                negocio.ObtenerClientePorId(id);

            hfIdCliente.Value =
                cliente.IdCliente.ToString();

            txtNombre.Text =
                cliente.Nombre;

            btnGuardar.Text =
                "Actualizar";
        }


        protected void btnEliminar_Click(
            object sender,
            EventArgs e)
        {
            Button btn =
                (Button)sender;

            int id =
                Convert.ToInt32(
                    btn.CommandArgument);

            negocio.EliminarCliente(id);

            CargarClientes();
        }


        protected void btnCancelar_Click(
            object sender,
            EventArgs e)
        {
            Limpiar();
        }


        private void Limpiar()
        {
            hfIdCliente.Value = "";

            txtNombre.Text = "";

            btnGuardar.Text =
                "Guardar";
        }
    }
}