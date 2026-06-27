import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const viajes = await prisma.viaje.findMany({
    where: { estado: 'programado' },
    include: { bus: true }
  });

  let count = 0;

  for (const viaje of viajes) {
    if (viaje.bus && (viaje.bus as any).asientos_restringidos) {
      try {
        const restringidos: number[] = JSON.parse((viaje.bus as any).asientos_restringidos);
        if (restringidos.length > 0) {
          const res = await prisma.asientoViaje.updateMany({
            where: {
              viaje_id: viaje.id,
              numero_asiento: { in: restringidos },
              estado: 'disponible' // Only update if currently disponible, don't overwrite ocupado
            },
            data: { estado: 'inactivo' }
          });
          count += res.count;
          
          // Also set anything NOT in restringidos back to disponible (only if it was inactivo)
          await prisma.asientoViaje.updateMany({
            where: {
              viaje_id: viaje.id,
              numero_asiento: { notIn: restringidos },
              estado: 'inactivo'
            },
            data: { estado: 'disponible' }
          });
        }
      } catch (e) {
        console.error("Error parsing", e);
      }
    }
  }

  console.log(`Updated ${count} seats to inactivo.`);
}

main()
  .catch(e => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
