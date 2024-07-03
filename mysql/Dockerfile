FROM mysql:8.0

# Instalar o cliente MySQL
RUN apt-get update && apt-get install -y mysql-client

# Definir variáveis de ambiente do MySQL
ENV MYSQL_DATABASE=material_construcao_prod
ENV MYSQL_USER=produser
ENV MYSQL_PASSWORD=!%(&%#LealDev
ENV MYSQL_ROOT_PASSWORD=!%(&%#LealDev
ENV MYSQL_HOST=mysql
ENV MYSQL_PORT=3307
# Expor a porta do MySQL
EXPOSE 3307
