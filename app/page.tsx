import { getServerSession } from "next-auth/next";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";

export default async function Home() {
  const session = await getServerSession(authOptions);

  return (
    <div className="flex flex-col flex-1 items-center justify-center bg-gray-50 p-6">
      <div className="text-center max-w-3xl mx-auto">
        {session ? (
          <h1 className="text-5xl md:text-7xl font-extrabold text-gray-900 tracking-tight">
            Hola <span className="text-[#f07639]">{session.user?.name}</span>
          </h1>
        ) : (
          <h1 className="text-5xl md:text-7xl font-extrabold text-gray-900 tracking-tight">
            Hola <span className="text-[#f07639]">mundo</span>
          </h1>
        )}
        <p className="mt-6 text-xl text-gray-600 leading-relaxed">
          Bienvenido al sistema web de <strong>El Cumbe</strong>. 
          <br className="hidden md:block" />
          Compra tus pasajes y revisa el historial de tus viajes de manera rápida y segura.
        </p>
      </div>
    </div>
  );
}
