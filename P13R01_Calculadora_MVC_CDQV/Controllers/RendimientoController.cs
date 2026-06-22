using Microsoft.AspNetCore.Mvc;
using P12R01_Calculadora_MVC_CDQV.Models;

namespace P12R01_Calculadora_MVC_CDQV.Controllers
{
    public class RendimientoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Calcular(RendimientoModel modelo)
        {
            if (modelo.Litros <= 0)
            {
                ModelState.AddModelError("", "Los litros deben ser mayores que cero.");
                return View("Index", modelo);
            }

            modelo.Rendimiento =
                modelo.Kilometros / modelo.Litros;

            return View("Index", modelo);
        }
    }
}