<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Choferes.aspx.cs" Inherits="CamionesWeb.Choferes"  MasterPageFile="~/Site.Master" %>

<asp:Content
    ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">
    <link href="/Content/Choferes/Choferes.css"
      rel="stylesheet" />

   
    <!-- ===================== HEADER ===================== -->
<header class="app-header">
  <div class="container-fluid">
    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
      <div class="d-flex align-items-center gap-3">
        <div class="header-icon">
          <i class="fa-solid fa-id-card-clip"></i>
        </div>
        <div>
          <h1 class="header-title mb-0">Gestión de Choferes</h1>
          <p class="header-subtitle mb-0">Administración de Personal Operativo</p>
        </div>
      </div>
      <div class="system-status">
        <span class="status-dot"></span>
        <span>Sistema Operativo</span>
        <span class="status-time" id="systemTime">--:--:--</span>
      </div>
    </div>
  </div>
</header>

<main class="container-fluid py-4">

  <!-- ===================== KPIs ===================== -->
  <section class="row g-3 mb-4">
    <div class="col-12 col-sm-6 col-xl-3">
      <div class="kpi-card kpi-total">
        <div class="kpi-icon"><i class="fa-solid fa-user-tie"></i></div>
        <div class="kpi-body">
          <span class="kpi-title">Total de Choferes</span>
          <span class="kpi-value" id="kpiTotal">0</span>
          <span class="kpi-desc">Personal registrado en el sistema</span>
        </div>
      </div>
    </div>
    <div class="col-12 col-sm-6 col-xl-3">
      <div class="kpi-card kpi-available">
        <div class="kpi-icon"><i class="fa-solid fa-circle-check"></i></div>
        <div class="kpi-body">
          <span class="kpi-title">Disponibles</span>
          <span class="kpi-value" id="kpiAvailable">0</span>
          <span class="kpi-desc">Listos para asignación</span>
        </div>
      </div>
    </div>
    <div class="col-12 col-sm-6 col-xl-3">
      <div class="kpi-card kpi-route">
        <div class="kpi-icon"><i class="fa-solid fa-truck-fast"></i></div>
        <div class="kpi-body">
          <span class="kpi-title">En Ruta</span>
          <span class="kpi-value" id="kpiRoute">0</span>
          <span class="kpi-desc">Realizando viajes activos</span>
        </div>
      </div>
    </div>
    <div class="col-12 col-sm-6 col-xl-3">
      <div class="kpi-card kpi-unavailable">
        <div class="kpi-icon"><i class="fa-solid fa-circle-xmark"></i></div>
        <div class="kpi-body">
          <span class="kpi-title">No Disponibles</span>
          <span class="kpi-value" id="kpiUnavailable">0</span>
          <span class="kpi-desc">Vacaciones, incapacidad o descanso</span>
        </div>
      </div>
    </div>
  </section>

  <!-- ===================== CHOFERES ACTIVOS ===================== -->
  <section class="mb-4">
    <div class="section-header">
      <div>
        <h2 class="section-title"><i class="fa-solid fa-bolt me-2"></i>Choferes Activos</h2>
        <p class="section-subtitle">Vista rápida del personal en operación</p>
      </div>
      <span class="badge bg-primary-soft">En tiempo real</span>
    </div>
    <div class="active-drivers-scroll">
      <div class="active-drivers" id="activeDrivers"></div>
    </div>
  </section>

  <!-- ===================== BARRA DE ACCIONES ===================== -->
  <section class="action-bar mb-3">
    <div class="row g-2 align-items-center">
      <div class="col-12 col-md-3">
        <label class="form-label small text-muted mb-1">Filtrar por estado</label>
        <select class="form-select" id="filterStatus">
          <option value="">Todos</option>
          <option value="Disponible">Disponibles</option>
          <option value="En Ruta">En Ruta</option>
          <option value="No Disponible">No Disponibles</option>
        </select>
      </div>
      <div class="col-12 col-md-5">
        <label class="form-label small text-muted mb-1">Buscar</label>
        <div class="input-group">
          <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass"></i></span>
          <input type="text" class="form-control" id="searchInput" placeholder="Nombre o número de licencia...">
        </div>
      </div>
      <div class="col-12 col-md-4 d-flex justify-content-md-end gap-2 mt-3 mt-md-0 pt-md-3">
        <button  type="button" class="btn btn-outline-primary" id="btnRefresh"><i class="fa-solid fa-rotate me-1"></i>Actualizar</button>
        <button type="button" class="btn btn-primary-grad" id="btnNew"><i class="fa-solid fa-plus me-1"></i>Nuevo Chofer</button>
      </div>
    </div>
  </section>

  <!-- ===================== TABLA ===================== -->
  <section class="card data-card">
    <div class="card-header d-flex justify-content-between align-items-center">
      <h3 class="card-title mb-0"><i class="fa-solid fa-list-ul me-2"></i>Listado General de Choferes</h3>
      <span class="text-muted small" id="resultCount">0 registros</span>
    </div>
    <div class="table-responsive">
      <table class="table table-modern align-middle mb-0">
        <thead>
          <tr>
            <th>Foto</th>
            <th data-sort="id" class="sortable">ID <i class="fa-solid fa-sort"></i></th>
            <th data-sort="nombre" class="sortable">Nombre Completo <i class="fa-solid fa-sort"></i></th>
            <th>Teléfono</th>
            <th data-sort="licencia" class="sortable">Licencia <i class="fa-solid fa-sort"></i></th>
            <th data-sort="estado" class="sortable">Estado <i class="fa-solid fa-sort"></i></th>
            <th data-sort="registro" class="sortable">Fecha de Registro <i class="fa-solid fa-sort"></i></th>
            <th class="text-center">Acciones</th>
          </tr>
        </thead>
        <tbody id="driversTable"></tbody>
      </table>
    </div>
  </section>

