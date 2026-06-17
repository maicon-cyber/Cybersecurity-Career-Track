#!/bin/bash

echo "=========================================="
echo "🚀 INICIANDO SINCRONIZAÇÃO COM O GITHUB..."
echo "=========================================="

git add .
DATA_ATUAL=$(date +'%Y-%m-%d %H:%M:%S')
git commit -m "Organização da estrutura acadêmica e arquivos - $DATA_ATUAL"
git push

echo "------------------------------------------"
echo "✅ Sincronização concluída com sucesso!"
echo "=========================================="
