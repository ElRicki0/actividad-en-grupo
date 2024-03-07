
USE db_ivane_care;

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

