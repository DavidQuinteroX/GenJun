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
    public partial class Inventario : System.Web.UI.Page
    {
        N_Inventario negocio = new N_Inventario();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPresentaciones();
                ListarInventario();
            }

        }
        void ListarInventario()
        {

            gvInventario.DataSource =
                negocio.ListarInventario();

            gvInventario.DataBind();

        }







        void CargarPresentaciones()
        {

            N_Presentacion n =
                new N_Presentacion();


            ddlPresentacion.DataSource =
                n.ListarPresentaciones();


            ddlPresentacion.DataTextField =
                "Nombre";


            ddlPresentacion.DataValueField =
                "IdPresentacion";


            ddlPresentacion.DataBind();


        }






        protected void btnGuardar_Click(object sender, EventArgs e)
        {


            E_Inventario inv =
                new E_Inventario();


            inv.IdPresentacion =
                Convert.ToInt32(
                    ddlPresentacion.SelectedValue);



            inv.Existencia =
                Convert.ToInt32(
                    txtExistencia.Text);



            negocio.InsertarInventario(inv);



            ListarInventario();


            Limpiar();

        }







        protected void btnActualizar_Click(object sender, EventArgs e)
        {


            E_Inventario inv =
                new E_Inventario();



            inv.IdInventario =
                Convert.ToInt32(
                hfIdInventario.Value);



            inv.IdPresentacion =
                Convert.ToInt32(
                ddlPresentacion.SelectedValue);



            inv.Existencia =
                Convert.ToInt32(
                txtExistencia.Text);




            negocio.ActualizarInventario(inv);



            btnGuardar.Visible = true;
            btnActualizar.Visible = false;


            ListarInventario();


            Limpiar();

        }







        protected void gvInventario_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {


            int id =
                Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Editar")
            {
                E_Inventario inv =
                    negocio.ObtenerInventarioPorId(id);
                hfIdInventario.Value =
                    inv.IdInventario.ToString();

                CargarPresentaciones();

                string valor =
                    inv.IdPresentacion.ToString();

                if (ddlPresentacion.Items.FindByValue(valor) != null)
                {
                    ddlPresentacion.SelectedValue = valor;
                }
                txtExistencia.Text =
                    inv.Existencia.ToString();
                btnGuardar.Visible = false;
                btnActualizar.Visible = true;

            }
            if (e.CommandName == "Eliminar")
            {

                negocio.EliminarInventario(id);


                ListarInventario();

            }

        }

        void Limpiar()
        {

            txtExistencia.Text = "";

            hfIdInventario.Value = "";

        }

    }
}