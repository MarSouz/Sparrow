CREATE DATABASE IF NOT EXISTS `Sparrow`;

USE `Sparrow` ;

CREATE TABLE IF NOT EXISTS `Sparrow`.`empresa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(255) NULL,
  `nome_representante` VARCHAR(255) NULL,
  `email_representante` VARCHAR(255) NULL,
  `cnpj` CHAR(14) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`cargo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`funcionario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `senha` VARCHAR(45) NULL,
  `fk_empresa` INT NOT NULL,
  `fk_cargo` INT NOT NULL,
  PRIMARY KEY (`id`,`fk_empresa`),
  CONSTRAINT `fk_funcionario_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `Sparrow`.`empresa` (`id`),
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`fk_cargo`)
    REFERENCES `Sparrow`.`cargo` (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`tipo_maquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`localizacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `latitude` DECIMAL(9,6) NULL,
  `longitude` DECIMAL(9,6) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`maquina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_empresa` INT NOT NULL,
  `fk_tipo_maquina` INT NOT NULL,
  `endereco_mac` CHAR(20) NULL,
  `fk_localizacao` INT NULL,
  PRIMARY KEY (`id`, `fk_empresa`),
  CONSTRAINT `fk_servidor_empresa1`
    FOREIGN KEY (`fk_empresa`)
    REFERENCES `Sparrow`.`empresa` (`id`),
  CONSTRAINT `fk_maquina_tipo_maquina1`
    FOREIGN KEY (`fk_tipo_maquina`)
    REFERENCES `Sparrow`.`tipo_maquina` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_maquina_localizacao1`
    FOREIGN KEY (`fk_localizacao`)
    REFERENCES `Sparrow`.`localizacao` (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`tipo_componente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_componente` VARCHAR(45) NULL,
  `unidade_medida` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
   
CREATE TABLE IF NOT EXISTS `Sparrow`.`maquina_componente` (
    `fk_maquina` INT NOT NULL,
    `fk_componente_maquina` INT NOT NULL,
    `limite_componente` INT NULL,
    PRIMARY KEY (`fk_maquina`, `fk_componente_maquina`),
    CONSTRAINT `fk_maquina_componente_maquina`
        FOREIGN KEY (`fk_maquina`)
        REFERENCES `Sparrow`.`maquina` (`id`)
        ON DELETE CASCADE,
    CONSTRAINT `fk_maquina_componente_tipo_componente`
        FOREIGN KEY (`fk_componente_maquina`)
        REFERENCES `Sparrow`.`tipo_componente` (`id`)
        ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS `Sparrow`.`dado_capturado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `registro` INT NULL,
  `data_hora` DATETIME NULL,
  `fk_maquina` INT NOT NULL,
  `fk_componente_maquina` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_dados_servidor_servidor_componentes1`
    FOREIGN KEY (`fk_maquina` , `fk_componente_maquina`)
    REFERENCES `Sparrow`.`maquina_componente` (`fk_maquina` , `fk_componente_maquina`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`alerta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fk_dado_maquina` INT NOT NULL,
  PRIMARY KEY (`id`, `fk_dado_maquina`),
  CONSTRAINT `fk_alertas_dados_servidor1`
    FOREIGN KEY (`fk_dado_maquina`)
    REFERENCES `Sparrow`.`dado_capturado` (`id`));

CREATE TABLE IF NOT EXISTS `Sparrow`.`possivel_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(255) NULL,
  `nome_representante` VARCHAR(255) NULL,
  `email_representante` VARCHAR(255) NULL,
  `cnpj` CHAR(14) NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`));
 
INSERT INTO empresa VALUES (default, "Sparrow", "sparrow", "sparrow@gmail.com", 12345678912345);

INSERT INTO cargo VALUES (default, "Administrador");
INSERT INTO cargo VALUES (default, "Analista");

INSERT INTO funcionario VALUES (default, "Sparrow", "sparrow@sptech.school", "sparrow", 1, 1);

INSERT INTO tipo_maquina VALUES (default, "Servidor");
INSERT INTO tipo_maquina VALUES (default, "Terminal");

INSERT INTO tipo_componente VALUES (default, "Uso de CPU", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "Uso de RAM", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "Uso do Disco", "Porcentagem");
INSERT INTO tipo_componente VALUES (default, "Pacotes Enviados", "Inteiro");
INSERT INTO tipo_componente VALUES (default, "Pacotes Recebidos", "Inteiro");
SELECT * FROM tipo_componente;

SELECT * FROM maquina_componente;
SELECT * FROM dado_capturado;

SELECT
    m.id,
    e.nome_empresa,
    tm.nome AS tipo_maquina
FROM
    maquina m
JOIN
    empresa e ON m.fk_empresa = e.id
JOIN
    tipo_maquina tm ON m.fk_tipo_maquina = tm.id
WHERE
    e.nome_empresa = 'Sparrow';
 
SELECT
    m.id AS id,
    m.fk_tipo_maquina,
    m.fk_empresa AS fk_empresa,
    l.latitude AS lat,
    l.longitude AS lon,
    MAX(CASE WHEN tc.nome_componente = 'CPU' THEN mc.limite_componente END) AS CPU,
    MAX(CASE WHEN tc.nome_componente = 'RAM' THEN mc.limite_componente END) AS RAM,
    MAX(CASE WHEN tc.nome_componente = 'Disco' THEN mc.limite_componente END) AS Disco
FROM
    maquina m
JOIN
    maquina_componente mc ON mc.fk_maquina = m.id
JOIN
    tipo_componente tc ON mc.fk_componente_maquina = tc.id
JOIN
    localizacao l ON l.id = m.fk_localizacao
WHERE
    fk_empresa = 1
    AND fk_tipo_maquina = 2
GROUP BY
    m.id;
   
UPDATE maquina_componente SET limite_componente = 70 WHERE fk_maquina = 3 AND fk_componente_maquina = 1;

SELECT * FROM maquina;

-- -----READ-----

CREATE VIEW maquinaComponente AS
SELECT 
    e.id AS idEmpresa,
    e.nome_empresa,
    m.fk_tipo_maquina AS fk_tipo_maquina,
    m.id,
    MAX(CASE WHEN tc.nome_componente = 'CPU' THEN mc.limite_componente END) AS CPU,
    MAX(CASE WHEN tc.nome_componente = 'RAM' THEN mc.limite_componente END) AS RAM,
    MAX(CASE WHEN tc.nome_componente = 'Disco' THEN mc.limite_componente END) AS Disco,
    MAX(CASE WHEN tc.nome_componente = 'Pacotes Enviados' THEN mc.limite_componente END) AS Pacotes_Enviados,
    MAX(CASE WHEN tc.nome_componente = 'Pacotes Recebidos' THEN mc.limite_componente END) AS Pacotes_Recebidos,
    l.latitude AS lat,
    l.longitude AS lon
FROM 
    maquina m
JOIN 
    empresa e ON m.fk_empresa = e.id
JOIN 
    maquina_componente mc ON m.id = mc.fk_maquina
JOIN 
    tipo_componente tc ON tc.id = mc.fk_componente_maquina
JOIN 
    localizacao l ON m.fk_localizacao = l.id
WHERE 
    fk_empresa = 1 AND fk_tipo_maquina = 1
GROUP BY 
    e.id, e.nome_empresa, m.fk_tipo_maquina, m.id, l.latitude, l.longitude;

SELECT * FROM maquinaComponente;