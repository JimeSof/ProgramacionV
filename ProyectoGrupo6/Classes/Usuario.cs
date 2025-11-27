using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoGrupo6.Classes
{
    public class Usuario
    {
        public string nombreCompleto { get; set; }

        public int? idPersona { get; set; }
        public bool? esEmpleado {  get; set; }
        public int? acceso { get; set; }
    }
}