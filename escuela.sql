-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-10-2025 a las 22:30:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `escuela`
--
CREATE DATABASE IF NOT EXISTS `escuela` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `escuela`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencias`
--

DROP TABLE IF EXISTS `asistencias`;
CREATE TABLE `asistencias` (
  `id` int(11) NOT NULL,
  `estudiante_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `presente` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asistencias`
--

INSERT INTO `asistencias` (`id`, `estudiante_id`, `fecha`, `presente`) VALUES
(1, 1, '2025-09-25', 1),
(2, 2, '2025-09-25', 1),
(3, 3, '2025-09-25', 0),
(4, 4, '2025-09-25', 1),
(5, 1, '2025-09-26', 0),
(6, 2, '2025-09-26', 1),
(7, 3, '2025-09-26', 1),
(8, 4, '2025-09-26', 1);

--
-- Disparadores `asistencias`
--
DROP TRIGGER IF EXISTS `trg_asistencias_insert`;
DELIMITER $$
CREATE TRIGGER `trg_asistencias_insert` AFTER INSERT ON `asistencias` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Asistencias', 'INSERT', CONCAT('Se insertó asistencia del estudiante ID ', NEW.estudiante_id, ' en fecha ', NEW.fecha), NOW())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_asistencias_update`;
DELIMITER $$
CREATE TRIGGER `trg_asistencias_update` AFTER UPDATE ON `asistencias` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Asistencias', 'UPDATE', CONCAT('Se actualizó asistencia del estudiante ID ', NEW.estudiante_id, ' en fecha ', NEW.fecha), NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

DROP TABLE IF EXISTS `auditoria`;
CREATE TABLE `auditoria` (
  `id` int(11) NOT NULL,
  `tabla_afectada` varchar(50) NOT NULL,
  `tipo_accion` varchar(20) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`id`, `tabla_afectada`, `tipo_accion`, `descripcion`, `fecha`) VALUES
(1, 'Estudiantes', 'INSERT', 'Se insertaron 4 estudiantes', '2025-09-29 21:16:42'),
(2, 'Profesores', 'INSERT', 'Se insertaron 4 profesores', '2025-09-29 21:16:42'),
(3, 'Padres', 'INSERT', 'Se insertaron 4 padres', '2025-09-29 21:16:42'),
(4, 'Asistencias', 'INSERT', 'Se insertaron 8 asistencias', '2025-09-29 21:16:42'),
(5, 'Calificaciones', 'INSERT', 'Se insertaron 5 calificaciones', '2025-09-29 21:16:42'),
(6, 'Calificaciones', 'UPDATE', 'Se actualizó calificación en Historia con nota 7.00 al estudiante ID 3', '2025-10-12 17:37:17'),
(7, 'Calificaciones', 'UPDATE', 'Se actualizó calificación en Historia con nota 6.50 al estudiante ID 3', '2025-10-12 17:42:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
CREATE TABLE `calificaciones` (
  `id` int(11) NOT NULL,
  `estudiante_id` int(11) NOT NULL,
  `materia` varchar(100) NOT NULL,
  `nota` decimal(5,2) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`id`, `estudiante_id`, `materia`, `nota`, `fecha`) VALUES
(1, 1, 'Matemáticas', 8.70, '2025-10-12'),
(2, 1, 'Lengua', 9.00, '2025-09-21'),
(3, 2, 'Ciencias', 7.80, '2025-09-22'),
(4, 3, 'Historia', 6.50, '2025-10-12'),
(5, 4, 'Lengua', 8.00, '2025-09-24');

--
-- Disparadores `calificaciones`
--
DROP TRIGGER IF EXISTS `trg_calificaciones_insert`;
DELIMITER $$
CREATE TRIGGER `trg_calificaciones_insert` AFTER INSERT ON `calificaciones` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Calificaciones', 'INSERT', CONCAT('Se insertó calificación en ', NEW.materia, ' con nota ', NEW.nota, ' al estudiante ID ', NEW.estudiante_id), NOW())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_calificaciones_update`;
DELIMITER $$
CREATE TRIGGER `trg_calificaciones_update` AFTER UPDATE ON `calificaciones` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Calificaciones', 'UPDATE', CONCAT('Se actualizó calificación en ', NEW.materia, ' con nota ', NEW.nota, ' al estudiante ID ', NEW.estudiante_id), NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
CREATE TABLE `estudiantes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `grado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`id`, `nombre`, `apellido`, `fecha_nacimiento`, `grado`) VALUES
(1, 'Luis', 'Pérez', '2010-05-15', 6),
(2, 'María', 'Gómez', '2011-08-20', 4),
(3, 'Juan', 'Rodríguez', '2009-02-10', 6),
(4, 'Ana', 'Martínez', '2012-11-05', 3),
(5, 'Master', 'Perez', '1997-04-03', 7),
(6, 'Carla', 'Perez', '2009-03-12', 8);

