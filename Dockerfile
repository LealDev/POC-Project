FROM gradle:7.4.2-jdk17 AS build

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Instalar dos2unix para converter scripts se necessário
RUN apt-get update && apt-get install -y dos2unix

# Copiar os arquivos Gradle e o diretório src para o diretório de trabalho
COPY build.gradle settings.gradle gradlew gradlew.bat docker-compose.yml ./
COPY gradle ./gradle
COPY src ./src

# Converter o script gradlew para formato Unix e garantir permissão de execução
RUN dos2unix gradlew && chmod +x gradlew

# Compilar a aplicação Spring Boot
RUN ./gradlew build -x test

# Use uma imagem base oficial do JDK 17 para executar a aplicação
FROM openjdk:17-jdk-slim

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o arquivo JAR gerado pelo Gradle do estágio de build para o diretório de trabalho
COPY --from=build /app/build/libs/*.jar app.jar

# Copiar o arquivo de configuração do Spring Boot e docker-compose.yml
COPY --from=build /app/docker-compose.yml /app/config/
COPY src/main/resources/application.properties /app/config/

# Expor a porta que a aplicação Spring Boot vai rodar
EXPOSE 8080

# Comando para rodar a aplicação Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
