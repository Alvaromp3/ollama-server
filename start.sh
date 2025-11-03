#!/bin/bash

echo "=== Starting Ollama Server with Model Auto-Download ==="

# Function to download model in background
download_model() {
    echo "Waiting for Ollama to be ready for model download..."
    # Wait up to 60 seconds for Ollama to be ready
    for i in {1..30}; do
        sleep 2
        if ollama list > /dev/null 2>&1; then
            echo "✓ Ollama is ready!"
            
            # Check if model exists
            MODEL_CHECK=$(ollama list 2>/dev/null | grep -c "llama3.2" || echo "0")
            
            if [ "$MODEL_CHECK" = "0" ]; then
                echo "Downloading llama3.2 model (this may take 5-10 minutes)..."
                echo "⚠ Please be patient, this is a one-time download..."
                if ollama pull llama3.2 2>&1; then
                    echo "✓ Model llama3.2 downloaded successfully!"
                else
                    echo "⚠ Model download had issues, but server continues running."
                fi
            else
                echo "✓ Model llama3.2 already exists."
            fi
            break
        fi
        if [ $i -eq 30 ]; then
            echo "⚠ Ollama took longer to start, but server is running."
            echo "Model download will be skipped. The model may need to be downloaded manually."
        fi
    done
}

# Start model download in background (non-blocking)
download_model &

# Start Ollama server in foreground (this keeps the container running)
echo "Starting Ollama server..."
exec ollama serve

