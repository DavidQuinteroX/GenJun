using apiGestores.Models;
using Microsoft.EntityFrameworkCore;

namespace apiGestores.Context
{
    public class AppDbContext:DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options): base(options) 
        {

        
        }

        //Sirve para modificar y consultar los registros
        public DbSet<Gestores_Bd> Gestores_Bd { get; set; }
    }
}
