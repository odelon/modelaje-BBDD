-- MySQL Workbench Synchronization
-- Generated: 2021-04-01 17:08
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: NAT

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `optica`.`Proveedores` (
  `NIF` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(10) NULL DEFAULT NULL,
  `idDirección` INT(11) NULL DEFAULT NULL,
  `Teléfono` INT(11) NULL DEFAULT NULL,
  `FAX` INT(11) NULL DEFAULT NULL,
  `Marcas_idMarcas` INT(11) NOT NULL,
  PRIMARY KEY (`NIF`, `Marcas_idMarcas`),
  INDEX `idDirección_idx` (`idDirección` ASC) VISIBLE,
  INDEX `fk_Proveedores_Marcas1_idx` (`Marcas_idMarcas` ASC) VISIBLE,
  CONSTRAINT `idDirección`
    FOREIGN KEY (`idDirección`)
    REFERENCES `optica`.`Dirección` (`idDirección`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Proveedores_Marcas1`
    FOREIGN KEY (`Marcas_idMarcas`)
    REFERENCES `optica`.`Marcas` (`idMarcas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`Dirección` (
  `idDirección` INT(11) NOT NULL AUTO_INCREMENT,
  `Calle` VARCHAR(10) NULL DEFAULT NULL,
  `Número` INT(11) NULL DEFAULT NULL,
  `Piso` INT(11) NULL DEFAULT NULL,
  `Puerta` INT(11) NULL DEFAULT NULL,
  `Ciudad` VARCHAR(25) NULL DEFAULT 'Barcelona',
  `Código_postal` INT(11) NULL DEFAULT NULL,
  `País` VARCHAR(25) NULL DEFAULT 'España',
  PRIMARY KEY (`idDirección`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`Gafas` (
  `idGafas` INT(11) NOT NULL AUTO_INCREMENT,
  `idMarca` INT(11) NOT NULL,
  `Graduación_cristales` INT(11) NOT NULL,
  `Montura` ENUM('Metálica', 'flotante', 'pasta') NOT NULL DEFAULT 'Metalica',
  `Color_montura` VARCHAR(20) NOT NULL DEFAULT 'Sin color',
  `Color_cristales` VARCHAR(20) NOT NULL DEFAULT 'Sin color',
  `Precio` DECIMAL NOT NULL DEFAULT '0,00',
  PRIMARY KEY (`idGafas`),
  INDEX `idMarca_idx` (`idMarca` ASC) VISIBLE,
  CONSTRAINT `idMarca`
    FOREIGN KEY (`idMarca`)
    REFERENCES `optica`.`Marcas` (`idMarcas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`Clientes` (
  `idClientes` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(10) NULL DEFAULT NULL,
  `Dirección` VARCHAR(100) NULL DEFAULT NULL,
  `Teléfono` INT(11) NULL DEFAULT NULL,
  `Correo_electrónico` VARCHAR(45) NULL DEFAULT NULL,
  `Fecha_registro` DATE NULL DEFAULT NULL,
  `Cliente_amigo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`Empleados` (
  `idEmpleados` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idEmpleados`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`Ventas` (
  `idVentas` INT(11) NOT NULL AUTO_INCREMENT,
  `idEmpleados` INT(11) NOT NULL,
  `IdGafas` INT(11) NOT NULL,
  `Clientes_idClientes` INT(11) NOT NULL,
  PRIMARY KEY (`idVentas`, `Clientes_idClientes`),
  INDEX `idEmpleados_idx` (`idEmpleados` ASC) VISIBLE,
  INDEX `idGafas_idx` (`IdGafas` ASC) VISIBLE,
  INDEX `fk_Ventas_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `idEmpleados`
    FOREIGN KEY (`idEmpleados`)
    REFERENCES `optica`.`Empleados` (`idEmpleados`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idGafas`
    FOREIGN KEY (`IdGafas`)
    REFERENCES `optica`.`Gafas` (`idGafas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ventas_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `optica`.`Clientes` (`idClientes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `optica`.`Marcas` (
  `idMarcas` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre_marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMarcas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
