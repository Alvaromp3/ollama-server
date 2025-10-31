FROM ollama/ollama:latest

# Expose Ollama port
EXPOSE 11434

# Ollama will start automatically
CMD ["ollama", "serve"]
