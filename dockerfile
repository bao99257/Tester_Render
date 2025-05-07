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

# Cài đặt Nginx
RUN apt-get update && apt-get install -y nginx

# Set working directory
WORKDIR /app

# Copy JARs
COPY --from=build /app/Admin/target/*.jar admin.jar
COPY --from=build /app/Customer/target/*.jar customer.jar

# Copy startup script và Nginx config
COPY start.sh /app/start.sh
COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod +x /app/start.sh

# Expose port
EXPOSE 10000

# Start services
CMD ["/app/start.sh"]
