-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ejemplo_nomina
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ejemplo_nomina` ;

-- -----------------------------------------------------
-- Schema ejemplo_nomina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ejemplo_nomina` DEFAULT CHARACTER SET utf8 ;
USE `ejemplo_nomina` ;

-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`tipos_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`tipos_documento` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`tipos_documento` (
  `id` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`paises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`paises` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`paises` (
  `id` VARCHAR(4) NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`departamentos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`departamentos` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`departamentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_pais` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_departamentos_pais1_idx` (`id_pais` ASC),
  CONSTRAINT `fk_departamentos_pais1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `ejemplo_nomina`.`paises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`ciudades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`ciudades` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`ciudades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `id_departamento` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ciudades_departamentos1_idx` (`id_departamento` ASC),
  CONSTRAINT `fk_ciudades_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `ejemplo_nomina`.`departamentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`cargos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`cargos` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`cargos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(20) NOT NULL,
  `apellidos` VARCHAR(20) NOT NULL,
  `num_documento` VARCHAR(15) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(40) NULL,
  `sueldo_basico` DOUBLE NOT NULL,
  `activo` TINYINT(1) NULL,
  `id_jefe_inmediato` INT NULL,
  `id_tipo_documento` INT NOT NULL,
  `id_ciudad` INT NOT NULL,
  `id_cargo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuarios_usuarios_idx` (`id_jefe_inmediato` ASC),
  INDEX `fk_usuarios_tipos_documento1_idx` (`id_tipo_documento` ASC),
  INDEX `fk_usuarios_ciudades1_idx` (`id_ciudad` ASC),
  INDEX `fk_usuarios_cargos1_idx` (`id_cargo` ASC),
  CONSTRAINT `fk_usuarios_usuarios`
    FOREIGN KEY (`id_jefe_inmediato`)
    REFERENCES `ejemplo_nomina`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_tipos_documento1`
    FOREIGN KEY (`id_tipo_documento`)
    REFERENCES `ejemplo_nomina`.`tipos_documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_ciudades1`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `ejemplo_nomina`.`ciudades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_cargos1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `ejemplo_nomina`.`cargos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`roles` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`roles` (
  `id` VARCHAR(10) NOT NULL,
  `descripcion` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`usuarios_has_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`usuarios_has_roles` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`usuarios_has_roles` (
  `id_usuario` INT NOT NULL,
  `id_rol` VARCHAR(10) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_usuario`, `id_rol`),
  INDEX `fk_usuarios_has_roles_roles1_idx` (`id_rol` ASC),
  INDEX `fk_usuarios_has_roles_usuarios1_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_usuarios_has_roles_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ejemplo_nomina`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_roles_roles1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `ejemplo_nomina`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`nominas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`nominas` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`nominas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(60) NOT NULL,
  `mes` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejemplo_nomina`.`detalle_nomina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ejemplo_nomina`.`detalle_nomina` ;

CREATE TABLE IF NOT EXISTS `ejemplo_nomina`.`detalle_nomina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dias_laborados` INT NOT NULL,
  `sueldo_devengado` DOUBLE NOT NULL,
  `auxilio_transporte` DOUBLE NULL DEFAULT 0,
  `valor_horas_extras` DOUBLE NULL DEFAULT 0,
  `descuento_salud` DOUBLE NOT NULL,
  `descuento_pension` DOUBLE NOT NULL,
  `descuento_fondo_solidaridad` DOUBLE NULL DEFAULT 0,
  `otros_descuentos` DOUBLE NULL DEFAULT 0,
  `total_devengado` DOUBLE NOT NULL,
  `total_descuento` DOUBLE NOT NULL,
  `neto_pagar` DOUBLE NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_nomina` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detalle_nomina_usuarios1_idx` (`id_usuario` ASC),
  INDEX `fk_detalle_nomina_nominas1_idx` (`id_nomina` ASC),
  CONSTRAINT `fk_detalle_nomina_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ejemplo_nomina`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_nomina_nominas1`
    FOREIGN KEY (`id_nomina`)
    REFERENCES `ejemplo_nomina`.`nominas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ejemplo_nomina`.`tipos_documento`
-- -----------------------------------------------------
START TRANSACTION;
USE `ejemplo_nomina`;
INSERT INTO `ejemplo_nomina`.`tipos_documento` (`id`, `descripcion`) VALUES (1, 'C.C.');
INSERT INTO `ejemplo_nomina`.`tipos_documento` (`id`, `descripcion`) VALUES (2, 'T.I');
INSERT INTO `ejemplo_nomina`.`tipos_documento` (`id`, `descripcion`) VALUES (3, 'C.E.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ejemplo_nomina`.`cargos`
-- -----------------------------------------------------
START TRANSACTION;
USE `ejemplo_nomina`;
INSERT INTO `ejemplo_nomina`.`cargos` (`id`, `descripcion`) VALUES (1, 'Contador Público');
INSERT INTO `ejemplo_nomina`.`cargos` (`id`, `descripcion`) VALUES (2, 'Auxiliar de Ventas');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ejemplo_nomina`.`roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `ejemplo_nomina`;
INSERT INTO `ejemplo_nomina`.`roles` (`id`, `descripcion`) VALUES ('ADMIN', 'Administrador');
INSERT INTO `ejemplo_nomina`.`roles` (`id`, `descripcion`) VALUES ('USER', 'Colaborador - Empleado');

COMMIT;

