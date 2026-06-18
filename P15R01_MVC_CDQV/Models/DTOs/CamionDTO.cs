using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace P15R01_MVC_CDQV.Models.DTOs
{
    public class CamionDTO
    {
        [Key]
        public int IdCamion { get; set; }


        [Required(ErrorMessage = "La matrícula es obligatoria")]
        [StringLength(10, ErrorMessage = "La matrícula no puede superar los 10 caracteres")]
        [Display(Name = "Matrícula")]
        public string Matricula { get; set; }


        [Required(ErrorMessage = "El tipo de camión es obligatorio")]
        [StringLength(50)]
        [Display(Name = "Tipo de Camión")]
        public string TipoCamion { get; set; }


        [Required(ErrorMessage = "El modelo es obligatorio")]
        [Range(1900, 2100, ErrorMessage = "Ingrese un modelo válido")]
        [Display(Name = "Modelo")]
        public int Modelo { get; set; }


        [Required(ErrorMessage = "La marca es obligatoria")]
        [StringLength(50)]
        [Display(Name = "Marca")]
        public string Marca { get; set; }


        [Required(ErrorMessage = "La capacidad es obligatoria")]
        [Range(1, 100, ErrorMessage = "La capacidad debe estar entre 1 y 100 toneladas")]
        [Display(Name = "Capacidad")]
        public int Capacidad { get; set; }


        [Required(ErrorMessage = "El kilometraje es obligatorio")]
        [Range(0, double.MaxValue, ErrorMessage = "El kilometraje no puede ser negativo")]
        [Display(Name = "Kilometraje")]
        public double Kilometraje { get; set; }


        [Display(Name = "Disponible")]
        public bool Disponibilidad { get; set; }


        [Url(ErrorMessage = "Ingrese una URL válida")]
        [Display(Name = "Foto")]
        public string UrlFoto { get; set; }
    }
}
