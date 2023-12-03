SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eletrobeer
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `eletrobeer` ;

-- -----------------------------------------------------
-- Schema eletrobeer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eletrobeer` ;
USE `eletrobeer` ;

-- -----------------------------------------------------
-- Table `eletrobeer`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eletrobeer`.`pedido` ;

CREATE TABLE IF NOT EXISTS `eletrobeer`.`pedido` (
  `id_pedido` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `data_criacao` DATE NULL,
  `qtde_itens` INT NULL,
  `valor_total` DECIMAL(10,2) NULL,
  `cidade_entrega` VARCHAR(100) NULL,
  `uf_entrega` VARCHAR(2) NULL,
  PRIMARY KEY (`id_pedido`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
