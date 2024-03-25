SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cartracking
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cartracking` ;

-- -----------------------------------------------------
-- Schema cartracking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cartracking` ;
USE `cartracking` ;

-- -----------------------------------------------------
-- Table `cartracking`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`cliente` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NULL,
  `cnpj` VARCHAR(18) NULL,
  `endereço` VARCHAR(150) NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`marca` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`marca` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idmarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`modelo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`modelo` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`modelo` (
  `idmodelo` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(60) NOT NULL,
  `idmarca` INT NOT NULL,
  PRIMARY KEY (`idmodelo`),
  UNIQUE INDEX `descricao_UNIQUE` (`modelo` ASC) VISIBLE,
  INDEX `fk_modelo_marca_idx` (`idmarca` ASC) VISIBLE,
  CONSTRAINT `fk_modelo_marca`
    FOREIGN KEY (`idmarca`)
    REFERENCES `cartracking`.`marca` (`idmarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`automovel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`automovel` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`automovel` (
  `idautomovel` INT NOT NULL AUTO_INCREMENT,
  `ano` INT NOT NULL,
  `idcliente` INT NOT NULL,
  `idmodelo` INT NOT NULL,
  `travado` TINYINT NULL,
  PRIMARY KEY (`idautomovel`),
  INDEX `fk_automovel_cliente1_idx` (`idcliente` ASC) VISIBLE,
  INDEX `fk_automovel_modelo1_idx` (`idmodelo` ASC) VISIBLE,
  CONSTRAINT `fk_automovel_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `cartracking`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_automovel_modelo1`
    FOREIGN KEY (`idmodelo`)
    REFERENCES `cartracking`.`modelo` (`idmodelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`tipo` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`tipo` (
  `idtipo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`rastreador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`rastreador` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`rastreador` (
  `idrastreador` INT NOT NULL AUTO_INCREMENT,
  `idautomovel` INT NULL,
  `idtipo` INT NOT NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`idrastreador`),
  INDEX `fk_rastreador_automovel1_idx` (`idautomovel` ASC) VISIBLE,
  INDEX `fk_rastreador_tipo1_idx` (`idtipo` ASC) VISIBLE,
  CONSTRAINT `fk_rastreador_automovel1`
    FOREIGN KEY (`idautomovel`)
    REFERENCES `cartracking`.`automovel` (`idautomovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rastreador_tipo1`
    FOREIGN KEY (`idtipo`)
    REFERENCES `cartracking`.`tipo` (`idtipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`evento` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`evento` (
  `idevento` INT NOT NULL AUTO_INCREMENT,
  `latitude` DECIMAL(7,5) NULL,
  `longitude` DECIMAL(7,5) NULL,
  `altitude` DECIMAL(10,2) NULL,
  `velocidade` DECIMAL(10,4) NULL,
  `idrastreador` INT NOT NULL,
  `temperatura_motor` DECIMAL(6,2) NULL,
  `temperatura_externa` DECIMAL(6,2) NULL,
  `data` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idevento`),
  INDEX `fk_evento_rastreador1_idx` (`idrastreador` ASC) VISIBLE,
  CONSTRAINT `fk_evento_rastreador1`
    FOREIGN KEY (`idrastreador`)
    REFERENCES `cartracking`.`rastreador` (`idrastreador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`servico` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`servico` (
  `idservico` INT NOT NULL AUTO_INCREMENT,
  `servico` VARCHAR(60) NOT NULL,
  `descricao` VARCHAR(200) NULL,
  `preco_base` DECIMAL(10,2) NULL,
  `disponivel_venda` TINYINT NOT NULL,
  PRIMARY KEY (`idservico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cartracking`.`automovel_has_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cartracking`.`automovel_has_servico` ;

CREATE TABLE IF NOT EXISTS `cartracking`.`automovel_has_servico` (
  `idautomovel` INT NOT NULL,
  `idservico` INT NOT NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`idautomovel`, `idservico`),
  INDEX `fk_automovel_has_servico_servico1_idx` (`idservico` ASC) VISIBLE,
  INDEX `fk_automovel_has_servico_automovel1_idx` (`idautomovel` ASC) VISIBLE,
  CONSTRAINT `fk_automovel_has_servico_automovel1`
    FOREIGN KEY (`idautomovel`)
    REFERENCES `cartracking`.`automovel` (`idautomovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_automovel_has_servico_servico1`
    FOREIGN KEY (`idservico`)
    REFERENCES `cartracking`.`servico` (`idservico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
