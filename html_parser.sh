#!/bin/bash

help(){
	echo 'HTML Parser - Help'
	echo 'Exemplo de uso: ./html_parser exemplo.com'
}

draw_line(){
	local colorMagenta='\033[35m'
	local colorReset='\033[0m'

	columns=$(tput cols)
	line=$(printf '=%.0s' $(seq 1 $columns))
	columnSpace=$(printf ' %.0s' $(seq 1 10))

	echo -e "\n$colorMagenta$line$colorReset\n"	
}

parse_url(){
	local host=$1
	local urlFile=$2
	local hostsFile=$3

	draw_line
	echo "[+] Resolvendo URLs em: $host"

	wget -q $host -O $urlFile || echo "Pagina nao encontrada." 
	grep href $urlFile | cut -d "/" -f3 | grep "\." | cut -d '"' -f1 | grep -v "<l" | grep -v '$(' | uniq -u | uniq -u > $hostsFile

	draw_line
    echo "[+] Concluido: Salvando os dados em $urlFile"
	draw_line
}

print_hosts(){
	local hostsFile=$1

	for url in $(cat $hostsFile);
	do
		host $url | grep "has address";
	done
}

if [ "$1" == "" ]
then
	help
else
	URL_FILE=target.html
	HOSTS_FILE=hosts.txt

	parse_url $1 $URL_FILE $HOSTS_FILE
	print_hosts $HOSTS_FILE
fi
