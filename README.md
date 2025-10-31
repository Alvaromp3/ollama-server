# Ollama Server on Render

Simple Ollama server deployment for use with Streamlit Cloud and other cloud services.

## Quick Deploy to Render

1. Fork or create this repository
2. Go to [Render.com](https://render.com)
3. Create new Web Service
4. Connect this repository
5. Render will automatically detect the Dockerfile
6. Set service name (e.g., `ollama-server`)
7. Click "Create Web Service"
8. Wait for deployment (~5 minutes)
9. Copy your Render URL (e.g., `ollama-xxx.onrender.com`)

## Usage

Once deployed, use the Render URL in your Streamlit Cloud secrets:

```toml
[general]
OLLAMA_HOST = "https://ollama-xxx.onrender.com"
```

## Note

This is a basic deployment. For production use with larger models, consider:
- Upgrading to paid Render plan for more resources
- Using services with GPU support (Google Cloud Run, AWS, etc.)

