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
    public class D_MovimientoInventario
    {
        // INSERTAR
        public string InsertarMovimiento(E_Movimiento_Inventario movimiento)
        {
            string mensaje = "";

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_Insert_Movimientos_Inventario", cn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdPresentacion",
                    movimiento.IdPresentacion);

                cmd.Parameters.AddWithValue("@TipoMovimiento",
                    movimiento.TipoMovimiento);

                cmd.Parameters.AddWithValue("@Cantidad",
                    movimiento.Cantidad);

                cmd.Parameters.AddWithValue("@Fecha",
                    movimiento.Fecha);

                cmd.Parameters.AddWithValue("@Motivo",
                    movimiento.Motivo);

                object resultado = cmd.ExecuteScalar();

                if (resultado != null)
                    mensaje = resultado.ToString();
            }

            return mensaje;
        }

        // OBTENER POR ID
        public E_Movimiento_Inventario ObtenerMovimientoPorId(int idMovimiento)
        {
            E_Movimiento_Inventario movimiento = null;

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_GetMovimientoById", cn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdMovimiento_Inventario",
                    idMovimiento);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    movimiento = new E_Movimiento_Inventario
                    {
                        IdMovimiento_Inventario =
                            Convert.ToInt32(dr["IdMovimientos_Inventario"]),
                        IdPresentacion =Convert.ToInt32(dr["IdPresentacion"]),
                        Producto =
                            dr["Producto"].ToString(),

                        Presentacion =
                            dr["Presentacion"].ToString(),

                        TipoMovimiento =
                            dr["TipoMovimiento"].ToString(),

                        Cantidad =
                            Convert.ToInt32(dr["Cantidad"]),

                        Fecha =
                            Convert.ToDateTime(dr["Fecha"]),

                        Motivo =
                            dr["Motivo"].ToString()
                    };
                }
            }

            return movimiento;
        }

        // LISTAR
        public List<E_Movimiento_Inventario> ListarMovimientos()
        {
            List<E_Movimiento_Inventario> lista =
                new List<E_Movimiento_Inventario>();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_GetMovimientos_Inventario", cn);

                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    lista.Add(new E_Movimiento_Inventario
                    {
                        IdMovimiento_Inventario =
                            Convert.ToInt32(dr["IdMovimientos_Inventario"]),

                        Producto =
                            dr["Producto"].ToString(),

                        Presentacion =
                            dr["Presentacion"].ToString(),

                        TipoMovimiento =
                            dr["TipoMovimiento"].ToString(),

                        Cantidad =
                            Convert.ToInt32(dr["Cantidad"]),

                        Fecha =
                            Convert.ToDateTime(dr["Fecha"]),

                        Motivo =
                            dr["Motivo"].ToString()
                    });
                }
            }

            return lista;
        }

        // ACTUALIZAR
        public bool ActualizarMovimiento(
            E_Movimiento_Inventario movimiento)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_Update_Movimiento_Inventario", cn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdMovimiento_Inventario",
                    movimiento.IdMovimiento_Inventario);

                cmd.Parameters.AddWithValue(
                    "@IdPresentacion",
                    movimiento.IdPresentacion);

                cmd.Parameters.AddWithValue(
                    "@TipoMovimiento",
                    movimiento.TipoMovimiento);

                cmd.Parameters.AddWithValue(
                    "@Cantidad",
                    movimiento.Cantidad);

                cmd.Parameters.AddWithValue(
                    "@Fecha",
                    movimiento.Fecha);

                cmd.Parameters.AddWithValue(
                    "@Motivo",
                    movimiento.Motivo);

                cmd.ExecuteNonQuery();

                return true;
            }
        }

        // ELIMINAR
        public bool EliminarMovimiento(int idMovimiento)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_Delete_Movimiento_Inventario", cn);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue(
                    "@IdMovimiento_Inventario",
                    idMovimiento);

                cmd.ExecuteNonQuery();

                return true;
            }
        }

        public List<E_Presentacion> ListarPresentaciones()
        {
            List<E_Presentacion> lista =
                new List<E_Presentacion>();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd =
                new SqlCommand(
                "sp_GetPresentacionesCombo",
                cn);


                cmd.CommandType =
                CommandType.StoredProcedure;


                SqlDataReader dr =
                cmd.ExecuteReader();


                while (dr.Read())
                {

                    lista.Add(new E_Presentacion
                    {

                        IdPresentacion =
                        Convert.ToInt32(
                        dr["IdPresentacion"]),

                        Producto =
                        dr["Producto"].ToString(),

                        Presentacion =
                        dr["Presentacion"].ToString()

                    });

                }

            }


            return lista;
        }
    }
}
