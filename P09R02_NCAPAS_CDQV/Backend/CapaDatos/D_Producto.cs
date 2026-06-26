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
    public class D_Producto
    {
        // Aquí puedes agregar métodos para insertar, actualizar, eliminar y obtener productos
        public string InsertarProducto(E_Producto producto)
        {
            string mensaje = "";

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_Insert_Productos", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Nombre", producto.Nombre);
                cmd.Parameters.AddWithValue("@IdMarca", producto.IdMarca);
                cmd.Parameters.AddWithValue("@IdCategoria", producto.IdCategoria);
                cmd.Parameters.AddWithValue("@ContenidoML", producto.ContenidoML);
                cmd.Parameters.AddWithValue("@Activo", producto.Activo);

                object resultado = cmd.ExecuteScalar();

                if (resultado != null)
                    mensaje = resultado.ToString();
            }

            return mensaje;
        }



        // OBTENER POR ID
        public E_Producto ObtenerProductoPorId(int idProducto)
        {
            E_Producto producto = null;

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_GetProductosById", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProducto", idProducto);

                SqlDataReader dr = cmd.ExecuteReader();


                if (dr.Read())
                {
                    producto = new E_Producto
                    {
                        IdProducto = Convert.ToInt32(dr["IdProducto"]),
                        Nombre = dr["Nombre"].ToString(),
                        IdMarca = Convert.ToInt32(dr["IdMarca"]),
                        IdCategoria = Convert.ToInt32(dr["IdCategoria"]),
                        ContenidoML = Convert.ToInt32(dr["ContenidoML"]),
                        Activo = Convert.ToBoolean(dr["Activo"])
                    };
                }
            }

            return producto;
        }




        // LISTAR PRODUCTOS
        public List<E_Producto> ListarProductos()
        {
            List<E_Producto> lista = new List<E_Producto>();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("sp_GetProductos", cn);
                cmd.CommandType = CommandType.StoredProcedure;


                SqlDataReader dr = cmd.ExecuteReader();


                while (dr.Read())
                {

                    lista.Add(new E_Producto
                    {

                        IdProducto = Convert.ToInt32(dr["IdProducto"]),


                        Nombre = dr["Nombre"].ToString(),



                        IdMarca = Convert.ToInt32(dr["IdMarca"]),


                        Marca = dr["Marca"].ToString(),




                        IdCategoria = Convert.ToInt32(dr["IdCategoria"]),


                        Categoria = dr["Categoria"].ToString(),




                        ContenidoML = Convert.ToInt32(dr["ContenidoML"]),



                        Activo = Convert.ToBoolean(dr["Activo"])

                    });
                }
            }


            return lista;
        }




        // ACTUALIZAR
        public bool ActualizarProducto(E_Producto producto)
        {

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand("sp_Update_Producto", cn);
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdProducto",
                    producto.IdProducto);

                cmd.Parameters.AddWithValue("@Nombre",
                    producto.Nombre);

                cmd.Parameters.AddWithValue("@IdMarca",
                    producto.IdMarca);

                cmd.Parameters.AddWithValue("@IdCategoria",
                    producto.IdCategoria);

                cmd.Parameters.AddWithValue("@ContenidoML",
                    producto.ContenidoML);

                cmd.Parameters.AddWithValue("@Activo",
                    producto.Activo);



                cmd.ExecuteNonQuery();


                return true;
            }
        }




        // ELIMINAR
        public bool EliminarProducto(int idProducto)
        {

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {

                SqlCommand cmd = new SqlCommand("sp_Delete_Producto", cn);
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdProducto",
                    idProducto);


                cmd.ExecuteNonQuery();


                return true;
            }

        }
        public DataTable ListarProductosCombo()
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand(
                    "sp_GetProductos",
                    cn);

                cmd.CommandType = CommandType.StoredProcedure;


                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }

            return dt;
        }
    }
}
