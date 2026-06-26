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
    public class D_Presentacion
    {
        // INSERTAR
        public string InsertarPresentacion(E_Presentacion presentacion)
        {
            string mensaje = "";


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_Insert_Presentacion", cn);

                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdProducto",
                    presentacion.IdProducto);

                cmd.Parameters.AddWithValue("@Nombre",
                    presentacion.Nombre);

                cmd.Parameters.AddWithValue("@Cantidad",
                    presentacion.Cantidad);



                object resultado = cmd.ExecuteScalar();


                if (resultado != null)
                    mensaje = resultado.ToString();

            }


            return mensaje;
        }

        // OBTENER POR ID
        public E_Presentacion ObtenerPresentacionPorId(int idPresentacion)
        {

            E_Presentacion presentacion = null;


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand(
                    "sp_GetPresentacionById", cn);

                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdPresentacion",
                    idPresentacion);



                SqlDataReader dr = cmd.ExecuteReader();



                if (dr.Read())
                {

                    presentacion = new E_Presentacion
                    {

                        IdPresentacion =
                        Convert.ToInt32(dr["IdPresentacion"]),


                        // viene del JOIN
                        IdProducto =Convert.ToInt32(dr["IdProducto"]),


                        Nombre =
                        dr["Presentacion"].ToString(),


                        Cantidad =
                        Convert.ToInt32(dr["Cantidad"])

                    };

                }

            }


            return presentacion;
        }

        // LISTAR
        public List<E_Presentacion> ListarPresentaciones()
        {

            List<E_Presentacion> lista = new List<E_Presentacion>();


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand(
                    "sp_GetPresentacion", cn);

                cmd.CommandType = CommandType.StoredProcedure;


                SqlDataReader dr = cmd.ExecuteReader();



                while (dr.Read())
                {

                    lista.Add(new E_Presentacion
                    {

                        IdPresentacion =
                        Convert.ToInt32(dr["IdPresentacion"]),



                        IdProducto =
                        Convert.ToInt32(dr["IdProducto"]),



                        Producto =
                        dr["Producto"].ToString(),



                        Nombre =
                        dr["Presentacion"].ToString(),



                        Cantidad =
                        Convert.ToInt32(dr["Cantidad"])

                    });

                }

            }


            return lista;
        }
        // ACTUALIZAR
        public bool ActualizarPresentacion(E_Presentacion presentacion)
        {


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {


                SqlCommand cmd = new SqlCommand(
                    "sp_Update_Presentacion", cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue("@IdPresentacion",
                    presentacion.IdPresentacion);


                cmd.Parameters.AddWithValue("@IdProducto",
                    presentacion.IdProducto);


                cmd.Parameters.AddWithValue("@Nombre",
                    presentacion.Nombre);


                cmd.Parameters.AddWithValue("@Cantidad",
                    presentacion.Cantidad);



                cmd.ExecuteNonQuery();


                return true;

            }

        }

        // ELIMINAR
        public bool EliminarPresentacion(int idPresentacion)
        {


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand(
                    "sp_Delete_Presentacion", cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue("@IdPresentacion",
                    idPresentacion);



                cmd.ExecuteNonQuery();


                return true;

            }

        }
    }
}