</main>

<!-- ===================== MODAL VER ===================== -->
<div class="modal fade" id="viewModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content modal-modern">
      <div class="modal-header view-header">
        <h5 class="modal-title"><i class="fa-solid fa-address-card me-2"></i>Ficha del Chofer</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="viewBody"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

<!-- ===================== MODAL NUEVO / EDITAR ===================== -->
<div class="modal fade" id="formModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content modal-modern">
      <div class="modal-header form-header">
        <h5 class="modal-title" id="formTitle"><i class="fa-solid fa-user-plus me-2"></i>Nuevo Chofer</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div id="driverForm">
        <div class="modal-body">
          <input type="hidden" id="driverId">
          <div class="row g-3">
            <div class="col-md-4">
              <label class="form-label">Nombre</label>
              <input type="text" class="form-control" id="nombre" >
            </div>
            <div class="col-md-4">
              <label class="form-label">Apellido Paterno</label>
              <input type="text" class="form-control" id="apellidoPaterno" >
            </div>
            <div class="col-md-4">
              <label class="form-label">Apellido Materno</label>
              <input type="text" class="form-control" id="apellidoMaterno">
            </div>
            <div class="col-md-6">
              <label class="form-label">Teléfono</label>
              <input type="tel" class="form-control" id="telefono" >
            </div>
            <div class="col-md-6">
              <label class="form-label">Fecha de Nacimiento</label>
              <input type="date" class="form-control" id="fechaNacimiento" >
            </div>
            <div class="col-md-6">
              <label class="form-label">Número de Licencia</label>
              <input type="text" class="form-control" id="licencia" >
            </div>
            <div class="col-md-6">
              <label class="form-label">Estado</label>
              <select class="form-select" id="estado" >
                <option value="Disponible">Disponible</option>
                <option value="En Ruta">En Ruta</option>
                <option value="No Disponible">No Disponible</option>
              </select>
            </div>
            <div class="col-12">
              <label class="form-label">URL de Fotografía</label>
              <input type="url" class="form-control" id="foto" placeholder="https://...">
            </div>
            <div class="col-12">
              <label class="form-label">Última Ruta Asignada</label>
              <input type="text" class="form-control" id="ultimaRuta" placeholder="Opcional">
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="button" id="btnSaveDriver" class="btn btn-primary-grad"><i class="fa-solid fa-floppy-disk me-1"></i>Guardar</button>
        </div>
      </div>
    </div>
  </div>
