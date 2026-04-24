# Relatório de Vulnerabilidade: Command Injection (RCE)

**Data:** 24/04/2026
**Alvo:** DVWA (Command Injection)
**Severidade:** Crítica

## Descrição
A aplicação permite a execução de comandos arbitrários no sistema operacional através de um campo destinado ao comando `ping`. A falta de filtragem de caracteres especiais (como `;`, `&&`, `|`) permite o encadeamento de comandos maliciosos.

## Prova de Conceito (PoC)
Ao inserir o payload `127.0.0.1; cat /etc/passwd`, foi possível visualizar a lista de usuários do servidor, provando a execução de código remoto.

## Impacto
Um atacante pode obter controle total sobre o servidor, escalar privilégios, instalar backdoors ou sequestrar dados confidenciais do sistema.

## Recomendação de Correção
1. **Nunca** passar inputs do usuário diretamente para funções de execução de shell.
2. Utilizar APIs integradas da linguagem para tarefas específicas (ex: bibliotecas de rede nativas).
3. Implementar uma "Allow-list" que aceite apenas endereços IP válidos.
