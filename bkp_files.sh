#!/bin/dash
help(){
	echo "BKP Files - HELP"
	echo "Modo de uso: $0 PASTA_ORIGEM PASTA_BACKUP"
	echo "Exemplo: $0 /home/kali/Documents /home/kali/Desktop/BKP_ARQUIVOS"
}

bkp_files(){
    local origem=$1
    local destino=$2

    if [ ! -d "$destino" ]; then
        mkdir -p "$destino"
    fi

    cp -r "$origem"/* "$destino"
    echo "[+] Backup realizado com sucesso!"
}



if [ "$1" == "" || "$2" == ""]
then
	help
else
	bkp_files $1 $2
fi