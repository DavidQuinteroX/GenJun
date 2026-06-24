using apiGestores.Context;
using apiGestores.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace apiGestores.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class GestoresController : ControllerBase
    {
        private readonly AppDbContext context;
        public GestoresController(AppDbContext context)
        {
            this.context = context;
        }

        //Get:api/<GestoresController>
        [HttpGet]
        public ActionResult Get()
        {
            try
            {
                return Ok(context.Gestores_Bd.ToList());
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        //GET api/<GestoresController>/5
        [HttpGet("{id}", Name = "GetGestor")]
        public ActionResult Get(int id)
        {
            try
            {
                var gestor = context.Gestores_Bd.FirstOrDefault(gestor => gestor.IdGestores == id);
                return Ok(gestor);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }


        //POST api/<GestoresController>
        [HttpPost]
        public ActionResult Post([FromBody] Gestores_Bd gestor)
        {
            try
            {
                context.Gestores_Bd.Add(gestor);
                context.SaveChanges();

                return CreatedAtRoute(
                    "GetGestor",
                    new { id = gestor.IdGestores },
                    gestor
                );
            }
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    mensaje = ex.Message,
                    inner = ex.InnerException?.Message
                });
            }
        }

        //PUT api/<GestoresController>/5
        [HttpPut("{id}")]
        public ActionResult Put(int id, [FromBody] Gestores_Bd gestor)
        {
            try
            {
                if (gestor.IdGestores == id)
                {
                    context.Entry(gestor).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
                    context.SaveChanges();
                    return CreatedAtRoute("GetGestor", new { id = gestor.IdGestores }, gestor);
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        //DELETE api/<GestoresController
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            try
            {
                var gestor = context.Gestores_Bd.FirstOrDefault(g => g.IdGestores == id);
                if (gestor != null)
                {
                    context.Gestores_Bd.Remove(gestor);
                    context.SaveChanges();
                    return Ok(id);
                }
                else
                {
                    return BadRequest();
                }
            }
            catch
            {
                return BadRequest();
            }

        }


    }//Fin de  la clase
}
