-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema compañiaAereaHector
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema compañiaAereaHector
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `compañiaAereaHector` DEFAULT CHARACTER SET utf8mb4 ;
USE `compañiaAereaHector` ;

-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_AEROPLANO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_AEROPLANO` (
  `Matricula` CHAR(9) NOT NULL,
  `Fabricantes` VARCHAR(15) NOT NULL,
  `Modelo` VARCHAR(20) NOT NULL,
  `Capacidad` SMALLINT UNSIGNED NOT NULL,
  `Autonomia` TINYINT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_CAT_PROFESIONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_CAT_PROFESIONAL` (
  `Codigo_categoria` CHAR(10) NOT NULL,
  `Nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Codigo_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_PASAJERO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_PASAJERO` (
  `Nombre` VARCHAR(25) NOT NULL,
  `Apellidos` VARCHAR(25) NOT NULL,
  `DNI_pasajero` VARCHAR(9) NOT NULL,
  `Clase` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`DNI_pasajero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_VUELO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_VUELO` (
  `ID_vuelo` CHAR(10) NOT NULL,
  `Matricula` CHAR(9) NOT NULL,
  `Origen` VARCHAR(20) NOT NULL,
  `Destino` VARCHAR(20) NOT NULL,
  `Fecha` DATE NOT NULL,
  PRIMARY KEY (`ID_vuelo`),
  INDEX `FK_T_VUELO_AEROPLANO` (`Matricula` ASC) VISIBLE,
  CONSTRAINT `FK_T_VUELO_AEROPLANO`
    FOREIGN KEY (`Matricula`)
    REFERENCES `compañiaAereaHector`.`T_AEROPLANO` (`Matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_DISTRIBUCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_DISTRIBUCION` (
  `DNI_pasajero` CHAR(9) NOT NULL,
  `ID_vuelo` CHAR(10) NOT NULL,
  `Asiento` CHAR(5) NOT NULL,
  `Clase` VARCHAR(20) NOT NULL,
  `TipoAsientoID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`DNI_pasajero`, `ID_vuelo`),
  UNIQUE INDEX `TipoAsientoID` (`TipoAsientoID` ASC) VISIBLE,
  INDEX `T_DISTRIBUCION_VUELO` (`ID_vuelo` ASC) VISIBLE,
  CONSTRAINT `T_DISTRIBUCION_PASAJERO`
    FOREIGN KEY (`DNI_pasajero`)
    REFERENCES `compañiaAereaHector`.`T_PASAJERO` (`DNI_pasajero`),
  CONSTRAINT `T_DISTRIBUCION_VUELO`
    FOREIGN KEY (`ID_vuelo`)
    REFERENCES `compañiaAereaHector`.`T_VUELO` (`ID_vuelo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_PERSONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_PERSONAL` (
  `ID_trabajador` CHAR(10) NOT NULL,
  `Codigo_categoria` CHAR(10) NOT NULL,
  `Nombre` VARCHAR(25) NOT NULL,
  `Apellido1` VARCHAR(25) NOT NULL,
  `Apellido2` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_trabajador`),
  INDEX `T_PERSONAL_CAT_PROFESIONAL` (`Codigo_categoria` ASC) VISIBLE,
  CONSTRAINT `T_PERSONAL_CAT_PROFESIONAL`
    FOREIGN KEY (`Codigo_categoria`)
    REFERENCES `compañiaAereaHector`.`T_CAT_PROFESIONAL` (`Codigo_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_PUESTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_PUESTO` (
  `ID_trabajador` CHAR(10) NOT NULL,
  `ID_vuelo` CHAR(10) NOT NULL,
  PRIMARY KEY (`ID_trabajador`, `ID_vuelo`),
  INDEX `T_PUESTO_VUELO` (`ID_vuelo` ASC) VISIBLE,
  CONSTRAINT `T_PUESTO_PERSONAL`
    FOREIGN KEY (`ID_trabajador`)
    REFERENCES `compañiaAereaHector`.`T_PERSONAL` (`ID_trabajador`),
  CONSTRAINT `T_PUESTO_VUELO`
    FOREIGN KEY (`ID_vuelo`)
    REFERENCES `compañiaAereaHector`.`T_VUELO` (`ID_vuelo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_TELEFONO_PASAJERO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_TELEFONO_PASAJERO` (
  `Telefono` VARCHAR(15) NOT NULL,
  `DNI_pasajero` CHAR(9) NOT NULL,
  PRIMARY KEY (`Telefono`),
  INDEX `T_TELEFONO_PASAJERO_PASAJERO` (`DNI_pasajero` ASC) VISIBLE,
  CONSTRAINT `T_TELEFONO_PASAJERO_PASAJERO`
    FOREIGN KEY (`DNI_pasajero`)
    REFERENCES `compañiaAereaHector`.`T_PASAJERO` (`DNI_pasajero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `compañiaAereaHector`.`T_TELEFONO_PERSONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compañiaAereaHector`.`T_TELEFONO_PERSONAL` (
  `Telefono` VARCHAR(15) NOT NULL,
  `ID_trabajador` CHAR(10) NOT NULL,
  PRIMARY KEY (`Telefono`),
  INDEX `T_TELEFONO_PERSONAL_PERSONAL` (`ID_trabajador` ASC) VISIBLE,
  CONSTRAINT `T_TELEFONO_PERSONAL_PERSONAL`
    FOREIGN KEY (`ID_trabajador`)
    REFERENCES `compañiaAereaHector`.`T_PERSONAL` (`ID_trabajador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SETwewewewe






