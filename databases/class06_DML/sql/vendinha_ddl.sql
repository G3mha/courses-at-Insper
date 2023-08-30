-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vendinha
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema vendinha
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vendinha` ;
USE `vendinha` ;

-- -----------------------------------------------------
-- Table `vendinha`.`regiao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendinha`.`regiao` (
  `regiao` CHAR(2) NOT NULL,
  `descricao` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`regiao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vendinha`.`uf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendinha`.`uf` (
  `uf` CHAR(2) NOT NULL,
  `descricao` VARCHAR(80) NOT NULL,
  `regiao` CHAR(2) NOT NULL,
  PRIMARY KEY (`uf`),
  INDEX `fk_uf_regiao_idx` (`regiao` ASC) VISIBLE,
  CONSTRAINT `fk_uf_regiao`
    FOREIGN KEY (`regiao`)
    REFERENCES `vendinha`.`regiao` (`regiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vendinha`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendinha`.`cidade` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  `uf` CHAR(2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_uf1_idx` (`uf` ASC) VISIBLE,
  CONSTRAINT `fk_cidade_uf1`
    FOREIGN KEY (`uf`)
    REFERENCES `vendinha`.`uf` (`uf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vendinha`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendinha`.`vendedor` (
  `id` INT NOT NULL,
  `nome` VARCHAR(120) NOT NULL,
  `data_nasc` DATE NOT NULL,
  `data_cad` DATE NOT NULL,
  `ativo` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vendinha`.`vendedor_vende_cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendinha`.`vendedor_vende_cidade` (
  `id_vendedor` INT NOT NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id_vendedor`, `id_cidade`),
  INDEX `fk_vendedor_has_cidade_cidade1_idx` (`id_cidade` ASC) VISIBLE,
  INDEX `fk_vendedor_has_cidade_vendedor1_idx` (`id_vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_vendedor_has_cidade_vendedor1`
    FOREIGN KEY (`id_vendedor`)
    REFERENCES `vendinha`.`vendedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendedor_has_cidade_cidade1`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `vendinha`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

