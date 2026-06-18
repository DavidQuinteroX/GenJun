using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace P15R01_MVC_CDQV.Models.DTOs
{
    public class ChoferDTO
    {
        [Key]
        public int IdChofer { get; set; }


        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(50, ErrorMessage = "El nombre no puede superar los 50 caracteres")]
        [Display(Name = "Nombre")]
        public string Nombre { get; set; }


        [Required(ErrorMessage = "El apellido paterno es obligatorio")]
        [StringLength(50, ErrorMessage = "El apellido paterno no puede superar los 50 caracteres")]
        [Display(Name = "Apellido Paterno")]
        public string ApPaterno { get; set; }


        [Required(ErrorMessage = "El apellido materno es obligatorio")]
        [StringLength(50, ErrorMessage = "El apellido materno no puede superar los 50 caracteres")]
        [Display(Name = "Apellido Materno")]
        public string ApMaterno { get; set; }


        [Required(ErrorMessage = "El teléfono es obligatorio")]
        [Phone(ErrorMessage = "Ingrese un teléfono válido")]
        [StringLength(15, ErrorMessage = "El teléfono no puede superar los 15 caracteres")]
        [Display(Name = "Teléfono")]
        public string Telefono { get; set; }


        [Required(ErrorMessage = "La fecha de nacimiento es obligatoria")]
        [DataType(DataType.Date)]
        [Display(Name = "Fecha de Nacimiento")]
        public DateTime FechaNacimiento { get; set; }


        [Required(ErrorMessage = "La licencia es obligatoria")]
        [StringLength(20, ErrorMessage = "La licencia no puede superar los 20 caracteres")]
        [Display(Name = "Licencia")]
        public string Licencia { get; set; }


        [Url(ErrorMessage = "Ingrese una URL válida")]
        [Display(Name = "Foto")]
        public string UrlFoto { get; set; }


        [Display(Name = "Disponible")]
        public bool Disponibilidad { get; set; }


        [Required(ErrorMessage = "La fecha de registro es obligatoria")]
        [DataType(DataType.Date)]
        [Display(Name = "Fecha de Registro")]
        public DateTime FechaRegistro
        {
            get; set;
        }
    }
}