#!/bin/bash

# Sử dụng các port mặc định cho Admin và Customer
ADMIN_PORT=8087
CUSTOMER_PORT=8020
NGINX_PORT=${PORT:-10000}

echo "PORT from environment: $PORT"
echo "Using Nginx port: $NGINX_PORT"

# Khởi động Admin service
echo "Starting Admin service on port $ADMIN_PORT..."
java -jar admin.jar --server.port=$ADMIN_PORT --server.address=0.0.0.0 --spring.h2.console.settings.web-allow-others=true &
ADMIN_PID=$!

# Khởi động Customer service
echo "Starting Customer service on port $CUSTOMER_PORT..."
java -jar customer.jar --server.port=$CUSTOMER_PORT --server.address=0.0.0.0 --spring.h2.console.settings.web-allow-others=true &
CUSTOMER_PID=$!

# Cập nhật cổng trong cấu hình Nginx
sed -i "s/listen 10000/listen $NGINX_PORT/g" /etc/nginx/nginx.conf

# Khởi động Nginx
echo "Starting Nginx on port $NGINX_PORT..."
nginx -g "daemon off;" &
NGINX_PID=$!

echo "All services started."

# Function to handle termination
terminate() {
  echo "Shutting down services..."
  kill $NGINX_PID $CUSTOMER_PID $ADMIN_PID
  exit 0
}

# Set up signal handling
trap terminate SIGTERM SIGINT

# Keep script running
wait $NGINX_PID $ADMIN_PID $CUSTOMER_PID

