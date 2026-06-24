using System.ComponentModel.DataAnnotations;

namespace apiGestores.Models
{
    public class Gestores_Bd
    {
        [Key]
        public int IdGestores { get; set; }
        public string Nombre { get; set; }
        public int Lazamiento { get; set; }

        public string Desarrollador { get; set; }

    }
}
