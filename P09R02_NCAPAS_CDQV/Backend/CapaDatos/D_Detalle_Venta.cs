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
    public class D_Detalle_Venta
    {
        // INSERTAR
        public string InsertarDetalle(E_Detalle_Venta detalle)
        {

            string mensaje = "";


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
                new SqlCommand(
                "sp_Insert_DetalleVenta",
                cn);


                cmd.CommandType =
                CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue(
                "@IdVenta",
                detalle.IdVenta);



                cmd.Parameters.AddWithValue(
                "@IdPresentacion",
                detalle.IdPresentacion);



                cmd.Parameters.AddWithValue(
                "@Cantidad",
                detalle.Cantidad);



                cmd.Parameters.AddWithValue(
                "@PrecioUnitario",
                detalle.PrecioUnitario);



                object resultado =
                cmd.ExecuteScalar();



                if (resultado != null)
                {
                    mensaje =
                    resultado.ToString();
                }

            }


            return mensaje;

        }

    



        // LISTAR DETALLE POR VENTA
        public List<E_Detalle_Venta> ObtenerDetallePorVenta(int idVenta)
        {

            List<E_Detalle_Venta> lista =
                new List<E_Detalle_Venta>();


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
                    new SqlCommand(
                    "sp_GetDetalleVentaByVenta",
                    cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue(
                    "@IdVenta",
                    idVenta);



                SqlDataReader dr =
                    cmd.ExecuteReader();



                while (dr.Read())
                {

                    lista.Add(
                        new E_Detalle_Venta
                        {

                            IdDetalleVenta =
                                Convert.ToInt32(
                                dr["IdDetalle_Venta"]),


                            IdVenta =
                                Convert.ToInt32(
                                dr["IdVenta"]),


                            IdPresentacion =
Convert.ToInt32(dr["IdPresentacion"]),


                            Cantidad =
                                Convert.ToInt32(
                                dr["Cantidad"]),


                            PrecioUnitario =
                                Convert.ToDecimal(
                                dr["PrecioUnitario"])

                        });

                }

            }


            return lista;

        }



        // ACTUALIZAR
        public bool ActualizarDetalleVenta(E_Detalle_Venta detalle)
        {

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
                    new SqlCommand(
                    "sp_Update_DetalleVenta",
                    cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue(
                    "@IdDetalle_Venta",
                    detalle.IdDetalleVenta);



                cmd.Parameters.AddWithValue(
                    "@IdPresentacion",
                    detalle.IdPresentacion);



                cmd.Parameters.AddWithValue(
                    "@Cantidad",
                    detalle.Cantidad);



                cmd.Parameters.AddWithValue(
                    "@PrecioUnitario",
                    detalle.PrecioUnitario);



                cmd.ExecuteNonQuery();


                return true;

            }

        }



        // ELIMINAR
        public bool EliminarDetalleVenta(int idDetalle)
        {

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
                    new SqlCommand(
                    "sp_Delete_DetalleVenta",
                    cn);


                cmd.CommandType =
                    CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue(
                    "@IdDetalle_Venta",
                    idDetalle);



                cmd.ExecuteNonQuery();


                return true;

            }

        }

    }
}
