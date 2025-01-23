#!/bin/bash
help(){
	echo "NC Port Scan - HELP"
	echo "Modo de uso: $0 IP"
	echo "Exemplo: $0 10.0.2.5"
}

scan_ports(){
    local ip=$1
    for port in {1..1024};
    do
        nc -zv -w1 $ip $port &> /dev/null

        if [ $? -eq 0 ]; then
            echo "[+] A porta $port esta aberta"
        fi
    done
}

if [ "$1" == "" ]
then
	help
else
	scan_ports $1
fi
