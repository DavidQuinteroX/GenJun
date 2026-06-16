using System.ComponentModel.DataAnnotations;

namespace P12R01_Calculadora_MVC_CDQV.Models
{
    public class CalculadoraModel
    {
        [Required(ErrorMessage ="El primer numero es requerido")]
        [Display(Name = "Primer Numero")]

        public double Numero1 { get; set; }
        public double Numero2 { get; set; }
        public string Operacion { get; set; }
        public double? Resultado { get; set; }


        public void Calcular()
        {
            switch (Operacion)
            {
                case "sumar":
                    Resultado = Numero1 + Numero2; 
                    break;
                case "restar":
                    Resultado = Numero1 - Numero2; 
                    break;
                case "multiplicar":
                    Resultado = Numero1 * Numero2; 
                    break;
                case "dividir":
                    if(Numero2 != 0)
                        Resultado = Numero1 / Numero2;
                    else 
                        Resultado = null;
                    break;
                default:
                    Resultado = null;
                    break;

            }
        }


    }
}
