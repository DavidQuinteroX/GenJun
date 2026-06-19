using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClienteCCRWcf.ServiceReference1;//Importa el espacio de nombres del servicio WCF
namespace ClienteCCRWcf
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Crear una instancia del cliente WCF
            Service1Client client = new Service1Client();
            try
            {
                //Llamar al método ObtenerUsuarios del servicio WCF
                string[] camiones = client.ObtenerCamiones();
                string[] choferes = client.ObtenerChoferes();
                string[] rutas = client.ObtenerRutas();
                Console.WriteLine("camiones obtenidos del servicio WCF:");
              
                foreach (string camion in camiones)
                {
                    Console.WriteLine("--" + camion);
                }
                Console.WriteLine("choferes obtenidos del servicio WCF:");
                foreach (string chorfer in choferes)
                {
                    Console.WriteLine("==CHOFERES" );
                    Console.WriteLine("--" + chorfer);
                }


                Console.WriteLine("Rutas obtenidos del servicio WCF:");
                foreach (string ruta in rutas)
                {
                    Console.WriteLine("==Rutas");
                    Console.WriteLine("--" + ruta);
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

