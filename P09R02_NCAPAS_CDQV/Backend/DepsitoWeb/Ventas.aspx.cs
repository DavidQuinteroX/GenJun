using CapaEntidades;
using CapaNegocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DepsitoWeb
{
    public partial class Ventas : System.Web.UI.Page
    {

        N_Ventas nVentas = new N_Ventas();
        N_Cliente nClientes = new N_Cliente();
        N_Detalle_Venta nDetalle = new N_Detalle_Venta();
        N_Presentacion nPresentacion =
    new N_Presentacion();


        private List<E_Detalle_Venta> Detalles
        {
            get
            {
                if (ViewState["Detalle"] == null)
                    ViewState["Detalle"] =
                    new List<E_Detalle_Venta>();

                return (List<E_Detalle_Venta>)
                    ViewState["Detalle"];
            }

            set
            {
                ViewState["Detalle"] = value;
            }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                txtFecha.Text =
                DateTime.Now.ToString("yyyy-MM-dd");


                CargarClientes();

                CargarPresentaciones();

                MostrarDetalle();

            }
        }



        private void CargarClientes()
        {

            ddlClientes.DataSource =
                nClientes.ListarClientes();


            ddlClientes.DataTextField =
                "Nombre";


            ddlClientes.DataValueField =
                "IdCliente";


            ddlClientes.DataBind();

        }



        private void CargarPresentaciones()
        {

            ddlPresentaciones.DataSource =
                nPresentacion.ListarPresentaciones();


            ddlPresentaciones.DataTextField =
                "Nombre";


            ddlPresentaciones.DataValueField =
                "IdPresentacion";


            ddlPresentaciones.DataBind();

        }





        protected void btnAgregarDetalle_Click(object sender, EventArgs e)
        {


            E_Detalle_Venta detalle =
                new E_Detalle_Venta();


            detalle.IdPresentacion =
                Convert.ToInt32(
                ddlPresentaciones.SelectedValue);



            detalle.Cantidad =
                Convert.ToInt32(
                txtCantidad.Text);



            detalle.PrecioUnitario =
                Convert.ToDecimal(
                txtPrecio.Text);



            Detalles.Add(detalle);



            decimal total =
                Detalles.Sum(x =>
                x.Subtotal);



            txtTotal.Text =
                total.ToString("0.00");



            MostrarDetalle();


            txtCantidad.Text = "";
            txtPrecio.Text = "";

        }





        private void MostrarDetalle()
        {

            gvDetalle.DataSource =
                Detalles;


            gvDetalle.DataBind();

        }





        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            if (Detalles.Count == 0)
            {
                lblMensaje.Text =
                "Agrega productos primero";

                return;
            }



            E_Ventas venta =
                new E_Ventas();



            venta.IdCliente =
                Convert.ToInt32(
                ddlClientes.SelectedValue);



            venta.Fecha =
                DateTime.Now;



            venta.Total =
                Detalles.Sum(x =>
                x.Subtotal);



            int idVenta =
                nVentas.InsertarVentaRetornaId(venta);




            foreach (E_Detalle_Venta d in Detalles)
            {

                d.IdVenta = idVenta;


                nDetalle.InsertarDetalle(d);


            }



            lblMensaje.Text =
            "Venta registrada correctamente";



            Detalles.Clear();


            txtTotal.Text = "";


            MostrarDetalle();

        }





        private void Limpiar()
        {

            txtTotal.Text = "";


            Detalles.Clear();


            MostrarDetalle();


        }


    }
}