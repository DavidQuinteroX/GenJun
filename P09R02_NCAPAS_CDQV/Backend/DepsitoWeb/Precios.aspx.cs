using CapaDatos;
using CapaEntidades;
using CapaNegocios;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DepsitoWeb
{
    public partial class Precios : System.Web.UI.Page
    {
        N_Precio negocio = new N_Precio();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                CargarPresentaciones();
                CargarPrecios();
            }

        }
        private void CargarPrecios()
        {

            gvPrecios.DataSource =
                negocio.ListarPrecios();


            gvPrecios.DataBind();

        }

        private void CargarPresentaciones()
        {

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
       new SqlCommand(
       "sp_GetPresentacionesCombo",
       cn);

                cmd.CommandType =
                CommandType.StoredProcedure;

                SqlDataReader dr =
                cmd.ExecuteReader();

                ddlPresentacion.DataSource = dr;

                //ddlPresentacion.DataTextField = "Descripcion";

                ddlPresentacion.DataValueField = "IdPresentacion";

                ddlPresentacion.DataBind();


            }


            ddlPresentacion.Items.Insert(
                0,
                new ListItem("-- Seleccione --", "0")
            );

        }






        // INSERTAR

        protected void btnGuardar_Click(object sender, EventArgs e)
        {


            E_Precio precio =
                new E_Precio();



            precio.IdPresentacion =
            Convert.ToInt32(ddlPresentacion.SelectedValue);



            precio.Precio =
                Convert.ToDecimal(txtPrecio.Text);



            precio.FechaInicio = DateTime.Today;




            negocio.InsertarPrecio(precio);



            Limpiar();

            CargarPrecios();

        }

        // ACTUALIZAR

        protected void btnActualizar_Click(object sender, EventArgs e)
        {


            E_Precio precio =
                new E_Precio();



            precio.IdPrecio =
            Convert.ToInt32(hfIdPrecio.Value);



            precio.IdPresentacion =
Convert.ToInt32(ddlPresentacion.SelectedValue);



            precio.Precio =
            Convert.ToDecimal(txtPrecio.Text);

          

            negocio.ActualizarPrecio(precio);

            btnGuardar.Visible = true;

            btnActualizar.Visible = false;

            Limpiar();

            CargarPrecios();

        }

        // EDITAR / ELIMINAR

        protected void gvPrecios_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {

            int id =
            Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {


                E_Precio precio =
                negocio.ObtenerPrecioPorId(id);



                hfIdPrecio.Value =
                precio.IdPrecio.ToString();



                ddlPresentacion.SelectedValue =
                precio.IdPresentacion.ToString();;



                txtPrecio.Text =
                precio.Precio.ToString();

                btnGuardar.Visible = false;

                btnActualizar.Visible = true;


            }

            if (e.CommandName == "Eliminar")
            {

                try
                {

                    negocio.EliminarPrecio(id);


                    CargarPrecios();


                }
                catch (Exception ex)
                {

                    Response.Write(ex.Message);

                }

            }
        }

        private void Limpiar()
        {

            ddlPresentacion.SelectedIndex = 0;
            txtPrecio.Text = "";
          
            hfIdPrecio.Value = "";

        }

    }
}