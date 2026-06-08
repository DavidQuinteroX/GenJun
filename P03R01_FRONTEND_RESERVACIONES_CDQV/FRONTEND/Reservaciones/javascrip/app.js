/* =========================================================
   Aurelia Boutique Hotel - Lógica de la aplicación
   HTML + CSS + JavaScript puro
   Almacenamiento: LocalStorage
   ========================================================= */

/* ----------------------------- DATOS ----------------------------- */
const ROOMS = [
  {
    id: 'std-01',
    type: 'Estándar',
    name: 'Habitación Estándar',
    price: 120,
    capacity: 2,
    size: '28 m²',
    description: 'Refugio acogedor con acabados cálidos, cama queen y vistas al jardín interior.',
    image: 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=1280&q=80',
    amenities: ['Wi-Fi de alta velocidad', 'Smart TV 50"', 'Desayuno continental', 'Aire acondicionado'],
  },
  {
    id: 'dlx-01',
    type: 'Deluxe',
    name: 'Habitación Deluxe',
    price: 220,
    capacity: 3,
    size: '42 m²',
    description: 'Espaciosa suite con sala de estar, balcón privado y amenidades premium.',
    image: 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=1280&q=80',
    amenities: ['Balcón privado', 'Bañera independiente', 'Minibar premium', 'Servicio 24h'],
  },
  {
    id: 'ste-01',
    type: 'Suite',
    name: 'Suite Presidencial',
    price: 480,
    capacity: 4,
    size: '85 m²',
    description: 'La experiencia más exclusiva: terraza panorámica, jacuzzi y mayordomo personal.',
    image: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?w=1280&q=80',
    amenities: ['Terraza panorámica', 'Jacuzzi privado', 'Mayordomo personal', 'Champagne de bienvenida'],
  },
];

const STORAGE_KEY = 'aurelia_reservations_v1';

/* --------------------------- UTILIDADES -------------------------- */
const $ = (sel, ctx = document) => ctx.querySelector(sel);
const $$ = (sel, ctx = document) => Array.from(ctx.querySelectorAll(sel));

function formatCurrency(n) {
  return new Intl.NumberFormat('es-MX', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(n);
}

function formatDate(iso) {
  if (!iso) return '—';
  const d = new Date(iso + 'T00:00:00');
  return d.toLocaleDateString('es-MX', { day: '2-digit', month: 'short', year: 'numeric' });
}

function nightsBetween(checkIn, checkOut) {
  if (!checkIn || !checkOut) return 0;
  const a = new Date(checkIn).getTime();
  const b = new Date(checkOut).getTime();
  const diff = Math.round((b - a) / (1000 * 60 * 60 * 24));
  return diff > 0 ? diff : 0;
}

function todayISO() {
  const d = new Date();
  d.setHours(0, 0, 0, 0);
  const tz = d.getTimezoneOffset() * 60000;
  return new Date(d - tz).toISOString().split('T')[0];
}

function generateCode() {
  // Código tipo AUR-9F4K
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  let s = '';
  for (let i = 0; i < 6; i++) s += chars[Math.floor(Math.random() * chars.length)];
  return 'AUR-' + s;
}

function findRoom(id) { return ROOMS.find(r => r.id === id); }

/* ------------------------- LOCALSTORAGE -------------------------- */
function getReservations() {
  try { return JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]'); }
  catch { return []; }
}
function saveReservations(list) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(list));
}
function addReservation(r) {
  const list = getReservations();
  list.push(r);
  saveReservations(list);
}
function updateReservationStatus(id, status) {
  const list = getReservations().map(r => r.id === id ? { ...r, status } : r);
  saveReservations(list);
}

/* -------------------- VERIFICACIÓN DE DISPONIBILIDAD --------------------- */
function isRoomAvailable(roomId, checkIn, checkOut) {
  const a = new Date(checkIn).getTime();
  const b = new Date(checkOut).getTime();
  return !getReservations().some(r => {
    if (r.status === 'Cancelada') return false;
    if (r.roomId !== roomId) return false;
    const ra = new Date(r.checkIn).getTime();
    const rb = new Date(r.checkOut).getTime();
    return a < rb && b > ra; // hay solapamiento
  });
}

