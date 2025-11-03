#!/bin/bash

echo "=== Starting Ollama Server with Model Auto-Download ==="

# Function to download model - more robust with retries
download_model() {
    echo "Waiting for Ollama to be ready for model download..."
    # Wait up to 2 minutes for Ollama to be ready
    for i in {1..60}; do
        sleep 2
        if timeout 5 ollama list > /dev/null 2>&1; then
            echo "✓ Ollama is ready (attempt $i)!"
            
            # Check if model exists with retry
            for check_try in {1..3}; do
                MODEL_CHECK=$(timeout 10 ollama list 2>/dev/null | grep -c "llama3.2" || echo "0")
                if [ "$MODEL_CHECK" != "0" ]; then
                    echo "✓ Model llama3.2 already exists."
                    return 0
                fi
                sleep 1
            done
            
            echo "Downloading llama3.2 model (this may take 5-10 minutes)..."
            echo "⚠ Please be patient, this is a one-time download..."
            
            # Try to download with timeout and retries
            for pull_try in {1..3}; do
                echo "Download attempt $pull_try of 3..."
                if timeout 600 ollama pull llama3.2 2>&1; then
                    echo "✓ Model llama3.2 downloaded successfully!"
                    return 0
                else
                    echo "⚠ Download attempt $pull_try failed, retrying..."
                    sleep 5
                fi
            done
            
            echo "⚠ Model download failed after 3 attempts, but server continues running."
            return 1
        fi
        if [ $i -eq 60 ]; then
            echo "⚠ Ollama took longer than expected to start."
            echo "Server is running, but model download may need to be triggered manually."
        fi
    done
    return 1
}

# Start model download in background (non-blocking)
download_model &
DOWNLOAD_PID=$!

# Start Ollama server in foreground (this keeps the container running)
echo "Starting Ollama server..."
exec ollama serve

