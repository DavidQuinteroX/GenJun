using CapaEntidades;
using CapaNegocios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CamionesWeb
{
    public partial class Rutas : System.Web.UI.Page
    {
        N_Ruta objNegocio = new N_Ruta();
        N_Chofer objChofer = new N_Chofer();   // si tienes capa chofer
        N_Camion objCamion = new N_Camion();   // si tienes capa camion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarChoferes();
                CargarCamiones();
                CargarRutas();
            }
           

        }
        private void CargarRutas()
        {
            try
            {
                gvRutas.DataSource = objNegocio.ListarRutas();
                gvRutas.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }


        private void CargarChoferes()
        {
            ddlChofer.DataSource = objChofer.ListarChoferes();
            ddlChofer.DataTextField = "Nombre";
            ddlChofer.DataValueField = "IdChofer";
            ddlChofer.DataBind();

            ddlChofer.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", "0"));
        }

        private void CargarCamiones()
        {
            ddlCamion.DataSource = objCamion.ListarCamiones();
            ddlCamion.DataTextField = "Matricula";
            ddlCamion.DataValueField = "IdCamion";
            ddlCamion.DataBind();

            ddlCamion.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", "0"));
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                E_Ruta ruta = new E_Ruta
                {
                    Origen = txtOrigen.Text,
                    Destino = txtDestino.Text,

                    IdChofer = Convert.ToInt32(ddlChofer.SelectedValue),
                    IdCamion = Convert.ToInt32(ddlCamion.SelectedValue),

                    FechaSalida = Convert.ToDateTime(txtSalida.Text),
                    FechaLlegada = Convert.ToDateTime(txtLlegada.Text),

                    Distancia = Convert.ToDouble(txtDistancia.Text),

                    ATiempo = chkATiempo.Checked
                };

                string respuesta = objNegocio.InsertarRuta(ruta);

                if (respuesta == "Ok")
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Green;
                    lblMensaje.Text = "✔ Ruta registrada correctamente";

                    Limpiar();
                }
                else
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = respuesta;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
            }
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Limpiar();

            lblMensaje.Text = "";
            hfIdRuta.Value = "";
        }
        private void Limpiar()
        {
            txtOrigen.Text = "";
            txtDestino.Text = "";
            txtSalida.Text = "";
            txtLlegada.Text = "";
            txtDistancia.Text = "";
            chkATiempo.Checked = false;

            ddlChofer.SelectedIndex = 0;
            ddlCamion.SelectedIndex = 0;
        }

        protected void gvRutas_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idRuta = Convert.ToInt32(gvRutas.SelectedDataKey.Value);

                var ruta = objNegocio.ListarRutas()
                                      .FirstOrDefault(x => x.IdRuta == idRuta);

                if (ruta != null)
                {
                    hfIdRuta.Value = ruta.IdRuta.ToString();

                    txtOrigen.Text = ruta.Origen;
                    txtDestino.Text = ruta.Destino;

                    ddlChofer.SelectedValue = ruta.IdChofer.ToString();
                    ddlCamion.SelectedValue = ruta.IdCamion.ToString();

                    txtSalida.Text = ruta.FechaSalida.ToString("yyyy-MM-dd");
                    txtLlegada.Text = ruta.FechaLlegada.ToString("yyyy-MM-dd");

                    txtDistancia.Text = ruta.Distancia.ToString();
                    chkATiempo.Checked = ruta.ATiempo;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
            }
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(hfIdRuta.Value))
                {
                    lblMensaje.Text = "Seleccione una ruta para editar";
                    return;
                }

                E_Ruta ruta = new E_Ruta
                {
                    IdRuta = Convert.ToInt32(hfIdRuta.Value),

                    Origen = txtOrigen.Text,
                    Destino = txtDestino.Text,

                    IdChofer = Convert.ToInt32(ddlChofer.SelectedValue),
                    IdCamion = Convert.ToInt32(ddlCamion.SelectedValue),

                    FechaSalida = Convert.ToDateTime(txtSalida.Text),
                    FechaLlegada = Convert.ToDateTime(txtLlegada.Text),

                    Distancia = Convert.ToDouble(txtDistancia.Text),
                    ATiempo = chkATiempo.Checked
                };

                string resp = objNegocio.ActualizarRuta(ruta);

                if (resp == "Ok")
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Green;
                    lblMensaje.Text = "✔ Ruta actualizada correctamente";

                    CargarRutas();
                    Limpiar();
                }
                else
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = resp;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
            }
        }

        protected void gvRutas_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int idRuta = Convert.ToInt32(gvRutas.DataKeys[e.RowIndex].Value);

                string resp = objNegocio.EliminarRuta(idRuta);

                if (resp == "Ok")
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Green;
                    lblMensaje.Text = "✔ Ruta eliminada correctamente";

                    CargarRutas();
                }
                else
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = resp;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
            }
        }
    }

}
