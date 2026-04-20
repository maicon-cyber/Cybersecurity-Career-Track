Vulnerabilidade: Command Injection (OS Injection).

Payload usado: 127.0.0.1 ; cat /etc/passwd.

Impacto: Permitiu a Execução Remota de Código (RCE), vazando informações sensíveis do sistema hospedeiro.

Correção Proposta: Implementar validação rigorosa de entrada (whitelisting) garantindo que apenas formatos de IP sejam aceitos, rejeitando meta-caracteres do shell.