/* ============================================================
   PÁGINA: HABITACIONES (catálogo + formulario)
   ============================================================ */
function initRoomsPage() {
  const grid = $('#rooms-grid');
  if (!grid) return;

  // Render catálogo
  grid.innerHTML = ROOMS.map(r => `
    <article class="room-card">
      <div class="room-image">
        <img src="${r.image}" alt="${r.name}" loading="lazy" />
        <span class="room-badge">${r.type}</span>
      </div>
      <div class="room-body">
        <h3>${r.name}</h3>
        <div class="room-meta">
          <span>${r.capacity} huéspedes</span>
          <span>·</span>
          <span>${r.size}</span>
        </div>
        <p class="room-desc">${r.description}</p>
        <ul class="room-amenities">
          ${r.amenities.map(a => `<li>${a}</li>`).join('')}
        </ul>
        <div class="room-footer">
          <span class="room-price">${formatCurrency(r.price)}<span>/ noche</span></span>
          <button class="btn btn-gold" data-reserve="${r.id}">Reservar</button>
        </div>
      </div>
    </article>
  `).join('');

  // Llenar select del formulario
  const select = $('#roomId');
  if (select) {
    select.innerHTML = '<option value="">Seleccionar...</option>' + ROOMS.map(r =>
      `<option value="${r.id}">${r.name} — ${formatCurrency(r.price)}/noche</option>`
    ).join('');
  }

  // Botones "Reservar" del catálogo → autoseleccionar y scroll al form
  grid.addEventListener('click', e => {
    const btn = e.target.closest('[data-reserve]');
    if (!btn) return;
    const roomId = btn.getAttribute('data-reserve');
    if (select) select.value = roomId;
    updateSummary();
    $('#reservar')?.scrollIntoView({ behavior: 'smooth' });
  });

  initBookingForm();
}

function initBookingForm() {
  const form = $('#bookingForm');
  if (!form) return;

  // Fechas mínimas = hoy
  const today = todayISO();
  const checkIn = $('#checkIn');
  const checkOut = $('#checkOut');
  checkIn.min = today;
  checkOut.min = today;

  // Sincronizar fechas
  checkIn.addEventListener('change', () => {
    if (checkIn.value && (!checkOut.value || checkOut.value <= checkIn.value)) {
      const next = new Date(checkIn.value);
      next.setDate(next.getDate() + 1);
      checkOut.value = next.toISOString().split('T')[0];
    }
    checkOut.min = checkIn.value || today;
    updateSummary();
  });

  ['change', 'input'].forEach(ev => {
    $('#roomId').addEventListener(ev, updateSummary);
    checkOut.addEventListener(ev, updateSummary);
  });

  form.addEventListener('submit', handleBookingSubmit);

  // Modal close
  $$('#confirmModal [data-close]').forEach(el => {
    el.addEventListener('click', () => $('#confirmModal').hidden = true);
  });
}

function updateSummary() {
  const room = findRoom($('#roomId').value);
  const checkIn = $('#checkIn').value;
  const checkOut = $('#checkOut').value;
  const nights = nightsBetween(checkIn, checkOut);
  const price = room ? room.price : 0;
  const total = price * nights;

  $('#sumRoom').textContent = room ? room.name : '—';
  $('#sumPrice').textContent = formatCurrency(price);
  $('#sumNights').textContent = nights;
  $('#sumTotal').textContent = formatCurrency(total);
}

function showMessage(type, text) {
  const el = $('#formMessage');
  el.className = 'form-message ' + type;
  el.textContent = text;
  el.hidden = false;
}

function clearMessage() {
  const el = $('#formMessage');
  el.hidden = true;
  el.textContent = '';
}

