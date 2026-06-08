import { useEffect, useMemo, useRef, useState } from "react";
import { Play, Pause, RotateCcw, Brain, Coffee, Flame, Clock, Target, Trees } from "lucide-react";

type Mode = "focus" | "rest";

interface Stats {
  pomodoros: number;
  focusSeconds: number;
  breaks: number;
  week: number[]; // 7 days, Mon..Sun, count of pomodoros
  weekStart: string; // ISO date of Monday
}

const STORAGE_KEY = "pomodoro_stats_v1";

function getMonday(d = new Date()) {
  const date = new Date(d);
  const day = date.getDay();
  const diff = (day === 0 ? -6 : 1) - day;
  date.setDate(date.getDate() + diff);
  date.setHours(0, 0, 0, 0);
  return date;
}

function loadStats(): Stats {
  if (typeof window === "undefined")
    return { pomodoros: 0, focusSeconds: 0, breaks: 0, week: Array(7).fill(0), weekStart: getMonday().toISOString() };
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) throw new Error();
    const parsed = JSON.parse(raw) as Stats;
    const currentMonday = getMonday().toISOString();
    if (parsed.weekStart !== currentMonday) {
      return { pomodoros: 0, focusSeconds: 0, breaks: 0, week: Array(7).fill(0), weekStart: currentMonday };
    }
    return parsed;
  } catch {
    return { pomodoros: 0, focusSeconds: 0, breaks: 0, week: Array(7).fill(0), weekStart: getMonday().toISOString() };
  }
}

function format(t: number) {
  const m = Math.floor(t / 60).toString().padStart(2, "0");
  const s = (t % 60).toString().padStart(2, "0");
  return `${m}:${s}`;
}

