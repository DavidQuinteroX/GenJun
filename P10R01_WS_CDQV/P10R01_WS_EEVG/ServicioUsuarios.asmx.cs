using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;

namespace P10R01_WS_EEVG
{
    /// <summary>
    /// Descripción breve de ServicioUsuarios
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class ServicioUsuarios : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }

        // Método con parámetros
        [WebMethod]
        public string Saludar(string nombre)
        {
            return "Hola " + nombre + "!";
        }

        // Método que retorna suma
        [WebMethod]
        public int Sumar(int a, int b)
        {
            return a + b;
        }

        [WebMethod]
        public List<string> ObtenerUsuarios() {
            List<string> usuarios = new List<string>();
            string connStr = ConfigurationManager
                .ConnectionStrings["ConexionSQL"]
                .ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT Nombre FROM Usuarios ORDER BY Nombre",
                    conn
                );

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    usuarios.Add(reader["Nombre"].ToString());
                }
            }

            return usuarios;
        }


        [WebMethod]
        public bool AgregarUsuario(string nombre)
        {
            if (string.IsNullOrWhiteSpace(nombre))
                return false;

            try
            {
                string connStr = ConfigurationManager
                    .ConnectionStrings["ConexionSQL"]
                    .ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Usuarios (Nombre) VALUES (@Nombre)",
                        conn
                    );

                    cmd.Parameters.AddWithValue("@Nombre", nombre);

                    conn.Open();
                    int filasAfectas = cmd.ExecuteNonQuery();

                    return filasAfectas > 0;
                }
            }
            catch
            {
                return false;
            }
        }

        [WebMethod]
        public UsuarioInfo ObtenerUsuarioPorId(int id)
        {
            UsuarioInfo usuario = null;

            string connStr = ConfigurationManager
                .ConnectionStrings["ConexionSQL"]
                .ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT Id, Nombre, FechaRegistro FROM Usuarios WHERE Id = @Id",
                    conn
                );
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    usuario = new UsuarioInfo
                    {
                        Id = (int)reader["Id"],
                        Nombre = reader["Nombre"].ToString(),
                        FechaRegistro = (DateTime)reader["FechaRegistro"]
                    };
                }
            }

            return usuario;
        }
    }

    [Serializable]
    public class UsuarioInfo
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public DateTime FechaRegistro { get; set; }
    }
}
