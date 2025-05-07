#!/bin/bash

# Start services in background
java -jar library.jar &
LIBRARY_PID=$!

# Wait for library service to start
sleep 30

# Start admin and customer services
java -jar admin.jar &
ADMIN_PID=$!

java -jar customer.jar &
CUSTOMER_PID=$!

# Function to handle termination
terminate() {
  echo "Shutting down services..."
  kill $CUSTOMER_PID $ADMIN_PID $LIBRARY_PID
  exit 0
}

# Set up signal handling
trap terminate SIGTERM SIGINT

# Keep script running
wait $LIBRARY_PID $ADMIN_PID $CUSTOMER_PID