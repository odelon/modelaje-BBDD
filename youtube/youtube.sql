-- MySQL Workbench Synchronization
-- Generated: 2021-04-01 22:49
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: NAT

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `youtube`.`Usuario` 
ADD INDEX `fk_Usuario_Registro_likes1_idx` (`Registro_likes_idRegistro_likes` ASC) VISIBLE,
ADD INDEX `fk_Usuario_Registro_dislikes1_idx` (`Registro_dislikes_idRegistro_dislikes` ASC) VISIBLE,
DROP INDEX `fk_Usuario_Registro_dislikes1_idx` ,
DROP INDEX `fk_Usuario_Registro_likes1_idx` ;
;

ALTER TABLE `youtube`.`Videos` 
ADD INDEX `fk_Videos_Registro_likes1_idx` (`Registro_likes_idRegistro_likes` ASC) VISIBLE,
ADD INDEX `fk_Videos_Registro_dislikes1_idx` (`Registro_dislikes_idRegistro_dislikes` ASC) VISIBLE,
DROP INDEX `fk_Videos_Registro_dislikes1_idx` ,
DROP INDEX `fk_Videos_Registro_likes1_idx` ;
;

ALTER TABLE `youtube`.`Canal` 
ADD INDEX `fk_Canal_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
DROP INDEX `fk_Canal_Usuario1_idx` ;
;

CREATE TABLE IF NOT EXISTS `youtube`.`Comentarios` (
  `idComentarios` INT(11) NOT NULL AUTO_INCREMENT,
  `Comentario` TEXT(200) NULL DEFAULT NULL,
  `Fecha_comentario` DATETIME NULL DEFAULT NULL,
  `Usuario_idUsuario` INT(11) NOT NULL,
  `Usuario_Registro_likes_idRegistro_likes` INT(11) NOT NULL,
  `Usuario_Registro_dislikes_idRegistro_dislikes` INT(11) NOT NULL,
  `Registro_comentarios_positivos_idRegistro_comentarios` INT(11) NOT NULL,
  `Registro_comentarios_negativos_idRegistro_comentarios_negativos` INT(11) NOT NULL,
  `Videos_idVideos` INT(11) NOT NULL,
  `Videos_Registro_likes_idRegistro_likes` INT(11) NOT NULL,
  `Videos_Registro_dislikes_idRegistro_dislikes` INT(11) NOT NULL,
  PRIMARY KEY (`idComentarios`, `Usuario_idUsuario`, `Usuario_Registro_likes_idRegistro_likes`, `Usuario_Registro_dislikes_idRegistro_dislikes`, `Registro_comentarios_positivos_idRegistro_comentarios`, `Registro_comentarios_negativos_idRegistro_comentarios_negativos`, `Videos_idVideos`, `Videos_Registro_likes_idRegistro_likes`, `Videos_Registro_dislikes_idRegistro_dislikes`),
  INDEX `fk_Comentarios_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Registro_likes_idRegistro_likes` ASC, `Usuario_Registro_dislikes_idRegistro_dislikes` ASC) VISIBLE,
  INDEX `fk_Comentarios_Registro_comentarios_positivos1_idx` (`Registro_comentarios_positivos_idRegistro_comentarios` ASC) VISIBLE,
  INDEX `fk_Comentarios_Registro_comentarios_negativos1_idx` (`Registro_comentarios_negativos_idRegistro_comentarios_negativos` ASC) VISIBLE,
  INDEX `fk_Comentarios_Videos1_idx` (`Videos_idVideos` ASC, `Videos_Registro_likes_idRegistro_likes` ASC, `Videos_Registro_dislikes_idRegistro_dislikes` ASC) VISIBLE,
  CONSTRAINT `fk_Comentarios_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Registro_likes_idRegistro_likes` , `Usuario_Registro_dislikes_idRegistro_dislikes`)
    REFERENCES `youtube`.`Usuario` (`idUsuario` , `Registro_likes_idRegistro_likes` , `Registro_dislikes_idRegistro_dislikes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comentarios_Registro_comentarios_positivos1`
    FOREIGN KEY (`Registro_comentarios_positivos_idRegistro_comentarios`)
    REFERENCES `youtube`.`Registro_comentarios_positivos` (`idRegistro_comentarios`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comentarios_Registro_comentarios_negativos1`
    FOREIGN KEY (`Registro_comentarios_negativos_idRegistro_comentarios_negativos`)
    REFERENCES `youtube`.`Registro_comentarios_negativos` (`idRegistro_comentarios_negativos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comentarios_Videos1`
    FOREIGN KEY (`Videos_idVideos` , `Videos_Registro_likes_idRegistro_likes` , `Videos_Registro_dislikes_idRegistro_dislikes`)
    REFERENCES `youtube`.`Videos` (`idVideos` , `Registro_likes_idRegistro_likes` , `Registro_dislikes_idRegistro_dislikes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`Registro_comentarios_positivos` (
  `idRegistro_comentarios` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha_registro` DATETIME NOT NULL,
  PRIMARY KEY (`idRegistro_comentarios`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `youtube`.`Registro_comentarios_negativos` (
  `idRegistro_comentarios_negativos` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha_registro` DATETIME NOT NULL,
  PRIMARY KEY (`idRegistro_comentarios_negativos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `youtube`.`Usuario` 
ADD CONSTRAINT `fk_Usuario_Registro_likes1`
  FOREIGN KEY (`Registro_likes_idRegistro_likes`)
  REFERENCES `youtube`.`Registro_likes` (`idRegistro_likes`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Usuario_Registro_dislikes1`
  FOREIGN KEY (`Registro_dislikes_idRegistro_dislikes`)
  REFERENCES `youtube`.`Registro_dislikes` (`idRegistro_dislikes`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `youtube`.`Videos` 
ADD CONSTRAINT `fk_Videos_Registro_likes1`
  FOREIGN KEY (`Registro_likes_idRegistro_likes`)
  REFERENCES `youtube`.`Registro_likes` (`idRegistro_likes`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Videos_Registro_dislikes1`
  FOREIGN KEY (`Registro_dislikes_idRegistro_dislikes`)
  REFERENCES `youtube`.`Registro_dislikes` (`idRegistro_dislikes`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
