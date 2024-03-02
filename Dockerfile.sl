# Use a Python 3.8 slim image as the base image
FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy the Streamlit app script into the container
# COPY app.py /app

# Install pip dependencies
RUN pip install streamlit streamlit_chat langchain langchain-community chromadb fastembed

# Expose the Streamlit port
EXPOSE 8080

# Start the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8080", "--server.address=0.0.0.0"]
