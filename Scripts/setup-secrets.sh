#!/bin/zsh

# Set the base service name and the prefix
BASE_SERVICE_NAME="WeatherAPIKey"
PREFIX="Weatherton-"
SERVICE_NAME="${PREFIX}${BASE_SERVICE_NAME}"

# Prompt the user to enter the secret value
echo "Please enter the value for '$BASE_SERVICE_NAME':"
read -s SECRET_VALUE

# Check if the user entered a value
if [ -z "$SECRET_VALUE" ]; then
    echo "No value entered. Exiting."
    exit 1
fi

# Store the value in the macOS keychain
security add-generic-password -a "$USER" -s "$SERVICE_NAME" -w "$SECRET_VALUE" -U

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Secret successfully stored in the keychain under the service name '$SERVICE_NAME'."
else
    echo "Failed to store the secret in the keychain."
    exit 1
fi
