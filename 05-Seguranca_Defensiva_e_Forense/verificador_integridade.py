import os
import hashlib
import json
import sys

# Arquivo onde vamos salvar o registro dos hashes para comparação posterior
DB_HASHES = "registro_hashes.json"

def calcular_sha256(caminho_arquivo):
    """Calcula o hash SHA-256 de um arquivo de forma eficiente."""
    sha256_hash = hashlib.sha256()
    try:
        with open(caminho_arquivo, "rb") as f:
            # Lê o arquivo em pedaços para não travar a memória RAM de 8GB
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()
    except (PermissionError, FileNotFoundError):
        return None

def gerar_linha_base(diretorio):
    """Mapeia o diretório e salva o hash de todos os arquivos."""
    print(f"[+] Criando linha de base para o diretório: {diretorio}")
    dados_hashes = {}
    
    for raiz, _, arquivos in os.walk(diretorio):
        for arquivo in arquivos:
            caminho_completo = os.path.join(raiz, arquivo)
            hash_resultado = calcular_sha256(caminho_completo)
            if hash_resultado:
                dados_hashes[caminho_completo] = hash_resultado

    with open(DB_HASHES, "w") as f:
        json.dump(dados_hashes, f, indent=4)
    print(f"[🎉] Registro salvo com sucesso em '{DB_HASHES}'. Integrity Baseline criada!")

def verificar_integridade():
    """Compara os hashes atuais com o registro salvo para detectar alterações (Forense)."""
    if not os.path.exists(DB_HASHES):
        print("[-] Erro: Arquivo de registro de hashes não encontrado. Crie a linha de base primeiro.")
        sys.exit(1)

    print("[+] Iniciando verificação de integridade dos arquivos...")
    with open(DB_HASHES, "r") as f:
        dados_antigos = json.load(f)

    arquivos_alterados = 0
    arquivos_deletados = 0

    # Verifica se os arquivos antigos mudaram ou foram apagados
    for caminho_completo, hash_antigo in dados_antigos.items():
        if not os.path.exists(caminho_completo):
            print(f"[🚨] ALERTA FORENSE: Arquivo DELETADO ou movido -> {caminho_completo}")
            arquivos_deletados += 1
            continue

        hash_atual = calcular_sha256(caminho_completo)
        if hash_atual != hash_antigo:
            print(f"[🔥] ALERTA DE VIOLAÇÃO: Arquivo MODIFICADO -> {caminho_completo}")
            arquivos_alterados += 1

    if arquivos_alterados == 0 and arquivos_deletados == 0:
        print("[🛡️] Tudo limpo! Nenhum arquivo foi alterado ou violado.")
    else:
        print(f"\n[!] Resumo: {arquivos_alterados} modificados, {arquivos_deletados} deletados.")

def main():
    print("-" * 50)
    print(" Monitor de Integridade de Arquivos (SHA-256) ")
    print("-" * 50)
    print("1. Criar nova Linha de Base (Registrar pasta)")
    print("2. Verificar Integridade (Checar alterações)")
    
    opcao = input("\nEscolha uma opção (1 ou 2): ")
    
    if opcao == "1":
        pasta = input("Digite o caminho completo da pasta para monitorar (ex: ./ ): ")
        gerar_linha_base(pasta)
    elif opcao == "2":
        verificar_integridade()
    else:
        print("[-] Opção inválida.")

if __name__ == "__main__":
    main()
