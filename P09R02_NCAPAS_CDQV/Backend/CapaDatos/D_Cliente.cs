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
    public class D_Cliente
    {
        // INSERTAR
        public string InsertarCliente(E_Cliente cliente)
        {
            string mensaje = "";

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_Insert_Cliente",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@Nombre",
                    cliente.Nombre);

                object resultado =
                    cmd.ExecuteScalar();

                if (resultado != null)
                {
                    mensaje = resultado.ToString();
                }
            }

            return mensaje;
        }


        // OBTENER POR ID
        public E_Cliente ObtenerClientePorId(int idCliente)
        {
            E_Cliente cliente = null;

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_GetClienteById",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdCliente",
                    idCliente);

                SqlDataReader dr =
                    cmd.ExecuteReader();

                if (dr.Read())
                {
                    cliente = new E_Cliente
                    {
                        IdCliente =
                            Convert.ToInt32(
                                dr["IdCliente"]),

                        Nombre =
                            dr["Nombre"].ToString()
                    };
                }
            }

            return cliente;
        }


        // LISTAR
        public List<E_Cliente> ListarClientes()
        {
            List<E_Cliente> lista =
                new List<E_Cliente>();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_GetClientes",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                SqlDataReader dr =
                    cmd.ExecuteReader();

                while (dr.Read())
                {
                    lista.Add(
                        new E_Cliente
                        {
                            IdCliente =
                                Convert.ToInt32(
                                    dr["IdCliente"]),

                            Nombre =
                                dr["Nombre"].ToString()
                        });
                }
            }

            return lista;
        }


        // ACTUALIZAR
        public bool ActualizarCliente(E_Cliente cliente)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_Update_Cliente",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdCliente",
                    cliente.IdCliente);

                cmd.Parameters.AddWithValue(
                    "@Nombre",
                    cliente.Nombre);

                cmd.ExecuteNonQuery();

                return true;
            }
        }


        // ELIMINAR
        public bool EliminarCliente(int idCliente)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_Delete_Cliente",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdCliente",
                    idCliente);

                cmd.ExecuteNonQuery();

                return true;
            }
        }
    }
}
