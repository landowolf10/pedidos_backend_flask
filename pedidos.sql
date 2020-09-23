-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-09-2020 a las 07:51:03
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pedidos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_product` (IN `id_producto` INT)  BEGIN
	DELETE FROM productos
    WHERE id = id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user` (IN `id_usuario` INT)  BEGIN
	DELETE FROM usuarios
    WHERE id = id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_producto` (IN `nombre_producto` VARCHAR(300), IN `categoria_producto` VARCHAR(100), IN `precio_producto` DECIMAL(10,2), IN `imagen_producto` VARCHAR(200), IN `desc_producto` VARCHAR(500))  BEGIN
	INSERT INTO productos(nombre, categoria, precio, imagen, descripcion)
    VALUES(nombre_producto, categoria_producto, precio_producto, imagen_producto, desc_producto);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_usuario` (IN `email_u` VARCHAR(100), IN `nombre_u` VARCHAR(30), IN `apellido_p` VARCHAR(30), IN `apellido_m` VARCHAR(30), IN `tel` VARCHAR(10), IN `estado_u` VARCHAR(30), IN `ciudad_u` VARCHAR(30), IN `colonia_u` VARCHAR(30), IN `calle_u` VARCHAR(30), IN `numero_u` VARCHAR(30), IN `pass_u` VARCHAR(20), IN `tipo_u` VARCHAR(30), IN `token` VARCHAR(200))  BEGIN
	INSERT INTO usuarios (email, nombre, apellido_paterno, apellido_materno, telefono, estado, ciudad, colonia, calle, numero, pass, tipo_usuario, firebase_token)  VALUES
	(email_u, nombre_u, apellido_p, apellido_m, tel, estado_u, ciudad_u, colonia_u, calle_u, numero_u, pass_u, tipo_u, token);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `email_u` VARCHAR(100), IN `pass_u` VARCHAR(20), IN `token` VARCHAR(200))  BEGIN
	SELECT * 
    FROM usuarios
    WHERE email = email_u AND pass = pass_u;
    
    IF NOT EXISTS
    (
    	SELECT u.firebase_token
        FROM usuarios AS u
        WHERE email = email_u AND pass = pass_u
    ) THEN
    	INSERT INTO usuarios (email, pass, firebase_token)  VALUES
		(email_u, pass_u, token);
    ELSE
    	UPDATE usuarios SET firebase_token = token
        WHERE email = email_u AND pass = pass_u;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_bebidas` ()  BEGIN
	SELECT p.nombre, p.precio, p.categoria, p.imagen, p.descripcion
    FROM productos AS p
    WHERE p.categoria = 'Bebida';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_entradas` ()  BEGIN
	SELECT p.nombre, p.precio, p.categoria, p.imagen, p.descripcion
    FROM productos AS p
    WHERE p.categoria = 'Entrada';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_platillos` ()  BEGIN
	SELECT p.nombre, p.precio, p.categoria, p.imagen, p.descripcion
    FROM productos AS p
    WHERE p.categoria = 'Platillo';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_postres` ()  BEGIN
	SELECT p.nombre, p.precio, p.categoria, p.imagen, p.descripcion
    FROM productos AS p
    WHERE p.categoria = 'Postre';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetImages` ()  BEGIN
	SELECT p.imagen
    FROM productos AS p;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetUsers` ()  BEGIN
	SELECT *
    FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_product` (IN `id_producto` INT, IN `nombre_producto` VARCHAR(300), IN `categoria_producto` VARCHAR(100), IN `precio_producto` DECIMAL(10,2), IN `imagen_producto` VARCHAR(200), IN `desc_producto` VARCHAR(500))  BEGIN
	IF nombre_producto IS NOT NULL THEN
    	UPDATE productos
        SET nombre = nombre_producto
        WHERE id = id_producto;
    END IF;
    
	IF categoria_producto IS NOT NULL THEN
    	UPDATE productos 
        SET categoria = categoria_producto
        WHERE id = id_producto;
    END IF;
    
	IF precio_producto IS NOT NULL THEN
    	UPDATE productos 
        SET precio = precio_producto
        WHERE id = id_producto;
    END IF;
    
	IF imagen_producto IS NOT NULL THEN
    	UPDATE productos 
        SET imagen = imagen_producto
        WHERE id = id_producto;
    END IF;
    
	IF desc_producto IS NOT NULL THEN
    	UPDATE productos 
        SET descripcion = desc_producto
        WHERE id = id_producto;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user` (IN `id_usuario` INT, IN `email_usuario` VARCHAR(100), IN `nombre_usuario` VARCHAR(30), IN `ap` VARCHAR(30), IN `am` VARCHAR(30), IN `telefono_usuario` VARCHAR(10), IN `estado_usuario` VARCHAR(30), IN `ciudad_usuario` VARCHAR(30), IN `colonia_usuario` VARCHAR(30), IN `calle_usuario` VARCHAR(30), IN `numero_usuario` VARCHAR(30), IN `pass_usuario` VARCHAR(20), IN `tipo` VARCHAR(30), IN `token` VARCHAR(200))  BEGIN
	IF email_usuario IS NOT NULL THEN
    	UPDATE usuarios
        SET email = email_usuario
        WHERE id = id_usuario;
    END IF;
    
	IF nombre_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET nombre = nombre_usuario
        WHERE id = id_usuario;
    END IF;
    
	IF ap IS NOT NULL THEN
    	UPDATE usuarios 
        SET apellido_paterno = ap
        WHERE id = id_usuario;
    END IF;
    
	IF am IS NOT NULL THEN
    	UPDATE usuarios 
        SET apellido_materno = am
        WHERE id = id_usuario;
    END IF;
    
	IF telefono_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET telefono = telefono_usuario
        WHERE id = id_usuario;
    END IF;
    
    IF estado_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET estado = estado_usuario
        WHERE id = id_usuario;
    END IF;
    
    IF ciudad_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET ciudad = ciudad_usuario
        WHERE id = id_usuario;
    END IF;
    
    IF colonia_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET colonia = colonia_usuario
        WHERE id = id_usuario;
    END IF;
    
    IF calle_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET calle = calle_usuario
        WHERE id = id_usuario;
    END IF;
    
    IF numero_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET numero = numero_usuario
        WHERE id = id_usuario;
    END IF;
    
    IF pass_usuario IS NOT NULL THEN
    	UPDATE usuarios 
        SET pass = pass_usuario
        WHERE id = id_usuario;
    END IF;

    IF tipo IS NOT NULL THEN
    	UPDATE usuarios 
        SET tipo_usuario = tipo
        WHERE id = id_usuario;
    END IF;
    
    IF token IS NOT NULL THEN
    	UPDATE usuarios 
        SET firebase_token = token
        WHERE id = id_usuario;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(300) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(200) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `categoria`, `precio`, `imagen`, `descripcion`) VALUES
