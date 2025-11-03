#!/bin/sh

echo "=== Starting Ollama Server with Model Auto-Download ==="

# Function to download model - simplified without timeout command
download_model() {
    echo "Waiting for Ollama to be ready for model download..."
    # Wait up to 2 minutes for Ollama to be ready
    i=0
    while [ $i -lt 60 ]; do
        sleep 2
        i=$((i + 1))
        
        # Check if ollama is ready (simple check without timeout)
        if ollama list > /dev/null 2>&1; then
            echo "✓ Ollama is ready (attempt $i)!"
            
            # Check if model exists
            MODEL_CHECK=$(ollama list 2>/dev/null | grep -c "llama3.2" || echo "0")
            if [ "$MODEL_CHECK" != "0" ]; then
                echo "✓ Model llama3.2 already exists."
                return 0
            fi
            
            echo "Downloading llama3.2 model (this may take 5-10 minutes)..."
            echo "⚠ Please be patient, this is a one-time download..."
            
            # Try to download (without timeout to avoid issues)
            if ollama pull llama3.2 2>&1; then
                echo "✓ Model llama3.2 downloaded successfully!"
                return 0
            else
                echo "⚠ Model download had issues, but server continues running."
                echo "The model may be downloaded automatically when first requested."
                return 1
            fi
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

# Start Ollama server in foreground (this keeps the container running)
echo "Starting Ollama server..."
exec ollama serve

