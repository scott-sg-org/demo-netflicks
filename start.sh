#!/bin/bash

# Check if any Netflicks Demo app is currently running
# TODO - use docker compose to check for running and reset

# Before Starting the Application we will update the Session Metadata
/root/netflicks/set-session-data.sh

echo "Starting Netflicks Demo application. This may take up to 2 minutes!"

echo "$1"

if [ "$1" = "fixed" ]; then
  docker compose -f docker-compose-fixed.yml up -d
else
  docker compose -f docker-compose.yml up -d
fi

sleep 30

#This script takes hostname as a parameter. If no paramter is provided, then hostname will default to localhost
# Check if at least one parameter is provided

# Example to run the script - ./start.sh http://example.com

if [ "$#" -eq 0 ]; then
    hostname='http://localhost'
else
        hostname="$1"
fi

# Specify the URL
url="$hostname:8081/"
check_application_running() {
    http_status=$(curl --write-out "%{http_code}" --silent --output /dev/null "$url")
    echo "http status + $http_status"

    if [ "$http_status" -eq 200 ]; then
            echo "Website is running (HTTP 200 OK)"
            return 0
        else
                echo "the Netflicks Demo Application has not been started correctly. (HTTP $http_status)"
                return 1
        fi
}

# Maximum number of attempts to check if the application is running
max_attempts=30
current_attempt=0
while [ $current_attempt -lt $max_attempts ]; do
    if check_application_running; then
        sleep 1
            echo "Application started successfully."
        exit 0
    else
        echo "Application not yet started. Waiting...trying again in 5 seconds"
        sleep 5
        ((current_attempt++))
    fi
done

echo "Application failed to start within the specified time. Check the logs for more information."
exit 1
