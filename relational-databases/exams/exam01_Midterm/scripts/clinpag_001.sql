SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clinpag
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `clinpag` ;

-- -----------------------------------------------------
-- Schema clinpag
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clinpag` ;
USE `clinpag` ;

-- -----------------------------------------------------
-- Table `clinpag`.`uf`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`uf` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`uf` (
  `id_uf` INT NOT NULL,
  `sigla` CHAR(2) NOT NULL,
  `descricao` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_uf`),
  UNIQUE INDEX `uf_UNIQUE` (`sigla` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinpag`.`medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`medico` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`medico` (
  `id_medico` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `cpf` CHAR(14) NULL,
  `crm` INT NOT NULL,
  `id_uf_crm` INT NOT NULL,
  PRIMARY KEY (`id_medico`),
  INDEX `fk_medico_uf1_idx` (`id_uf_crm` ASC) VISIBLE,
  CONSTRAINT `fk_medico_uf1`
    FOREIGN KEY (`id_uf_crm`)
    REFERENCES `clinpag`.`uf` (`id_uf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinpag`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`cidade` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`cidade` (
  `id_cidade` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `id_uf` INT NOT NULL,
  PRIMARY KEY (`id_cidade`),
  INDEX `fk_cidade_uf_idx` (`id_uf` ASC) VISIBLE,
  CONSTRAINT `fk_cidade_uf`
    FOREIGN KEY (`id_uf`)
    REFERENCES `clinpag`.`uf` (`id_uf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinpag`.`clinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`clinica` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`clinica` (
  `id_clinica` INT NOT NULL,
  `nome_fantasia` VARCHAR(100) NOT NULL,
  `cep` CHAR(9) NULL,
  `whatsapp` VARCHAR(15) NULL,
  `ativo` VARCHAR(45) NULL,
  `cnpj` CHAR(18) NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id_clinica`),
  INDEX `fk_clinica_cidade1_idx` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_clinica_cidade1`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `clinpag`.`cidade` (`id_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinpag`.`especialidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`especialidade` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`especialidade` (
  `id_especialidade` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`id_especialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinpag`.`medico_atende_clinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`medico_atende_clinica` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`medico_atende_clinica` (
  `id_medico` INT NOT NULL,
  `id_clinica` INT NOT NULL,
  `id_especialidade` INT NOT NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`id_medico`, `id_clinica`, `id_especialidade`),
  INDEX `fk_medico_atende_clinica_clinica1_idx` (`id_clinica` ASC) VISIBLE,
  INDEX `fk_medico_atende_clinica_medico1_idx` (`id_medico` ASC) VISIBLE,
  INDEX `fk_medico_atende_clinica_especialidade1_idx` (`id_especialidade` ASC) VISIBLE,
  CONSTRAINT `fk_medico_has_clinica_medico1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `clinpag`.`medico` (`id_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_has_clinica_clinica1`
    FOREIGN KEY (`id_clinica`)
    REFERENCES `clinpag`.`clinica` (`id_clinica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_atende_clinica_especialidade1`
    FOREIGN KEY (`id_especialidade`)
    REFERENCES `clinpag`.`especialidade` (`id_especialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinpag`.`paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`paciente` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`paciente` (
  `id_paciente` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `cpf` CHAR(14) NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id_paciente`),
  INDEX `fk_paciente_cidade1_idx` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_paciente_cidade1`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `clinpag`.`cidade` (`id_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clinpag`.`consulta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clinpag`.`consulta` ;

CREATE TABLE IF NOT EXISTS `clinpag`.`consulta` (
  `id_consulta` INT NOT NULL,
  `id_paciente` INT NOT NULL,
  `data_hora` DATETIME NULL,
  `valor` DECIMAL(10,2) NULL,
  `id_medico` INT NOT NULL,
  `id_clinica` INT NOT NULL,
  `id_especialidade` INT NOT NULL,
  PRIMARY KEY (`id_consulta`),
  INDEX `fk_consulta_paciente1_idx` (`id_paciente` ASC) VISIBLE,
  INDEX `fk_consulta_medico_atende_clinica1_idx` (`id_medico` ASC, `id_clinica` ASC, `id_especialidade` ASC) VISIBLE,
  CONSTRAINT `fk_consulta_paciente1`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `clinpag`.`paciente` (`id_paciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_medico_atende_clinica1`
    FOREIGN KEY (`id_medico` , `id_clinica` , `id_especialidade`)
    REFERENCES `clinpag`.`medico_atende_clinica` (`id_medico` , `id_clinica` , `id_especialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