(1, 'Tiritas de pescado', 'Platillo', '100.00', 'https://pruebasbotanax.000webhostapp.com/Pedidos/images/tiritas.jpg', 'Filete de pescado cortado en tiras delgadas crudo, cocido con jugo de limón, cebolla morada fileteada, chile picado, con sal y pimienta.'),
(2, 'Pasta', 'Platillo', '85.00', 'https://pruebasbotanax.000webhostapp.com/Pedidos/images/Pasta.jpg', 'Descripción de la pasta.'),
(3, 'Yoli', 'Bebida', '12.00', 'https://pruebasbotanax.000webhostapp.com/Pedidos/images/Yoli.jpg', 'Descripción de la Yoli.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido_paterno` varchar(30) NOT NULL,
  `apellido_materno` varchar(30) NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  `colonia` varchar(30) DEFAULT NULL,
  `calle` varchar(30) DEFAULT NULL,
  `numero` varchar(30) DEFAULT NULL,
  `pass` varchar(20) DEFAULT NULL,
  `tipo_usuario` varchar(30) DEFAULT NULL,
  `firebase_token` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `email`, `nombre`, `apellido_paterno`, `apellido_materno`, `telefono`, `estado`, `ciudad`, `colonia`, `calle`, `numero`, `pass`, `tipo_usuario`, `firebase_token`) VALUES
(1, 'orlando.avilag@hotmail.com', 'Luis Orlando', 'Avila', 'Garcia', '5564191682', 'Ciudad De México', 'CDMX', 'Las Cruces', 'Ahuatla', 'S/N', 'landowolf10', 'Cliente', 'eWaA2VL18mQ:APA91bHS8xJgMTzHgzZjRZUPeyFSrw_CCoqCKhLWmn9tXFvkxaF9cP3CKnwKWgnxg18_oDQeJZUpifo8VWujGzfWpTfYMiJJrhgPG5lmHwQVRVwNJmbJj-8TDDoCFpURIYpc9dTD5Ief');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
