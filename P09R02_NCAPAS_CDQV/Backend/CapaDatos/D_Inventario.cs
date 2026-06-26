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
    public class D_Inventario
    {
        // INSERTAR
        public string InsertarInventario(E_Inventario inventario)
        {
            string mensaje = "";


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand(
                    "sp_Insert_Inventario", cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue("@IdPresentacion",
                    inventario.IdPresentacion);


                cmd.Parameters.AddWithValue("@Existencia",
                    inventario.Existencia);



                object resultado =
                    cmd.ExecuteScalar();



                if (resultado != null)
                    mensaje = resultado.ToString();

            }


            return mensaje;
        }






        // OBTENER POR ID
        public E_Inventario ObtenerInventarioPorId(int idInventario)
        {

            E_Inventario inventario = null;



            using (SqlConnection cn = Conexion.ObtenerConexion())
            {


                SqlCommand cmd = new SqlCommand(
                    "sp_GetInventarioById", cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue(
                    "@IdInventario", idInventario);



                SqlDataReader dr =
                    cmd.ExecuteReader();



                if (dr.Read())
                {

                    inventario = new E_Inventario
                    {

                        IdInventario =
     Convert.ToInt32(dr["IdInventario"]),


                        IdPresentacion =
     Convert.ToInt32(dr["IdPresentacion"]),


                        Presentacion =
     dr["Presentacion"].ToString(),


                        Existencia =
     Convert.ToInt32(dr["Existencia"])

                    };

                }

            }


            return inventario;

        }







        // LISTAR
        public List<E_Inventario> ListarInventario()
        {


            List<E_Inventario> lista =
                new List<E_Inventario>();



            using (SqlConnection cn = Conexion.ObtenerConexion())
            {


                SqlCommand cmd = new SqlCommand(
                    "sp_GetInventario", cn);



                cmd.CommandType =
                    CommandType.StoredProcedure;



                SqlDataReader dr =
                    cmd.ExecuteReader();




                while (dr.Read())
                {
                    lista.Add(new E_Inventario
                    {

                        IdInventario =
                        Convert.ToInt32(dr["IdInventario"]),


                        IdPresentacion =
                        Convert.ToInt32(dr["IdPresentacion"]),


                        Producto =
                        dr["Producto"].ToString(),


                        Marca =
                        dr["Marca"].ToString(),


                        Presentacion =
                        dr["Presentacion"].ToString(),


                        Existencia =
                        Convert.ToInt32(dr["Existencia"])

                    });
                }


            }
            return lista;

        }


        // ACTUALIZAR
        public bool ActualizarInventario(E_Inventario inventario)
        {


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {


                SqlCommand cmd = new SqlCommand(
                    "sp_Update_Inventario", cn);



                cmd.CommandType =
                    CommandType.StoredProcedure;




                cmd.Parameters.AddWithValue("@IdInventario",inventario.IdInventario);
                cmd.Parameters.AddWithValue("@IdPresentacion",inventario.IdPresentacion);
                cmd.Parameters.AddWithValue("@Existencia",inventario.Existencia);
                cmd.ExecuteNonQuery();
                return true;


            }

        }

        // ELIMINAR
        public bool EliminarInventario(int idInventario)
        {


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Delete_Inventario", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@IdInventario",idInventario);
                cmd.ExecuteNonQuery();
                return true;
            }


        }

    }
}
