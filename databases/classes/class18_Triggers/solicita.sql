-- -----------------------------------------------------
-- Schema solicita
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `solicita` ;

-- -----------------------------------------------------
-- Schema solicita
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `solicita` ;
USE `solicita` ;

-- -----------------------------------------------------
-- Table `solicita`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solicita`.`cliente` ;

CREATE TABLE IF NOT EXISTS `solicita`.`cliente` (
  `id_cliente` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(150) NOT NULL,
  `cpf` CHAR(14) NULL,
  `ultimo_acesso` DATE NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solicita`.`solicitacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solicita`.`solicitacao` ;

CREATE TABLE IF NOT EXISTS `solicita`.`solicitacao` (
  `id_solicitacao` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `mensagem` TEXT NOT NULL,
  `data` DATE NULL,
  PRIMARY KEY (`id_solicitacao`),
  INDEX `fk_venda_cliente_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_venda_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `solicita`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

