#!/bin/bash
help(){
	echo "Network Port Scan - HELP"
	echo "Modo de uso: $0 REDE PORTA"
	echo "Exemplo: $0 198.168.0 80"
}

scan_net_ports(){
	local rede=$1
	local porta=$2

	echo "[+] Inciando varredura na REDE $rede.$host PORTA $porta..."

	for host in {1..254};
	do
		
		hping3 -S -p $porta -c1 $rede.$host 2> /dev/null | grep "flags=SA" | cut -d " " -f2 | cut -d "=" -f2;
	done
}

if [ "$1" == "" ]
then
	help
else
	scan_net_ports $1 $2
fi
