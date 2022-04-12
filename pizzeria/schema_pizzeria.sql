-- MySQL Script generated by MySQL Workbench -- Mon Apr 11 13:08:39 2022 -- Model: New Model    Version: 1.0 -- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `id_provincia` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `id_localidad` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_id` INT(4) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_localidad`, `provincia_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_id` ASC),
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`id_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id_cliente` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(60) NOT NULL,
  `CP` INT(5) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `localidad_id` INT(4) UNSIGNED NOT NULL,
  `provincia_id` INT(4) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_cliente`, `localidad_id`, `provincia_id`),
  INDEX `fk_cliente_localidad1_idx` (`localidad_id` ASC, `provincia_id` ASC),
  CONSTRAINT `fk_cliente_localidad1`
    FOREIGN KEY (`localidad_id` , `provincia_id`)
    REFERENCES `pizzeria`.`localidad` (`id_localidad` , `provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id_tienda` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(60) NOT NULL,
  `CP` INT(5) NOT NULL,
  `localidad_id` INT(4) UNSIGNED NOT NULL,
  `provincia_id` INT(4) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_tienda`, `localidad_id`, `provincia_id`),
  INDEX `fk_tienda_localidad1_idx` (`localidad_id` ASC, `provincia_id` ASC),
  CONSTRAINT `fk_tienda_localidad1`
    FOREIGN KEY (`localidad_id` , `provincia_id`)
    REFERENCES `pizzeria`.`localidad` (`id_localidad` , `provincia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`burguer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`burguer` (
  `id_burguer` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NOT NULL,
  `img` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id_burguer`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`pedido_burguer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido_burguer` (
  `id_pedido_burguer` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `burguer_id` INT(4) UNSIGNED NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_pedido_burguer`, `burguer_id`),
  INDEX `fk_pedido_has_burguer_burguer1_idx` (`burguer_id` ASC),
  CONSTRAINT `fk_pedido_has_burguer_burguer1`
    FOREIGN KEY (`burguer_id`)
    REFERENCES `pizzeria`.`burguer` (`id_burguer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`categoria_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria_pizza` (
  `id_categoria` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `id_pizza` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NOT NULL,
  `img` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `categoria_pizza_id` INT(4) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pizza`, `categoria_pizza_id`),
  INDEX `fk_pizza_categoria_pizza1_idx` (`categoria_pizza_id` ASC),
  CONSTRAINT `fk_pizza_categoria_pizza1`
    FOREIGN KEY (`categoria_pizza_id`)
    REFERENCES `pizzeria`.`categoria_pizza` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`pedido_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido_pizza` (
  `id_pedido_pizza` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pizza_id` INT(4) UNSIGNED NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_pedido_pizza`, `pizza_id`),
  INDEX `fk_pedido_has_pizza_pizza1_idx` (`pizza_id` ASC),
  CONSTRAINT `fk_pedido_has_pizza_pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `pizzeria`.`pizza` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`bebida` (
  `id_bebida` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NOT NULL,
  `img` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id_bebida`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`pedido_bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido_bebida` (
  `id_pedido_bebida` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bebida_id` INT(4) UNSIGNED NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_pedido_bebida`, `bebida_id`),
  INDEX `fk_pedido_has_bebida_bebida1_idx` (`bebida_id` ASC),
  CONSTRAINT `fk_pedido_has_bebida_bebida1`
    FOREIGN KEY (`bebida_id`)
    REFERENCES `pizzeria`.`bebida` (`id_bebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`a_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`a_domicilio` (
  `id_aDomicilio` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_entrega` DATETIME NOT NULL,
  PRIMARY KEY (`id_aDomicilio`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `tipo` ENUM('repartidor', 'cocinero') NOT NULL,
  `aDomicilio_id` INT UNSIGNED NULL,
  `tienda_id` INT(4) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_empleado`, `tienda_id`),
  INDEX `fk_empleado_a_domicilio1_idx` (`aDomicilio_id` ASC),
  INDEX `fk_empleado_tienda1_idx` (`tienda_id` ASC),
  CONSTRAINT `fk_empleado_a_domicilio1`
    FOREIGN KEY (`aDomicilio_id`)
    REFERENCES `pizzeria`.`a_domicilio` (`id_aDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `id_pedido` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_pedido` DATETIME NOT NULL,
  `tipo_pedido` ENUM("recogida", "domicilio") NOT NULL,
  `pedido_burguer_id_pedido_burguer` INT(4) UNSIGNED NULL,
  `pedido_pizza_id_pedido_pizza` INT(4) UNSIGNED NULL,
  `pedido_bebida_id_pedido_bebida` INT(4) UNSIGNED NULL,
  `aDomicilio_id` INT UNSIGNED NULL,
  `cliente_id` INT(4) UNSIGNED NOT NULL,
  `tienda_id` INT(4) UNSIGNED NOT NULL,
  `empleado_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pedido`, `cliente_id`, `tienda_id`, `empleado_id`),
  INDEX `fk_pedido_pedido_burguer1_idx` (`pedido_burguer_id_pedido_burguer` ASC),
  INDEX `fk_pedido_pedido_pizza1_idx` (`pedido_pizza_id_pedido_pizza` ASC),
  INDEX `fk_pedido_pedido_bebida1_idx` (`pedido_bebida_id_pedido_bebida` ASC),
  INDEX `fk_pedido_a_domicilio1_idx` (`aDomicilio_id` ASC),
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC),
  INDEX `fk_pedido_tienda1_idx` (`tienda_id` ASC),
  INDEX `fk_pedido_empleado1_idx` (`empleado_id` ASC),
  CONSTRAINT `fk_pedido_pedido_burguer1`
    FOREIGN KEY (`pedido_burguer_id_pedido_burguer`)
    REFERENCES `pizzeria`.`pedido_burguer` (`id_pedido_burguer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_pedido_pizza1`
    FOREIGN KEY (`pedido_pizza_id_pedido_pizza`)
    REFERENCES `pizzeria`.`pedido_pizza` (`id_pedido_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_pedido_bebida1`
    FOREIGN KEY (`pedido_bebida_id_pedido_bebida`)
    REFERENCES `pizzeria`.`pedido_bebida` (`id_pedido_bebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_a_domicilio1`
    FOREIGN KEY (`aDomicilio_id`)
    REFERENCES `pizzeria`.`a_domicilio` (`id_aDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_tienda1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `pizzeria`.`empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

/*Datos tabal provincia*/
INSERT INTO provincia (nombre) VALUE ('Barcelona');
INSERT INTO provincia (nombre) VALUE ('Girona');
INSERT INTO provincia (nombre) VALUE ('Lleida');
INSERT INTO provincia (nombre) VALUE ('Tarragona');

/*Datos tabal localidad*/
INSERT INTO localidad (nombre,provincia_id) VALUE ('La Garriga', 1);
INSERT INTO localidad (nombre,provincia_id) VALUE ('Granollers', 1);
INSERT INTO localidad (nombre,provincia_id) VALUE ('Les Franqueses del Vallès', 1);

/*Datos tabal cliente*/
INSERT INTO cliente (nombre, apellido1, apellido2, direccion, CP, telefono, localidad_id, provincia_id) VALUE ('Marc', 'Morales', 'Urena', 'c/ Gran, 8', 08530, '656432123', 1, 1);
INSERT INTO cliente (nombre, apellido1, apellido2, direccion, CP, telefono, localidad_id, provincia_id) VALUE ('Laia', 'Riu', 'Vadia', 'c/ del Pont, 45', 08530, '636789456', 1, 1);
INSERT INTO cliente (nombre, apellido1, apellido2, direccion, CP, telefono, localidad_id, provincia_id) VALUE ('Albert', 'Homs', 'Cruells', 'c/ Imprenta, 11', 08530, '609876543', 1, 1);

/*Datos tabal tienda*/
INSERT INTO tienda (direccion,CP,localidad_id,provincia_id) VALUE ('c/ de la Sinia', 08530, 1, 1);
INSERT INTO tienda (direccion,CP,localidad_id,provincia_id) VALUE ('c/ Major', 08345, 2, 1);

/*Datos tabal categria pizza*/
INSERT INTO categoria_pizza (nombre) VALUE ('Basica');
INSERT INTO categoria_pizza (nombre) VALUE ('Especial');
INSERT INTO categoria_pizza (nombre) VALUE ('Extra');

/*Datos tabal pizza*/
INSERT INTO pizza (nombre, descripcion, img, precio, categoria_pizza_id) VALUE ('Margarita', 'Queso Mozzarella, jamón y tomate al oreganato', 'margarita.png', 9.99, 1);
INSERT INTO pizza (nombre, descripcion, img, precio, categoria_pizza_id) VALUE ('4 quesos', 'Queso Mozzarella, queso Edam, queso Gouda, queso Azul y tomate al oreganato', '4quesos.png', 9.99, 1);
INSERT INTO pizza (nombre, descripcion, img, precio, categoria_pizza_id) VALUE ('Barbacoa', 'Queso Mozzarella, carne picada, salsa barbacoa y tomate al oreganato', 'barbacoa.png', 11.99, 2);
INSERT INTO pizza (nombre, descripcion, img, precio, categoria_pizza_id) VALUE ('La Garriga', 'Queso Mozzarella, jamón, botifarra, huevo y tomate al oreganato', 'laGarriga.png', 13.99, 3);

/*Datos tabal burguer*/
INSERT INTO burguer (nombre, descripcion, img, precio) VALUE ('Ternera', '100% ternera 1/4 de kilo', 'ternera.png', 4.50);
INSERT INTO burguer (nombre, descripcion, img, precio) VALUE ('Poll', '100% pollo 1/4 de kilo', 'pollo.png', 3.50);

/*Datos tabal bebida*/
INSERT INTO bebida (nombre, descripcion, img, precio) VALUE ('Agua', 'Agua mineral', 'agua.png', 1.00);
INSERT INTO bebida (nombre, descripcion, img, precio) VALUE ('Trina limón', 'Trina limón', 'trinaL.png', 1.40);
INSERT INTO bebida (nombre, descripcion, img, precio) VALUE ('Cerveza', 'Cerveza Estrella con alcohol', 'cerveza.png', 2.00);
INSERT INTO bebida (nombre, descripcion, img, precio) VALUE ('Cerveza sin', 'Cerveza Estrella sin alcohol', 'agua.png', 2.00);
INSERT INTO bebida (nombre, descripcion, img, precio) VALUE ('Cerveza tostada', 'Cerveza negra', 'cervezaNegra.png', 2.40);

/*Datos tabal pizza pedido*/
INSERT INTO pedido_pizza (pizza_id, cantidad) VALUE (3,2);
INSERT INTO pedido_pizza (pizza_id, cantidad) VALUE (4,1);

/*Datos tabal burguer pedido*/
INSERT INTO pedido_burguer (burguer_id, cantidad) VALUE (1,2);

/*Datos tabal bebida pedido*/
INSERT INTO pedido_bebida (bebida_id,cantidad) VALUE (3,2);
INSERT INTO pedido_bebida (bebida_id,cantidad) VALUE (5,1);
INSERT INTO pedido_bebida (bebida_id,cantidad) VALUE (4,2);


/*Datos tabal aDomicilio*/
INSERT INTO a_domicilio (fecha_entrega) VALUE ('2022-04-03 23:34:09');

/*Datos tabal empleado*/
INSERT INTO empleado (nombre, nif, telefono, tipo, tienda_id) VALUE ('Maria', '65432134R', '654321335', 'repartidor', 1);
INSERT INTO empleado (nombre, nif, telefono, tipo, tienda_id) VALUE ('Marc', '98653456C', '675432123', 'cocinero', 1);

/*Datos tabal pedido*/
INSERT INTO pedido (fecha_pedido, tipo_pedido, pedido_pizza_id_pedido_pizza, pedido_bebida_id_pedido_bebida, cliente_id, tienda_id, empleado_id) VALUE ('2022-04-03 21:34:12','recogida',1,1,1,1,1);
INSERT INTO pedido (fecha_pedido, tipo_pedido, pedido_burguer_id_pedido_burguer, pedido_bebida_id_pedido_bebida, cliente_id, tienda_id, empleado_id) VALUE ('2022-04-03 22:05:09','recogida',1,2,2,1,1);
INSERT INTO pedido (fecha_pedido, tipo_pedido, pedido_pizza_id_pedido_pizza, pedido_bebida_id_pedido_bebida, cliente_id, tienda_id, empleado_id) VALUE ('2022-04-04 22:34:09','recogida',2,3,3,1,1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* Queries */
SELECT SUM(cantidad) FROM pedido_bebida RIGHT JOIN pedido ON pedido_bebida.id_pedido_bebida = pedido.pedido_bebida_id_pedido_bebida RIGHT JOIN tienda ON pedido.tienda_id = tienda.id_tienda RIGHT JOIN localidad ON tienda.localidad_id = localidad.id_localidad WHERE localidad.id_localidad = 1;

SELECT COUNT(pedido.id_pedido) FROM pedido WHERE empleado_id = 1;