-- MySQL Workbench Synchronization
-- Generated: 2021-04-04 17:06
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: NAT

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `pizzeria`.`Cliente` 
ADD INDEX `fk_Cliente_Provincia1_idx` (`Provincia_idProvincia` ASC) VISIBLE,
ADD INDEX `fk_Cliente_Localidad1_idx` (`Localidad_idLocalidad` ASC) VISIBLE,
DROP INDEX `fk_Cliente_Localidad1_idx` ,
DROP INDEX `fk_Cliente_Provincia1_idx` ;
;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Pedido` (
  `idPedido` INT(11) NOT NULL AUTO_INCREMENT,
  `idCliente` INT(11) NOT NULL,
  `idTienda` INT(11) NOT NULL,
  `Fecha_pedido` DATETIME NOT NULL,
  `Productos` VARCHAR(30) NOT NULL,
  `Precio_total` DECIMAL NOT NULL DEFAULT '0,00',
  `Entrega_IdEntrega` INT(11) NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `idCliente_idx` (`idCliente` ASC) VISIBLE,
  INDEX `idTienda_idx` (`idTienda` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_IdEntrega` ASC) VISIBLE,
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `pizzeria`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idTienda`
    FOREIGN KEY (`idTienda`)
    REFERENCES `pizzeria`.`Tienda` (`idTienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_IdEntrega`)
    REFERENCES `pizzeria`.`Entrega` (`IdEntrega`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Productos` (
  `idProductos` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(20) NOT NULL,
  `Descripción` TEXT(500) NULL DEFAULT NULL,
  `Imagen` LONGBLOB NULL DEFAULT NULL,
  `Precio` DECIMAL NOT NULL DEFAULT '0,00',
  `Categorias_pizzas_idCategorias_pizzas` INT(11) NOT NULL,
  `Pedido_idPedido` INT(11) NOT NULL,
  `Entrega_IdEntrega` INT(11) NOT NULL,
  PRIMARY KEY (`idProductos`),
  INDEX `fk_Productos_Categorias_pizzas1_idx` (`Categorias_pizzas_idCategorias_pizzas` ASC) VISIBLE,
  INDEX `fk_Productos_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Productos_Entrega1_idx` (`Entrega_IdEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Categorias_pizzas1`
    FOREIGN KEY (`Categorias_pizzas_idCategorias_pizzas`)
    REFERENCES `pizzeria`.`Categorias_pizzas` (`idCategorias_pizzas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Productos_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `pizzeria`.`Pedido` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Productos_Entrega1`
    FOREIGN KEY (`Entrega_IdEntrega`)
    REFERENCES `pizzeria`.`Entrega` (`IdEntrega`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Categorias_pizzas` (
  `idCategorias_pizzas` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre_categoria` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategorias_pizzas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Tienda` (
  `idTienda` INT(11) NOT NULL AUTO_INCREMENT,
  `Dirección` VARCHAR(45) NOT NULL,
  `Código_postal` INT(11) NOT NULL,
  `Localidad` VARCHAR(20) NOT NULL,
  `Provincia` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idTienda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Empleados` (
  `idEmpleados` INT(11) NOT NULL AUTO_INCREMENT,
  `idTienda` INT(11) NOT NULL,
  `Nombre` VARCHAR(10) NOT NULL,
  `Apellidos` VARCHAR(25) NULL DEFAULT NULL,
  `Nif` VARCHAR(15) NOT NULL,
  `Teléfono` INT(11) NULL DEFAULT NULL,
  `Puesto` ENUM('Cocinero', 'Repartidor') NOT NULL DEFAULT 'Repartidor',
  PRIMARY KEY (`idEmpleados`),
  INDEX `idTienda_idx` (`idTienda` ASC) VISIBLE,
  CONSTRAINT `idTienda`
    FOREIGN KEY (`idTienda`)
    REFERENCES `pizzeria`.`Tienda` (`idTienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Reparto_domicilio` (
  `idReparto_domicilio` INT(11) NOT NULL AUTO_INCREMENT,
  `idEmpleados` INT(11) NOT NULL,
  `Fecha_pedido` DATETIME NOT NULL,
  PRIMARY KEY (`idReparto_domicilio`),
  INDEX `idEmpleados_idx` (`idEmpleados` ASC) VISIBLE,
  CONSTRAINT `idEmpleados`
    FOREIGN KEY (`idEmpleados`)
    REFERENCES `pizzeria`.`Empleados` (`idEmpleados`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Entrega` (
  `IdEntrega` INT(11) NOT NULL AUTO_INCREMENT,
  `Domicilio` TINYINT(4) NOT NULL,
  `Tienda` TINYINT(4) NOT NULL,
  `Reparto_domicilio_idReparto_domicilio` INT(11) NOT NULL,
  PRIMARY KEY (`IdEntrega`),
  INDEX `fk_Entrega_Reparto_domicilio1_idx` (`Reparto_domicilio_idReparto_domicilio` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Reparto_domicilio1`
    FOREIGN KEY (`Reparto_domicilio_idReparto_domicilio`)
    REFERENCES `pizzeria`.`Reparto_domicilio` (`idReparto_domicilio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