</div>
   

<!-- ===================== MODAL ELIMINAR ===================== -->
<div class="modal fade" id="deleteModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-modern">
      <div class="modal-header delete-header">
        <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i>Eliminar Chofer</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center" id="deleteBody"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-danger" id="btnConfirmDelete"><i class="fa-solid fa-trash me-1"></i>Eliminar</button>
      </div>
    </div>
  </div>
</div>

<!-- Toast -->
<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index:1080">
  <div id="appToast" class="toast align-items-center text-white bg-primary border-0" role="alert">
    <div class="d-flex">
      <div class="toast-body" id="toastBody">Acción completada</div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
  </div>
</div>
    
    <script type="text/javascript">

/* =========================================================
Gestión de Choferes - JavaScript Vanilla (ES6)
========================================================= */

/* ---------- Datos de ejemplo ---------- */
let drivers = [
    { id: 1, nombre: "Carlos", apellidoPaterno: "Ramírez", apellidoMaterno: "López", telefono: "555-120-3344", fechaNacimiento: "1985-03-12", licencia: "LIC-001023", estado: "Disponible", fechaRegistro: "2022-01-15", ultimaRuta: "CDMX → Querétaro", foto: "https://randomuser.me/api/portraits/men/1.jpg" },
    { id: 2, nombre: "Miguel", apellidoPaterno: "Hernández", apellidoMaterno: "Soto", telefono: "555-220-1188", fechaNacimiento: "1990-07-22", licencia: "LIC-001098", estado: "En Ruta", fechaRegistro: "2021-06-03", ultimaRuta: "Monterrey → Saltillo", foto: "https://randomuser.me/api/portraits/men/2.jpg" },
    { id: 3, nombre: "María", apellidoPaterno: "González", apellidoMaterno: "Vega", telefono: "555-330-7755", fechaNacimiento: "1988-11-04", licencia: "LIC-001145", estado: "Disponible", fechaRegistro: "2023-02-20", ultimaRuta: "Guadalajara → León", foto: "https://randomuser.me/api/portraits/women/3.jpg" },
    { id: 4, nombre: "Jorge", apellidoPaterno: "Pérez", apellidoMaterno: "Castro", telefono: "555-410-9933", fechaNacimiento: "1979-05-18", licencia: "LIC-001210", estado: "No Disponible", fechaRegistro: "2020-09-10", ultimaRuta: "Puebla → Veracruz", foto: "https://randomuser.me/api/portraits/men/4.jpg" },
    { id: 5, nombre: "Ana", apellidoPaterno: "Martínez", apellidoMaterno: "Ruiz", telefono: "555-512-4477", fechaNacimiento: "1992-09-30", licencia: "LIC-001288", estado: "En Ruta", fechaRegistro: "2022-11-25", ultimaRuta: "Toluca → Morelia", foto: "https://randomuser.me/api/portraits/women/5.jpg" },
    { id: 6, nombre: "Luis", apellidoPaterno: "Sánchez", apellidoMaterno: "Mora", telefono: "555-617-2266", fechaNacimiento: "1983-02-14", licencia: "LIC-001331", estado: "Disponible", fechaRegistro: "2021-04-18", ultimaRuta: "CDMX → Toluca", foto: "https://randomuser.me/api/portraits/men/6.jpg" },
    { id: 7, nombre: "Sofía", apellidoPaterno: "Torres", apellidoMaterno: "Díaz", telefono: "555-718-5599", fechaNacimiento: "1995-12-01", licencia: "LIC-001402", estado: "Disponible", fechaRegistro: "2023-08-05", ultimaRuta: "Cancún → Mérida", foto: "https://randomuser.me/api/portraits/women/7.jpg" },
    { id: 8, nombre: "Andrés", apellidoPaterno: "Flores", apellidoMaterno: "Ortega", telefono: "555-820-3311", fechaNacimiento: "1987-06-25", licencia: "LIC-001475", estado: "En Ruta", fechaRegistro: "2020-03-12", ultimaRuta: "Tijuana → Mexicali", foto: "https://randomuser.me/api/portraits/men/8.jpg" },
    { id: 9, nombre: "Laura", apellidoPaterno: "Rivera", apellidoMaterno: "Gómez", telefono: "555-921-6688", fechaNacimiento: "1991-04-08", licencia: "LIC-001523", estado: "No Disponible", fechaRegistro: "2022-07-30", ultimaRuta: "Pachuca → CDMX", foto: "https://randomuser.me/api/portraits/women/9.jpg" },
    { id: 10, nombre: "Roberto", apellidoPaterno: "Mendoza", apellidoMaterno: "Cruz", telefono: "555-022-9911", fechaNacimiento: "1980-08-19", licencia: "LIC-001601", estado: "Disponible", fechaRegistro: "2019-12-01", ultimaRuta: "Acapulco → CDMX", foto: "https://randomuser.me/api/portraits/men/10.jpg" }
];

