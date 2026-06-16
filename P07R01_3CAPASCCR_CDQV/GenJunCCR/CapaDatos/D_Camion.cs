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
    //
    public class D_Camion
    {
        //Listar todos los camiones

        public List<E_Camion> ListarCamiones(bool? disponibilidad = null)
        {
            List<E_Camion> lista = new List<E_Camion>();
            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Listar_Camiones", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                if (disponibilidad.HasValue)

                    cmd.Parameters.AddWithValue("@Disponibilidad", disponibilidad.Value);
                else
                    cmd.Parameters.AddWithValue("@Disponibilidad", DBNull.Value);


                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new E_Camion
                    {
                        IdCamion = Convert.ToInt32(dr["IdCamion"]),
                        Matricula = dr["Matricula"].ToString(),
                        TipoCamion = dr["TipoCamion"].ToString(),
                        Modelo = Convert.ToInt32(dr["Modelo"]),
                        Marca = dr["Marca"].ToString(),
                        Capacidad = Convert.ToInt32(dr["Capacidad"]),
                        Kilometraje = Convert.ToDouble(dr["Kilometraje"]),
                        Disponibilidad = Convert.ToBoolean(dr["Disponibilidad"]),
                        UrlFoto = dr["UrlFoto"].ToString()

                    });

                }

            }
            return lista;
        }
        //Insertar Camion
        public bool InsertarCamion(E_Camion camion)
        {
            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("Insert_Camion", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Matricula", camion.Matricula);
                cmd.Parameters.AddWithValue("@TipoCamion", camion.TipoCamion);
                cmd.Parameters.AddWithValue("@Modelo", camion.Modelo);
                cmd.Parameters.AddWithValue("@Marca", camion.Marca);
                cmd.Parameters.AddWithValue("@Capacidad", camion.Capacidad);
                cmd.Parameters.AddWithValue("@kilometraje", camion.Kilometraje);
                cmd.Parameters.AddWithValue("@Disponibilidad", camion.Disponibilidad);
                cmd.Parameters.AddWithValue("@UrlFoto", string.IsNullOrEmpty(camion.UrlFoto) ? (object)DBNull.Value : camion.UrlFoto);

                 cmd.ExecuteNonQuery();
                return true;
            }
        }
        //Actualizar Camion
        public bool ActualizarCamion(E_Camion camion)
        {                      
            using (SqlConnection conn = Conexion.ObtenerConexion())              
            {
                SqlCommand cmd = new SqlCommand("sp_Update_Camion", conn);
                cmd.CommandType= CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCamion", camion.IdCamion);
                cmd.Parameters.AddWithValue("@Matricula", camion.Matricula);
                cmd.Parameters.AddWithValue("@TipoCamion", camion.TipoCamion);
                cmd.Parameters.AddWithValue("@Modelo", camion.Modelo);
                cmd.Parameters.AddWithValue("@Marca", camion.Marca);
                cmd.Parameters.AddWithValue("@Capacidad", camion.Capacidad);
                cmd.Parameters.AddWithValue("@Kilometraje", camion.Kilometraje);
                cmd.Parameters.AddWithValue("@Disponibilidad", camion.Disponibilidad);
                cmd.Parameters.AddWithValue("@UrlFoto", string.IsNullOrEmpty(camion.UrlFoto) ? (object)DBNull.Value : camion.UrlFoto);



                cmd.ExecuteNonQuery();
                return true;
            }
      
        }

        //Eliminar Camion
        public bool EliminarCamion(int idCamion)
        {
            using(SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Delete_Camion", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCamion", idCamion);
                cmd.ExecuteNonQuery();

                return true;
            }
        }

        //Verificar si existe matricula

        public bool ExisteMatricula(string matricula)
        {
            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Existe_Matricula",conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Matricula", matricula);

                int resultado = Convert.ToInt32(cmd.ExecuteScalar());//EXAMEN EXECUTE 
                return resultado > 0;
            }
        }

        //Obtener camion por Id
        public E_Camion ObternerCamionPorID(int idCamion)
        {
            using (SqlConnection conn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Obtener_Camion_ID", conn);
                cmd.CommandType= CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCamion", idCamion);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    return new E_Camion
                    {
                        IdCamion = Convert.ToInt32(dr["IdCamion"]),
                        Matricula = dr["Matricula"].ToString(),
                        TipoCamion = dr["TipoCamion"].ToString(),
                        Modelo = Convert.ToInt32(dr["Modelo"]),
                        Marca = dr["Marca"].ToString(),
                        Capacidad = Convert.ToInt32(dr["Capacidad"]),
                        Kilometraje = Convert.ToDouble(dr["Kilometraje"]),
                        Disponibilidad = Convert.ToBoolean(dr["Disponibilidad"]),
                        UrlFoto = dr["UrlFoto"].ToString(),
                    };
                }
                return null;
            }
        }
            
        };

    }
