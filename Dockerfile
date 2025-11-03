FROM ollama/ollama:latest

# Expose Ollama port
EXPOSE 11434

# Set environment variables for Render to listen on all interfaces
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_ORIGINS=*

# Use the default Ollama serve command
# Model will be downloaded automatically by Streamlit app when first requested
CMD ["serve"]
