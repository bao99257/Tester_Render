# Base image
FROM maven:3.8.4-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build all modules
RUN mvn clean package -DskipTests

# Runtime image
FROM openjdk:17-jdk

# Set working directory
WORKDIR /app

# Copy built artifacts
COPY --from=build /app/Library/target/*.jar library.jar
COPY --from=build /app/Admin/target/*.jar admin.jar
COPY --from=build /app/Customer/target/*.jar customer.jar

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose ports
EXPOSE 8083 8087 8020

# Start services
CMD ["/app/start.sh"]