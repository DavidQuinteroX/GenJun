using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidades;
namespace CapaNegocios
{
    public class N_Chofer
    {
        private D_Chofer objDatos = new D_Chofer();

        public List<E_Chofer> ListarChoferes(bool? disponibilidad = null)
        {
            try
            {
                return objDatos.ListarChoferes(disponibilidad);
            }
            catch (Exception ex)
            {
                throw new Exception("Error en capa de negocios " + ex.Message);
            }
        }
        public string InsertarChofer(E_Chofer chofer)
        {
            try
            {
                if (string.IsNullOrEmpty(chofer.Nombre))
                    return "El nombre es obligatorio";

                if (string.IsNullOrEmpty(chofer.ApPaterno))
                    return "El apellido paterno es obligatorio";

                if (string.IsNullOrEmpty(chofer.ApMaterno))
                    return "El apellido materno es obligatorio";

                if (string.IsNullOrEmpty(chofer.Telefono))
                    return "El teléfono es obligatorio";

                if (chofer.Telefono.Length != 10)
                    return "El teléfono debe tener 10 dígitos";

                if (string.IsNullOrEmpty(chofer.Licencia))
                    return "La licencia es obligatoria";

                int edad = DateTime.Now.Year - chofer.FechaNacimiento.Year;
                if (chofer.FechaNacimiento > DateTime.Now.AddYears(-edad))
                    edad--;

                if (edad < 18)
                    return "El chofer debe ser mayor de 18 años";

                if (objDatos.ExisteLicencia(chofer.Licencia))
                    return "Ya existe un chofer con esa licencia";

                // Valores por defecto de negocio
                if (chofer.FechaRegistro == DateTime.MinValue)
                    chofer.FechaRegistro = DateTime.Now;

                if (objDatos.InsertarChofer(chofer))
                    return "Ok";

                return "No se pudo insertar el chofer";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
        public string ActualizarChofer(E_Chofer chofer) 
        {
            try
            {
                if (string.IsNullOrEmpty(chofer.Nombre))
                    return "El nombre es obligatorio";

                if (chofer.Telefono.Length != 10)
                    return "El telefono debe tener 10 digitos";

                if (objDatos.ActualizarChofer(chofer))
                    return "Ok";
                else
                    return "No se pudo Actualizar el chofer";

            }
            catch (Exception ex)
            {
                {
                    return "Error: " + ex.Message;
                }
            }
        }

        public E_Chofer ObtenerChofer(int idChofer)
        {
            return objDatos.ObtenerChofer(idChofer);
        }

        public string EliminarChofer(int idchofer) 
        {
            try
            {

                if (objDatos.EliminarChofer(idchofer))
                    return "Ok";
                else
                    return "No se pudo insertar el Chofer";
            }
            catch (Exception ex)
            {
                return "Error : " + ex.Message;
            }

        }


       

    }
}
