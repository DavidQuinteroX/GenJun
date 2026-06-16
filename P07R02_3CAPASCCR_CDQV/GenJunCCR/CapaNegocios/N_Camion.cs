using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidades;

namespace CapaNegocios
{
    public class N_Camion
    {
        private D_Camion objDatos = new D_Camion();

        public List<E_Camion> ListarCamiones(bool ? disponibilidad = null)
        {
            try
            {
                return objDatos.ListarCamiones(disponibilidad);
            }
            catch (Exception ex)
            {
                throw new Exception("Error en capa de negocios "+ ex.Message);
            }
    }

        public string InsertarCamion(E_Camion camion)
        {
            try
            {
                //validaciones de negocio
                if (string.IsNullOrEmpty(camion.Matricula))
                    return "La matricula es obligatoria";

                if (string.IsNullOrEmpty(camion.TipoCamion))
                    return "El tipo de camion es obligatorio";

                if (camion.Modelo < 1900 || camion.Modelo > DateTime.Now.Year + 1)
                    return "El modelo debe estar entre 1900 y " + (DateTime.Now.Year + 1);

                if (string.IsNullOrEmpty(camion.Marca))
                    return "La marca es obligatoria";

                if (camion.Capacidad <= 0)
                    return "La capacidad debe ser mayor a 0";

                if (camion.Kilometraje < 0)
                    return "El kilometraje  no piede ser negativo";

                //Verificar si existe la matricula
                if (objDatos.InsertarCamion(camion))
                    return "Ok";
                else
                    return "No se pudo insertar el camion";
            }
            catch (Exception ex) 
            {
                return "Error : " + ex.Message;
            }
        }

        public string ActualizarCamion(E_Camion camion)
        {
            try
            {
                //validaciones similarees al insertar
                if (string.IsNullOrEmpty(camion.Matricula))
                    return "La matricula es obligatoria";

                if (camion.Modelo < 1900 || camion.Modelo > DateTime.Now.Year + 1)
                    return "El modelo debe estar entre 1900 y " + (DateTime.Now.Year + 1);

                if (camion.Capacidad <= 0)
                    return "La capacidad debe ser mayor a 0";

                if (objDatos.ActualizarCamion(camion))
                    return "Ok";
                else
                    return "No se pudo insertar el camion";
            }
            catch (Exception ex)
            {
                return "Error : " + ex.Message;
            }

        }
        public string EliminiarCamion(int idCamion)
        {
            try
            {

                if (objDatos.EliminarCamion(idCamion))
                    return "Ok";
                else
                    return "No se pudo insertar el camion";
            }
            catch (Exception ex)
            {
                return "Error : " + ex.Message;
            }
        }
        
        public E_Camion ObtenerCamionPorId(int idCamion)
        {
            try
            {
                return objDatos.ObternerCamionPorID(idCamion);
            }
            catch (Exception ex)
            {
                throw new Exception("Error :" + ex.Message);
            }
        }
    }
}
