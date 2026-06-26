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
    public class D_Precio
    {
        public string InsertarPrecio(E_Precio precio)
        {
            string mensaje = "";

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Insertar_Precios", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdPresentacion",precio.IdPresentacion);
                cmd.Parameters.AddWithValue("@Precio",precio.Precio);
                cmd.Parameters.AddWithValue("@FechaInicio",precio.FechaInicio);
                cmd.Parameters.AddWithValue("@FechaFin",(object)precio.FechaFin ?? DBNull.Value);
                object resultado = cmd.ExecuteScalar();
                if (resultado != null)
                    mensaje = resultado.ToString();
            }
            return mensaje;
        }
        // OBTENER POR ID
        public E_Precio ObtenerPrecioPorId(int idPrecio)
        {
            E_Precio precio = null;
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand("sp_GetPreciosbyId",cn);
                cmd.CommandType =CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdPrecio",idPrecio);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    precio = new E_Precio()
                    {
                        IdPrecio = Convert.ToInt32(dr["IdPrecio"]),

                        Precio = Convert.ToDecimal(dr["Precio"]),

                        FechaInicio = Convert.ToDateTime(dr["FechaInicio"]),

                        FechaFin =dr["FechaFin"] == DBNull.Value ? (DateTime?)null: Convert.ToDateTime(dr["FechaFin"])
                    };
                }
            }
            return precio;
        }
        // LISTAR
        public List<E_Precio> ListarPrecios()
        {

            List<E_Precio> lista =new List<E_Precio>();
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_GetPrecios",cn);
                cmd.CommandType =CommandType.StoredProcedure;
                SqlDataReader dr =cmd.ExecuteReader();
                while (dr.Read())
                {
                    lista.Add(new E_Precio()
                    {
                        IdPrecio = Convert.ToInt32(dr["IdPrecio"]),
                        Producto =dr["Producto"].ToString(),
                        Presentacion =dr["Presentacion"].ToString(),
                        Precio =Convert.ToDecimal(dr["Precio"]),
                        FechaInicio =Convert.ToDateTime(dr["FechaInicio"]),
                        FechaFin =dr["FechaFin"] == DBNull.Value? (DateTime?)null: Convert.ToDateTime(dr["FechaFin"])
                    });
                }
            }
            return lista;
        }
        // ACTUALIZAR

        public bool ActualizarPrecio(E_Precio precio)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Update_Precios",cn);
                cmd.CommandType =CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdPrecio",precio.IdPrecio);
                cmd.Parameters.AddWithValue("@IdPresentacion",precio.IdPresentacion);
                cmd.Parameters.AddWithValue("@Precio",precio.Precio);
                cmd.ExecuteNonQuery();


                return true;

            }

        }
        // ELIMINAR
        public bool EliminarPrecio(int idPrecio)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand("sp_Delete_Precios",cn);
                cmd.CommandType =CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdPrecio",idPrecio);
                cmd.ExecuteNonQuery();
                return true;

            }

        }
        public DataTable ObtenerPresentacionesCombo()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_GetPresentacionesCombo",cn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }
    }
}
