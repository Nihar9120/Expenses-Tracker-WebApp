# Stage 1 - Build the JAR (Java Application Runtime) using Maven
FROM maven:3.9-eclipse-temurin-17-alpine AS build

# Set Working Dir.
WORKDIR /app

# Copy source code from local to container
COPY . .

# Build application and skip test cases

# EXPOSE 8080

# Create JAR File
RUN mvn clean install -DskipTests=true

# ENTRYPOINT ["java", "-jar", "/expenseapp.jar"]

# Stage 2 - Execute JAR File from the above stage

# Import small size java image
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy build from stage 1 (builder)
COPY --from=build /app/target/*.jar /app/expenseapp.jar

# Expose application port
EXPOSE 8080

# Start the application
CMD ["java","-jar","expenseapp.jar"]
ENTRYPOINT ["java", "-jar", "/app/target/expenseapp.jar"]
