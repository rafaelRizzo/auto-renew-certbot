# Verificador e Renovador de Certificados SSL

Este script foi criado para facilitar a gestão de certificados SSL em servidores que hospedam múltiplos domínios. Ele verifica a validade dos certificados, registra logs detalhados, e, caso necessário, renova os certificados automaticamente usando o Certbot.

## Pré-requisitos
Certbot instalado no servidor, para sistemas baseados em Fedora:

`sudo apt install certbot`

Permissões adequadas para acessar e modificar os arquivos de log.

# Como funciona o script
### *1. Lista de domínios* 

O script utiliza um arquivo de texto (dominios.txt) onde você lista os domínios que deseja monitorar.

Exemplo do arquivo dominios.txt:

```
seusite.com
outrosite.com
exemplosite.com
```

### *2. Verificação e Renovação*

Para cada domínio na lista:
Verifica a validade do certificado SSL.

Se o certificado estiver próximo de expirar (≤ 7 dias), executa:
 `certbot renew --domain "dominio"`

Caso contrário, registra que o certificado ainda é válido.

### *3. Logs*

Todos os resultados (verificações e renovações) são registrados em um arquivo de log centralizado:
Caminho padrão: /var/log/ssl_check.log.
Inclui mensagens de erro caso algo dê errado, como problemas ao acessar o certificado de um domínio.
Automatização
Para garantir que o script rode automaticamente e monitore os domínios diariamente, configure uma tarefa no Cron:

### *4. Edite o Cron:*

```crontab -e```
Adicione uma entrada para rodar o script diariamente às 9h:

```0 9 * * * /caminho/para/seu/verify.sh```

Nota: Certifique-se de que o script possui permissões de execução:

```chmod +x /caminho/para/seu/verify.sh```

## Benefícios do Script

Gestão simples: Monitore múltiplos domínios de uma única vez.
Automação eficiente: Renova automaticamente certificados próximos de expirar.
Centralização de logs: Mantém um histórico detalhado das verificações e ações realizadas.
Resiliência: Identifica e registra erros caso algum domínio não esteja acessível.

### Contribuindo

Sinta-se à vontade para sugerir melhorias ou relatar problemas abrindo uma issue. Qualquer contribuição é bem-vinda!