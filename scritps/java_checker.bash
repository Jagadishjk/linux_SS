#!/usr/bin/env bash

# Check if the script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi
#Function to check weather java 17 is installed
check_java_17_installed() {
  if type -p java; then
    version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ "$version" == "17"* ]]; then
      return 0
    fi
  fi
  return 1
}
#Function to install java 17
install_java_17() {
  sudo dnf install -y java-17-openjdk
}
#check weather java 17 is installed
if check_java_17_installed; then
  echo "Java 17 is already installed."
else
  echo "Java 17 is not installed. Installing Java 17..."
  install_java_17
fi
#verifying installation
if check_java_17_installed; then
  echo "Java 17 installation successful."
else
  echo "Java 17 installation failed. Please install Java 17 manually."
fi
