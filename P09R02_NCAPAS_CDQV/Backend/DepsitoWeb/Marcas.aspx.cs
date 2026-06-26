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
    public partial class Marcas : System.Web.UI.Page
    {
        N_Marca negocio = new N_Marca();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarMarcas();
                btnActualizar.Visible = false;
            }
        }
        private void CargarMarcas()
        {
            gvMarcas.DataSource =
                negocio.ListarMarcas();

            gvMarcas.DataBind();
        }




        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            E_Marca marca = new E_Marca();


            marca.Nombre =
                txtNombre.Text;


            negocio.InsertarMarca(marca);


            Limpiar();

            CargarMarcas();

        }





        protected void btnActualizar_Click(object sender, EventArgs e)
        {

            E_Marca marca = new E_Marca();


            marca.IdMarca =
                Convert.ToInt32(hfIdMarca.Value);


            marca.Nombre =
                txtNombre.Text;


            negocio.ActualizarMarca(marca);



            btnGuardar.Visible = true;
            btnActualizar.Visible = false;


            Limpiar();

            CargarMarcas();

        }





        protected void gvMarcas_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {

            int id =
                Convert.ToInt32(e.CommandArgument);



            if (e.CommandName == "Editar")
            {

                E_Marca marca =
                    negocio.ObtenerMarcaPorId(id);


                hfIdMarca.Value =
                    marca.IdMarca.ToString();


                txtNombre.Text =
                    marca.Nombre;


                btnGuardar.Visible = false;
                btnActualizar.Visible = true;

            }




            if (e.CommandName == "Eliminar")
            {

                negocio.EliminarMarca(id);

                CargarMarcas();

            }

        }



        private void Limpiar()
        {
            txtNombre.Text = "";
            hfIdMarca.Value = "";
        }
    }
}