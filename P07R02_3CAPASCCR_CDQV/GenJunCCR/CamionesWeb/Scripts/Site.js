
  // Navbar scroll effect
  (function(){
    var nav = document.getElementById('mainNavbar');
    function onScroll(){
      if(window.scrollY > 30){ nav.classList.add('scrolled'); }
      else{ nav.classList.remove('scrolled'); }
    }
    window.addEventListener('scroll', onScroll, { passive:true });
    onScroll();
  })();

  // Active link highlight on click
  document.querySelectorAll('.navbar-glass .nav-link').forEach(function(link){
    link.addEventListener('click', function(){
      document.querySelectorAll('.navbar-glass .nav-link').forEach(function(l){ l.classList.remove('active'); });
      link.classList.add('active');
    });
  });

  // Animated counters
  (function(){
    var counters = document.querySelectorAll('.hero-stats .num');
    var started = false;
    function animate(){
      if(started) return;
      started = true;
      counters.forEach(function(el){
        var target = parseInt(el.getAttribute('data-target'), 10) || 0;
        var current = 0;
        var step = Math.max(1, Math.ceil(target / 60));
        var timer = setInterval(function(){
          current += step;
          if(current >= target){ current = target; clearInterval(timer); }
          el.textContent = current.toLocaleString('es-ES');
        }, 25);
      });
    }
    // start once hero is visible
    if('IntersectionObserver' in window){
      var io = new IntersectionObserver(function(entries){
        entries.forEach(function(e){ if(e.isIntersecting) animate(); });
      }, { threshold: .4 });
      var stats = document.querySelector('.hero-stats');
      if(stats) io.observe(stats);
    } else {
      setTimeout(animate, 1200);
    }
  })();

  // Smooth scroll for in-page anchors
  document.querySelectorAll('a[href^="#"]').forEach(function(a){
    a.addEventListener('click', function(e){
      var id = a.getAttribute('href');
      if(id.length > 1){
        var el = document.querySelector(id);
        if(el){
          e.preventDefault();
          window.scrollTo({ top: el.offsetTop - 70, behavior: 'smooth' });
        }
      }
    });
  });
