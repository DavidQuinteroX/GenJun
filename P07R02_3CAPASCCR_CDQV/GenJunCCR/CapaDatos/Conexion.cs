using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class Conexion
    {
        private static string cadenaConexion = "Server=DEIBEAT;Database=GenJunCCR;User Id = sa; Password=15514154880;TrustServerCertificate=True;";
        //"Server=Maquina;Database=GenJunCCR;Trusted_Connection=True;";
        //"Data Source=DEIBEAT\\SQLEXPRESS;Initial Catalog=GenJunCCR;Integrated Security=True;TrustServerCertificate=True;";

        //Metodod para obtener conexion

        public static SqlConnection ObtenerConexion()
        {
            SqlConnection conn = new SqlConnection(cadenaConexion);
            try
            {
                conn.Open();
                return conn;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al conectar con la base de datos : " + ex.Message);
            }
    }
        //Metodo para probar la conexion

        public static bool ProbarConexion()
        {
            try
            {
                using(SqlConnection conn = ObtenerConexion())
                {
                    return conn.State == System.Data.ConnectionState.Open;
                }
            }
            catch
            {
                return false;
            }
        }
}
}
