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
  `id` INT NOT NULL AUTO_INCREMENT,
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
  `desvio_padrao` FLOAT NULL,
  `outliers` JSON,
  `periodo_dias` INT NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Sparrow`.`manu_dados_tratados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_empresa` INT NOT NULL,
  `fk_maquina` INT NOT NULL,
  `fk_dado_monitorado` INT NOT NULL,
  `fk_alerta` INT NOT NULL,
  `data_hora` DATETIME NOT NULL,                     
  `registro` INT NOT NULL, 
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

INSERT INTO Sparrow.elerson_dados_tratados (
  fk_maquina,
  fk_empresa,
  fk_dado_monitorado,
  media,
  minimo,
  primeiro_quartil,
  mediana,
  terceiro_quartil,
  maximo,
  desvio_padrao,
  outliers,
  periodo_dias
) VALUES
-- Máquina 1
(1, 2, 1, 45.3, 30.0, 40.0, 45.0, 50.0, 60.0, 8.1, '[70.0, 80.0,90.0,89.9,80]', 7), 
(1, 2, 2, 60.5, 50.0, 55.0, 60.0, 65.0, 75.0, 7.3, '[80.0, 90.0]', 7),
(1, 2, 3, 70.1, 60.0, 65.0, 70.0, 75.0, 80.0, 5.2, '[85.0, 95.0]', 7),
(1, 2, 4, 1500.5, 1200.0, 1350.0, 1500.0, 1600.0, 1700.0, 150.6, '[1800.0, 2000.0]', 7),
(1, 2, 5, 1300.7, 1100.0, 1200.0, 1300.0, 1400.0, 1500.0, 125.3, '[1600.0, 1700.0]', 7),

-- Máquina 2
(2, 2, 1, 48.0, 30.0, 40.0, 45.0, 50.0, 55.0, 6.8, '[60.0, 65.0]', 7),
(2, 2, 2, 67.0, 60.0, 62.0, 65.0, 68.0, 72.0, 5.2, '[75.0, 80.0]', 7),
(2, 2, 3, 90.0, 70.0, 75.0, 80.0, 85.0, 90.0, 6.1, '[95.0, 100.0]', 7),
(2, 2, 4, 1700.0, 1400.0, 1500.0, 1550.0, 1600.0, 1650.0, 140.2, '[1800.0, 1900.0]', 7),
(2, 2, 5, 1340.0, 1250.0, 1300.0, 1350.0, 1400.0, 1450.0, 75.1, '[1500.0, 1600.0]', 7),

-- Máquina 3
(3, 2, 1, 52.5, 40.0, 45.0, 50.0, 55.0, 65.0, 7.0, '[70.0, 75.0]', 7),
(3, 2, 2, 62.3, 52.0, 56.0, 60.0, 66.0, 77.0, 8.0, '[80.0, 85.0]', 7),
(3, 2, 3, 72.0, 62.0, 66.0, 70.0, 74.0, 82.0, 6.0, '[85.0, 90.0]', 7),
(3, 2, 4, 1550.5, 1250.0, 1400.0, 1500.0, 1600.0, 1800.0, 160.0, '[1900.0, 2000.0]', 7),
(3, 2, 5, 1380.7, 1200.0, 1300.0, 1350.0, 1400.0, 1550.0, 100.0, '[1600.0, 1700.0]', 7),

-- Máquina 4
(4, 2, 1, 50.0, 35.0, 45.0, 50.0, 55.0, 65.0, 8.0, '[70.0, 75.0]', 7),
(4, 2, 2, 66.0, 55.0, 60.0, 65.0, 70.0, 80.0, 7.0, '[85.0, 90.0]', 7),
(4, 2, 3, 75.5, 65.0, 68.0, 72.0, 76.0, 85.0, 5.5, '[90.0, 95.0]', 7),
(4, 2, 4, 1650.0, 1300.0, 1450.0, 1550.0, 1650.0, 1750.0, 140.0, '[1900.0, 2000.0]', 7),
(4, 2, 5, 1400.0, 1250.0, 1300.0, 1350.0, 1400.0, 1500.0, 75.0, '[1550.0, 1650.0]', 7),

-- Máquina 5
(5, 2, 1, 53.2, 38.0, 45.0, 50.0, 56.0, 68.0, 9.0, '[70.0, 80.0]', 7),
(5, 2, 2, 68.5, 58.0, 62.0, 66.0, 72.0, 85.0, 10.0, '[90.0, 95.0]', 7),
(5, 2, 3, 80.1, 70.0, 72.0, 75.0, 80.0, 90.0, 7.5, '[95.0, 100.0]', 7),
(5, 2, 4, 1600.0, 1250.0, 1450.0, 1500.0, 1550.0, 1750.0, 130.0, '[1900.0, 2000.0]', 7),
(5, 2, 5, 1420.0, 1250.0, 1300.0, 1400.0, 1450.0, 1500.0, 60.0, '[1550.0, 1600.0]', 7),
-- Máquina 6
(6, 2, 1, 49.0, 32.0, 42.0, 47.0, 52.0, 62.0, 7.5, '[65.0, 70.0]', 7),
(6, 2, 2, 61.2, 50.5, 55.5, 60.5, 65.5, 75.5, 6.5, '[80.0, 85.0]', 7),
(6, 2, 3, 74.0, 63.0, 67.0, 72.0, 77.0, 82.0, 4.8, '[85.0, 90.0]', 7),
(6, 2, 4, 1550.5, 1200.0, 1350.0, 1500.0, 1600.0, 1700.0, 145.0, '[1750.0, 1800.0]', 7),
(6, 2, 5, 1385.0, 1200.0, 1250.0, 1350.0, 1400.0, 1450.0, 78.0, '[1500.0, 1550.0]', 7),

-- Máquina 7
(7, 2, 1, 46.8, 30.5, 40.5, 45.5, 50.5, 60.5, 6.9, '[65.0, 70.0]', 7),
(7, 2, 2, 62.3, 52.0, 57.0, 61.0, 66.0, 77.0, 7.8, '[80.0, 85.0]', 7),
(7, 2, 3, 76.5, 66.0, 70.0, 75.0, 78.0, 85.0, 5.0, '[88.0, 92.0]', 7),
(7, 2, 4, 1580.0, 1250.0, 1400.0, 1500.0, 1600.0, 1750.0, 135.0, '[1800.0, 1900.0]', 7),
(7, 2, 5, 1410.0, 1280.0, 1320.0, 1370.0, 1420.0, 1500.0, 65.0, '[1550.0, 1600.0]', 7),

-- Máquina 8
(8, 2, 1, 51.0, 35.0, 43.0, 49.0, 53.0, 63.0, 7.2, '[68.0, 72.0]', 7),
(8, 2, 2, 65.0, 54.0, 58.0, 63.0, 68.0, 80.0, 8.1, '[85.0, 90.0]', 7),
(8, 2, 3, 78.2, 68.0, 72.0, 76.0, 79.0, 88.0, 5.6, '[92.0, 95.0]', 7),
(8, 2, 4, 1620.0, 1300.0, 1450.0, 1550.0, 1650.0, 1800.0, 125.0, '[1850.0, 1900.0]', 7),
(8, 2, 5, 1440.0, 1300.0, 1350.0, 1400.0, 1450.0, 1500.0, 60.0, '[1550.0, 1600.0]', 7),

-- Máquina 9
(9, 2, 1, 47.5, 32.0, 41.0, 46.0, 51.0, 61.0, 7.0, '[64.0, 68.0]', 7),
(9, 2, 2, 63.7, 53.0, 58.0, 62.0, 67.0, 78.0, 7.4, '[82.0, 87.0]', 7),
(9, 2, 3, 75.8, 64.0, 68.0, 73.0, 77.0, 83.0, 4.9, '[87.0, 92.0]', 7),
(9, 2, 4, 1570.5, 1220.0, 1370.0, 1520.0, 1620.0, 1750.0, 150.0, '[1800.0, 1900.0]', 7),
(9, 2, 5, 1405.0, 1260.0, 1305.0, 1355.0, 1410.0, 1480.0, 70.0, '[1530.0, 1580.0]', 7),

-- Máquina 10
(10, 2, 1, 50.3, 34.0, 44.0, 49.0, 54.0, 64.0, 8.0, '[68.0, 72.0]', 7),
(10, 2, 2, 64.2, 55.0, 59.0, 64.0, 69.0, 79.0, 6.9, '[83.0, 88.0]', 7),
(10, 2, 3, 79.0, 68.0, 71.0, 74.0, 79.0, 89.0, 5.5, '[92.0, 96.0]', 7),
(10, 2, 4, 1640.0, 1300.0, 1450.0, 1550.0, 1650.0, 1850.0, 135.0, '[1900.0, 2000.0]', 7),
(10, 2, 5, 1450.0, 1300.0, 1350.0, 1400.0, 1450.0, 1550.0, 55.0, '[1600.0, 1650.0]', 7);

DELIMITER //
CREATE TRIGGER alerta
AFTER INSERT ON dado_capturado
FOR EACH ROW
BEGIN
    DECLARE limite INT;

    SELECT limite_componente INTO limite
    FROM maquina_dado_monitorado
    WHERE fk_maquina = NEW.fk_maquina AND fk_dado_monitorado = NEW.fk_dado_monitorado;

	
	
    IF NEW.registro >= limite THEN
        INSERT INTO alerta (fk_dado_maquina)
        VALUES (NEW.id);
    END IF;
END;
//
DELIMITER ;

-- Insert da empresa
INSERT INTO empresa VALUES (DEFAULT, 'SPTech', 'Alessandro', 'alessandro@sptech.school', '12345678909876');

-- Insert dos funcionários
INSERT INTO funcionario VALUES (2, 'Alessandro', 'alessandro@sptech.school', 'sptech', 2, 1);
INSERT INTO funcionario VALUES (3, 'Vera', 'vera@sptech.school', 'sptech', 2, 2);

-- Insert da coordenada
INSERT INTO coordenada VALUES (default, -23.550520, -46.633308);

-- Insert Máquina Sparrow
INSERT INTO maquina VALUES (default, 1, '1A.2A.3A.4A.5A.6A', 1, 1);

-- Insert Máquinas Cliente 
INSERT INTO maquina VALUES
    (default, 2,'3A:4F:92:8B:1C:2E', 1, 1),
    (default, 2,'F0:18:3C:AA:67:8F', 1, 1),
    (default, 2,'7D:1B:FA:44:CC:92', 1, 1),
    (default, 2,'D3:9F:6A:11:8E:23', 1, 1),
    (default, 2,'AA:5E:4D:78:90:34', 2, 1),
    (default, 2,'48:2C:9A:DF:63:7B', 2, 1),
    (default, 2,'19:8F:DE:2A:CB:5D', 2, 1),
    (default, 2,'6E:77:3B:01:AC:98', 2, 1);
select * from maquina_dado_monitorado;
-- Insert maquina_dado_monitorado MAQUINA SPARROW
INSERT INTO maquina_dado_monitorado VALUES
	(80, 1, 1, 1),
	(80, 1, 1, 2),
	(80, 1, 1, 3),
	(null, 1, 1, 4),
	(null, 1, 1, 5);
    
-- Insert maquina_dado_monitorado MAQUINA 2 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 2, 1),
	(80, 2, 2, 2),
	(80, 2, 2, 3),
	(null, 2, 2, 4),
	(null, 2, 2, 5);
    
-- Insert maquina_dado_monitorado MAQUINA 3 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 3, 1),
	(80, 2, 3, 2),
	(80, 2, 3, 3),
	(null, 2, 3, 4),
	(null, 2, 3, 5);
    
-- Insert maquina_dado_monitorado MAQUINA 4 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 4, 1),
	(80, 2, 4, 2),
	(80, 2, 4, 3),
	(null, 2, 4, 4),
	(null, 2, 4, 5);
    
-- Insert maquina_dado_monitorado MAQUINA 5 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 5, 1),
	(80, 2, 5, 2),
	(80, 2, 5, 3),
	(null, 2, 5, 4),
	(null, 2, 5, 5);

-- Insert maquina_dado_monitorado MAQUINA 6 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 6, 1),
	(80, 2, 6, 2),
	(80, 2, 6, 3),
	(null, 2, 6, 4),
	(null, 2, 6, 5);

-- Insert maquina_dado_monitorado MAQUINA 7 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 7, 1),
	(80, 2, 7, 2),
	(80, 2, 7, 3),
	(null, 2, 7, 4),
	(null, 2, 7, 5);

-- Insert maquina_dado_monitorado MAQUINA 8 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 8, 1),
	(80, 2, 8, 2),
	(80, 2, 8, 3),
	(null, 2, 8, 4),
	(null, 2, 8, 5);
    
-- Insert maquina_dado_monitorado MAQUINA 9 CLIENTE
INSERT INTO maquina_dado_monitorado VALUES
	(80, 2, 9, 1),
	(80, 2, 9, 2),
	(80, 2, 9, 3),
	(null, 2, 9, 4),
	(null, 2, 9, 5);
    
    select * from dado_capturado;
-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 2, 3);

-- Insert de dado_capturado MAQUINA 2 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 2, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 2, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 2, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 2, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 2, 1);

-- Insert de dado_capturado MAQUINA 2 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 2, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 2, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 2, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 2, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 2, 2);

-- Insert de dado_capturado MAQUINA 2 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 2, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 2, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 2, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 2, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 2, 3);

-- ------------------------------
select * from dado_capturado;
-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 3, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 3, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 3, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 3, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 3, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 3, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 3, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 3, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 3, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 3, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 3, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 3, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 3, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 3, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 3, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 3, 3);

-- ------------------------- MAQUINA 4
-- Insert de dado_capturado MAQUINA 4 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 4, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 4, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 4, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 4, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 4, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 4, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 4, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 4, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 4, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 4, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 4, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 4, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 4, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 4, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 4, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 4, 3);


-- ------------------------- MAQUINA 5
-- Insert de dado_capturado MAQUINA 4 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 5, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 5, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 5, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 5, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 5, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 5, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 5, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 5, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 5, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 5, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 5, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 5, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 5, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 5, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 5, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 5, 3);


-- ------------------------- MAQUINA 6
-- Insert de dado_capturado MAQUINA 4 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 6, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 6, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 6, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 6, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 6, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 6, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 6, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 6, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 6, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 6, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 6, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 6, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 6, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 6, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 6, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 6, 3);


-- ------------------------- MAQUINA 7
-- Insert de dado_capturado MAQUINA 4 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 7, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 7, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 7, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 7, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 7, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 7, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 7, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 7, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 7, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 7, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 7, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 7, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 7, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 7, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 7, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 7, 3);

-- ------------------------- MAQUINA 8
-- Insert de dado_capturado MAQUINA 4 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 8, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 8, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 8, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 8, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 8, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 8, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 8, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 8, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 8, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 8, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 8, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 8, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 8, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 8, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 8, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 8, 3);

-- ------------------------- MAQUINA 9
-- Insert de dado_capturado MAQUINA 4 CLIENTE CPU 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-01 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-01 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-01 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-01 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-01 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-01 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-01 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-01 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/01
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-01 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-01 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-01 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-01 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-01 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-02 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-02 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-02 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-02 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-02 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-02 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-02 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-02 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/02
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-02 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-02 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-02 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-02 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-02 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-03 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-03 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-03 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-03 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-03 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-03 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-03 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-03 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/03
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-03 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-03 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-03 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-03 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-03 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-04 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-04 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-04 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-04 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-04 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-04 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-04 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-04 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/04
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-04 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-04 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-04 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-04 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-04 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-05 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-05 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-05 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-05 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-05 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-05 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-05 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-05 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/05
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-05 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-05 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-05 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-05 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-05 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-06 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-06 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-06 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-06 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-06 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-06 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-06 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-06 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/06
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-06 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-06 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-06 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-06 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-06 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-07 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-07 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-07 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-07 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-07 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-07 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-07 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-07 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/07
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-07 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-07 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-07 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-07 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-07 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-08 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-08 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-08 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-08 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-08 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-08 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-08 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-08 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/08
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-08 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-08 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-08 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-08 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-08 14:00:00', 2, 9, 3);

-- Insert de dado_capturado MAQUINA 3 CLIENTE CPU 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 9, 1), 
(default, 90, '2024-12-09 11:00:00', 2, 9, 1), 
(default, 35, '2024-12-09 12:00:00', 2, 9, 1), 
(default, 88, '2024-12-09 13:00:00', 2, 9, 1), 
(default, 35, '2024-12-09 14:00:00', 2, 9, 1);

-- Insert de dado_capturado MAQUINA 3 CLIENTE RAM 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 9, 2), 
(default, 90, '2024-12-09 11:00:00', 2, 9, 2), 
(default, 13, '2024-12-09 12:00:00', 2, 9, 2), 
(default, 88, '2024-12-09 13:00:00', 2, 9, 2), 
(default, 74, '2024-12-09 14:00:00', 2, 9, 2);

-- Insert de dado_capturado MAQUINA 3 CLIENTE Disco 12/09
INSERT INTO dado_capturado VALUES
(default, 35, '2024-12-09 10:00:00', 2, 9, 3), 
(default, 35, '2024-12-09 11:00:00', 2, 9, 3), 
(default, 40, '2024-12-09 12:00:00', 2, 9, 3), 
(default, 40, '2024-12-09 13:00:00', 2, 9, 3), 
(default, 40, '2024-12-09 14:00:00', 2, 9, 3);

-- SERVIDOR
-- Pico máximo CPU
INSERT INTO manu_dados_tratados (fk_empresa, fk_maquina, fk_dado_monitorado, fk_alerta, data_hora, registro) VALUES
(2, 1, 1, 1, '2024-12-08 12:00:00', 80),  
(2, 1, 1, 1, '2024-12-08 13:00:00', 70),  
(2, 1, 1, 1, '2024-12-08 14:00:00', 80),  
(2, 1, 1, 1, '2024-12-08 15:00:00', 60);  

-- Pico máximo RAM
INSERT INTO `Sparrow`.`manu_dados_tratados` 
(fk_empresa, fk_maquina, fk_dado_monitorado, fk_alerta, data_hora, registro)
VALUES 
(2, 1, 2, 1, '2024-12-08 12:00:00', 50),  
(2, 1, 2, 1, '2024-12-08 13:00:00', 60), 
(2, 1, 2, 1, '2024-12-08 14:00:00', 40),  
(2, 1, 2, 1, '2024-12-08 15:00:00', 40);  

-- Pico máximo Pacotes Enviados
INSERT INTO manu_dados_tratados (fk_empresa, fk_maquina, fk_dado_monitorado, fk_alerta, data_hora, registro)
VALUES 
(2, 1, 5, 1, '2024-12-08 12:00:00', 50), 
(2, 1, 5, 1, '2024-12-08 13:00:00', 60), 
(2, 1, 5, 1, '2024-12-08 14:00:00', 40),  
(2, 1, 5, 1, '2024-12-08 15:00:00', 40);  


-- TERMINAL
-- Pico máximo CPU
INSERT INTO manu_dados_tratados (fk_empresa, fk_maquina, fk_dado_monitorado, fk_alerta, data_hora, registro) VALUES
(2, 2, 1, 1, '2024-12-08 12:00:00', 80),  
(2, 2, 1, 1, '2024-12-08 13:00:00', 70),  
(2, 2, 1, 1, '2024-12-08 14:00:00', 80), 
(2, 2, 1, 1, '2024-12-08 15:00:00', 60);  

-- Pico máximo RAM
INSERT INTO `Sparrow`.`manu_dados_tratados` 
(fk_empresa, fk_maquina, fk_dado_monitorado, fk_alerta, data_hora, registro)
VALUES 
(2, 2, 2, 1, '2024-12-08 12:00:00', 50),  
(2, 2, 2, 1, '2024-12-08 13:00:00', 60),  
(2, 2, 2, 1, '2024-12-08 14:00:00', 40),  
(2, 2, 2, 1, '2024-12-08 15:00:00', 40);  

-- Pico máximo Pacotes Enviados
INSERT INTO `Sparrow`.`manu_dados_tratados` 
(fk_empresa, fk_maquina, fk_dado_monitorado, fk_alerta, data_hora, registro)
VALUES 
(2, 2, 4, 1, '2024-12-08 12:00:00', 2050), 
(2, 2, 4, 1, '2024-12-08 13:00:00', 2260),  
(2, 2, 4, 1, '2024-12-08 14:00:00', 2440),  
(2, 2, 4, 1, '2024-12-08 15:00:00', 2340); 

select * from dado_capturado;
select * from alerta;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;