FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0

# Copia o script de entrada e dá permissão de execução
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]