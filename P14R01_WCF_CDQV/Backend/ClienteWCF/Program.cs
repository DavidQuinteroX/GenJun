using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClienteWCF.ServiceReference1;//Importa el espacio de nombres del servicio WCF
namespace ClienteWCF
{
    public class Program
    {
        static void Main(string[] args)
        {
            //Crear una instancia del cliente WCF
            Service1Client client = new Service1Client();
            try
            {
                //Llamar al método ObtenerUsuarios del servicio WCF
                string[] usuarios = client.ObtenerUsuarios();
                Console.WriteLine("Usuarios obtenidos del servicio WCF:");
                foreach (string usuario in usuarios)
                {
                    Console.WriteLine("--" + usuario);
                }
                //Cerrar el cliente WCF
                client.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al llamar al servicio WCF: " + ex.Message);
             
            }
          
            Console.WriteLine("Presione cualquier tecla para salir...");
            Console.ReadKey();
        }
    }
}
