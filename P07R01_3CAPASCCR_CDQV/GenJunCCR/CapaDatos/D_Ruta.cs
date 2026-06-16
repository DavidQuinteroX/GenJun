using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using CapaEntidades;
namespace CapaDatos
{
    public class D_Ruta
    {
        public List<E_Ruta> ListarRutas()
        {
            List<E_Ruta> lista = new List<E_Ruta>();

            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Select_Rutas_Detalle", conn);
                cmd.CommandType = CommandType.StoredProcedure;                

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new E_Ruta
                    {
                        IdRuta = Convert.ToInt32(dr["IdRuta"]),
                        Origen = dr["Origen"].ToString(),
                        Destino = dr["Destino"].ToString(),
                        FechaSalida = Convert.ToDateTime(dr["FechaSalida"]),
                        FechaLlegada = Convert.ToDateTime(dr["FechaLlegada"]),
                        ATiempo = Convert.ToBoolean(dr["ATiempo"]),
                        Distancia = Convert.ToDouble(dr["Distancia"]),
                       
                        NombreChofer = dr["NombreChofer"].ToString(),
                        Licencia = dr["Licencia"].ToString(),
                        TelefonoChofer = dr["TelefonoChofer"].ToString(),
                        FotoChofer = dr["FotoChofer"].ToString(),
                        Matricula = dr["Matricula"].ToString(),
                        FotoCamion = dr["FotoCamion"].ToString(),                                             
                    });


                }

            }
            return lista;

        }
        public bool InsertarRuta(E_Ruta ruta)
        {
            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Insert_Rutas", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdChofer", ruta.IdChofer);
                cmd.Parameters.AddWithValue("@IdCamion", ruta.IdCamion);
                cmd.Parameters.AddWithValue("@Origen", ruta.Origen);
                cmd.Parameters.AddWithValue("@Destino", ruta.Destino);
                cmd.Parameters.AddWithValue("@FechaSalida", ruta.FechaSalida);
                cmd.Parameters.AddWithValue("@FechaLlegada", ruta.FechaLlegada);
                cmd.Parameters.AddWithValue("@ATiempo", ruta.ATiempo);
                cmd.Parameters.AddWithValue("@Distancia", ruta.Distancia);
                cmd.Parameters.AddWithValue("@FechaRegistro", ruta.FechaRegistro);
                
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        public bool ActualizarRuta(E_Ruta ruta)
        {
            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Update_Choferes", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdRuta", ruta.IdRuta);
                cmd.Parameters.AddWithValue("@IdChofer", ruta.IdChofer);
                cmd.Parameters.AddWithValue("@IdCamion", ruta.IdCamion);
                cmd.Parameters.AddWithValue("@Origen", ruta.Origen);
                cmd.Parameters.AddWithValue("@Destino", ruta.Destino);
                cmd.Parameters.AddWithValue("@FechaLlegada", ruta.FechaLlegada);
                cmd.Parameters.AddWithValue("@FechaSalida", ruta.FechaSalida);
                cmd.Parameters.AddWithValue("@ATiempo", ruta.ATiempo);
                cmd.Parameters.AddWithValue("@Distancia", ruta.Distancia);
                cmd.Parameters.AddWithValue("@FechaRegistro", ruta.FechaRegistro);
                
                return cmd.ExecuteNonQuery() > 0;
            }

        }

        public bool EliminarRuta(int idRuta)
        {
            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Delete_Ruta", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdRuta", idRuta);
                return cmd.ExecuteNonQuery() > 0;


            }
        }

    }
}