function handleBookingSubmit(e) {
  e.preventDefault();
  clearMessage();

  const name = $('#name').value.trim();
  const email = $('#email').value.trim();
  const phone = $('#phone').value.trim();
  const roomId = $('#roomId').value;
  const checkIn = $('#checkIn').value;
  const checkOut = $('#checkOut').value;
  const guests = parseInt($('#guests').value, 10);

  // Validaciones
  if (!name || !email || !phone || !roomId || !checkIn || !checkOut) {
    return showMessage('error', 'Por favor completa todos los campos obligatorios.');
  }
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    return showMessage('error', 'Ingresa un correo electrónico válido.');
  }
  const today = todayISO();
  if (checkIn < today) {
    return showMessage('error', 'La fecha de entrada no puede ser anterior a hoy.');
  }
  if (checkOut <= checkIn) {
    return showMessage('error', 'La fecha de salida debe ser posterior a la fecha de entrada.');
  }

  const room = findRoom(roomId);
  if (guests > room.capacity) {
    return showMessage('error', `La habitación seleccionada admite máximo ${room.capacity} huéspedes.`);
  }

  if (!isRoomAvailable(roomId, checkIn, checkOut)) {
    return showMessage('error', 'Habitación no disponible en las fechas seleccionadas. Por favor elige otras fechas.');
  }

  const nights = nightsBetween(checkIn, checkOut);
  const total = nights * room.price;

  const reservation = {
    id: generateCode(),
    roomId, roomName: room.name, roomType: room.type,
    guestName: name, guestEmail: email, guestPhone: phone,
    checkIn, checkOut, guests, nights,
    pricePerNight: room.price, total,
    status: 'Confirmada',
    createdAt: new Date().toISOString(),
  };

  addReservation(reservation);

  // Mostrar modal
  $('#modalCode').textContent = reservation.id;
  $('#confirmModal').hidden = false;

  // Reset
  e.target.reset();
  $('#guests').value = 2;
  updateSummary();
}

/* ============================================================
   PÁGINA: MIS RESERVAS
   ============================================================ */
function initReservationsPage() {
  const container = $('#reservationsContainer');
  if (!container) return;
  renderReservations();

  container.addEventListener('click', e => {
    const btn = e.target.closest('[data-cancel]');
    if (!btn) return;
    const id = btn.getAttribute('data-cancel');
    if (confirm('¿Estás seguro de cancelar esta reserva? Esta acción no se puede deshacer.')) {
      updateReservationStatus(id, 'Cancelada');
      renderReservations();
    }
  });
}

function renderReservations() {
  const container = $('#reservationsContainer');
  const list = getReservations().sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));

  if (list.length === 0) {
    container.innerHTML = `
      <div class="empty-state">
        <h3>Aún no tienes reservas</h3>
        <p>Explora nuestras habitaciones y vive una experiencia única en Aurelia.</p>
        <a href="habitaciones.html" class="btn btn-gold">Reservar Ahora</a>
      </div>`;
    return;
  }

  container.innerHTML = `
    <div class="table-wrapper">
      <table class="reservations-table">
        <thead>
          <tr>
            <th>Código</th>
            <th>Cliente</th>
            <th>Habitación</th>
            <th>Entrada</th>
            <th>Salida</th>
            <th>Noches</th>
            <th>Total</th>
            <th>Estado</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          ${list.map(r => `
            <tr>
              <td><code>${r.id}</code></td>
              <td>${r.guestName}<br><small style="color:var(--muted)">${r.guestEmail}</small></td>
              <td>${r.roomName}</td>
              <td>${formatDate(r.checkIn)}</td>
              <td>${formatDate(r.checkOut)}</td>
              <td>${r.nights}</td>
              <td><strong>${formatCurrency(r.total)}</strong></td>
              <td><span class="status ${r.status.toLowerCase()}">${r.status}</span></td>
              <td>
                ${r.status === 'Confirmada'
                  ? `<button class="btn btn-danger" data-cancel="${r.id}">Cancelar</button>`
                  : `<span style="color:var(--muted);font-size:0.8rem">—</span>`}
              </td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

/* ------------------------------ INIT ------------------------------ */
document.addEventListener('DOMContentLoaded', () => {
  initRoomsPage();
  initReservationsPage();
});
