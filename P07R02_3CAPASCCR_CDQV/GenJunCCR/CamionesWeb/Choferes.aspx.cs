using CapaDatos;
using CapaEntidades;
using CapaNegocios;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CamionesWeb
{
    public partial class Choferes : System.Web.UI.Page
    {
        private N_Chofer objNegocio = new N_Chofer();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarChoferes();
            }


        }
        private void CargarChoferes()
        {
            gvChoferes.DataSource = objNegocio.ListarChoferes();
            gvChoferes.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            pnlChofer.Visible = true;
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            pnlChofer.Visible = false;
        }
       

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            E_Chofer chofer = new E_Chofer();

            chofer.Nombre = txtNombre.Text.Trim();
            chofer.ApPaterno = txtApPaterno.Text.Trim();
            chofer.ApMaterno = txtApMaterno.Text.Trim();
            chofer.Telefono = txtTelefono.Text.Trim();
            chofer.FechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text);
            chofer.Licencia = txtLicencia.Text.Trim();
            chofer.UrlFoto = txtUrlFoto.Text.Trim();
            chofer.Disponibilidad = chkDisponibilidad.Checked;

            string respuesta;

            // NUEVO
            if (string.IsNullOrEmpty(hfIdChofer.Value))
            {
                chofer.FechaRegistro = DateTime.Now;

                respuesta = objNegocio.InsertarChofer(chofer);
            }
            // EDITAR
            else
            {
                chofer.IdChofer = Convert.ToInt32(hfIdChofer.Value);

                respuesta = objNegocio.ActualizarChofer(chofer);
            }

            if (respuesta == "Ok")
            {
                lblMensaje.CssClass = "alert alert-success";

                lblMensaje.Text =
                    string.IsNullOrEmpty(hfIdChofer.Value)
                    ? "Chofer registrado correctamente"
                    : "Chofer actualizado correctamente";

                CargarChoferes();

                LimpiarFormulario();

                hfIdChofer.Value = "";

                pnlChofer.Visible = false;

                btnGuardar.Text = "Guardar";
            }
            else
            {
                lblMensaje.CssClass = "alert alert-danger";
                lblMensaje.Text = respuesta;
            }
        }   

        private void LimpiarFormulario()
        {
            txtNombre.Text = "";
            txtApPaterno.Text = "";
            txtApMaterno.Text = "";
            txtTelefono.Text = "";
            txtFechaNacimiento.Text = "";
            txtLicencia.Text = "";
            txtUrlFoto.Text = "";
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            int idChofer = Convert.ToInt32(btn.CommandArgument);

            E_Chofer chofer = objNegocio.ObtenerChofer(idChofer);

            if (chofer != null)
            {
                hfIdChofer.Value = chofer.IdChofer.ToString();

                txtNombre.Text = chofer.Nombre;
                txtApPaterno.Text = chofer.ApPaterno;
                txtApMaterno.Text = chofer.ApMaterno;
                txtTelefono.Text = chofer.Telefono;

                txtFechaNacimiento.Text =
                    chofer.FechaNacimiento.ToString("yyyy-MM-dd");

                txtLicencia.Text = chofer.Licencia;
                txtUrlFoto.Text = chofer.UrlFoto;

                chkDisponibilidad.Checked = chofer.Disponibilidad;

                pnlChofer.Visible = true;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            int idChofer = Convert.ToInt32(btn.CommandArgument);

            string respuesta = objNegocio.EliminarChofer(idChofer);

            if (respuesta == "Ok")
            {
                lblMensaje.CssClass = "alert alert-success";
                lblMensaje.Text = "Chofer eliminado correctamente";

                CargarChoferes();
            }
            else
            {
                lblMensaje.CssClass = "alert alert-danger";
                lblMensaje.Text = respuesta;
            }
        }
    }
}