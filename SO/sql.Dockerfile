FROM mysql:8.0.36

# Variáveis de ambiente para configurar o MySQL
ENV MYSQL_ROOT_PASSWORD=urubu100

# Copiar scripts de inicialização (opcional)
COPY ./script.sql/ /docker-entrypoint-initdb.d/

EXPOSE 3306
