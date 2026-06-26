using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;

namespace CapaNegocios
{
    public class N_MovimientoInventario
    {
        D_MovimientoInventario datos =
            new D_MovimientoInventario();

        // INSERTAR
        public string InsertarMovimiento(
            E_Movimiento_Inventario movimiento)
        {
            return datos.InsertarMovimiento(movimiento);
        }

        // OBTENER POR ID
        public E_Movimiento_Inventario ObtenerMovimientoPorId(
            int idMovimiento)
        {
            return datos.ObtenerMovimientoPorId(idMovimiento);
        }

        // LISTAR
        public List<E_Movimiento_Inventario> ListarMovimientos()
        {
            return datos.ListarMovimientos();
        }

        // ACTUALIZAR
        public bool ActualizarMovimiento(
            E_Movimiento_Inventario movimiento)
        {
            return datos.ActualizarMovimiento(movimiento);
        }

        // ELIMINAR
        public bool EliminarMovimiento(int idMovimiento)
        {
            return datos.EliminarMovimiento(idMovimiento);
        }

        public List<E_Presentacion> ListarPresentaciones()
        {
            return datos.ListarPresentaciones();
        }
    }
}

