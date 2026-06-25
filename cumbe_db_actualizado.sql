-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-06-2026 a las 05:58:56
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cumbe_db`
--

CREATE DATABASE IF NOT EXISTS `cumbe_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `cumbe_db`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `pasaje`;
DROP TABLE IF EXISTS `encomienda`;
DROP TABLE IF EXISTS `codigodescuento`;
DROP TABLE IF EXISTS `asientoviaje`;
DROP TABLE IF EXISTS `viaje`;
DROP TABLE IF EXISTS `ruta`;
DROP TABLE IF EXISTS `bus`;
DROP TABLE IF EXISTS `sucursal`;
DROP TABLE IF EXISTS `usuario`;
DROP TABLE IF EXISTS `cliente`;
DROP TABLE IF EXISTS `verification_codes`;

SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bus`
--

CREATE TABLE `bus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `placa` varchar(15) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `capacidad` int(11) NOT NULL,
  `pisos` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta`
--

CREATE TABLE `ruta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `origen_id` bigint(20) UNSIGNED NOT NULL,
  `destino_id` bigint(20) UNSIGNED NOT NULL,
  `duracion_estimada_minutos` int(11) NOT NULL,
  `precio_base` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje`
--

CREATE TABLE `viaje` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ruta_id` bigint(20) UNSIGNED NOT NULL,
  `bus_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_salida` datetime NOT NULL,
  `fecha_llegada` datetime DEFAULT NULL,
  `estado` varchar(191) NOT NULL DEFAULT 'programado',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` varchar(191) NOT NULL DEFAULT 'operario',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `dni` varchar(15) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asientoviaje`
--

CREATE TABLE `asientoviaje` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `viaje_id` bigint(20) UNSIGNED NOT NULL,
  `numero_asiento` int(11) NOT NULL,
  `piso` int(11) NOT NULL DEFAULT 1,
  `estado` varchar(191) NOT NULL DEFAULT 'disponible',
  `bloqueado_por_usuario_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bloqueado_en` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pasaje`
--

CREATE TABLE `pasaje` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `asiento_viaje_id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `fecha_compra` timestamp NULL DEFAULT current_timestamp(),
  `codigo_qr` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encomienda`
--

CREATE TABLE `encomienda` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo_seguimiento` varchar(50) NOT NULL,
  `remitente_nombre` varchar(255) NOT NULL,
  `remitente_dni` varchar(15) NOT NULL,
  `destinatario_nombre` varchar(255) NOT NULL,
  `destinatario_dni` varchar(15) NOT NULL,
  `origen_id` bigint(20) UNSIGNED NOT NULL,
  `destino_id` bigint(20) UNSIGNED NOT NULL,
  `viaje_id` bigint(20) UNSIGNED DEFAULT NULL,
  `peso_kg` decimal(5,2) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(8,2) NOT NULL,
  `estado` varchar(191) NOT NULL DEFAULT 'recepcionado',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigodescuento`
--

CREATE TABLE `codigodescuento` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `porcentaje_descuento` int(11) NOT NULL DEFAULT 10,
  `esta_usado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_expiracion` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `verification_codes`
--

CREATE TABLE `verification_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(10) NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Índices para tablas volcadas
--

ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `bus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Bus_placa_key` (`placa`);

ALTER TABLE `ruta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Ruta_origen_id_fkey` (`origen_id`),
  ADD KEY `Ruta_destino_id_fkey` (`destino_id`);

ALTER TABLE `viaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Viaje_ruta_id_fkey` (`ruta_id`),
  ADD KEY `Viaje_bus_id_fkey` (`bus_id`);

ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Usuario_correo_key` (`correo`);

ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Cliente_correo_key` (`correo`),
  ADD UNIQUE KEY `Cliente_dni_key` (`dni`);

ALTER TABLE `asientoviaje`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `AsientoViaje_viaje_id_numero_asiento_key` (`viaje_id`,`numero_asiento`),
  ADD KEY `AsientoViaje_bloqueado_por_usuario_id_fkey` (`bloqueado_por_usuario_id`);

