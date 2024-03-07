DROP DATABASE if exists db_ivane_care;

CREATE DATABASE db_ivane_care;                                

USE db_ivane_care;

/*datos de los clientes*/

CREATE TABLE tb_clientes(
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre_cliente 	VARCHAR(50) unique not null,
apellido_cliente 	VARCHAR(50)not null,
telefono_cliente	INT not null,
residencia_cliente	VARCHAR(500) not null,
usuario_cliente	varchar(50) not null unique,
correo_cliente		VARCHAR(50) not null unique,
pass_correo_cliente	VARCHAR(50) not null ,
imagen_cliente		varchar(500) not null,
estado_cliente		enum('conectado', 'desconectado', 'inutilizable', 'baneado') not null
); 

/*datos de los empleados*/

CREATE TABLE tb_niveles_empleados(
id_nivel_empleado	INT AUTO_INCREMENT PRIMARY KEY,
nombre_nivel_empleado	VARCHAR(50) not null unique,
descripcion_nivel_empleado	VARCHAR(500) not null
);   

CREATE table tb_niveles_usuarios(
id_nivel_usuario	INT AUTO_INCREMENT PRIMARY KEY,
nombre_nivel_usuario	VARCHAR(50) not null unique,
descripcion_nivel_usuario VARCHAR(500) not null
);
   
CREATE TABLE tb_empleados(
	id_empleado		INT AUTO_INCREMENT PRIMARY KEY,
	nombre_empleado	VARCHAR(50) not null,
	apellido_empleado	VARCHAR(50) not null,
	correo_empleado	VARCHAR(50) not null unique,
	DUI_empleado		INT not null unique,
	telefono_empleado VARCHAR(10) not null unique,
	numero_emerjencia_empleado	VARCHAR(10) not null unique,
	contacto_emerjencia_empleado VARCHAR(50) not null unique,
	image_empleado		VARCHAR(50) not null,
	id_nivele_emp INT not null,
	FOREIGN KEY (id_nivele_emp) REFERENCES tb_niveles_empleados(id_nivel_empleado),
    nombre_usuario_empleado VARCHAR(50) not null unique,
	pass_usuario_empleado VARCHAR(5000) not null unique,
	id_nivele_usu INT,
	FOREIGN KEY (id_nivele_usu) REFERENCES tb_niveles_usuarios(id_nivel_usuario),
    imagen_usuario	VARCHAR(50),
    estado_cliente		enum('conectado', 'desconectado', 'inutilizable', 'baneado') not null
);   

/*partes productos*/
   
CREATE TABLE tb_categorias_productos(
	id_categoria_producto 				INT AUTO_INCREMENT PRIMARY KEY,
	nombre_categoria_producto			VARCHAR(50) not null unique,
	descripcion_categoria_producto	VARCHAR(50) not null,
	imagen_categoria_producto			VARCHAR(50)
);

CREATE TABLE tb_subcategoria(
	id_subcategoria			INT AUTO_INCREMENT PRIMARY KEY ,
	nombre_subcategoria		VARCHAR(50) not null unique,
	descripcion_subcategoria	VARCHAR(50) not null,
	id_categoria				INT,
	FOREIGN KEY (id_categoria) REFERENCES tb_categorias_productos (id_categoria_producto)
);



CREATE TABLE tb_marcas(
	id_marca			INT auto_increment PRIMARY key,
	nombre_marca	VARCHAR(50) not null unique,
	imagen_marca	VARCHAR(100)
);

CREATE TABLE tb_productos(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(50) not null,
    descripcion_producto VARCHAR(500) not null,
    precio_producto float not null,
    id_subcat INT,
    FOREIGN KEY (id_subcat) REFERENCES tb_subcategoria(id_subcategoria),
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES tb_empleados(id_empleado),
    id_marca	INT,
    FOREIGN KEY (id_marca) REFERENCES tb_marcas	(id_marca)
);

create table tb_comentarios(
	id_comentario int auto_increment primary key,
    comentario		varchar(500) not null,
    id_producto		int,
    foreign key(id_producto) references tb_productos (id_producto),
    id_cliente		INT,
	FOREIGN KEY (id_cliente) REFERENCES tb_clientes (id_cliente)
);
select*from tb_comentarios;

CREATE TABLE tb_pedidos(
	id_pedido	INT AUTO_INCREMENT PRIMARY KEY,
	id_cliente		INT,
	FOREIGN KEY (id_cliente) REFERENCES tb_clientes (id_cliente),
	fecha_pedido	DATE not null,
	estado_pedido	enum('pendiente', 'en_proceso', 'entregado', 'cancelado') not null,
	direccion_pedido	VARCHAR(500) not null
);

CREATE TABLE tb_imagenes(
	id_imagene	INT AUTO_INCREMENT	PRIMARY KEY,
	codigo_imagenes	VARCHAR(200),
	id_producto	INT,
	FOREIGN KEY (id_producto )REFERENCES tb_productos (id_producto)
);

CREATE TABLE tb_detalles_pedidos (
id_detalle_entrega		INT AUTO_INCREMENT PRIMARY KEY,
id_pedido	INT,
FOREIGN KEY (id_pedido) REFERENCES tb_pedidos (id_pedido),
id_producto	INT,
FOREIGN KEY (id_producto) REFERENCES tb_productos (id_producto),
precio_pedido	float,
cantidad_pedido	INT
);


## Creacion de procedimiento almacenado para la tabla categorias

DELIMITER //

CREATE PROCEDURE InsertarCategoriaProducto(
    IN nombre_categoria_producto_param VARCHAR(50),
    IN descripcion_categoria_producto_param VARCHAR(50),
    IN imagen_categoria_producto_param VARCHAR(50)
)
BEGIN
    INSERT INTO tb_categorias_productos (
        nombre_categoria_producto,
        descripcion_categoria_producto,
        imagen_categoria_producto
    ) VALUES (
        nombre_categoria_producto_param,
        descripcion_categoria_producto_param,
        imagen_categoria_producto_param
    );
END //

DELIMITER ;

CALL InsertarCategoriaProducto('Electrónicos', 'Productos electrónicos', 'imagen_electronicos.jpg');

SELECT * FROM tb_categorias_productos;


## Creacion de funcion para la tabla comentarios, esta funcion lo que estara realizando sera contar los comentarios que un producto tenga

DELIMITER //

CREATE FUNCTION ComentariosPorProducto (id_producto INT) 
RETURNS INT
BEGIN
    DECLARE total_comentarios INT;

    SELECT COUNT(*) INTO total_comentarios
    FROM tb_comentarios
    WHERE id_producto = id_producto;

    RETURN total_comentarios;
END //

DELIMITER ;

SELECT ComentariosPorProducto(1); 


## Creacion de Triggers. aca lo que hara este trigger es cambiar el estado del cliente 

DELIMITER //

CREATE TRIGGER actualizar_estado_empleado
BEFORE UPDATE ON tb_empleados
FOR EACH ROW
BEGIN
    IF NEW.estado_cliente NOT IN ('conectado', 'desconectado', 'inutilizable', 'baneado') THEN
        SET NEW.estado_cliente = 'inutilizable';
    END IF;
END //

DELIMITER ;

