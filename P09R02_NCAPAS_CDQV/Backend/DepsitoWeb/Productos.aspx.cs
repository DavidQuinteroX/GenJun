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
    public partial class Productos : System.Web.UI.Page
    {
        N_Producto negocioProducto = new N_Producto();       
        N_Categoria negocioCategoria = new N_Categoria();
        N_Marca negocioMarca = new N_Marca();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                //CargarMarcas();
                CargarCategorias();
                CargarProductos();
                CargarMarcas();
                btnActualizar.Visible = false;

            }
        }
        private void CargarMarcas()
        {


            ddlMarca.DataSource =
                negocioMarca.ListarMarcas();


            ddlMarca.DataTextField = "Nombre";

            ddlMarca.DataValueField = "IdMarca";


            ddlMarca.DataBind();



            ddlMarca.Items.Insert(
                0,
                new ListItem("-- Seleccione Marca --", "0")
            );


        }








        private void CargarCategorias()
        {


            ddlCategoria.DataSource =
                negocioCategoria.ListarCategorias();


            ddlCategoria.DataTextField = "Nombre";

            ddlCategoria.DataValueField = "IdCategoria";


            ddlCategoria.DataBind();



            ddlCategoria.Items.Insert(
                0,
                new ListItem("-- Seleccione Categoria --", "0")
            );

        }








        private void CargarProductos()
        {


            gvProductos.DataSource =
                negocioProducto.ListarProductos();



            gvProductos.DataBind();


        }








        // INSERTAR

        protected void btnGuardar_Click(object sender, EventArgs e)
        {


            E_Producto producto =
                new E_Producto();



            producto.Nombre =
                txtNombre.Text;




            producto.IdMarca =
                Convert.ToInt32(
                    ddlMarca.SelectedValue);



            producto.IdCategoria =
                Convert.ToInt32(
                    ddlCategoria.SelectedValue);




            producto.ContenidoML =
                Convert.ToInt32(
                    txtContenidoML.Text);




            producto.Activo =
                chkActivo.Checked;





            negocioProducto.InsertarProducto(producto);



            Limpiar();

            CargarProductos();


        }









        // ACTUALIZAR


        protected void btnActualizar_Click(object sender, EventArgs e)
        {


            E_Producto producto =
                new E_Producto();



            producto.IdProducto =
                Convert.ToInt32(
                    hfIdProducto.Value);



            producto.Nombre =
                txtNombre.Text;




            producto.IdMarca =
                Convert.ToInt32(
                    ddlMarca.SelectedValue);




            producto.IdCategoria =
                Convert.ToInt32(
                    ddlCategoria.SelectedValue);




            producto.ContenidoML =
                Convert.ToInt32(
                    txtContenidoML.Text);




            producto.Activo =
                chkActivo.Checked;





            negocioProducto.ActualizarProducto(producto);





            btnGuardar.Visible = true;

            btnActualizar.Visible = false;



            Limpiar();

            CargarProductos();


        }









        // EDITAR / ELIMINAR


        protected void gvProductos_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {


            int id =
                Convert.ToInt32(
                    e.CommandArgument);





            if (e.CommandName == "Editar")
            {



                E_Producto producto =
                    negocioProducto.ObtenerProductoPorId(id);





                hfIdProducto.Value =
                    producto.IdProducto.ToString();




                txtNombre.Text =
                    producto.Nombre;




                ddlMarca.SelectedValue =
                    producto.IdMarca.ToString();




                ddlCategoria.SelectedValue =
                    producto.IdCategoria.ToString();




                txtContenidoML.Text =
                    producto.ContenidoML.ToString();




                chkActivo.Checked =
                    producto.Activo;





                btnGuardar.Visible = false;

                btnActualizar.Visible = true;



            }







            if (e.CommandName == "Eliminar")
            {


                negocioProducto.EliminarProducto(id);



                CargarProductos();


            }



        }










        private void Limpiar()
        {

            hfIdProducto.Value = "";

            txtNombre.Text = "";

            ddlMarca.SelectedIndex = 0;

            ddlCategoria.SelectedIndex = 0;


            txtContenidoML.Text = "";

            chkActivo.Checked = false;


        }

    }
}