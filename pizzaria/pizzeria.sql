-- MySQL Workbench Synchronization
-- Generated: 2021-04-04 17:07
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

ALTER TABLE `pizzeria`.`Pedido` 
CHANGE COLUMN `Precio_total` `Precio_total` DECIMAL NOT NULL DEFAULT '0,00' ,
ADD INDEX `fk_Pedido_Entrega1_idx` (`Entrega_IdEntrega` ASC) VISIBLE,
DROP INDEX `fk_Pedido_Entrega1_idx` ;
;

ALTER TABLE `pizzeria`.`Productos` 
CHANGE COLUMN `Precio` `Precio` DECIMAL NOT NULL DEFAULT '0,00' ,
ADD INDEX `fk_Productos_Categorias_pizzas1_idx` (`Categorias_pizzas_idCategorias_pizzas` ASC) VISIBLE,
ADD INDEX `fk_Productos_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
ADD INDEX `fk_Productos_Entrega1_idx` (`Entrega_IdEntrega` ASC) VISIBLE,
DROP INDEX `fk_Productos_Entrega1_idx` ,
DROP INDEX `fk_Productos_Pedido1_idx` ,
DROP INDEX `fk_Productos_Categorias_pizzas1_idx` ;
;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Empleados` (
  `idEmpleados` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(10) NOT NULL,
  `Apellidos` VARCHAR(25) NULL DEFAULT NULL,
  `Nif` VARCHAR(15) NOT NULL,
  `Teléfono` INT(11) NULL DEFAULT NULL,
  `Puesto` ENUM('Cocinero', 'Repartidor') NOT NULL DEFAULT 'Repartidor',
  `Tienda_idTienda` INT(11) NOT NULL,
  PRIMARY KEY (`idEmpleados`),
  INDEX `fk_Empleados_Tienda1_idx` (`Tienda_idTienda` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Tienda1`
    FOREIGN KEY (`Tienda_idTienda`)
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
