// ============ DATA ============
const MENU = {
  cal: [
    { n:'Espresso clásico', d:'Cuerpo intenso, crema dorada y aroma envolvente.', p:45, img:'https://images.unsplash.com/photo-1510707577719-ae7c14805e3a?auto=format&fit=crop&w=900&q=80' },
    { n:'Cappuccino', d:'Equilibrio perfecto entre espresso, leche y espuma sedosa.', p:65, img:'https://images.unsplash.com/photo-1572442388796-11668a67e53d?auto=format&fit=crop&w=900&q=80' },
    { n:'Latte de avellana', d:'Notas tostadas y un toque dulce para los amantes del aroma.', p:75, img:'https://images.unsplash.com/photo-1561882468-9110e03e0f78?auto=format&fit=crop&w=900&q=80' },
    { n:'Mocha de autor', d:'Chocolate belga, espresso doble y crema batida en casa.', p:85, img:'https://images.unsplash.com/photo-1578374173703-7eb1c4b3c2b6?auto=format&fit=crop&w=900&q=80' },
  ],
  fri: [
    { n:'Cold Brew', d:'12 horas de infusión en frío. Suave, dulce y refrescante.', p:70, img:'https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=900&q=80' },
    { n:'Iced Latte', d:'Espresso, hielo y leche fría para el calor del día.', p:75, img:'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?auto=format&fit=crop&w=900&q=80' },
    { n:'Frappé caramelo', d:'Caramelo artesanal, café y leche batida con hielo.', p:90, img:'https://images.unsplash.com/photo-1572490122747-3968b75cc699?auto=format&fit=crop&w=900&q=80' },
    { n:'Matcha tonic', d:'Matcha ceremonial con agua tónica y limón.', p:95, img:'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?auto=format&fit=crop&w=900&q=80' },
  ],
  pos: [
    { n:'Cheesecake fresa', d:'Base de galleta artesanal y fresas naturales.', p:95, img:'https://images.unsplash.com/photo-1565958011703-44f9829ba187?auto=format&fit=crop&w=900&q=80' },
    { n:'Brownie de chocolate', d:'Chocolate 70%, nueces y un toque de sal de mar.', p:75, img:'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=900&q=80' },
    { n:'Tarta de manzana', d:'Manzana caramelizada, canela y masa hojaldrada.', p:80, img:'https://images.unsplash.com/photo-1568571780765-9276ac8b75a2?auto=format&fit=crop&w=900&q=80' },
    { n:'Croissant almendra', d:'Mantequilla francesa y crema de almendras tostadas.', p:60, img:'https://images.unsplash.com/photo-1555507036-ab1f4038808a?auto=format&fit=crop&w=900&q=80' },
  ],
  esp: [
    { n:'V60 origen único', d:'Filtrado manual del grano del mes. Notas frutales.', p:110, img:'https://images.unsplash.com/photo-1610632380989-680fe40816c6?auto=format&fit=crop&w=900&q=80' },
    { n:'Aeropress', d:'Cuerpo limpio y dulzor natural en una extracción rápida.', p:95, img:'https://images.unsplash.com/photo-1551030173-122aabc4489c?auto=format&fit=crop&w=900&q=80' },
    { n:'Chemex', d:'Cuerpo ligero y aroma floral para los puristas.', p:115, img:'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80' },
    { n:'Affogato', d:'Helado de vainilla bañado con espresso recién hecho.', p:90, img:'https://images.unsplash.com/photo-1497636577773-f1231844b336?auto=format&fit=crop&w=900&q=80' },
  ],
};

const TESTIMONIOS = [
  { n:'Daniela Ruiz', r:5, t:'El mejor café que he probado en la ciudad. El ambiente es perfecto para trabajar o leer.', img:'https://i.pravatar.cc/120?img=47' },
  { n:'Carlos Mendoza', r:5, t:'Los baristas son verdaderos artistas. El V60 es una experiencia que hay que vivir.', img:'https://i.pravatar.cc/120?img=12' },
  { n:'Sofía Hernández', r:4, t:'Postres deliciosos y un servicio impecable. Mi lugar favorito para los domingos.', img:'https://i.pravatar.cc/120?img=32' },
];

