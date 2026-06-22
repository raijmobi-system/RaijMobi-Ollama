#!/bin/sh
set -e

echo "🚀 Iniciando Ollama..."

# Inicia o servidor em background
ollama serve &
OLLAMA_PID=$!

# Função para verificar se o servidor está pronto
wait_for_ollama() {
    echo "⏳ Aguardando servidor Ollama ficar pronto..."
    for i in $(seq 1 30); do
        if ollama list > /dev/null 2>&1; then
            echo "✅ Servidor pronto."
            return 0
        fi
        sleep 2
    done
    echo "❌ Timeout esperando o servidor"
    return 1
}

# Aguarda o servidor ficar pronto
wait_for_ollama

# Verifica se o modelo já existe
if ollama list | grep -q "llama3.2:3b"; then
    echo "✅ Modelo llama3.2:3b já existe."
else
    echo "🔽 Baixando modelo llama3.2:3b..."
    if ollama pull llama3.2:3b; then
        echo "✅ Modelo baixado com sucesso!"
    else
        echo "❌ Falha no download do modelo"
    fi
fi

echo "🔄 Servidor Ollama rodando. Container permanecerá ativo."

# Mantém o container ativo esperando o processo em background
wait $OLLAMA_PID