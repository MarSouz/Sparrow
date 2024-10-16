#!/bin/bash

GREEN='\033[0;32m'

NC='\033[0m'

echo -e "${GREEN}Atualizando o Linux${NC}"
sudo apt update > /dev/null 2>&1 -y && sudo apt upgrade -y > /dev/null 2>&1

echo -e "${GREEN}Fazendo instalação do Docker${NC}"
sudo apt install docker.io  -y > /dev/null 2>&1

echo -e "${GREEN}Ativando os serviços docker${NC}"
sudo systemctl start docker

echo -e "${GREEN}Habilitando os serviços docker${NC}"
sudo systemctl enable docker

echo -e "${GREEN}Fazendo pull das imagens do Web-site e do Banco de dados${NC}"
sudo docker pull dominiquedornan/sparrow_mysql > /dev/null 2>&1
sudo docker pull dominiquedornan/sparrow_nodejs > /dev/null 2>&1

echo -e "${GREEN}Criando e ativando os contâiners a partir das imagens${NC}"
sudo docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=urubu100 dominiquedornan/sparrow_mysql
sudo docker run -d --name site -p 3333:3333 dominiquedornan/sparrow_nodejs

echo -e "${GREEN}Verifique o STATUS dos contâiners${NC}"
sudo docker ps -a