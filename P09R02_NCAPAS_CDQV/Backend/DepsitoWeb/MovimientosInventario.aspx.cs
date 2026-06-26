using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CapaNegocios;
using CapaEntidades;

namespace DepsitoWeb
{
    public partial class MovimientosInventario : System.Web.UI.Page
    {
        N_MovimientoInventario negocio =
            new N_MovimientoInventario();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPresentaciones();
                CargarMovimientos();
                Limpiar();
            }
        }



        private void CargarPresentaciones()
        {

            ddlPresentacion.DataSource =
                negocio.ListarPresentaciones();


            ddlPresentacion.DataTextField =
                "Descripcion";


            ddlPresentacion.DataValueField =
                "IdPresentacion";


            ddlPresentacion.DataBind();


            ddlPresentacion.Items.Insert(
                0,
                "--Seleccione--");

        }




        private void CargarMovimientos()
        {

            gvMovimientos.DataSource =
                negocio.ListarMovimientos();


            gvMovimientos.DataBind();

        }




        protected void btnGuardar_Click(
            object sender,
            EventArgs e)
        {

            E_Movimiento_Inventario movimiento =
                new E_Movimiento_Inventario();



            movimiento.IdPresentacion =
                Convert.ToInt32(
                    ddlPresentacion.SelectedValue);



            movimiento.TipoMovimiento =
                ddlTipoMovimiento.SelectedValue;



            movimiento.Cantidad =
                Convert.ToInt32(
                    txtCantidad.Text);



            movimiento.Fecha =
                Convert.ToDateTime(
                    txtFecha.Text);



            movimiento.Motivo =
                txtMotivo.Text;



            // INSERTAR

            if (string.IsNullOrEmpty(
                hfIdMovimiento.Value))
            {

                string mensaje =
                    negocio.InsertarMovimiento(
                        movimiento);


                lblMensaje.Text = mensaje;

            }


            // ACTUALIZAR

            else
            {

                movimiento.IdMovimiento_Inventario =
                    Convert.ToInt32(
                        hfIdMovimiento.Value);



                negocio.ActualizarMovimiento(
                    movimiento);



                lblMensaje.Text =
                    "Movimiento actualizado correctamente";

            }



            CargarMovimientos();

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



            E_Movimiento_Inventario movimiento =
                negocio.ObtenerMovimientoPorId(id);



            hfIdMovimiento.Value =
                movimiento.IdMovimiento_Inventario.ToString();



            string idPresentacion =
     movimiento.IdPresentacion.ToString();


            if (ddlPresentacion.Items.FindByValue(idPresentacion) != null)
            {
                ddlPresentacion.SelectedValue = idPresentacion;
            }



            ddlTipoMovimiento.SelectedValue =
                movimiento.TipoMovimiento;



            txtCantidad.Text =
                movimiento.Cantidad.ToString();



            txtFecha.Text =
                movimiento.Fecha.ToString("yyyy-MM-dd");



            txtMotivo.Text =
                movimiento.Motivo;



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



            negocio.EliminarMovimiento(id);



            lblMensaje.Text =
                "Movimiento eliminado correctamente";



            CargarMovimientos();


            Limpiar();

        }






        protected void btnCancelar_Click(
            object sender,
            EventArgs e)
        {

            Limpiar();

        }






        private void Limpiar()
        {

            hfIdMovimiento.Value = "";


            ddlPresentacion.SelectedIndex = 0;


            ddlTipoMovimiento.SelectedIndex = 0;


            txtCantidad.Text = "";


            txtFecha.Text = "";


            txtMotivo.Text = "";


            btnGuardar.Text =
                "Guardar";

        }

    }
}