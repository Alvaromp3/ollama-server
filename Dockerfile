FROM ollama/ollama:latest

# Expose Ollama port
EXPOSE 11434

# Set environment variables for Render to listen on all interfaces
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_ORIGINS=*

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start Ollama server and download model
# Use shell form to properly execute the script
CMD ["/bin/sh", "/start.sh"]
