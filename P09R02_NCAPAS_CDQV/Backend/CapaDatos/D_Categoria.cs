using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class D_Categoria
    {
        // INSERTAR
        public string InsertarCategoria(E_Categoria categoria)
        {
            string mensaje = "";

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Insert_Categoria", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Nombre", categoria.Nombre);

                object resultado = cmd.ExecuteScalar();

                if (resultado != null)
                    mensaje = resultado.ToString();
            }

            return mensaje;
        }

        // BUSCAR POR ID
        public E_Categoria ObtenerCategoriaPorId(int idCategoria)
        {
            E_Categoria categoria = null;

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_GetCategoriaById", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdCategoria", idCategoria);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    categoria = new E_Categoria
                    {
                        IdCategoria = Convert.ToInt32(dr["IdCategoria"]),
                        Nombre = dr["Nombre"].ToString()
                    };
                }
            }

            return categoria;
        }

        // LISTAR TODAS
        public List<E_Categoria> ListarCategorias()
        {
            List<E_Categoria> lista = new List<E_Categoria>();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_GetCategorias", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    lista.Add(new E_Categoria
                    {
                        IdCategoria = Convert.ToInt32(dr["IdCategoria"]),
                        Nombre = dr["Nombre"].ToString()
                    });
                }
            }

            return lista;
        }

        // ACTUALIZAR
        public bool ActualizarCategoria(E_Categoria categoria)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Update_Categoria", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdCategoria", categoria.IdCategoria);
                cmd.Parameters.AddWithValue("@Nombre", categoria.Nombre);

                cmd.ExecuteNonQuery();

                return true;
            }
        }

        // ELIMINAR
        public bool EliminarCategoria(int idCategoria)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Delete_Categoria", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdCategoria", idCategoria);

                cmd.ExecuteNonQuery();

                return true;
            }
        }
    }
}
