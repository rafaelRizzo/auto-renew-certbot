# Verificador e Renovador de Certificados SSL

## 💡 Por que e para que?
Este projeto foi criado para simplificar e automatizar a gestão de certificados SSL em servidores que hospedam múltiplos domínios. Certificados SSL são essenciais para garantir a segurança e confiabilidade de sites, mas a renovação manual pode ser trabalhosa e propensa a erros. Com este script, você pode:

- Monitorar a validade dos certificados de forma centralizada.
- Automatizar a renovação de certificados próximos de expirar.
- Registrar logs detalhados para facilitar auditorias e resolver problemas rapidamente.
- Evitar interrupções causadas por certificados expirados.

## ⚙️ Como funciona?
### 1. Lista de domínios.
O script usa um arquivo chamado domains.txt para armazenar a lista de domínios a serem monitorados. Cada domínio deve estar em uma linha separada.

Exemplo do arquivo domains.txt:

```
example.com
mywebsite.com
anotherdomain.net
```

### 2. Verificação e Renovação
O script realiza as seguintes etapas para cada domínio listado:

Verifica a data de expiração do certificado SSL.
Caso o certificado esteja próximo de expirar (≤ 7 dias), executa o comando certbot renew para renovar o certificado.
Registra no log o status da operação, incluindo erros, se houver.
### 3. Logs
Todas as ações realizadas pelo script são registradas em um arquivo de log e inclui:

- Data e hora das verificações.
- Resultados das verificações (ex.: certificado válido, renovação necessária, erros).
- Caminho padrão do log: /var/log/ssl_check.log.

### 4. Automatização
Para garantir que o script seja executado automaticamente, configure uma tarefa Cron que o execute diariamente.

Exemplo de configuração do Cron:

```
crontab -e
```
Adicione a seguinte linha para rodar o script todos os dias às 3h:

```
0 3 * * * /caminho/para/seu/verify.sh
```
Certifique-se de que o script tem permissão de execução:

`chmod +x /caminho/para/seu/verify.sh`

## ✨ Benefícios do Script
- Praticidade: Automatiza o monitoramento e renovação de certificados.
- Segurança: Evita interrupções causadas por certificados expirados.
- Eficiência: Gera logs detalhados para fácil auditoria.
- Escalabilidade: Suporte para múltiplos domínios sem necessidade de configuração adicional.

## 🌐 Contribuindo
Caso tenha sugestões ou encontre problemas, sinta-se à vontade para abrir uma issue ou enviar um pull request. Suas contribuições são muito bem-vindas!

## 🪪 Licença
Este projeto é licenciado sob a Licença MIT - veja o arquivo LICENSE para mais detalhes.

## ☕ Donate 
Caso queira contribuir com para mim com um café, pode fazer uma doação através do PIX: `a1006c68-e9df-44e1-bfab-fa1dfe7047ce`
