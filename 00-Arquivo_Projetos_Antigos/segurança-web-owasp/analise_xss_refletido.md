# Relatório de Vulnerabilidade: Cross-Site Scripting (XSS) Refletido

**Data:** 22/04/2026
**Alvo:** DVWA (Vulnerabilidade: XSS Reflected)
**Severidade:** Alta

## Descrição
A aplicação reflete o input do usuário (parâmetro `name`) diretamente na página sem a devida sanitização ou codificação (encoding). Isso permite a execução de scripts maliciosos no lado do cliente (navegador).

## Prova de Conceito (PoC)
Ao inserir o payload `<script>alert('Hacked by Maicon')</script>`, o navegador executa o script e exibe um alerta, confirmando a falha.

## Impacto
Um atacante pode utilizar essa falha para realizar:
1. **Session Hijacking:** Roubo de cookies de sessão via `document.cookie`.
2. **Phishing:** Redirecionamento para sites maliciosos.
3. **Defacement:** Alteração visual do conteúdo da página para outros usuários.

## Recomendação de Correção
Implementar a **Codificação de Saída (Output Encoding)**. Todo dado vindo do usuário deve ser tratado como texto puro antes de ser renderizado no HTML (ex: converter `<` para `&lt;`).
