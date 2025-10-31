FROM ollama/ollama:latest

# Expose Ollama port
EXPOSE 11434

# Set environment variables for Render to listen on all interfaces
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_ORIGINS=*

# The ollama/ollama image has its own entrypoint
# We just need to make sure it runs serve command
# Use exec form to properly pass the command
CMD ["serve"]
