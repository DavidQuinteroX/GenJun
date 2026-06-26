using CapaDatos;
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
    public partial class Presentaciones : System.Web.UI.Page
    {
        N_Presentacion negocio = new N_Presentacion();
        N_Producto negocioProducto = new N_Producto();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
                CargarTabla();
            }
        }
        private void CargarProductos()
        {
            ddlProducto.DataSource =
                negocioProducto.ListarProductosCombo();


            ddlProducto.DataTextField =
                "Nombre";


            ddlProducto.DataValueField =
                "IdProducto";


            ddlProducto.DataBind();


            ddlProducto.Items.Insert(
                0,
                new ListItem("-- Seleccione --", "0"));
        }
        private void CargarTabla()
        {

            gvPresentaciones.DataSource =
                negocio.ListarPresentaciones();


            gvPresentaciones.DataBind();

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            E_Presentacion presentacion =
                new E_Presentacion();


            presentacion.IdProducto =Convert.ToInt32(ddlProducto.SelectedValue);


            presentacion.Nombre =
                txtNombre.Text;


            presentacion.Cantidad =
                Convert.ToInt32(txtCantidad.Text);



            negocio.InsertarPresentacion(presentacion);



            Limpiar();

            CargarTabla();

        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {

            E_Presentacion presentacion =
                new E_Presentacion();



            presentacion.IdPresentacion =
                Convert.ToInt32(hfIdPresentacion.Value);



            presentacion.IdProducto =
Convert.ToInt32(ddlProducto.SelectedValue);



            presentacion.Nombre =
                txtNombre.Text;



            presentacion.Cantidad =
                Convert.ToInt32(txtCantidad.Text);



            negocio.ActualizarPresentacion(presentacion);



            btnGuardar.Visible = true;
            btnActualizar.Visible = false;


            Limpiar();

            CargarTabla();

        }
        protected void gvPresentaciones_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {

            int id =
                Convert.ToInt32(e.CommandArgument);



            if (e.CommandName == "Editar")
            {


                E_Presentacion p =
                    negocio.ObtenerPresentacionPorId(id);



                hfIdPresentacion.Value =
                    p.IdPresentacion.ToString();



                ddlProducto.SelectedValue =p.IdProducto.ToString();



                txtNombre.Text =
                    p.Nombre;



                txtCantidad.Text =
                    p.Cantidad.ToString();



                btnGuardar.Visible = false;

                btnActualizar.Visible = true;

            }
            if (e.CommandName == "Eliminar")
            {

                negocio.EliminarPresentacion(id);


                CargarTabla();

            }

        }
        private void Limpiar()
        {
            ddlProducto.SelectedIndex = 0;
            txtNombre.Text = "";
            txtCantidad.Text = "";
            hfIdPresentacion.Value = "";

        }

    }
}