#!/bin/bash

# Chỉ chạy Admin và Customer services
echo "Starting Admin service..."
java -jar admin.jar &
ADMIN_PID=$!

echo "Starting Customer service..."
java -jar customer.jar &
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
