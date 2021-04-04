-- MySQL Workbench Synchronization
-- Generated: 2021-04-04 17:35
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: NAT

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `spotify`.`Usuario` 
ADD INDEX `fk_Usuario_Usuario_premium_idx` (`Usuario_premium_idUsuario_premium` ASC) VISIBLE,
ADD INDEX `fk_Usuario_Usuario_free1_idx` (`Usuario_free_idUsuario_free` ASC) VISIBLE,
ADD INDEX `fk_Usuario_Playlist_compartida1_idx` (`Playlist_compartida_idPlaylist_compartida` ASC) VISIBLE,
DROP INDEX `fk_Usuario_Playlist_compartida1_idx` ,
DROP INDEX `fk_Usuario_Usuario_free1_idx` ,
DROP INDEX `fk_Usuario_Usuario_premium_idx` ;
;

ALTER TABLE `spotify`.`Subscripción_premium` 
ADD INDEX `fk_Subscripción_premium_Usuario_premium1_idx` (`Usuario_premium_idUsuario_premium` ASC) VISIBLE,
DROP INDEX `fk_Subscripción_premium_Usuario_premium1_idx` ;
;

ALTER TABLE `spotify`.`Pagos_premium` 
CHANGE COLUMN `Total_pagos` `Total_pagos` DECIMAL NOT NULL DEFAULT '0,00' ,
ADD INDEX `fk_Pagos_premium_Subscripción_premium1_idx` (`Subscripción_premium_idSubscripción_premium` ASC, `Subscripción_premium_Usuario_premium_idUsuario_premium` ASC) VISIBLE,
ADD INDEX `fk_Pagos_premium_PayPal1_idx` (`PayPal_idPayPal` ASC) VISIBLE,
ADD INDEX `fk_Pagos_premium_Tarjeta_crédito1_idx` (`Tarjeta_crédito_idTarjeta_crédito` ASC) VISIBLE,
DROP INDEX `fk_Pagos_premium_Tarjeta_crédito1_idx` ,
DROP INDEX `fk_Pagos_premium_PayPal1_idx` ,
DROP INDEX `fk_Pagos_premium_Subscripción_premium1_idx` ;
;

ALTER TABLE `spotify`.`Playlist` 
ADD INDEX `fk_Playlist_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Usuario_premium_idUsuario_premium` ASC, `Usuario_Usuario_free_idUsuario_free` ASC) VISIBLE,
ADD INDEX `fk_Playlist_Playlist_borrada1_idx` (`Playlist_borrada_idPlaylist_borrada` ASC) VISIBLE,
ADD INDEX `fk_Playlist_Playlist_activa1_idx` (`Playlist_activa_idPlaylist_activa` ASC) VISIBLE,
DROP INDEX `fk_Playlist_Playlist_activa1_idx` ,
DROP INDEX `fk_Playlist_Playlist_borrada1_idx` ,
DROP INDEX `fk_Playlist_Usuario1_idx` ;
;