export function PomodoroApp() {
  const [focusMin, setFocusMin] = useState(25);
  const [restMin, setRestMin] = useState(5);
  const [mode, setMode] = useState<Mode>("focus");
  const [remaining, setRemaining] = useState(25 * 60);
  const [running, setRunning] = useState(false);
  const [stats, setStats] = useState<Stats>(() => loadStats());
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  const total = (mode === "focus" ? focusMin : restMin) * 60;
  const progress = 1 - remaining / total;

  // Persist stats
  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(stats));
  }, [stats]);

  // Reset remaining when mode or durations change while not running
  useEffect(() => {
    if (!running) setRemaining((mode === "focus" ? focusMin : restMin) * 60);
  }, [focusMin, restMin, mode, running]);

  useEffect(() => {
    if (!running) {
      if (intervalRef.current) clearInterval(intervalRef.current);
      return;
    }
    intervalRef.current = setInterval(() => {
      setRemaining((r) => {
        if (r <= 1) {
          // session complete
          setRunning(false);
          setStats((s) => {
            const dayIdx = (new Date().getDay() + 6) % 7;
            if (mode === "focus") {
              const week = [...s.week];
              week[dayIdx] = (week[dayIdx] || 0) + 1;
              return {
                ...s,
                pomodoros: s.pomodoros + 1,
                focusSeconds: s.focusSeconds + focusMin * 60,
                week,
              };
            } else {
              return { ...s, breaks: s.breaks + 1 };
            }
          });
          // auto-switch mode
          const next: Mode = mode === "focus" ? "rest" : "focus";
          setMode(next);
          return (next === "focus" ? focusMin : restMin) * 60;
        }
        return r - 1;
      });
    }, 1000);
    return () => {
      if (intervalRef.current) clearInterval(intervalRef.current);
    };
  }, [running, mode, focusMin, restMin]);

  const handleStart = () => setRunning(true);
  const handlePause = () => setRunning(false);
  const handleReset = () => {
    setRunning(false);
    setRemaining((mode === "focus" ? focusMin : restMin) * 60);
  };

  const switchMode = (m: Mode) => {
    setRunning(false);
    setMode(m);
    setRemaining((m === "focus" ? focusMin : restMin) * 60);
  };

  const concentration = useMemo(() => {
    const sessions = stats.pomodoros + stats.breaks;
    if (sessions === 0) return 0;
    return Math.round((stats.pomodoros / sessions) * 100);
  }, [stats]);

  // Circle math
  const size = 340;
  const stroke = 14;
  const radius = (size - stroke) / 2;
  const circumference = 2 * Math.PI * radius;
  const offset = circumference * (1 - progress);

  const days = ["L", "M", "X", "J", "V", "S", "D"];
  const maxDay = Math.max(1, ...stats.week);

  return (
    <div className="min-h-screen bg-background text-foreground">
      {/* ambient gradient */}
      <div className="pointer-events-none fixed inset-0 overflow-hidden">
        <div className="absolute -top-40 left-1/2 h-[500px] w-[800px] -translate-x-1/2 rounded-full bg-[var(--focus)] opacity-[0.08] blur-3xl" />
        <div className="absolute bottom-0 right-0 h-[400px] w-[400px] rounded-full bg-[var(--pink-accent)] opacity-[0.06] blur-3xl" />
      </div>

      <div className="relative mx-auto max-w-6xl px-6 py-10">
        {/* Header */}
        <header className="mb-10 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="grid h-10 w-10 place-items-center rounded-xl bg-surface-elevated ring-1 ring-border">
              <Flame className="h-5 w-5 text-[var(--pink-accent)]" />
            </div>
            <div>
              <h1 className="text-lg font-semibold tracking-tight">Focusly</h1>
              <p className="text-xs text-muted-foreground">Pomodoro · Productividad</p>
            </div>
          </div>
          <div className="hidden gap-1 rounded-full bg-surface p-1 ring-1 ring-border sm:flex">
            <button
              onClick={() => switchMode("focus")}
              className={`flex items-center gap-2 rounded-full px-4 py-1.5 text-sm transition ${
                mode === "focus"
                  ? "bg-surface-elevated text-foreground shadow-soft"
                  : "text-muted-foreground hover:text-foreground"
              }`}
            >
              <Brain className="h-3.5 w-3.5" /> Enfoque
            </button>
            <button
              onClick={() => switchMode("rest")}
              className={`flex items-center gap-2 rounded-full px-4 py-1.5 text-sm transition ${
                mode === "rest"
                  ? "bg-surface-elevated text-foreground shadow-soft"
                  : "text-muted-foreground hover:text-foreground"
              }`}
            >
              <Coffee className="h-3.5 w-3.5" /> Descanso
            </button>
          </div>
        </header>

        <div className="grid gap-8 lg:grid-cols-[1.1fr_1fr]">
          {/* Timer card */}
          <section className="rounded-3xl bg-surface p-8 ring-1 ring-border shadow-soft">
            <div className="flex flex-col items-center">
              <div className="relative" style={{ width: size, height: size }}>
                <svg width={size} height={size} className="-rotate-90">
                  <defs>
                    <linearGradient id="ring-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                      <stop offset="0%" stopColor="var(--rest)" />
                      <stop offset="50%" stopColor="var(--focus)" />
                      <stop offset="100%" stopColor="var(--pink-accent)" />
                    </linearGradient>
                  </defs>
                  <circle
                    cx={size / 2}
                    cy={size / 2}
                    r={radius}
                    fill="none"
                    stroke="var(--border)"
                    strokeWidth={stroke}
                    opacity={0.4}
                  />
                  <circle
                    cx={size / 2}
                    cy={size / 2}
                    r={radius}
                    fill="none"
                    stroke="url(#ring-gradient)"
                    strokeWidth={stroke}
                    strokeLinecap="round"
                    strokeDasharray={circumference}
                    strokeDashoffset={offset}
                    style={{ transition: "stroke-dashoffset 0.9s linear" }}
                  />
                </svg>
                <div className="absolute inset-0 flex flex-col items-center justify-center">
                  <span className="font-mono text-7xl font-semibold tracking-tight tabular-nums">
                    {format(remaining)}
                  </span>
                  <span
                    className={`mt-3 inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-medium ring-1 ${
                      mode === "focus"
                        ? "bg-[var(--focus)]/10 text-[var(--focus)] ring-[var(--focus)]/30"
                        : "bg-[var(--rest)]/10 text-[var(--rest)] ring-[var(--rest)]/30"
                    } ${running ? "animate-pulse-glow" : ""}`}
                  >
                    {mode === "focus" ? <Brain className="h-3 w-3" /> : <Coffee className="h-3 w-3" />}
                    {mode === "focus" ? "Enfoque" : "Descanso"}
                  </span>
                </div>
              </div>

              {/* Controls */}
              <div className="mt-8 flex items-center gap-3">
                {running ? (
                  <button
                    onClick={handlePause}
                    className="flex items-center gap-2 rounded-full bg-surface-elevated px-6 py-3 text-sm font-medium ring-1 ring-border transition hover:bg-accent"
                  >
                    <Pause className="h-4 w-4" /> Pausar
                  </button>
                ) : (
                  <button
                    onClick={handleStart}
                    className="flex items-center gap-2 rounded-full bg-[var(--focus)] px-7 py-3 text-sm font-semibold text-primary-foreground shadow-glow transition hover:opacity-90"
                  >
                    <Play className="h-4 w-4" /> Iniciar
                  </button>
                )}
                <button
                  onClick={handleReset}
                  className="flex items-center gap-2 rounded-full bg-surface-elevated px-6 py-3 text-sm font-medium ring-1 ring-border transition hover:bg-accent"
                >
                  <RotateCcw className="h-4 w-4" /> Reiniciar
                </button>
              </div>

              {/* Duration inputs */}
              <div className="mt-8 grid w-full max-w-sm grid-cols-2 gap-3">
                <DurationInput
                  label="Enfoque"
                  value={focusMin}
                  onChange={setFocusMin}
                  accent="var(--focus)"
                />
                <DurationInput
                  label="Descanso"
                  value={restMin}
                  onChange={setRestMin}
                  accent="var(--rest)"
                />
              </div>
            </div>
          </section>

          {/* Right column: stats + week */}
          <section className="flex flex-col gap-6">
            <div className="rounded-3xl bg-surface p-6 ring-1 ring-border shadow-soft">
              <div className="mb-5 flex items-center justify-between">
                <h2 className="text-sm font-semibold">Hoy</h2>
                <span className="text-xs text-muted-foreground">Resumen del día</span>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <MetricCard
                  icon={<Flame className="h-4 w-4" />}
                  label="Pomodoros"
                  value={String(stats.pomodoros)}
                  color="var(--pink-accent)"
                />
                <MetricCard
                  icon={<Clock className="h-4 w-4" />}
                  label="Tiempo enfocado"
                  value={`${Math.floor(stats.focusSeconds / 60)}m`}
                  color="var(--focus)"
                />
                <MetricCard
                  icon={<Target className="h-4 w-4" />}
                  label="Concentración"
                  value={`${concentration}%`}
                  color="var(--rest)"
                />
                <MetricCard
                  icon={<Trees className="h-4 w-4" />}
                  label="Descansos"
                  value={String(stats.breaks)}
                  color="var(--focus)"
                />
              </div>
            </div>

            <div className="rounded-3xl bg-surface p-6 ring-1 ring-border shadow-soft">
              <div className="mb-6 flex items-center justify-between">
                <div>
                  <h2 className="text-sm font-semibold">Historial semanal</h2>
                  <p className="text-xs text-muted-foreground">Pomodoros por día</p>
                </div>
                <span className="rounded-full bg-surface-elevated px-3 py-1 text-xs text-muted-foreground ring-1 ring-border">
                  {stats.week.reduce((a, b) => a + b, 0)} totales
                </span>
              </div>
              <div className="flex h-44 items-end justify-between gap-2">
                {stats.week.map((count, i) => {
                  const h = (count / maxDay) * 100;
                  const today = (new Date().getDay() + 6) % 7 === i;
                  return (
                    <div key={i} className="flex flex-1 flex-col items-center gap-2">
                      <div className="relative flex h-full w-full items-end">
                        <div
                          className="w-full rounded-lg transition-all duration-700"
                          style={{
                            height: `${Math.max(h, 4)}%`,
                            background: today
                              ? "linear-gradient(180deg, var(--pink-accent), var(--focus))"
                              : "linear-gradient(180deg, var(--focus), oklch(0.4 0.08 263))",
                            opacity: count === 0 ? 0.25 : 1,
                          }}
                        />
                      </div>
                      <span
                        className={`text-[11px] ${
                          today ? "font-semibold text-foreground" : "text-muted-foreground"
                        }`}
                      >
                        {days[i]}
                      </span>
                    </div>
                  );
                })}
              </div>
            </div>
          </section>
        </div>

        <footer className="mt-10 text-center text-xs text-muted-foreground">
          Diseñado para enfocarte profundamente.
        </footer>
      </div>
    </div>
  );
}

