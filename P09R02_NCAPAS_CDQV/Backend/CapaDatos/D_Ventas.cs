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
    public class D_Ventas
    {
        // INSERTAR
        public string InsertarVenta(E_Ventas venta)
        {
            string mensaje = "";

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_Insert_Venta",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdCliente",
                    venta.IdCliente);

                cmd.Parameters.AddWithValue(
                    "@Fecha",
                    venta.Fecha);

                cmd.Parameters.AddWithValue(
                    "@Total",
                    venta.Total);

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
        public E_Ventas ObtenerVentaPorId(int idVenta)
        {
            E_Ventas venta = null;

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_GetVentaById",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdVenta",
                    idVenta);

                SqlDataReader dr =
                    cmd.ExecuteReader();

                if (dr.Read())
                {
                    venta = new E_Ventas
                    {
                        IdVenta =
         Convert.ToInt32(dr["IdVenta"]),

                        IdCliente =
         Convert.ToInt32(dr["IdCliente"]),

                        Fecha =
         Convert.ToDateTime(dr["Fecha"]),

                        Total =
         Convert.ToDecimal(dr["Total"]),

                        Cliente =
         dr["Cliente"].ToString()
                    };
                }
            }

            return venta;
        }

        // LISTAR
        public List<E_Ventas> ListarVentas()
        {
            List<E_Ventas> lista =
                new List<E_Ventas>();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_GetVentas",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                SqlDataReader dr =
                    cmd.ExecuteReader();

                while (dr.Read())
                {
                    lista.Add(
    new E_Ventas
    {
        IdVenta =
            Convert.ToInt32(dr["IdVenta"]),

        IdCliente =
            Convert.ToInt32(dr["IdCliente"]),

        Fecha =
            Convert.ToDateTime(dr["Fecha"]),

        Total =
            Convert.ToDecimal(dr["Total"]),

        Cliente =
            dr["Cliente"].ToString()
    });
                }
            }

            return lista;
        }

        // ACTUALIZAR
        public bool ActualizarVenta(E_Ventas venta)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_Update_Venta",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdVenta",
                    venta.IdVenta);

                cmd.Parameters.AddWithValue(
                    "@IdCliente",
                    venta.IdCliente);

                cmd.Parameters.AddWithValue(
                    "@Fecha",
                    venta.Fecha);

                cmd.Parameters.AddWithValue(
                    "@Total",
                    venta.Total);

                cmd.ExecuteNonQuery();

                return true;
            }
        }

        // ELIMINAR
        public bool EliminarVenta(int idVenta)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd =
                    new SqlCommand(
                        "sp_Delete_Venta",
                        cn);

                cmd.CommandType =
                    CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdVenta",
                    idVenta);

                cmd.ExecuteNonQuery();

                return true;
            }
        }

        public int InsertarVentaRetornaId(E_Ventas venta)
        {
            int idVenta = 0;


            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
                new SqlCommand(
                "sp_Insert_VentaDetalle",
                cn);


                cmd.CommandType =
                CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue(
                "@IdCliente",
                venta.IdCliente);


                cmd.Parameters.AddWithValue(
                "@Fecha",
                venta.Fecha);


                cmd.Parameters.AddWithValue(
                "@Total",
                venta.Total);



                object resultado =
                cmd.ExecuteScalar();



                if (resultado != null)
                {
                    idVenta =
                    Convert.ToInt32(resultado);
                }

            }


            return idVenta;
        }
    }
}
