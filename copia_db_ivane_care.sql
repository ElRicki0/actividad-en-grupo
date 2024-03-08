-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: db_ivane_care
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_categorias_productos`
--

DROP TABLE IF EXISTS `tb_categorias_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_categorias_productos` (
  `id_categoria_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria_producto` varchar(50) NOT NULL,
  `descripcion_categoria_producto` varchar(50) NOT NULL,
  `imagen_categoria_producto` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_categoria_producto`),
  UNIQUE KEY `nombre_categoria_producto` (`nombre_categoria_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_categorias_productos`
--

LOCK TABLES `tb_categorias_productos` WRITE;
/*!40000 ALTER TABLE `tb_categorias_productos` DISABLE KEYS */;
INSERT INTO `tb_categorias_productos` VALUES (1,'Electrónicos','Productos electrónicos','imagen_electronicos.jpg');
/*!40000 ALTER TABLE `tb_categorias_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_clientes`
--

DROP TABLE IF EXISTS `tb_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(50) NOT NULL,
  `apellido_cliente` varchar(50) NOT NULL,
  `telefono_cliente` int(11) NOT NULL,
  `residencia_cliente` varchar(500) NOT NULL,
  `usuario_cliente` varchar(50) NOT NULL,
  `correo_cliente` varchar(50) NOT NULL,
  `pass_correo_cliente` varchar(50) NOT NULL,
  `imagen_cliente` varchar(500) NOT NULL,
  `estado_cliente` enum('conectado','desconectado','inutilizable','baneado') NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `nombre_cliente` (`nombre_cliente`),
  UNIQUE KEY `usuario_cliente` (`usuario_cliente`),
  UNIQUE KEY `correo_cliente` (`correo_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_clientes`
--

LOCK TABLES `tb_clientes` WRITE;
/*!40000 ALTER TABLE `tb_clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_comentarios`
--

DROP TABLE IF EXISTS `tb_comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_comentarios` (
  `id_comentario` int(11) NOT NULL AUTO_INCREMENT,
  `comentario` varchar(500) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_comentario`),
  KEY `id_producto` (`id_producto`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `tb_comentarios_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`),
  CONSTRAINT `tb_comentarios_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `tb_clientes` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_comentarios`
--

LOCK TABLES `tb_comentarios` WRITE;
/*!40000 ALTER TABLE `tb_comentarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_detalles_pedidos`
--

DROP TABLE IF EXISTS `tb_detalles_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_detalles_pedidos` (
  `id_detalle_entrega` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `precio_pedido` float DEFAULT NULL,
  `cantidad_pedido` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_detalle_entrega`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `tb_detalles_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `tb_pedidos` (`id_pedido`),
  CONSTRAINT `tb_detalles_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_detalles_pedidos`
--

LOCK TABLES `tb_detalles_pedidos` WRITE;
/*!40000 ALTER TABLE `tb_detalles_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_detalles_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_empleados`
--

DROP TABLE IF EXISTS `tb_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_empleados` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_empleado` varchar(50) NOT NULL,
  `apellido_empleado` varchar(50) NOT NULL,
  `correo_empleado` varchar(50) NOT NULL,
  `DUI_empleado` int(11) NOT NULL,
  `telefono_empleado` varchar(10) NOT NULL,
  `numero_emerjencia_empleado` varchar(10) NOT NULL,
  `contacto_emerjencia_empleado` varchar(50) NOT NULL,
  `image_empleado` varchar(50) NOT NULL,
  `id_nivele_emp` int(11) NOT NULL,
  `nombre_usuario_empleado` varchar(50) NOT NULL,
  `pass_usuario_empleado` varchar(5000) NOT NULL,
  `id_nivele_usu` int(11) DEFAULT NULL,
  `imagen_usuario` varchar(50) DEFAULT NULL,
  `estado_cliente` enum('conectado','desconectado','inutilizable','baneado') NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE KEY `correo_empleado` (`correo_empleado`),
  UNIQUE KEY `DUI_empleado` (`DUI_empleado`),
  UNIQUE KEY `telefono_empleado` (`telefono_empleado`),
  UNIQUE KEY `numero_emerjencia_empleado` (`numero_emerjencia_empleado`),
  UNIQUE KEY `contacto_emerjencia_empleado` (`contacto_emerjencia_empleado`),
  UNIQUE KEY `nombre_usuario_empleado` (`nombre_usuario_empleado`),
  UNIQUE KEY `pass_usuario_empleado` (`pass_usuario_empleado`) USING HASH,
  KEY `id_nivele_emp` (`id_nivele_emp`),
  KEY `id_nivele_usu` (`id_nivele_usu`),
  CONSTRAINT `tb_empleados_ibfk_1` FOREIGN KEY (`id_nivele_emp`) REFERENCES `tb_niveles_empleados` (`id_nivel_empleado`),
  CONSTRAINT `tb_empleados_ibfk_2` FOREIGN KEY (`id_nivele_usu`) REFERENCES `tb_niveles_usuarios` (`id_nivel_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_empleados`
--

LOCK TABLES `tb_empleados` WRITE;
/*!40000 ALTER TABLE `tb_empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_empleados` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER actualizar_estado_empleado
BEFORE UPDATE ON tb_empleados
FOR EACH ROW
BEGIN
    IF NEW.estado_cliente NOT IN ('conectado', 'desconectado', 'inutilizable', 'baneado') THEN
        SET NEW.estado_cliente = 'inutilizable';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_imagenes`
--

DROP TABLE IF EXISTS `tb_imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_imagenes` (
  `id_imagene` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_imagenes` varchar(200) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_imagene`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `tb_imagenes_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_imagenes`
--

LOCK TABLES `tb_imagenes` WRITE;
/*!40000 ALTER TABLE `tb_imagenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_imagenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_marcas`
--

DROP TABLE IF EXISTS `tb_marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_marcas` (
  `id_marca` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_marca` varchar(50) NOT NULL,
  `imagen_marca` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `nombre_marca` (`nombre_marca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_marcas`
--

LOCK TABLES `tb_marcas` WRITE;
/*!40000 ALTER TABLE `tb_marcas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_niveles_empleados`
--

DROP TABLE IF EXISTS `tb_niveles_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_niveles_empleados` (
  `id_nivel_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_nivel_empleado` varchar(50) NOT NULL,
  `descripcion_nivel_empleado` varchar(500) NOT NULL,
  PRIMARY KEY (`id_nivel_empleado`),
  UNIQUE KEY `nombre_nivel_empleado` (`nombre_nivel_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_niveles_empleados`
--

LOCK TABLES `tb_niveles_empleados` WRITE;
/*!40000 ALTER TABLE `tb_niveles_empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_niveles_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_niveles_usuarios`
--

DROP TABLE IF EXISTS `tb_niveles_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_niveles_usuarios` (
  `id_nivel_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_nivel_usuario` varchar(50) NOT NULL,
  `descripcion_nivel_usuario` varchar(500) NOT NULL,
  PRIMARY KEY (`id_nivel_usuario`),
  UNIQUE KEY `nombre_nivel_usuario` (`nombre_nivel_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_niveles_usuarios`
--

LOCK TABLES `tb_niveles_usuarios` WRITE;
/*!40000 ALTER TABLE `tb_niveles_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_niveles_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pedidos`
--

DROP TABLE IF EXISTS `tb_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) DEFAULT NULL,
  `fecha_pedido` date NOT NULL,
  `estado_pedido` enum('pendiente','en_proceso','entregado','cancelado') NOT NULL,
  `direccion_pedido` varchar(500) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `tb_pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `tb_clientes` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pedidos`
--

LOCK TABLES `tb_pedidos` WRITE;
/*!40000 ALTER TABLE `tb_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_productos`
--

DROP TABLE IF EXISTS `tb_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(50) NOT NULL,
  `descripcion_producto` varchar(500) NOT NULL,
  `precio_producto` float NOT NULL,
  `id_subcat` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_marca` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `id_subcat` (`id_subcat`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_marca` (`id_marca`),
  CONSTRAINT `tb_productos_ibfk_1` FOREIGN KEY (`id_subcat`) REFERENCES `tb_subcategoria` (`id_subcategoria`),
  CONSTRAINT `tb_productos_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `tb_empleados` (`id_empleado`),
  CONSTRAINT `tb_productos_ibfk_3` FOREIGN KEY (`id_marca`) REFERENCES `tb_marcas` (`id_marca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_productos`
--

LOCK TABLES `tb_productos` WRITE;
/*!40000 ALTER TABLE `tb_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_subcategoria`
--

DROP TABLE IF EXISTS `tb_subcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_subcategoria` (
  `id_subcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_subcategoria` varchar(50) NOT NULL,
  `descripcion_subcategoria` varchar(50) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_subcategoria`),
  UNIQUE KEY `nombre_subcategoria` (`nombre_subcategoria`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `tb_subcategoria_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias_productos` (`id_categoria_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_subcategoria`
--

LOCK TABLES `tb_subcategoria` WRITE;
/*!40000 ALTER TABLE `tb_subcategoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_subcategoria` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-07 11:39:11
