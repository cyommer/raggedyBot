# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install curl
RUN apt-get update && apt-get install -y curl

# Install Ollama
RUN curl https://ollama.ai/install.sh | sh

# Set the Ollama host
ENV OLLAMA_HOST 0.0.0.0

# Expose the Streamlit port
EXPOSE 11434

# Start the Ollama Server
CMD ["ollama", "serve"]