--
-- Disparadores `estudiantes`
--
DROP TRIGGER IF EXISTS `trg_estudiantes_insert`;
DELIMITER $$
CREATE TRIGGER `trg_estudiantes_insert` AFTER INSERT ON `estudiantes` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Estudiantes', 'INSERT', CONCAT('Se insertó el estudiante: ', NEW.nombre, ' ', NEW.apellido), NOW())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_estudiantes_update`;
DELIMITER $$
CREATE TRIGGER `trg_estudiantes_update` AFTER UPDATE ON `estudiantes` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Estudiantes', 'UPDATE', CONCAT('Se actualizó el estudiante: ', NEW.nombre, ' ', NEW.apellido), NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `padres`
--

DROP TABLE IF EXISTS `padres`;
CREATE TABLE `padres` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estudiante_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `padres`
--

INSERT INTO `padres` (`id`, `nombre`, `telefono`, `estudiante_id`) VALUES
(1, 'José Pérez', '809-555-1234', 1),
(2, 'Laura Gómez', '555-5678', 2),
(3, 'Miguel Rodríguez', '555-9012', 3),
(4, 'Sandra Martínez', '555-3456', 4);

--
-- Disparadores `padres`
--
DROP TRIGGER IF EXISTS `trg_padres_insert`;
DELIMITER $$
CREATE TRIGGER `trg_padres_insert` AFTER INSERT ON `padres` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Padres', 'INSERT', CONCAT('Se insertó el padre/madre: ', NEW.nombre), NOW())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_padres_update`;
DELIMITER $$
CREATE TRIGGER `trg_padres_update` AFTER UPDATE ON `padres` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Padres', 'UPDATE', CONCAT('Se actualizó el padre/madre: ', NEW.nombre), NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

DROP TABLE IF EXISTS `profesores`;
CREATE TABLE `profesores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `especialidad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO `profesores` (`id`, `nombre`, `especialidad`) VALUES
(1, 'Carlos Ramírez', 'Matemáticas'),
(2, 'Elena Torres', 'Ciencias Naturales'),
(3, 'Jorge Herrera', 'Lengua'),
(4, 'Lucía Fernández', 'Historia'),
(5, 'Maria Rodriguez', 'Fisica');

--
-- Disparadores `profesores`
--
DROP TRIGGER IF EXISTS `trg_profesores_insert`;
DELIMITER $$
CREATE TRIGGER `trg_profesores_insert` AFTER INSERT ON `profesores` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Profesores', 'INSERT', CONCAT('Se insertó el profesor: ', NEW.nombre), NOW())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_profesores_update`;
DELIMITER $$
CREATE TRIGGER `trg_profesores_update` AFTER UPDATE ON `profesores` FOR EACH ROW INSERT INTO auditoria (tabla_afectada, tipo_accion, descripcion, fecha)
VALUES ('Profesores', 'UPDATE', CONCAT('Se actualizó el profesor: ', NEW.nombre), NOW())
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estudiante_id` (`estudiante_id`);

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estudiante_id` (`estudiante_id`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `padres`
--
ALTER TABLE `padres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estudiante_id` (`estudiante_id`);

--
-- Indices de la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencias`
--
ALTER TABLE `asistencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `padres`
--
ALTER TABLE `padres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `profesores`
--
ALTER TABLE `profesores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencias`
--
ALTER TABLE `asistencias`
  ADD CONSTRAINT `asistencias_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `padres`
--
ALTER TABLE `padres`
  ADD CONSTRAINT `padres_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
