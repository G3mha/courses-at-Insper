SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fiscamuni
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `fiscamuni` ;

-- -----------------------------------------------------
-- Schema fiscamuni
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fiscamuni` ;
USE `fiscamuni` ;

-- -----------------------------------------------------
-- Table `fiscamuni`.`fiscal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fiscamuni`.`fiscal` ;

CREATE TABLE IF NOT EXISTS `fiscamuni`.`fiscal` (
  `id_fiscal` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `data_nasc` DATE NULL,
  PRIMARY KEY (`id_fiscal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fiscamuni`.`empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fiscamuni`.`empresa` ;

CREATE TABLE IF NOT EXISTS `fiscamuni`.`empresa` (
  `id_empresa` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(18) NOT NULL,
  `nome_fantasia` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fiscamuni`.`motivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fiscamuni`.`motivo` ;

CREATE TABLE IF NOT EXISTS `fiscamuni`.`motivo` (
  `id_motivo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_motivo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fiscamuni`.`propriedade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fiscamuni`.`propriedade` ;

CREATE TABLE IF NOT EXISTS `fiscamuni`.`propriedade` (
  `id_propriedade` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NULL,
  `endereco` VARCHAR(100) NULL,
  `tags` VARCHAR(100) NULL,
  `id_empresa` INT NOT NULL,
  PRIMARY KEY (`id_propriedade`),
  CONSTRAINT `fk_propriedade_empresa1`
    FOREIGN KEY (`id_empresa`)
    REFERENCES `fiscamuni`.`empresa` (`id_empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_propriedade_empresa1_idx` ON `fiscamuni`.`propriedade` (`id_empresa` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `fiscamuni`.`multa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fiscamuni`.`multa` ;

CREATE TABLE IF NOT EXISTS `fiscamuni`.`multa` (
  `id_multa` INT NOT NULL AUTO_INCREMENT,
  `id_propriedade` INT NOT NULL,
  `id_fiscal` INT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `data_notificacao` DATE NOT NULL,
  `id_motivo` INT NOT NULL,
  PRIMARY KEY (`id_multa`),
  CONSTRAINT `fk_multa_fiscal`
    FOREIGN KEY (`id_fiscal`)
    REFERENCES `fiscamuni`.`fiscal` (`id_fiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_multa_motivo1`
    FOREIGN KEY (`id_motivo`)
    REFERENCES `fiscamuni`.`motivo` (`id_motivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_multa_propriedade1`
    FOREIGN KEY (`id_propriedade`)
    REFERENCES `fiscamuni`.`propriedade` (`id_propriedade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_multa_fiscal_idx` ON `fiscamuni`.`multa` (`id_fiscal` ASC) VISIBLE;

CREATE INDEX `fk_multa_motivo1_idx` ON `fiscamuni`.`multa` (`id_motivo` ASC) VISIBLE;

CREATE INDEX `fk_multa_propriedade1_idx` ON `fiscamuni`.`multa` (`id_propriedade` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO fiscamuni.empresa (cnpj,nome_fantasia) VALUES
	 ('44.156.844/0001-00','FERREIRA S.A.'),
	 ('29.938.223/0001-86','LEGUMES E CIA'),
	 ('28.648.164/0001-49','CASA DO GERADOR'),
	 ('15.920.432/0001-98','DIVERTIDAMENTE S.A.'),
	 ('21.517.062/0001-45','MARS: ONE WAY TRAVELS'),
	 ('41.950.095/0001-91','ROBOTS S.A.'),
	 ('03.944.410/0001-89','FAZENDA SOL'),
	 ('45.437.344/0001-09','INSULA PROPERTIES');
	 
INSERT INTO fiscamuni.fiscal (nome,data_nasc) VALUES
	 ('José Inácio','1970-05-01'),
	 ('Ana Florência','1984-01-17'),
	 ('Bruna Pereira','1962-10-15'),
	 ('Antônio Shuni','1965-07-02'),
	 ('Luiza Alves','1990-10-21');
	 
INSERT INTO fiscamuni.motivo (descricao) VALUES
	 ('IMPOSTOS'),
	 ('TRABALHISTA'),
	 ('AMBIENTAL'),
	 ('DIREITOS CONSUMIDOR'),
	 ('ELEITORAL');
	 
INSERT INTO fiscamuni.propriedade (descricao,cidade,endereco,tags,id_empresa) VALUES
	 ('Horti Bomba','São Paulo','R. Junior, 109, ao lado do Banco do Brasil','frutas, verduras, pastel',2),
	 ('Sol Unidade 1','Rio Verde','zona rural','soja, milho, algodão',7),
	 ('Sol Unidade 2','Rio Verde','zona rural','soja',7),
	 ('Horti Fresh','São Paulo','Av. das Bananeiras, 911, esquina com R. XVII','frutas, verduras',2),
	 ('Fresco Lettuce','Campinas','Av. Princesa do Oeste, Shopping Plaza','frutas, verduras',2),
	 ('Sol Unidade 3','Rio Verde','zona rural','sorgo, pastagem',7),
	 ('Space Station','Alcântara','BR 345, km 15','lua, marte, viagem, espaço',5),
	 ('Sol Unidade 4','Rio Verde','zona rural','soja, milho, algodão',7);
	 
INSERT INTO fiscamuni.multa (id_propriedade,id_fiscal,valor,data_notificacao,id_motivo) VALUES
	 (6,1,63.00,'2022-03-09',1),
	 (3,4,190.00,'2022-04-14',3),
	 (4,4,134.00,'2022-02-08',3),
	 (5,3,166.00,'2022-03-02',5),
	 (1,5,74.00,'2022-01-07',3),
	 (3,4,91.00,'2022-01-31',5),
	 (6,1,92.00,'2022-05-14',5),
	 (4,1,115.00,'2022-02-04',1),
	 (1,1,190.00,'2022-05-12',1),
	 (5,1,103.00,'2022-01-16',3);
INSERT INTO fiscamuni.multa (id_propriedade,id_fiscal,valor,data_notificacao,id_motivo) VALUES
	 (3,1,148.00,'2022-02-12',1),
	 (2,4,161.00,'2022-06-14',3),
	 (5,3,47.00,'2022-06-06',1),
	 (4,5,191.00,'2022-04-16',5),
	 (3,1,23.00,'2022-03-02',1),
	 (3,4,148.00,'2022-06-15',1),
	 (6,3,198.00,'2022-04-15',3),
	 (5,4,87.00,'2022-01-25',1),
	 (3,5,184.00,'2022-06-19',3),
	 (3,4,58.00,'2022-02-25',3);
INSERT INTO fiscamuni.multa (id_propriedade,id_fiscal,valor,data_notificacao,id_motivo) VALUES
	 (5,3,195.00,'2022-05-06',5),
	 (6,4,71.00,'2022-04-12',1),
	 (6,1,110.00,'2022-05-12',5),
	 (2,4,110.00,'2022-06-21',1),
	 (6,5,24.00,'2022-04-12',1),
	 (1,5,27.00,'2022-06-21',3),
	 (2,5,19.00,'2022-01-14',1),
	 (1,5,116.00,'2022-04-04',1),
	 (6,3,103.00,'2022-03-09',5),
	 (2,3,142.00,'2022-02-23',3);
INSERT INTO fiscamuni.multa (id_propriedade,id_fiscal,valor,data_notificacao,id_motivo) VALUES
	 (3,5,146.00,'2022-03-08',5),
	 (5,3,91.00,'2022-06-19',1),
	 (1,3,119.00,'2022-04-20',5),
	 (2,5,51.00,'2022-02-09',1),
	 (1,3,74.00,'2022-02-15',5),
	 (5,5,125.00,'2022-04-21',5),
	 (4,1,92.00,'2022-02-24',5),
	 (4,3,140.00,'2022-04-29',5),
	 (5,5,104.00,'2022-03-13',3),
	 (3,1,84.00,'2022-01-02',1);
INSERT INTO fiscamuni.multa (id_propriedade,id_fiscal,valor,data_notificacao,id_motivo) VALUES
	 (5,1,157.00,'2022-06-03',5),
	 (2,5,145.00,'2022-02-12',3),
	 (5,5,32.00,'2022-04-22',1),
	 (3,5,166.00,'2022-03-09',1),
	 (4,4,28.00,'2022-01-03',3),
	 (6,4,115.00,'2022-06-20',5),
	 (1,1,56.00,'2022-05-05',5),
	 (2,1,29.00,'2022-04-22',5),
	 (1,4,141.00,'2022-01-04',5),
	 (4,5,58.00,'2022-02-09',5);
INSERT INTO fiscamuni.multa (id_propriedade,id_fiscal,valor,data_notificacao,id_motivo) VALUES
	 (5,1,24.00,'2022-01-10',1);

COMMIT;