let nextId = 11;
let sortKey = null;
let sortAsc = true;

/* ---------- Utilidades ---------- */
const $ = (id) => document.getElementById(id);
const badgeClass = (estado) => "badge-status badge-" + estado.replace(/\s+/g, "");
const fullName = (d) => `${d.nombre} ${d.apellidoPaterno} ${d.apellidoMaterno}`.trim();
const formatDate = (str) => {
    if (!str) return "—";
    const d = new Date(str);
    return d.toLocaleDateString("es-MX", { day: "2-digit", month: "short", year: "numeric" });
};

function showToast(msg, type = "primary") {
    const toast = $("appToast");
    toast.className = `toast align-items-center text-white bg-${type} border-0`;
    $("toastBody").textContent = msg;
    bootstrap.Toast.getOrCreateInstance(toast, { delay: 2200 }).show();
}

/* ---------- KPIs ---------- */
function renderKPIs() {
    $("kpiTotal").textContent = drivers.length;
    $("kpiAvailable").textContent = drivers.filter(d => d.estado === "Disponible").length;
    $("kpiRoute").textContent = drivers.filter(d => d.estado === "En Ruta").length;
    $("kpiUnavailable").textContent = drivers.filter(d => d.estado === "No Disponible").length;
}

/* ---------- Choferes activos ---------- */
function renderActiveDrivers() {
    const cont = $("activeDrivers");
    const activos = drivers
        .filter(d => d.estado === "Disponible" || d.estado === "En Ruta")
        .slice(0, 5);

    cont.innerHTML = activos.map(d => `
    <div class="active-card">
      <img src="${d.foto}" alt="${fullName(d)}" class="avatar" onerror="this.src='https://via.placeholder.com/80'">
      <div class="name">${fullName(d)}</div>
      <div class="license"><i class="fa-solid fa-id-card me-1"></i>${d.licencia}</div>
      <span class="${badgeClass(d.estado)}">${d.estado}</span>
      <div class="route"><i class="fa-solid fa-route me-1"></i>${d.ultimaRuta || "Sin ruta asignada"}</div>
    </div>
  `).join("");
}

/* ---------- Tabla ---------- */
function getFilteredDrivers() {
    const term = $("searchInput").value.trim().toLowerCase();
    const stat = $("filterStatus").value;
    let list = drivers.filter(d => {
        const matchStat = !stat || d.estado === stat;
        const matchTerm = !term || fullName(d).toLowerCase().includes(term) || d.licencia.toLowerCase().includes(term);
        return matchStat && matchTerm;
    });
    if (sortKey) {
        list.sort((a, b) => {
            let va, vb;
            if (sortKey === "nombre") { va = fullName(a); vb = fullName(b); }
            else if (sortKey === "registro") { va = a.fechaRegistro; vb = b.fechaRegistro; }
            else { va = a[sortKey]; vb = b[sortKey]; }
            if (va < vb) return sortAsc ? -1 : 1;
            if (va > vb) return sortAsc ? 1 : -1;
            return 0;
        });
    }
    return list;
}

