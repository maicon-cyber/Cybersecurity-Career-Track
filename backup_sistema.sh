#!/bin/bash

# Configuração de diretórios
PASTA_ORIGEM="$HOME/Downloads" 
PASTA_DESTINO="$HOME/Backup_Sistemas"
ARQUIVO_LOG="$PASTA_DESTINO/backup_status.log"
DATA_ATUAL=$(date +"%Y-%m-%d_%H-%M-%S")
NOME_BACKUP="backup_dados_$DATA_ATUAL.tar.gz"

# Cria a pasta de destino caso ela não exista
if [ ! -d "$PASTA_DESTINO" ]; then
    mkdir -p "$PASTA_DESTINO"
fi

echo "=========================================="
echo "   Iniciando Rotina de Backup de TI"
echo "=========================================="

# Verifica se a pasta de origem existe
if [ -d "$PASTA_ORIGEM" ]; then
    # Compacta a pasta de origem em formato .tar.gz (ocultando avisos comuns)
    tar -czf "$PASTA_DESTINO/$NOME_BACKUP" -C "$PASTA_ORIGEM" . 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "[✅ SUCESSO] Backup criado em: $PASTA_DESTINO/$NOME_BACKUP"
        echo "[$DATA_ATUAL] [SUCESSO] Backup realizado com sucesso. Arquivo: $NOME_BACKUP" >> "$ARQUIVO_LOG"
    else
        echo "[❌ ERRO] Falha ao compactar os arquivos."
        echo "[$DATA_ATUAL] [ERRO] Falha crítica na compactação do backup." >> "$ARQUIVO_LOG"
    fi
else
    echo "[⚠️ ALERTA] Pasta de origem '$PASTA_ORIGEM' não encontrada."
    echo "[$DATA_ATUAL] [FALHA] Diretório de origem não existe. Backup abortado." >> "$ARQUIVO_LOG"
fi
echo "=========================================="
