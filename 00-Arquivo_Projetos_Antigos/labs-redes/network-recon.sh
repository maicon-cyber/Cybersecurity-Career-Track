#!/bin/bash

# Cores para o terminal ficar profissional
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== SCRIPT DE RECONHECIMENTO DE REDE ===${NC}"

# 1. Pergunta qual a rede
echo "Digite a faixa de IP (ex: 192.168.0.0/24):"
read RANGE

# 2. Cria uma pasta para os logs se não existir
mkdir -p logs

# 3. Varredura rápida para descobrir quem está vivo (Ping Sweep)
echo -e "\n[+] Identificando dispositivos ativos em $RANGE..."
nmap -sn $RANGE -oG logs/vivos.txt

# 4. Filtra e mostra apenas os IPs que responderam
echo -e "[!] Dispositivos encontrados:"
grep "Up" logs/vivos.txt | cut -d " " -f 2

echo -e "\n${GREEN}[OK] O resultado detalhado foi salvo em: labs-redes/logs/vivos.txt${NC}"
