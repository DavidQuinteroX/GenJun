using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;

namespace CapaNegocios
{
    public class N_Dashboard
    {
      


            D_Dashboard datos =
                new D_Dashboard();



            public DashboardEntidad ObtenerDashboard()
            {

                return datos.ObtenerDashboard();

            }


        }

 }
