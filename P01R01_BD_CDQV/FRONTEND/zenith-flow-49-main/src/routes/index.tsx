import { createFileRoute } from "@tanstack/react-router";
import { PomodoroApp } from "@/components/PomodoroApp";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "Focusly — Pomodoro y productividad" },
      { name: "description", content: "Temporizador Pomodoro elegante con métricas de productividad e historial semanal." },
      { property: "og:title", content: "Focusly — Pomodoro y productividad" },
      { property: "og:description", content: "Temporizador Pomodoro elegante con métricas de productividad e historial semanal." },
    ],
  }),
  component: PomodoroApp,
});
