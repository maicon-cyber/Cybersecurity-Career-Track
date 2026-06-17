# Relatório de Vulnerabilidade: SQL Injection (Union Based)

**Data:** 21/04/2026
**Alvo:** DVWA (Web Application)
**Severidade:** Crítica (Exposição de Credenciais)

## Descrição
Foi identificada uma falha de injeção de SQL no campo de busca de usuários. A aplicação não realiza a sanitização adequada dos inputs, permitindo a execução de comandos arbitrários no banco de dados.

## Prova de Conceito (PoC)
Utilizando o payload abaixo, foi possível extrair a tabela completa de usuários e seus respectivos hashes de senha:
`%' UNION SELECT user, password FROM users #`

## Impacto
Um atacante pode obter acesso administrativo ao sistema e comprometer todas as contas de usuários, levando à exfiltração total de dados sensíveis.

## Recomendação de Correção
Implementar **Prepared Statements** (Consultas Parametrizadas) para garantir que o input do usuário seja tratado apenas como dado, e não como parte do comando SQL.
