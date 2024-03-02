# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install curl, python3, and pip
RUN apt-get update && apt-get install -y python3 python3-pip curl

# Install Ollama
RUN curl https://ollama.ai/install.sh | sh

# Start the Ollama Server
CMD ["ollama", "serve"]