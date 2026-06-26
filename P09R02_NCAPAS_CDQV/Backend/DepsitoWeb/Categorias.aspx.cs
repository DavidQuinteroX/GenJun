using CapaEntidades;
using CapaNegocios;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace DepsitoWeb
{
    public partial class Categorias : System.Web.UI.Page
    {
        N_Categoria negocio = new N_Categoria();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarCategorias();
            }

        }





        private void CargarCategorias()
        {

            gvCategorias.DataSource =
                negocio.ListarCategorias();


            gvCategorias.DataBind();

        }






        // INSERTAR
        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            E_Categoria categoria =
                new E_Categoria();


            categoria.Nombre =
                txtNombre.Text;



            negocio.InsertarCategoria(categoria);



            Limpiar();

            CargarCategorias();

        }






        // ACTUALIZAR
        protected void btnActualizar_Click(object sender, EventArgs e)
        {

            E_Categoria categoria =
                new E_Categoria();



            categoria.IdCategoria =
                Convert.ToInt32(hfIdCategoria.Value);



            categoria.Nombre =
                txtNombre.Text;




            negocio.ActualizarCategoria(categoria);



            btnGuardar.Visible = true;

            btnActualizar.Visible = false;



            Limpiar();

            CargarCategorias();

        }








        // EDITAR / ELIMINAR
        protected void gvCategorias_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {


            int id =
                Convert.ToInt32(e.CommandArgument);




            if (e.CommandName == "Editar")
            {

                E_Categoria categoria =
                    negocio.ObtenerCategoriaPorId(id);



                hfIdCategoria.Value =
                    categoria.IdCategoria.ToString();



                txtNombre.Text =
                    categoria.Nombre;



                btnGuardar.Visible = false;

                btnActualizar.Visible = true;


            }





            if (e.CommandName == "Eliminar")
            {
                try
                {
                    negocio.EliminarCategoria(id);

                    CargarCategorias();

                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "mensaje",
                        "alert('Categoría eliminada correctamente');",
                        true);
                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "mensaje",
                        "alert('" + ex.Message + "');",
                        true);

                }
            }


        }







        private void Limpiar()
        {

            txtNombre.Text = "";

            hfIdCategoria.Value = "";

        }
    }
}