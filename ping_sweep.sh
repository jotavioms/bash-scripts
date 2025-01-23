#!/bin/bash
help(){
	echo "Ping Sweep - HELP"
	echo "Modo de uso: $0 REDE"
	echo "Exemplo: $0 198.168.0"
}

ping_sweep(){
	local rede=$1
	for host in {1..254};
	do
		ping -c1 $rede.$host | grep "64 bytes" | cut -d ":" -f1;
	done
}

if [ "$1" == "" ]
then
	help
else
	ping_sweep $1
fi
