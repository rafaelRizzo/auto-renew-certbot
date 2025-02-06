#!/bin/bash

# Configurações
DOMAINS_FILE="/caminho/ate/a/pasta/auto-renew-certbot/dominios.txt"  # Caminho para o arquivo com os domínios
ALERT_DAYS=7                              # Dias para alerta antes do vencimento
LOG_FILE="/var/log/auto-renew-certbot/ssl_check.log"      # Arquivo de log

# Verifique se o arquivo de domínios existe
if [ ! -f "$DOMAINS_FILE" ]; then
    echo "$(date): Arquivo de domínios $DOMAINS_FILE não encontrado." | tee -a "$LOG_FILE"
    exit 1
fi

# Leia os domínios do arquivo e verifique cada um
while IFS= read -r DOMAIN; do
    # Remover espaços extras e ignorar linhas vazias/comentários
    DOMAIN=$(echo "$DOMAIN" | sed 's/#.*//' | xargs)
    [[ -z "$DOMAIN" ]] && continue

    # Obtenha a data de validade do certificado SSL
    EXPIRATION_DATE=$(echo | timeout 5 openssl s_client -servername "$DOMAIN" -connect "$DOMAIN:443" 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)

    # Verifique se a data foi capturada corretamente
    if [ -z "$EXPIRATION_DATE" ]; then
        echo "$(date): Não foi possível obter a data de validade do certificado para $DOMAIN." | tee -a "$LOG_FILE"
        continue
    fi

    # Converta a data de validade para timestamp
    EXPIRATION_TIMESTAMP=$(date -d "$EXPIRATION_DATE" +%s 2>/dev/null || date -j -f "%b %d %H:%M:%S %Y %Z" "$EXPIRATION_DATE" +%s 2>/dev/null)

    # Obtenha a data atual em timestamp
    CURRENT_TIMESTAMP=$(date +%s)

    # Calcule a diferença em dias
    DAYS_LEFT=$(( (EXPIRATION_TIMESTAMP - CURRENT_TIMESTAMP) / 86400 ))

    # Verifique se o certificado está próximo de expirar
    if [ "$DAYS_LEFT" -le "$ALERT_DAYS" ]; then
        echo "$(date): O certificado SSL para $DOMAIN expira em $DAYS_LEFT dias. Executando 'certbot renew'." | tee -a "$LOG_FILE"
        certbot renew --force-renewal --cert-name "$DOMAIN" >> "$LOG_FILE" 2>&1
    else
        echo "$(date): O certificado SSL para $DOMAIN está válido por mais $DAYS_LEFT dias." | tee -a "$LOG_FILE"
    fi

done < "$DOMAINS_FILE"
