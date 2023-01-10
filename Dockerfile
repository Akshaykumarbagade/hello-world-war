FROM maven:3.8.2-openjdk-8 as build_stage
ARG BUILD_VERSION=1.0.5
WORKDIR /docker-workdir
COPY . .
RUN mvn clean package

FROM tomcat:9.0
ARG BUILD_VERSION=1.0.5
COPY --from=build_stage /docker-workdir/target/hello-world-war-1.0.0.war /usr/local/tomcat/webapps/
