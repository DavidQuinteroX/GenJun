(function(){
  const KEY = 'focusly:v1';
  const today = () => new Date().toISOString().slice(0,10);
  const dayIdx = () => { const d=new Date().getDay(); return (d+6)%7; }; // L=0..D=6

  const defaultState = {
    focusMin: 25, breakMin: 5,
    stats: { date: today(), pomodoros:0, minutes:0, breaks:0, startedFocus:0 },
    week: [0,0,0,0,0,0,0],
    weekStart: today(),
  };

  let state = load();
  rolloverIfNeeded();

  function load(){
    try { const raw = localStorage.getItem(KEY); if(raw) return Object.assign({},defaultState,JSON.parse(raw)); } catch(e){}
    return JSON.parse(JSON.stringify(defaultState));
  }
  function save(){ localStorage.setItem(KEY, JSON.stringify(state)); }
  function rolloverIfNeeded(){
    if(state.stats.date !== today()){
      state.stats = { date: today(), pomodoros:0, minutes:0, breaks:0, startedFocus:0 };
    }
    // weekly reset on Monday
    const start = new Date(state.weekStart||today());
    const diff = (Date.now()-start.getTime())/86400000;
    if(diff >= 7){ state.week=[0,0,0,0,0,0,0]; state.weekStart=today(); }
    save();
  }

  // DOM
  const $ = s => document.querySelector(s);
  const timeEl = $('#time'), labelEl=$('#timeLabel');
  const startBtn=$('#startBtn'), pauseBtn=$('#pauseBtn'), resetBtn=$('#resetBtn');
  const focusVal=$('#focusVal'), breakVal=$('#breakVal');
  const ring = document.querySelector('.ring-progress');
  const modeSwitch = document.querySelector('.mode-switch');
  const timerCard = document.querySelector('.timer-card');
  const RING_LEN = 2*Math.PI*100;
  ring.setAttribute('stroke-dasharray', RING_LEN);

  let mode='focus'; // 'focus' | 'break'
  let remaining = state.focusMin*60;
  let total = state.focusMin*60;
  let timer=null;

  function fmt(s){ const m=Math.floor(s/60), sec=s%60; return String(m).padStart(2,'0')+':'+String(sec).padStart(2,'0'); }

  function render(){
    focusVal.textContent = state.focusMin;
    breakVal.textContent = state.breakMin;
    timeEl.textContent = fmt(remaining);
    labelEl.textContent = mode==='focus' ? 'Enfoque' : 'Descanso';
    const pct = total>0 ? remaining/total : 0;
    ring.style.strokeDashoffset = (RING_LEN*(1-pct)).toFixed(2);
    modeSwitch.classList.toggle('break', mode==='break');
    timerCard.classList.toggle('mode-break', mode==='break');
    document.querySelectorAll('.mode-btn').forEach(b=>{
      b.classList.toggle('active', b.dataset.mode===mode);
    });
    // stats
    $('#statPomodoros').textContent = state.stats.pomodoros;
    $('#statMinutes').textContent = state.stats.minutes + 'm';
    $('#statBreaks').textContent = state.stats.breaks;
    const conc = state.stats.startedFocus>0 ? Math.round(100*state.stats.pomodoros/state.stats.startedFocus) : 0;
    $('#statFocus').textContent = conc + '%';
    renderChart();
  }

  function renderChart(){
    const chart = $('#chart');
    chart.innerHTML='';
    const labels=['L','M','X','J','V','S','D'];
    const max = Math.max(4, ...state.week);
    const ti = dayIdx();
    labels.forEach((l,i)=>{
      const wrap=document.createElement('div'); wrap.className='bar-wrap';
      const bar=document.createElement('div'); bar.className='bar'+(i===ti?' today':'');
      const h = state.week[i]/max*100;
      bar.style.height='0%';
      const lab=document.createElement('div'); lab.className='bar-label'; lab.textContent=l;
      wrap.appendChild(bar); wrap.appendChild(lab); chart.appendChild(wrap);
      requestAnimationFrame(()=>{ bar.style.height = Math.max(4,h) + '%'; });
    });
  }

  function setMode(m, resetTime=true){
    mode=m;
    if(resetTime){
      total = (m==='focus'?state.focusMin:state.breakMin)*60;
      remaining = total;
    }
    render();
  }

  function start(){
    if(timer) return;
    if(mode==='focus' && remaining===total){ state.stats.startedFocus++; save(); }
    timer=setInterval(tick,1000);
    startBtn.querySelector('span').textContent='En curso';
  }
  function pause(){ if(timer){clearInterval(timer); timer=null;} startBtn.querySelector('span').textContent='Iniciar'; }
  function reset(){ pause(); total=(mode==='focus'?state.focusMin:state.breakMin)*60; remaining=total; render(); }

  function tick(){
    remaining--;
    if(remaining<=0){
      clearInterval(timer); timer=null;
      beep();
      if(mode==='focus'){
        state.stats.pomodoros++;
        state.stats.minutes += state.focusMin;
        state.week[dayIdx()] = (state.week[dayIdx()]||0)+1;
        save();
        setMode('break',true); start();
      } else {
        state.stats.breaks++; save();
        setMode('focus',true); render();
        startBtn.querySelector('span').textContent='Iniciar';
      }
      return;
    }
    render();
  }

  function beep(){
    try{
      const ctx = new (window.AudioContext||window.webkitAudioContext)();
      const o = ctx.createOscillator(); const g=ctx.createGain();
      o.connect(g); g.connect(ctx.destination);
      o.type='sine'; o.frequency.value= mode==='focus'?880:660;
      g.gain.setValueAtTime(0,ctx.currentTime);
      g.gain.linearRampToValueAtTime(.2,ctx.currentTime+.05);
      g.gain.exponentialRampToValueAtTime(.0001,ctx.currentTime+.8);
      o.start(); o.stop(ctx.currentTime+.85);
    }catch(e){}
  }

  // Events
  startBtn.addEventListener('click',start);
  pauseBtn.addEventListener('click',pause);
  resetBtn.addEventListener('click',reset);

  document.querySelectorAll('.mode-btn').forEach(b=>{
    b.addEventListener('click',()=>{ pause(); setMode(b.dataset.mode,true); });
  });

  document.querySelectorAll('.step-btn').forEach(b=>{
    b.addEventListener('click',()=>{
      const dir=parseInt(b.dataset.dir,10);
      const key=b.dataset.step;
      if(key==='focus'){
        state.focusMin = Math.min(90, Math.max(1, state.focusMin+dir));
      } else {
        state.breakMin = Math.min(60, Math.max(1, state.breakMin+dir));
      }
      save();
      if(!timer){ total=(mode==='focus'?state.focusMin:state.breakMin)*60; remaining=total; }
      render();
    });
  });

  setMode('focus',true);
  render();
})();
