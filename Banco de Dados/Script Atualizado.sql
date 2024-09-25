create database sparrow;
use sparrow;

create table empresa(
id int primary key auto_increment, 
nome_empresa varchar(45), 
nome_representante varchar(45), 
email_contato varchar(255), 
cnpj char(14));

create table cargo(
id int primary key auto_increment,
nome varchar(45));

create table funcionario(
id int primary key auto_increment, 
nome_completo varchar(255), 
email varchar(255), 
senha varchar(45), 
fk_empresa int, 
constraint fk_empresa foreign key (fk_empresa)
            references empresa(id));
            
            
            
create table servidor(
id int primary key auto_increment, 
fk_empresa_servidor int, 
constraint fk_empresa_servidor foreign key (fk_empresa_servidor)
            references empresa(id));    
            
create table componente_servidor(
id int primary key auto_increment, 
nome_componente varchar(45), 
unidade_medida varchar(45));

create table servidor_componente(
fk_servidor int, 
constraint fk_servidor foreign key (fk_servidor)
            references servidor(id),
fk_componente_servidor int, 
constraint fk_componente_servidor foreign key (fk_componente_servidor)
            references componente_servidor(id),
limite_componente int);    

create table informacao_servidor(
id int primary key auto_increment, 
registro_porcentagem int, 
data_hora datetime, 
fk_servidor_informacao int, 
constraint fk_servidor_informacao foreign key (fk_servidor_informacao)
           references servidor_componente(fk_servidor),
fk_componente_informacao int, 
constraint fk_componente_informacao foreign key (fk_componente_informacao)
			references servidor_componente(fk_componente_servidor));
            
create table alerta_servidor(
id int primary key auto_increment,
fk_dado_servidor int, 
constraint fk_dado_servidor foreign key (fk_dado_servidor)  
           references informacao_servidor(id));
           
           
create table terminal(
id int primary key auto_increment, 
longitude decimal (18, 15), 
latitude decimal (17.15), 
fk_empresa_terminal int, 
constraint fk_empresa_terminal foreign key (fk_empresa_terminal)      
		   references empresa (id));
           
create table componente_terminal(
id int primary key auto_increment,
nome_componente varchar(45), 
unidade_medida varchar(45)); 

create table terminal_componente(
fk_terminal int, 
constraint fk_terminal foreign key (fk_terminal)
           references terminal (id), 
fk_componente_terminal int,
constraint fk_componente_terminal foreign key (fk_componente_terminal)
			references componente_terminal(id));
            
create table informacao_terminal(
id int primary key auto_increment,
registro_porcentagem int, 
data_hora datetime, 
fk_terminal_informacao int,
constraint fk_terminal_informacao foreign key (fk_terminal_informacao)
           references terminal_componente(fk_terminal), 
fk_componente int, 
constraint fk_componente foreign key (fk_componente)
           references terminal_componente(fk_componente_terminal));
           
           
create table alerta_terminal(
id int primary key auto_increment, 
fk_informacao_terminal int,
constraint fk_informacao_terminal foreign key (fk_informacao_terminal)
           references informacao_terminal(id));


            
