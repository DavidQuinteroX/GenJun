using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace P15R01_MVC_CDQV.Models.DTOs
{
    public class RutaDTO
    {
        [Key]
        public int IdRuta { get; set; }


        [Required(ErrorMessage = "Debe seleccionar un chofer")]
        [Display(Name = "Chofer")]
        public int IdChofer { get; set; }


        [Required(ErrorMessage = "Debe seleccionar un camión")]
        [Display(Name = "Camión")]
        public int IdCamion { get; set; }


        [Required(ErrorMessage = "El origen es obligatorio")]
        [StringLength(100, ErrorMessage = "El origen no puede superar los 100 caracteres")]
        [Display(Name = "Origen")]
        public string Origen { get; set; }


        [Required(ErrorMessage = "El destino es obligatorio")]
        [StringLength(100, ErrorMessage = "El destino no puede superar los 100 caracteres")]
        [Display(Name = "Destino")]
        public string Destino { get; set; }


        [Required(ErrorMessage = "La fecha de salida es obligatoria")]
        [DataType(DataType.DateTime)]
        [Display(Name = "Fecha de Salida")]
        public DateTime FechaSalida { get; set; }


        [Required(ErrorMessage = "La fecha de llegada es obligatoria")]
        [DataType(DataType.DateTime)]
        [Display(Name = "Fecha de Llegada")]
        public DateTime FechaLlegada { get; set; }


        [Display(Name = "A tiempo")]
        public bool ATiempo { get; set; }


        [Required(ErrorMessage = "La distancia es obligatoria")]
        [Range(0.1, double.MaxValue, ErrorMessage = "La distancia debe ser mayor a 0")]
        [Display(Name = "Distancia (Km)")]
        public double Distancia { get; set; }


        [Required(ErrorMessage = "La fecha de registro es obligatoria")]
        [DataType(DataType.DateTime)]
        [Display(Name = "Fecha de Registro")]
        public DateTime FechaRegistro { get; set; }
    }
}