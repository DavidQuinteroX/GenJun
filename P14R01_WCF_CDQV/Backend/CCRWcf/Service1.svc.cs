using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;

namespace CCRWcf
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "Service1" en el código, en svc y en el archivo de configuración.
    // NOTE: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione Service1.svc o Service1.svc.cs en el Explorador de soluciones e inicie la depuración.
    
    public class Service1 : IService1
    {
        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }//fIN GetDataUsingDataContract

        public List<string> ObtenerCamiones()
        {
            List<string> camiones = new List<string>();
            //Obtener la cadena de conexion
            string connStr = ConfigurationManager.ConnectionStrings["ConexionSql"].ConnectionString;

            //Conectar con la BD
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                SqlCommand command = new SqlCommand("SELECT Matricula FROM Camiones", connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    camiones.Add(reader["Matricula"].ToString());
                }
            }
            return camiones;
        }//FIN camiones

        public List<string> ObtenerChoferes()
        {
            List<string> choferes = new List<string>();
            //Obtener la cadena de conexion
            string connStr = ConfigurationManager.ConnectionStrings["ConexionSql"].ConnectionString;

            //Conectar con la BD
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                SqlCommand command = new SqlCommand("SELECT Nombre FROM Choferes", connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    choferes.Add(reader["Nombre"].ToString());
                }
            }
            return choferes;
        }

        public List<string> ObtenerRutas()
        {
            List<string> rutas = new List<string>();
            //Obtener la cadena de conexion
            string connStr = ConfigurationManager.ConnectionStrings["ConexionSql"].ConnectionString;

            //Conectar con la BD
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                SqlCommand command = new SqlCommand("SELECT Origen FROM rutas", connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    rutas.Add(reader["Origen"].ToString());
                }
            }
            return rutas;
        }
    }//FIN Service1
}

