using CapaNegocios;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CamionesWeb
{
    public partial class Camiones : System.Web.UI.Page
    {
        private N_Camion objNegocio = new N_Camion();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCamiones();

            }

        }//Fin del Page_Load

        private void CargarCamiones()
        {
            try
            {
                bool? disponibilidad = null;

                //Determinar filtro

                if (ddlFiltro.SelectedValue == "1")
                    disponibilidad = true;
                else if (ddlFiltro.SelectedValue == "0")
                    disponibilidad = false;
                List<E_Camion> lista = objNegocio.ListarCamiones(disponibilidad);

                //Asignar al gridView
                gvCamiones.DataSource = lista;
                gvCamiones.DataBind();

                //Mostrar mensaje si no hay datos
                if (lista == null || lista.Count == 0)
                {
                    MostrarMensaje("No se encontraron camiones con el filtro seleccionado", "info");

                }
                else
                {
                    pnlMensaje.Visible = false;
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar camiones" + ex.Message, "error");
            }
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            CargarCamiones();
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            ddlFiltro.SelectedIndex = 0;
            CargarCamiones();
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensaje.Visible = true;
            lblMensaje.Text = mensaje;
            pnlMensaje.CssClass = "info-mensaje " + tipo;
        }

        //Guardar camion
        protected void btnGuardarCamion_Click(object sender, EventArgs e)
        {
            try
            {
                E_Camion camion = new E_Camion();

                camion.Matricula = txtMatricula.Text.Trim();
                camion.TipoCamion = txtTipo.Text.Trim();
                camion.Marca = txtMarca.Text.Trim();

                int modelo;
                int capacidad;
                double kilometraje;

                if (!int.TryParse(txtModelo.Text, out modelo))
                {
                    MostrarMensaje("Modelo inválido", "error");
                    return;
                }

                if (!int.TryParse(txtCapacidad.Text, out capacidad))
                {
                    MostrarMensaje("Capacidad inválida", "error");
                    return;
                }

                if (!double.TryParse(txtKilometraje.Text, out kilometraje))
                {
                    MostrarMensaje("Kilometraje inválido", "error");
                    return;
                }

                camion.Modelo = modelo;
                camion.Capacidad = capacidad;
                camion.Kilometraje = kilometraje;
                camion.Disponibilidad = Convert.ToBoolean(ddlDisponibilidad.SelectedValue);
                camion.UrlFoto = txtUrlFoto.Text.Trim();

                string respuesta ;

                // 🔥 AQUÍ LA MAGIA: EDITAR vs INSERTAR
                if (ViewState["IdCamionEditar"] != null)
                {
                    camion.IdCamion = Convert.ToInt32(ViewState["IdCamionEditar"]);

                    respuesta = objNegocio.ActualizarCamion(camion);

                    if (respuesta == "Ok")
                    {
                        MostrarMensaje("Camión actualizado correctamente", "success");

                        ViewState["IdCamionEditar"] = null;
                        btnGuardarCamion.Text = "💾 Guardar";

                        LimpiarFormulario();
                        CargarCamiones();
                    }
                    else
                    {
                        MostrarMensaje(respuesta, "error");
                    }
                }
                else
                {
                    respuesta = objNegocio.InsertarCamion(camion);

                    if (respuesta == "Ok")
                    {
                        MostrarMensaje("Camión registrado correctamente", "success");

                        LimpiarFormulario();
                        CargarCamiones();
                    }
                    else
                    {
                        MostrarMensaje(respuesta, "error");
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error: " + ex.Message, "error");
            }
        }

        private void LimpiarFormulario()
        {
            txtMatricula.Text = "";
            txtTipo.Text = "";
            txtMarca.Text = "";
            txtModelo.Text = "";
            txtCapacidad.Text = "";
            txtKilometraje.Text = "";

            ddlDisponibilidad.SelectedIndex = 0;
        }

        protected void gvCamiones_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idCamion = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Eliminar")
            {
                string respuesta = objNegocio.EliminiarCamion(idCamion);

                if (respuesta == "Ok")
                {
                    MostrarMensaje("Camión eliminado correctamente", "success");
                    CargarCamiones();
                }
                else
                {
                    MostrarMensaje(respuesta, "error");
                }
            }
            if (e.CommandName == "Editar")
            {
             
                var camion = objNegocio.ObtenerCamionPorId(idCamion);

                if (camion != null)
                {
                    ViewState["IdCamionEditar"] = camion.IdCamion;

                    txtMatricula.Text = camion.Matricula;
                    txtTipo.Text = camion.TipoCamion;
                    txtMarca.Text = camion.Marca;
                    txtModelo.Text = camion.Modelo.ToString();
                    txtCapacidad.Text = camion.Capacidad.ToString();
                    txtKilometraje.Text = camion.Kilometraje.ToString();
                    ddlDisponibilidad.SelectedValue = camion.Disponibilidad.ToString().ToLower();
                    txtUrlFoto.Text = camion.UrlFoto;

                    btnGuardarCamion.Text = "💾 Actualizar";

                    ScriptManager.RegisterStartupScript(this, GetType(),
                        "OpenModal", "abrirModal();", true);
                }
            }


        }



    }
}