// ============ RENDER MENU ============
function cardHTML(it){
  return `
    <div class="col-md-6 col-lg-3 reveal">
      <article class="menu-card">
        <div class="img" style="background-image:url('${it.img}')"></div>
        <div class="body">
          <h5>${it.n}</h5>
          <p>${it.d}</p>
          <div class="foot">
            <span class="price">${it.p}</span>
            <button class="btn btn-gold btn-sm add-btn" data-name="${it.n}">
              <i class="bi bi-plus-lg"></i> Agregar
            </button>
          </div>
        </div>
      </article>
    </div>`;
}
document.getElementById('menu-cal').innerHTML = MENU.cal.map(cardHTML).join('');
document.getElementById('menu-fri').innerHTML = MENU.fri.map(cardHTML).join('');
document.getElementById('menu-pos').innerHTML = MENU.pos.map(cardHTML).join('');
document.getElementById('menu-esp').innerHTML = MENU.esp.map(cardHTML).join('');

// ============ TESTIMONIOS ============
document.getElementById('testimonios').innerHTML = TESTIMONIOS.map(t => {
  const stars = '<i class="bi bi-star-fill"></i>'.repeat(t.r) + '<i class="bi bi-star"></i>'.repeat(5 - t.r);
  return `
    <div class="col-md-6 col-lg-4 reveal">
      <div class="testi-card">
        <div class="testi-head">
          <img src="${t.img}" alt="${t.n}" />
          <div>
            <h6>${t.n}</h6>
            <div class="stars">${stars}</div>
          </div>
        </div>
        <p class="testi-text">"${t.t}"</p>
      </div>
    </div>`;
}).join('');

// ============ NAVBAR SCROLL ============
const nav = document.getElementById('mainNav');
const onScroll = () => nav.classList.toggle('scrolled', window.scrollY > 60);
window.addEventListener('scroll', onScroll, { passive:true });
onScroll();

// Close mobile nav on link click
document.querySelectorAll('#navMenu .nav-link, #navMenu .btn').forEach(a => {
  a.addEventListener('click', () => {
    const collapse = bootstrap.Collapse.getInstance(document.getElementById('navMenu'));
    if (collapse && window.innerWidth < 992) collapse.hide();
  });
});

// ============ REVEAL ON SCROLL ============
const io = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting){
      e.target.classList.add('in');
      io.unobserve(e.target);
    }
  });
}, { threshold:0.12 });
document.querySelectorAll('.reveal').forEach(el => io.observe(el));

// Re-observe newly tabbed content (cards already in DOM but trigger on tab show)
document.querySelectorAll('[data-bs-toggle="pill"]').forEach(btn => {
  btn.addEventListener('shown.bs.tab', () => {
    document.querySelectorAll('.tab-pane.active .reveal').forEach(el => el.classList.add('in'));
  });
});

// ============ ADD TO CART TOAST ============
const toastEl = document.getElementById('cartToast');
const toastText = document.getElementById('toastText');
const toast = new bootstrap.Toast(toastEl, { delay:1800 });
document.addEventListener('click', (e) => {
  const b = e.target.closest('.add-btn');
  if (!b) return;
  toastText.textContent = `"${b.dataset.name}" agregado a tu pedido`;
  toast.show();
});

// ============ FORM ============
const form = document.getElementById('contactForm');
form.addEventListener('submit', (e) => {
  e.preventDefault();
  const msg = document.getElementById('formMsg');
  if (!form.checkValidity()){
    msg.textContent = 'Por favor completa todos los campos.';
    msg.style.color = '#e2c184';
    return;
  }
  msg.style.color = '#c8a464';
  msg.textContent = '¡Gracias! Te responderemos en breve.';
  form.reset();
});

// ============ YEAR ============
document.getElementById('year').textContent = new Date().getFullYear();
