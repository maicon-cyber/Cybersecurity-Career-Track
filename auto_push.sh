#!/bin/bash

echo "=========================================="
echo "🚀 INICIANDO SINCRONIZAÇÃO COM O GITHUB..."
echo "=========================================="

# Adiciona todas as modificações, pastas novas e arquivos deletados
git add .

# Cria o commit com a data e hora exatas do sistema
DATA_ATUAL=$(date +'%Y-%m-%d %H:%M:%S')
git commit -m "Organização da estrutura acadêmica e arquivos - $DATA_ATUAL"

# Envia para o repositório oficial
git push

echo "------------------------------------------"
echo "✅ Sincronização concluída com sucesso!"
echo "=========================================="