function renderTable() {
    const list = getFilteredDrivers();
    const tbody = $("driversTable");
    $("resultCount").textContent = `${list.length} registro${list.length !== 1 ? "s" : ""}`;

    if (list.length === 0) {
        tbody.innerHTML = `<tr><td colspan="8" class="text-center text-muted py-4">
      <i class="fa-solid fa-magnifying-glass-minus me-2"></i>No se encontraron choferes
    </td></tr>`;
        return;
    }

    tbody.innerHTML = list.map(d => `
    <tr>
      <td><img src="${d.foto}" class="table-avatar" alt="${fullName(d)}" onerror="this.src='https://via.placeholder.com/40'"></td>
      <td><span class="fw-semibold text-muted">#${String(d.id).padStart(4, '0')}</span></td>
      <td><strong>${fullName(d)}</strong></td>
      <td>${d.telefono}</td>
      <td><span class="badge bg-light text-dark border">${d.licencia}</span></td>
      <td><span class="${badgeClass(d.estado)}">${d.estado}</span></td>
      <td>${formatDate(d.fechaRegistro)}</td>
      <td>
        <div class="row-actions">
          <button class="btn-icon btn-view"   title="Ver"     data-action="view"   data-id="${d.id}"><i class="fa-solid fa-eye"></i></button>
          <button class="btn-icon btn-edit"   title="Editar"  data-action="edit"   data-id="${d.id}"><i class="fa-solid fa-pen"></i></button>
          <button class="btn-icon btn-delete" title="Eliminar" data-action="delete" data-id="${d.id}"><i class="fa-solid fa-trash"></i></button>
        </div>
      </td>
    </tr>
  `).join("");
}

/* ---------- Modal Ver ---------- */
function openView(id) {
    const d = drivers.find(x => x.id === id);
    if (!d) return;
    $("viewBody").innerHTML = `
    <div class="profile-view">
      <img src="${d.foto}" alt="${fullName(d)}" class="profile-photo" onerror="this.src='https://via.placeholder.com/180'">
      <div>
        <div class="profile-name">${fullName(d)}</div>
        <span class="${badgeClass(d.estado)}">${d.estado}</span>
        <div class="profile-grid">
          <div class="profile-field"><label>Teléfono</label><span>${d.telefono}</span></div>
          <div class="profile-field"><label>Fecha de Nacimiento</label><span>${formatDate(d.fechaNacimiento)}</span></div>
          <div class="profile-field"><label>Licencia</label><span>${d.licencia}</span></div>
          <div class="profile-field"><label>Fecha de Registro</label><span>${formatDate(d.fechaRegistro)}</span></div>
          <div class="profile-field" style="grid-column:1/-1"><label>Última Ruta Asignada</label><span>${d.ultimaRuta || "—"}</span></div>
        </div>
      </div>
    </div>
  `;
    bootstrap.Modal.getOrCreateInstance($("viewModal")).show();
}

/* ---------- Modal Form ---------- */
function openForm(id = null) {

    const formContainer = $("driverForm");

    if (!formContainer) {
        console.error("No existe driverForm");
        return;
    }

    [
        "driverId",
        "nombre",
        "apellidoPaterno",
        "apellidoMaterno",
        "telefono",
        "fechaNacimiento",
        "licencia",
        "foto",
        "ultimaRuta"
    ].forEach(idCampo => {
        const el = $(idCampo);
        if (el) el.value = "";
    });

    if (id) {

        const d = drivers.find(x => x.id === id);

        if (!d) return;

        $("formTitle").innerHTML =
            '<i class="fa-solid fa-user-pen me-2"></i>Editar Chofer';

        $("driverId").value = d.id;
        $("nombre").value = d.nombre;
        $("apellidoPaterno").value = d.apellidoPaterno;
        $("apellidoMaterno").value = d.apellidoMaterno;
        $("telefono").value = d.telefono;
        $("fechaNacimiento").value = d.fechaNacimiento;
        $("licencia").value = d.licencia;
        $("estado").value = d.estado;
        $("foto").value = d.foto;
        $("ultimaRuta").value = d.ultimaRuta || "";

    } else {

        $("formTitle").innerHTML =
            '<i class="fa-solid fa-user-plus me-2"></i>Nuevo Chofer';

        $("estado").value = "Disponible";
    }

    bootstrap.Modal
        .getOrCreateInstance($("formModal"))
                .show();
        }

