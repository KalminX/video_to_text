# Use official Python slim image for a smaller footprint
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies, including ffmpeg and build tools for whisper.cpp
RUN apt-get update && apt-get install -y \
    ffmpeg \
    g++ \
    curl \
    cmake \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone and build whisper.cpp
RUN git clone https://github.com/ggerganov/whisper.cpp.git && \
    cd whisper.cpp && \
     sh ./models/download-ggml-model.sh base.en && \
    mkdir -p build && cd build && \
    cmake .. && make -j$(nproc) && \
    cd ../..


# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code, scripts, and whisper model
COPY . .

# Ensure process_video.sh is executable
RUN chmod +x process_video.sh

# Create uploads and output directories
RUN mkdir -p uploads output

# Expose port 8000
EXPOSE 8000

# Run Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]