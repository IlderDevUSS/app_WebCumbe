"use client";

import Link from "next/link";
import { Ticket } from "lucide-react";
import { usePathname } from "next/navigation";

export default function FloatingTicketButton() {
  const pathname = usePathname();

  // No mostrar el botón si ya estamos en el perfil
  if (pathname === "/perfil") {
    return null;
  }

  return (
    <Link
      href="/perfil?tab=tickets"
      className="fixed bottom-6 right-6 z-50 flex items-center gap-2 bg-[#f07639] hover:bg-orange-600 text-white px-5 py-3.5 rounded-full shadow-2xl shadow-orange-500/30 transition-all hover:scale-105 active:scale-95 group border border-white"
    >
      <Ticket className="w-5 h-5 group-hover:rotate-12 transition-transform" />
      <span className="font-bold text-sm md:text-base hidden sm:inline-block tracking-wide">Mis Pasajes</span>
    </Link>
  );
}
