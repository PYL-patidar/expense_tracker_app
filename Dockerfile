#base image for java spting boot app and for this perform many task to run this --> use maven
#that's why maven use for code compile and pack into .jar

FROM maven:4.0.0-rc-7-eclipse-temurin-17 AS builder

# code store workdirectroy
WORKDIR /app

# copy entire code to container
COPY . .

# run maven to compile code and build --> target/expense-tracker.jar
RUN mvn clean install -DskipTests 

# Now base image of java eclipse-temurin
#FROM eclipse-temurin:8u504-b01-jre-ubi9-minimal as deployer
# destroless image of java 25
#FROM gcr.io/distroless/java25-debian13 
FROM eclipse-temurin:8u504-b01-jre-ubi10-minimal

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/expense-tracker.jar

CMD ["/app/target/expense-tracker.jar"]


  
