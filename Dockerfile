# Use Ubuntu as base image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Create a virtual environment and install dependencies
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Expose FastAPI default port
EXPOSE 8000

# Run FastAPI app
CMD ["bash", "-c", ". venv/bin/activate && uvicorn main:app --host 0.0.0.0 --port 8000"]
