using Microsoft.AspNetCore.Mvc;
using P12R01_Calculadora_MVC_CDQV.Models;

namespace P12R01_Calculadora_MVC_CDQV.Controllers
{
    public class CalculadoraController : Controller
    {
        public IActionResult Index()
        {
            return View(new CalculadoraModel());
        }

        //POST CALCUALDORA CALCULAR
        [HttpPost]
        public IActionResult Calcular(CalculadoraModel modelo)
        {
            if (ModelState.IsValid)
            {
                modelo.Calcular();

                if (modelo.Resultado == null && modelo.Operacion == "dividir")
                {
                    ViewBag.Error = "No se pude dividir por cero";
                }
            }

            return View("Index",modelo);
        }

        //GET: CALCULADORA/LIMPIAR
        public IActionResult Limpiar()
        {
            return RedirectToAction("Index");
        }
}
}
