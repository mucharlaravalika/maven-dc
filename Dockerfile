FROM maven:3.5-jdk-8  
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean package

FROM gcr.io/distroless/java  
COPY --from=build /usr/src/app/target/gs-maven-0.1.0.jar /usr/app/gs-maven-0.1.0.jar.jar  
EXPOSE 8080  
ENTRYPOINT ["java","-jar","/usr/app/gs-maven-0.1.0.jar.jar"]
