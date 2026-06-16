using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaEntidades;
using CapaNegocios;

namespace CapaWindowsForms
{
    public partial class Form1 : Form
    {
        private readonly N_Camion objNegocioCamion = new N_Camion();
        private readonly N_Chofer objNegocioChofer = new N_Chofer();
        private readonly N_Ruta objNegocioRuta = new N_Ruta();
        public Form1()
        {
            InitializeComponent();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            tabControl1_SelectedIndexChanged(sender, e);

        }

        private void cargarCamiones()
        {
            dgvCamiones.DataSource = null;
            dgvCamiones.DataSource = objNegocioCamion.ListarCamiones();
            
        }
        private void cargarChoferes()
        {
            dgvChoferes.DataSource = null;
            dgvChoferes.DataSource = objNegocioChofer.ListarChoferes();
        }
        private void cargarRutas()
        {
            dgvRutas.DataSource = null;
            dgvRutas.DataSource = objNegocioRuta.ListarRutas();
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (tabControl1.SelectedTab.Name)
            {
                case "tabCamiones":
                    cargarCamiones();
                    break;

                case "tabChoferes":
                    cargarChoferes();
                    break;

                case "tabRutas":
                    cargarRutas();
                    break;
            }
        }
    }
}