ALTER TABLE `pasaje`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Pasaje_asiento_viaje_id_key` (`asiento_viaje_id`),
  ADD UNIQUE KEY `Pasaje_codigo_qr_key` (`codigo_qr`),
  ADD KEY `Pasaje_usuario_id_fkey` (`usuario_id`);

ALTER TABLE `encomienda`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Encomienda_codigo_seguimiento_key` (`codigo_seguimiento`),
  ADD KEY `Encomienda_origen_id_fkey` (`origen_id`),
  ADD KEY `Encomienda_destino_id_fkey` (`destino_id`),
  ADD KEY `Encomienda_viaje_id_fkey` (`viaje_id`);

ALTER TABLE `codigodescuento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `CodigoDescuento_codigo_key` (`codigo`),
  ADD KEY `CodigoDescuento_usuario_id_fkey` (`usuario_id`);

ALTER TABLE `verification_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verification_codes_user_id_fkey` (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

ALTER TABLE `sucursal` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `bus` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `ruta` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
ALTER TABLE `viaje` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `usuario` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `cliente` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `asientoviaje` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `pasaje` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `encomienda` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `codigodescuento` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `verification_codes` MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones de tablas volcadas (Claves Foráneas)
--

ALTER TABLE `ruta`
  ADD CONSTRAINT `Ruta_destino_id_fkey` FOREIGN KEY (`destino_id`) REFERENCES `sucursal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Ruta_origen_id_fkey` FOREIGN KEY (`origen_id`) REFERENCES `sucursal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `viaje`
  ADD CONSTRAINT `Viaje_bus_id_fkey` FOREIGN KEY (`bus_id`) REFERENCES `bus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Viaje_ruta_id_fkey` FOREIGN KEY (`ruta_id`) REFERENCES `ruta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `asientoviaje`
  ADD CONSTRAINT `AsientoViaje_bloqueado_por_usuario_id_fkey` FOREIGN KEY (`bloqueado_por_usuario_id`) REFERENCES `cliente` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `AsientoViaje_viaje_id_fkey` FOREIGN KEY (`viaje_id`) REFERENCES `viaje` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `pasaje`
  ADD CONSTRAINT `Pasaje_asiento_viaje_id_fkey` FOREIGN KEY (`asiento_viaje_id`) REFERENCES `asientoviaje` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Pasaje_usuario_id_fkey` FOREIGN KEY (`usuario_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `encomienda`
  ADD CONSTRAINT `Encomienda_destino_id_fkey` FOREIGN KEY (`destino_id`) REFERENCES `sucursal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Encomienda_origen_id_fkey` FOREIGN KEY (`origen_id`) REFERENCES `sucursal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Encomienda_viaje_id_fkey` FOREIGN KEY (`viaje_id`) REFERENCES `viaje` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `codigodescuento`
  ADD CONSTRAINT `CodigoDescuento_usuario_id_fkey` FOREIGN KEY (`usuario_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `verification_codes`
  ADD CONSTRAINT `verification_codes_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Volcado de datos para la tabla `sucursal`
--
INSERT INTO `sucursal` (`id`, `nombre`, `direccion`, `created_at`, `updated_at`) VALUES
(1, 'Cajamarca', 'Av. Atahualpa 123', NOW(), NOW()),
(2, 'Chiclayo', 'Av. Bolognesi 456', NOW(), NOW()),
(3, 'Trujillo', 'Av. Nicolás de Piérola 789', NOW(), NOW()),
(4, 'Jaén', 'Av. Pakamuros 456', NOW(), NOW());

--
-- Volcado de datos para la tabla `bus`
--
INSERT INTO `bus` (`id`, `placa`, `marca`, `capacidad`, `pisos`, `created_at`, `updated_at`) VALUES
(1, 'T4A-950', 'Mercedes-Benz', 40, 1, NOW(), NOW()),
(2, 'C6B-720', 'Scania', 60, 2, NOW(), NOW()),
(3, 'A8C-110', 'Volvo', 40, 1, NOW(), NOW());

--
-- Volcado de datos para la tabla `ruta`
--
INSERT INTO `ruta` (`id`, `origen_id`, `destino_id`, `duracion_estimada_minutos`, `precio_base`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 360, 40.00, NOW(), NOW()), -- Cajamarca -> Chiclayo
(2, 2, 1, 360, 40.00, NOW(), NOW()), -- Chiclayo -> Cajamarca
(3, 1, 3, 420, 50.00, NOW(), NOW()), -- Cajamarca -> Trujillo
(4, 3, 1, 420, 50.00, NOW(), NOW()), -- Trujillo -> Cajamarca
(5, 1, 4, 360, 45.00, NOW(), NOW()), -- Cajamarca -> Jaén
(6, 4, 1, 360, 45.00, NOW(), NOW()), -- Jaén -> Cajamarca
(7, 2, 4, 360, 40.00, NOW(), NOW()), -- Chiclayo -> Jaén
(8, 4, 2, 360, 40.00, NOW(), NOW()); -- Jaén -> Chiclayo

--
-- Volcado de datos para la tabla `usuario`
--
INSERT INTO `usuario` (`id`, `nombre`, `correo`, `contrasena`, `rol`, `created_at`, `updated_at`) VALUES
(1, 'Administrador El Cumbe', 'admin@elcumbe.com', '$2b$10$o2vxXx27hI6NER448hBaVOgS7mHvHx.hik0OQhv2k.iebDqpTrzk6', 'admin', NOW(), NOW()),
(2, 'Operario Cajamarca', 'operario@elcumbe.com', '$2b$10$3sjnlWXAZjw5I6LsV5zFu.Y/Dx06vbs47w4Xt4kfYdmALIeE6GuPy', 'operario', NOW(), NOW());

--
-- Volcado de datos para la tabla `cliente`
--
INSERT INTO `cliente` (`id`, `nombre`, `correo`, `contrasena`, `dni`, `telefono`, `fecha_nacimiento`, `created_at`, `updated_at`) VALUES
(1, 'Cliente de Prueba', 'cliente@elcumbe.com', '$2b$10$3sjnlWXAZjw5I6LsV5zFu.Y/Dx06vbs47w4Xt4kfYdmALIeE6GuPy', '33333333', '977777777', '1995-05-15', NOW(), NOW());

--
-- Volcado de datos para la tabla `viaje`
--
INSERT INTO `viaje` (`id`, `ruta_id`, `bus_id`, `fecha_salida`, `fecha_llegada`, `estado`, `created_at`, `updated_at`) VALUES
-- Viajes de Cajamarca a Chiclayo
(1, 1, 1, DATE_ADD(CURDATE(), INTERVAL 8 HOUR), DATE_ADD(CURDATE(), INTERVAL 14 HOUR), 'programado', NOW(), NOW()), -- Hoy 08:00 AM
(2, 1, 2, DATE_ADD(CURDATE(), INTERVAL 14 HOUR), DATE_ADD(CURDATE(), INTERVAL 20 HOUR), 'programado', NOW(), NOW()), -- Hoy 02:00 PM
(3, 1, 3, DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 8 HOUR), DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 14 HOUR), 'programado', NOW(), NOW()), -- Mañana 08:00 AM
-- Viajes de Cajamarca a Trujillo
(4, 3, 2, DATE_ADD(CURDATE(), INTERVAL 10 HOUR), DATE_ADD(CURDATE(), INTERVAL 17 HOUR), 'programado', NOW(), NOW()), -- Hoy 10:00 AM
(5, 3, 1, DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 15 HOUR), DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 22 HOUR), 'programado', NOW(), NOW()); -- Mañana 03:00 PM

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
