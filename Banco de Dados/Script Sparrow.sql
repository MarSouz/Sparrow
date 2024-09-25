CREATE DATABASE sparrow;

USE sparrow;

CREATE TABLE cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nomeCliente VARCHAR(50),
cnpj CHAR(14),
estado CHAR(2)
);

CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeUsuario VARCHAR(45),
emailUsuario VARCHAR(100),
senhaUsuario VARCHAR(45),
tipoUsuario VARCHAR(13),
fk_Cliente INT,
FOREIGN KEY (fk_Cliente) REFERENCES cliente(idCliente));

CREATE TABLE servidores(
idServidores INT PRIMARY KEY,
numeroSerial VARCHAR(45),
cep CHAR(8),
logradouro VARCHAR(45),
numeroEndereco VARCHAR(45),
bairro VARCHAR(65),
fkClienteServidor INT,
FOREIGN KEY (fkClienteServidor) REFERENCES cliente(idCliente));

CREATE TABLE radares(
idRadares INT PRIMARY KEY,
tipo VARCHAR(45),
localizacao VARCHAR(255),
numeroSerial VARCHAR(10),
clienteRadar INT,
FOREIGN KEY (clienteRadar) REFERENCES cliente(idCliente));


CREATE TABLE componentes(
CpuUtilizada DECIMAL,
RamUtilizada DECIMAL,
DiscoUtilizado DECIMAL,
PacotesEnviados INT,
PacotesRecebidos INT,
TempoDeBoot DATETIME
);

CREATE TABLE servidoresEcomponentes(
servidores_idservidores INT,
servidores_fkClienteServidor INT,
Componentes_idComponentes INT,
PRIMARY KEY (servidores_idservidores, servidores_fkClienteServidor, Componentes_idComponentes)
);

CREATE TABLE radaresEcomponentes(
radares_idradares INT,
radares_ClienteRadar INT,
Componentes_idComponentes INT,
PRIMARY KEY (radares_idradares, radares_ClienteRadar, Componentes_idComponentes)
);




