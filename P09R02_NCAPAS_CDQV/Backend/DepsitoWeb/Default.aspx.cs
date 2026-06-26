using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CapaNegocios;
namespace DepsitoWeb
{
    public partial class _Default : Page
    {
        N_Dashboard negocio =
        new N_Dashboard();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                CargarDashboard();
               
            }
        }
        private void CargarDashboard()
        {
            DashboardEntidad datos = negocio.ObtenerDashboard();

            if (datos == null)
            {
                lblProductos.Text = "0";
                lblClientes.Text = "0";
                lblVentas.Text = "0";
                lblInventario.Text = "0";
                return;
            }

            lblProductos.Text = datos.TotalProductos.ToString();
            lblClientes.Text = datos.TotalClientes.ToString();
            lblVentas.Text = datos.TotalVentas.ToString();
            lblInventario.Text = datos.TotalInventario.ToString();
        }
        //private void CargarDashboard()
        //{

        //    DashboardEntidad datos =
        //        negocio.ObtenerDashboard();



        //    lblProductos.Text =
        //        datos.TotalProductos.ToString();


        //    lblClientes.Text =
        //        datos.TotalClientes.ToString();


        //    lblVentas.Text =
        //        datos.TotalVentas.ToString();


        //    lblInventario.Text =
        //        datos.TotalInventario.ToString();


        //}

    }
}