using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
namespace CapaDatos
{
    public class D_Dashboard
    {
        public DashboardEntidad ObtenerDashboard()
        {

            DashboardEntidad datos = null;


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
                    new SqlCommand(
                        "sp_DashboardResumen",
                        cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;



                SqlDataReader dr =
                    cmd.ExecuteReader();



                if (dr.Read())
                {

                    datos = new DashboardEntidad
                    {

                        TotalProductos =
                        Convert.ToInt32(
                        dr["TotalProductos"]),


                        TotalClientes =
                        Convert.ToInt32(
                        dr["TotalClientes"]),


                        TotalVentas =
                        Convert.ToInt32(
                        dr["TotalVentas"]),


                        TotalInventario =
                        Convert.ToInt32(
                        dr["TotalInventario"])

                    };

                }

            }


            return datos;

        }


    }
}
