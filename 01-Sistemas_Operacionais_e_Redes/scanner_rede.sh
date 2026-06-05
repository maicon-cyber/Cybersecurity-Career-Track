#!/bin/bash

echo "=========================================="
echo "      SCANNER DE REDE AUTOMATIZADO"
echo "=========================================="

# Solicita ao usuário os 3 primeiros octetos da rede (ex: 192.168.1)
read -p "Digite a base da rede para mapear (Ex: 192.168.1): " REDE_BASE

echo "Iniciando varredura rápida na rede $REDE_BASE.0/24..."
echo "Isso pode levar alguns instantes. Aguarde..."
echo "------------------------------------------"

# Loop que dispara 1 ping rápido para os IPs de 1 a 254
for ip in $(seq 1 254); do
    # O comando ping envia 1 pacote (-c 1) e aguarda no máximo 1 segundo (-W 1)
    ping -c 1 -W 1 $REDE_BASE.$ip > /dev/null 2>&1
    
    # Se o retorno do ping for sucesso (0), a máquina está ligada
    if [ $? -eq 0 ]; then
        echo "[✅ ATIVO] Host respondendo: $REDE_BASE.$ip"
    fi
done

echo "------------------------------------------"
echo "Varredura finalizada com sucesso!"
echo "=========================================="
