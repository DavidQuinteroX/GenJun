using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using P15R01_MVC_CDQV;

namespace P15R01_MVC_CDQV.Controllers
{
    public class RutasController : Controller
    {
        private GenJunCCREntities db = new GenJunCCREntities();

        // GET: Rutas
        public ActionResult Index()
        {
            var rutas = db.Rutas.Include(r => r.Camiones).Include(r => r.Choferes);
            return View(rutas.ToList());
        }

        // GET: Rutas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Rutas rutas = db.Rutas.Find(id);
            if (rutas == null)
            {
                return HttpNotFound();
            }
            return View(rutas);
        }

        // GET: Rutas/Create
        public ActionResult Create()
        {
            ViewBag.IdCamion = new SelectList(db.Camiones, "IdCamion", "Matricula");
            ViewBag.IdChofer = new SelectList(db.Choferes, "IdChofer", "Nombre");
            return View();
        }

        // POST: Rutas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdRuta,IdChofer,IdCamion,Origen,Destino,FechaSalida,FechaLlegada,ATiempo,Distancia,FechaRegistro")] Rutas rutas)
        {
            if (ModelState.IsValid)
            {
                db.Rutas.Add(rutas);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdCamion = new SelectList(db.Camiones, "IdCamion", "Matricula", rutas.IdCamion);
            ViewBag.IdChofer = new SelectList(db.Choferes, "IdChofer", "Nombre", rutas.IdChofer);
            return View(rutas);
        }

        // GET: Rutas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Rutas rutas = db.Rutas.Find(id);
            if (rutas == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdCamion = new SelectList(db.Camiones, "IdCamion", "Matricula", rutas.IdCamion);
            ViewBag.IdChofer = new SelectList(db.Choferes, "IdChofer", "Nombre", rutas.IdChofer);
            return View(rutas);
        }

        // POST: Rutas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdRuta,IdChofer,IdCamion,Origen,Destino,FechaSalida,FechaLlegada,ATiempo,Distancia,FechaRegistro")] Rutas rutas)
        {
            if (ModelState.IsValid)
            {
                db.Entry(rutas).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdCamion = new SelectList(db.Camiones, "IdCamion", "Matricula", rutas.IdCamion);
            ViewBag.IdChofer = new SelectList(db.Choferes, "IdChofer", "Nombre", rutas.IdChofer);
            return View(rutas);
        }

        // GET: Rutas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Rutas rutas = db.Rutas.Find(id);
            if (rutas == null)
            {
                return HttpNotFound();
            }
            return View(rutas);
        }

        // POST: Rutas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Rutas rutas = db.Rutas.Find(id);
            db.Rutas.Remove(rutas);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