function DurationInput({
  label,
  value,
  onChange,
  accent,
}: {
  label: string;
  value: number;
  onChange: (n: number) => void;
  accent: string;
}) {
  return (
    <div className="rounded-2xl bg-surface-elevated p-4 ring-1 ring-border">
      <div className="flex items-center justify-between">
        <span className="text-xs text-muted-foreground">{label}</span>
        <span className="h-2 w-2 rounded-full" style={{ background: accent }} />
      </div>
      <div className="mt-2 flex items-center gap-2">
        <button
          onClick={() => onChange(Math.max(1, value - 1))}
          className="grid h-8 w-8 place-items-center rounded-lg bg-surface text-muted-foreground ring-1 ring-border transition hover:text-foreground"
          aria-label="decrease"
        >
          −
        </button>
        <input
          type="number"
          min={1}
          max={120}
          value={value}
          onChange={(e) => onChange(Math.max(1, Math.min(120, Number(e.target.value) || 1)))}
          className="w-full bg-transparent text-center font-mono text-2xl font-semibold tabular-nums outline-none"
        />
        <button
          onClick={() => onChange(Math.min(120, value + 1))}
          className="grid h-8 w-8 place-items-center rounded-lg bg-surface text-muted-foreground ring-1 ring-border transition hover:text-foreground"
          aria-label="increase"
        >
          +
        </button>
      </div>
      <p className="mt-1 text-center text-[10px] uppercase tracking-wider text-muted-foreground">
        minutos
      </p>
    </div>
  );
}

function MetricCard({
  icon,
  label,
  value,
  color,
}: {
  icon: React.ReactNode;
  label: string;
  value: string;
  color: string;
}) {
  return (
    <div className="rounded-2xl bg-surface-elevated p-4 ring-1 ring-border">
      <div
        className="mb-3 grid h-8 w-8 place-items-center rounded-lg"
        style={{ background: `color-mix(in oklab, ${color} 18%, transparent)`, color }}
      >
        {icon}
      </div>
      <div className="text-2xl font-semibold tabular-nums">{value}</div>
      <div className="mt-0.5 text-xs text-muted-foreground">{label}</div>
    </div>
  );
}
