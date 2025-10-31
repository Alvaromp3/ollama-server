FROM ollama/ollama:latest

# Expose Ollama port
EXPOSE 11434

# Set environment variables for Render to listen on all interfaces
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_ORIGINS=*

# Start Ollama server
CMD ["ollama", "serve"]
