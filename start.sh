#!/bin/bash

# Sử dụng PORT từ Render hoặc mặc định là 8087
ADMIN_PORT=${PORT:-8087}
CUSTOMER_PORT=$((ADMIN_PORT + 1))

# Chạy Admin service trên port chính
echo "Starting Admin service on port $ADMIN_PORT..."
java -jar admin.jar --server.port=$ADMIN_PORT --server.address=0.0.0.0 &
ADMIN_PID=$!

echo "Starting Customer service on port $CUSTOMER_PORT..."
java -jar customer.jar --server.port=$CUSTOMER_PORT --server.address=0.0.0.0 &
CUSTOMER_PID=$!

echo "All services started."

# Function to handle termination
terminate() {
  echo "Shutting down services..."
  kill $CUSTOMER_PID $ADMIN_PID
  exit 0
}

# Set up signal handling
trap terminate SIGTERM SIGINT

# Keep script running
wait $ADMIN_PID $CUSTOMER_PID