CREATE TABLE IF NOT EXISTS `spotify`.`Artista` (
  `idArtista` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(10) NOT NULL,
  `Imagen` LONGBLOB NULL DEFAULT NULL,
  `Usuario_idUsuario` INT(11) NOT NULL,
  `Usuario_Usuario_premium_idUsuario_premium` INT(11) NOT NULL,
  `Usuario_Usuario_free_idUsuario_free` INT(11) NOT NULL,
  `Usuario_Playlist_compartida_idPlaylist_compartida` INT(11) NOT NULL,
  `Artista_idArtista` INT(11) NOT NULL,
  PRIMARY KEY (`idArtista`),
  INDEX `fk_Artista_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Usuario_premium_idUsuario_premium` ASC, `Usuario_Usuario_free_idUsuario_free` ASC, `Usuario_Playlist_compartida_idPlaylist_compartida` ASC) VISIBLE,
  INDEX `fk_Artista_Artista1_idx` (`Artista_idArtista` ASC) VISIBLE,
  CONSTRAINT `fk_Artista_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Usuario_premium_idUsuario_premium` , `Usuario_Usuario_free_idUsuario_free` , `Usuario_Playlist_compartida_idPlaylist_compartida`)
    REFERENCES `spotify`.`Usuario` (`idUsuario` , `Usuario_premium_idUsuario_premium` , `Usuario_free_idUsuario_free` , `Playlist_compartida_idPlaylist_compartida`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Artista_Artista1`
    FOREIGN KEY (`Artista_idArtista`)
    REFERENCES `spotify`.`Artista` (`idArtista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`Album` (
  `idAlbum` INT(11) NOT NULL AUTO_INCREMENT,
  `Título` VARCHAR(20) NOT NULL,
  `Año_publicación` YEAR NOT NULL,
  `Imagen_portada` LONGBLOB NOT NULL,
  `Artista_idArtista` INT(11) NOT NULL,
  `Usuario_idUsuario` INT(11) NOT NULL,
  `Usuario_Usuario_premium_idUsuario_premium` INT(11) NOT NULL,
  `Usuario_Usuario_free_idUsuario_free` INT(11) NOT NULL,
  `Usuario_Playlist_compartida_idPlaylist_compartida` INT(11) NOT NULL,
  PRIMARY KEY (`idAlbum`),
  INDEX `fk_Album_Artista1_idx` (`Artista_idArtista` ASC) VISIBLE,
  INDEX `fk_Album_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Usuario_premium_idUsuario_premium` ASC, `Usuario_Usuario_free_idUsuario_free` ASC, `Usuario_Playlist_compartida_idPlaylist_compartida` ASC) VISIBLE,
  CONSTRAINT `fk_Album_Artista1`
    FOREIGN KEY (`Artista_idArtista`)
    REFERENCES `spotify`.`Artista` (`idArtista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Album_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Usuario_premium_idUsuario_premium` , `Usuario_Usuario_free_idUsuario_free` , `Usuario_Playlist_compartida_idPlaylist_compartida`)
    REFERENCES `spotify`.`Usuario` (`idUsuario` , `Usuario_premium_idUsuario_premium` , `Usuario_free_idUsuario_free` , `Playlist_compartida_idPlaylist_compartida`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`Canción` (
  `idCanción` INT(11) NOT NULL AUTO_INCREMENT,
  `Título` VARCHAR(20) NOT NULL,
  `Duración` FLOAT(11) NOT NULL,
  `Número_reproducciones` INT(11) NOT NULL,
  `Album_idAlbum` INT(11) NOT NULL,
  `Usuario_idUsuario` INT(11) NOT NULL,
  `Usuario_Usuario_premium_idUsuario_premium` INT(11) NOT NULL,
  `Usuario_Usuario_free_idUsuario_free` INT(11) NOT NULL,
  `Usuario_Playlist_compartida_idPlaylist_compartida` INT(11) NOT NULL,
  PRIMARY KEY (`idCanción`),
  INDEX `fk_Canción_Album1_idx` (`Album_idAlbum` ASC) VISIBLE,
  INDEX `fk_Canción_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Usuario_premium_idUsuario_premium` ASC, `Usuario_Usuario_free_idUsuario_free` ASC, `Usuario_Playlist_compartida_idPlaylist_compartida` ASC) VISIBLE,
  CONSTRAINT `fk_Canción_Album1`
    FOREIGN KEY (`Album_idAlbum`)
    REFERENCES `spotify`.`Album` (`idAlbum`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Canción_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Usuario_premium_idUsuario_premium` , `Usuario_Usuario_free_idUsuario_free` , `Usuario_Playlist_compartida_idPlaylist_compartida`)
    REFERENCES `spotify`.`Usuario` (`idUsuario` , `Usuario_premium_idUsuario_premium` , `Usuario_free_idUsuario_free` , `Playlist_compartida_idPlaylist_compartida`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
