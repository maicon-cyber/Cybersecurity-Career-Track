#!/bin/bash
echo "--- Relatorio de Sistema: m.cybertech ---"
echo "Data: $(date)"
echo "Uso de Memoria:"
free -h
echo "Conexoes de Rede Ativas:"
netstat -tunlp