function handleSubmit() {
    
    const id = $("driverId").value;
    const data = {
        nombre: $("nombre").value.trim(),
        apellidoPaterno: $("apellidoPaterno").value.trim(),
        apellidoMaterno: $("apellidoMaterno").value.trim(),
        telefono: $("telefono").value.trim(),
        fechaNacimiento: $("fechaNacimiento").value,
        licencia: $("licencia").value.trim(),
        estado: $("estado").value,
        foto: $("foto").value.trim() || "https://randomuser.me/api/portraits/lego/1.jpg",
        ultimaRuta: $("ultimaRuta").value.trim()
    };

    if (id) {
        const idx = drivers.findIndex(x => x.id === Number(id));
        drivers[idx] = { ...drivers[idx], ...data };
        showToast("Chofer actualizado correctamente", "success");
    } else {
        drivers.push({ id: nextId++, ...data, fechaRegistro: new Date().toISOString().slice(0, 10) });
        showToast("Chofer agregado correctamente", "success");
    }

    bootstrap.Modal.getInstance($("formModal")).hide();
    renderAll();
}

/* ---------- Modal Eliminar ---------- */
let deleteTargetId = null;
function openDelete(id) {
    const d = drivers.find(x => x.id === id);
    if (!d) return;
    deleteTargetId = id;
    $("deleteBody").innerHTML = `
    <img src="${d.foto}" class="delete-photo" onerror="this.src='https://via.placeholder.com/90'">
    <h5 class="mb-1">${fullName(d)}</h5>
    <p class="text-muted mb-2">Licencia ${d.licencia}</p>
    <p class="mb-0">¿Desea eliminar este chofer? Esta acción no se puede deshacer.</p>
  `;
    bootstrap.Modal.getOrCreateInstance($("deleteModal")).show();
}

function confirmDelete() {
    drivers = drivers.filter(x => x.id !== deleteTargetId);
    bootstrap.Modal.getInstance($("deleteModal")).hide();
    showToast("Chofer eliminado", "danger");
    renderAll();
}

/* ---------- Render global ---------- */
function renderAll() {
    renderKPIs();
    renderActiveDrivers();
    renderTable();
}

/* ---------- Eventos ---------- */
document.addEventListener("DOMContentLoaded", () => {
    renderAll();

    $("filterStatus").addEventListener("change", renderTable);
    $("searchInput").addEventListener("input", renderTable);
    const el = $("btnNew");
    if (el) {
        el.addEventListener("click", () => openForm());
    }
    $("btnRefresh").addEventListener("click", () => { renderAll(); showToast("Datos actualizados", "primary"); });
    $("btnSaveDriver").addEventListener("click", handleSubmit);
    $("btnConfirmDelete").addEventListener("click", confirmDelete);

    // Acciones por fila (delegación)
    $("driversTable").addEventListener("click", (e) => {
        const btn = e.target.closest("[data-action]");
        if (!btn) return;

        const id = Number(btn.dataset.id);
        const action = btn.dataset.action;

        console.log("CLICK:", action, id);

        if (action === "view") openView(id);
        if (action === "edit") openForm(id);
        if (action === "delete") openDelete(id);
    });

    // Ordenamiento de encabezados
    document.querySelectorAll("th.sortable").forEach(th => {
        th.addEventListener("click", () => {
            const key = th.dataset.sort;
            if (sortKey === key) sortAsc = !sortAsc;
            else { sortKey = key; sortAsc = true; }
            renderTable();
        });
    });

    // Reloj del sistema
    const updateTime = () => {
        $("systemTime").textContent = new Date().toLocaleTimeString("es-MX", { hour12: false });
    };
    updateTime();
    setInterval(updateTime, 1000);
        });

    </script>
  


</asp:Content>
    
