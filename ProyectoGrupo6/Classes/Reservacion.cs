using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoGrupo6.Classes
{
    public class Reservacion
    {
        public int idHotel { get; set; }
        public int idHabitacion { get; set; }
        public decimal precioAdulto { get; set; }
        public decimal precioNinho { get; set; }
    }
}