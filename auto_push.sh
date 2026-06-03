#!/bin/bash

# Cores para o terminal
VERDE='\033[0;32m'
AZUL='\033[0;34m'
VERMELHO='\033[0;31m'
SEM_COR='\033[0m'

echo -e "${AZUL}[+] Verificando alterações no repositório...${SEM_COR}"

# 1. Verifica se existem mudanças (arquivos novos, modificados ou deletados)
if [[ -n $(git status -s) ]]; then
    echo -e "${AZUL}[+] Alterações detectadas. Preparando arquivos...${SEM_COR}"
    
    # Adiciona tudo ao estágio de commit
    git add .
    
    # Cria uma mensagem de commit automática com data e hora
    DATA_ATUAL=$(date "+%Y-%m-%d %H:%M:%S")
    MENSAGEM_COMMIT="Automação via Kali Linux - Upload em: $DATA_ATUAL"
    
    git commit -m "$MENSAGEM_COMMIT"
    
    # 2. Faz o push 100% automatizado usando a sua chave SSH ativa
    echo -e "${AZUL}[+] Enviando para o GitHub via SSH...${SEM_COR}"
    git push origin main
    
    # Verifica se o comando anterior (git push) deu certo
    if [ $? -eq 0 ]; then
        echo -e "${VERDE}[🎉] Sucesso total! Seus códigos já estão no GitHub.${SEM_COR}"
    else
        echo -e "${VERMELHO}[-] Erro ao enviar. Verifique sua conexão ou permissão da Chave SSH.${SEM_COR}"
    fi
else
    echo -e "${VERDE}[*] Nada novo para atualizar. O repositório já está sincronizado.${SEM_COR}"
fi
