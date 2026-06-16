using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidades;

namespace CapaNegocios
{
    public class N_Ruta
    {
        private D_Ruta objDatos = new D_Ruta();

        public List<E_Ruta> ListarRutas()
        {
            try
            {
                return objDatos.ListarRutas();
            }
            catch (Exception ex)
            {
                throw new Exception("Error en negocio (ListarRutas): " + ex.Message);
            }
        }
        public string InsertarRuta(E_Ruta ruta)
        {
            try
            {
                if (string.IsNullOrEmpty(ruta.Origen))
                    return "El origen es obligatorio";

                if (string.IsNullOrEmpty(ruta.Destino))
                    return "El destino es obligatorio";

                if (ruta.FechaSalida >= ruta.FechaLlegada)
                    return "La fecha de llegada debe ser posterior a la salida";

                if (ruta.Distancia <= 0)
                    return "La distancia debe ser mayor a 0";

                if (ruta.IdCamion <= 0)
                    return "Debe seleccionar un camión";

                if (ruta.IdChofer <= 0)
                    return "Debe seleccionar un chofer";

                bool ok = objDatos.InsertarRuta(ruta);

                return ok ? "Ok" : "No se pudo insertar la ruta";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        public string ActualizarRuta(E_Ruta ruta)
        {
            try
            {
                if (ruta.FechaSalida >= ruta.FechaLlegada)
                    return "La fecha de llegada debe ser posterior a la fecha de salida";

                if (ruta.Distancia <= 0)
                    return "La distancia debe ser mayor a 0";

                if (objDatos.ActualizarRuta(ruta))
                    return "Ok";
                else
                    return "No se pudo actualizar la ruta";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        public string EliminarRuta(int idruta)
        {
            try
            {
                if (idruta <= 0)
                    return "Id inválido";

                if (objDatos.EliminarRuta(idruta))
                    return "Ok";
                else
                    return "No se pudo eliminar la ruta";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }
    }
}
