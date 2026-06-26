using CapaDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocios
{
    public class N_Presentacion
    {
        D_Presentacion datos = new D_Presentacion();



        // INSERTAR
        public string InsertarPresentacion(E_Presentacion presentacion)
        {

            return datos.InsertarPresentacion(presentacion);

        }




        // OBTENER POR ID
        public E_Presentacion ObtenerPresentacionPorId(int idPresentacion)
        {

            return datos.ObtenerPresentacionPorId(idPresentacion);

        }




        // LISTAR
        public List<E_Presentacion> ListarPresentaciones()
        {

            return datos.ListarPresentaciones();

        }





        // ACTUALIZAR
        public bool ActualizarPresentacion(E_Presentacion presentacion)
        {

            return datos.ActualizarPresentacion(presentacion);

        }


        // ELIMINAR
        public bool EliminarPresentacion(int idPresentacion)
        {

            return datos.EliminarPresentacion(idPresentacion);

        }
    }
}
