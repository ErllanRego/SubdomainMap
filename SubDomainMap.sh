#!/bin/bash

domain=$1

if [[ -z "$domain" ]]; then
    echo "Domínio não inserido na linha de comando!"
    echo "Digite SubDomainMap.sh nome_do_domínio"
else
    if [[ ! -e "Subdomain.txt" ]]; then
        echo "Obtendo lista de palavras-chave"
        wget https://raw.githubusercontent.com/danTaler/WordLists/master/Subdomain.txt
    fi

    total_lines_txt=$(wc -l < Subdomain.txt)

    count=1

    for subdominio in $(cat Subdomain.txt);do
        
        echo -ne "VERIFICANDO $count de $total_lines_txt\r"
        
        if host="$(host ${subdominio//[$'\t\r\n']}.pacificsec.com)"; then
            echo "Subdomain: ${subdominio//[$'\t\r\n']}.pacificsec.com" >> validSubdomainsList.txt
            echo "$host" >> validSubdomainsList.txt
            echo "------------" >> validSubdomainsList.txt
        fi
        
        count=$(expr $count + 1)

        #sleep 1
    done
fi



