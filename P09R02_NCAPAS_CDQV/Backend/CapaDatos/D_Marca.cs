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
    public class D_Marca
    {
        // INSERTAR
        public string InsertarMarca(E_Marca marca)
        {
            string mensaje = "";

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Insert_marcas", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Nombre", marca.Nombre);

                object resultado = cmd.ExecuteScalar();

                if (resultado != null)
                    mensaje = resultado.ToString();
            }

            return mensaje;
        }

        // OBTENER POR ID
        public E_Marca ObtenerMarcaPorId(int idMarca)
        {
            E_Marca marca = null;

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("spGetMarcaById", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdMarca", idMarca);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    marca = new E_Marca
                    {
                        IdMarca = Convert.ToInt32(dr["IdMarca"]),
                        Nombre = dr["Nombre"].ToString()
                    };
                }
            }

            return marca;
        }

        // LISTAR TODAS
        public List<E_Marca> ListarMarcas()
        {
            List<E_Marca> lista = new List<E_Marca>();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_GetMarcas", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    lista.Add(new E_Marca
                    {
                        IdMarca = Convert.ToInt32(dr["IdMarca"]),
                        Nombre = dr["Nombre"].ToString()
                    });
                }
            }

            return lista;
        }

        // ACTUALIZAR
        public bool ActualizarMarca(E_Marca marca)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Update_Marca", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdMarca", marca.IdMarca);
                cmd.Parameters.AddWithValue("@Nombre", marca.Nombre);

                cmd.ExecuteNonQuery();

                return true;
            }
        }

        // ELIMINAR
        public bool EliminarMarca(int idMarca)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Delete_Marca", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdMarca", idMarca);

                cmd.ExecuteNonQuery();

                return true;
            }
        }
    }
}
