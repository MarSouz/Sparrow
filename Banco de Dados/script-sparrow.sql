-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Sparrow
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Sparrow
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Sparrow` DEFAULT CHARACTER SET utf8 ;
USE `Sparrow` ;

-- -----------------------------------------------------
-- Table `Sparrow`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`empresa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(255) NULL,
  `nome_representante` VARCHAR(255) NULL,
  `email_representante` VARCHAR(255) NULL,
  `cnpj` CHAR(14) NULL,
  PRIMARY KEY (`id`))
AUTO_INCREMENT = 1000;


-- -----------------------------------------------------
-- Table `Sparrow`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`cargo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `senha` VARCHAR(45) NULL,
  `fk_empresa` INT NOT NULL,
  `fk_cargo` INT NOT NULL,
  PRIMARY KEY (`id`, `fk_empresa`),
  INDEX `fk_funcionario_empresa1_idx` (`fk_empresa` ASC) VISIBLE,
  INDEX `fk_funcionario_cargo1_idx` (`fk_cargo` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `Sparrow`.`empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`fk_cargo`)
    REFERENCES `Sparrow`.`cargo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`tipo_maquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`tipo_maquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`coordenada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`coordenada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `latitude` DECIMAL(9,6) NULL,
  `longitude` DECIMAL(9,6) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`maquina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`maquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_empresa` INT NOT NULL,
  `endereco_mac` CHAR(20) NULL,
  `fk_tipo_maquina` INT NOT NULL,
  `fk_coordenada` INT NULL,
  PRIMARY KEY (`id`, `fk_empresa`),
  INDEX `fk_servidor_empresa1_idx` (`fk_empresa` ASC) VISIBLE,
  INDEX `fk_maquina_tipo_maquina1_idx` (`fk_tipo_maquina` ASC) VISIBLE,
  INDEX `fk_maquina_coordenada1_idx` (`fk_coordenada` ASC) VISIBLE,
  CONSTRAINT `fk_servidor_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `Sparrow`.`empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maquina_tipo_maquina1`
    FOREIGN KEY (`fk_tipo_maquina`)
    REFERENCES `Sparrow`.`tipo_maquina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maquina_coordenada1`
    FOREIGN KEY (`fk_coordenada`)
    REFERENCES `Sparrow`.`coordenada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`dado_monitorado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`dado_monitorado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `unidade_medida` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`maquina_dado_monitorado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`maquina_dado_monitorado` (
  `limite_componente` INT NULL,
  `fk_empresa` INT NOT NULL,
  `fk_maquina` INT NOT NULL,
  `fk_dado_monitorado` INT NOT NULL,
  PRIMARY KEY (`fk_empresa`, `fk_maquina`, `fk_dado_monitorado`),
  INDEX `fk_maquina_dado_monitorado_maquina1_idx` (`fk_empresa` ASC, `fk_maquina` ASC) VISIBLE,
  INDEX `fk_maquina_dado_monitorado_dado_monitorado1_idx` (`fk_dado_monitorado` ASC) VISIBLE,
  CONSTRAINT `fk_maquina_dado_monitorado_maquina1`
    FOREIGN KEY (`fk_maquina`,`fk_empresa`)
    REFERENCES `Sparrow`.`maquina` (`id` , `fk_empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maquina_dado_monitorado_dado_monitorado1`
    FOREIGN KEY (`fk_dado_monitorado`)
    REFERENCES `Sparrow`.`dado_monitorado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`dado_capturado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`dado_capturado` (
  `id` INT NOT NULL,
  `registro` INT NULL,
  `data_hora` DATETIME NULL,
  `fk_empresa` INT NOT NULL,
  `fk_maquina` INT NOT NULL,
  `fk_dado_monitorado` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dado_capturado_maquina_dado_monitorado1_idx` (`fk_empresa` ASC, `fk_maquina` ASC, `fk_dado_monitorado` ASC) VISIBLE,
  CONSTRAINT `fk_dado_capturado_maquina_dado_monitorado1`
    FOREIGN KEY (`fk_empresa` , `fk_maquina` , `fk_dado_monitorado`)
    REFERENCES `Sparrow`.`maquina_dado_monitorado` (`fk_empresa` , `fk_maquina` , `fk_dado_monitorado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`alerta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_dado_maquina` INT NOT NULL,
  PRIMARY KEY (`id`, `fk_dado_maquina`),
  INDEX `fk_alertas_dados_servidor1_idx` (`fk_dado_maquina` ASC) VISIBLE,
  CONSTRAINT `fk_alertas_dados_servidor1`
    FOREIGN KEY (`fk_dado_maquina`)
    REFERENCES `Sparrow`.`dado_capturado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sparrow`.`lead`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sparrow`.`lead` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(255) NULL,
  `nome_representante` VARCHAR(255) NULL,
  `email_representante` VARCHAR(255) NULL,
  `cnpj` CHAR(14) NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Sparrow`.`elerson_dados_tratados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_maquina` INT NOT NULL,
  `fk_empresa` INT NOT NULL,
  `fk_dado_monitorado` INT NOT NULL,
  `media` FLOAT NULL,
  `minimo` FLOAT NULL,
  `primeiro_quartil` FLOAT NULL,
  `mediana` FLOAT NULL,
  `terceiro_quartil` FLOAT NULL,
  `maximo` FLOAT NULL,
  `periodo_dias` INT NOT NULL,
  PRIMARY KEY (`id`)
);


INSERT INTO empresa VALUES (1, "Sparrow", "sparrow", "sparrow@gmail.com", 12345678912345);

INSERT INTO cargo VALUES (default, "Administrador");
INSERT INTO cargo VALUES (default, "Analista");

INSERT INTO funcionario VALUES (default, "Sparrow", "sparrow@sptech.school", "sparrow", 1, 1);

INSERT INTO tipo_maquina VALUES (default, "Servidor");
INSERT INTO tipo_maquina VALUES (default, "Terminal");

INSERT INTO dado_monitorado VALUES (default, "Uso de CPU", "Porcentagem");
INSERT INTO dado_monitorado VALUES (default, "Uso de RAM", "Porcentagem");
INSERT INTO dado_monitorado VALUES (default, "Uso do Disco", "Porcentagem");
INSERT INTO dado_monitorado VALUES (default, "Pacotes Enviados", "Inteiro");
INSERT INTO dado_monitorado VALUES (default, "Pacotes Recebidos", "Inteiro");

-- Supondo que já existam entradas nas tabelas de referência

-- Inserir uma nova máquina
INSERT INTO `Sparrow`.`maquina` (fk_empresa, endereco_mac, fk_tipo_maquina, fk_coordenada) 
VALUES (2, '00:1A:2B:3C:4D:5E', 1, null);

-- Inserir outra máquina
INSERT INTO `Sparrow`.`maquina` (fk_empresa, endereco_mac, fk_tipo_maquina, fk_coordenada) 
VALUES (2, '00:1A:2B:3C:4D:5F', 1, null);

-- Inserir mais uma máquina
INSERT INTO `Sparrow`.`maquina` (fk_empresa, endereco_mac, fk_tipo_maquina, fk_coordenada) 
VALUES (2, '00:1A:2B:3C:4D:6A', 1, null);

-- Inserir outra máquina
INSERT INTO `Sparrow`.`maquina` (fk_empresa, endereco_mac, fk_tipo_maquina, fk_coordenada) 
VALUES (2, '00:1A:2B:3C:4D:6B', 1, null);

SELECT
    m.id AS id,
    m.fk_empresa as fk_empresa,
    l.latitude as lat,
    l.longitude as lon,
    l.id as idlocalizacao,
    MAX(CASE WHEN tc.nome = 'Uso de CPU' THEN mc.limite_componente END) AS CPU,
    MAX(CASE WHEN tc.nome = 'Uso de RAM' THEN mc.limite_componente END) AS RAM,
    MAX(CASE WHEN tc.nome = 'Uso do Disco' THEN mc.limite_componente END) AS Disco
FROM
    maquina m
JOIN
    maquina_dado_monitorado mc ON mc.fk_maquina = m.id
JOIN
    dado_monitorado tc ON mc.fk_dado_monitorado = tc.id
LEFT JOIN
	coordenada l ON l.id = m.fk_coordenada
WHERE
    m.fk_empresa = 2 and m.fk_tipo_maquina = 1
GROUP BY
    m.id;
 
 select * from empresa;
 select * from maquina_dado_monitorado;   
insert into maquina_dado_monitorado (limite_componente, fk_empresa, fk_maquina, fk_dado_monitorado) values(80,2,4,3);

select * from maquina;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
