#!/bin/bash

host=""
portSequence=()
outputFile="knock_capture.pcap"

echo "[+] Capturando o tráfego para análise em $outputFile."
sudo tcpdump -i eth0 host $host -w $outputFile & tcpdump_pid=$!

for port in ${portSequence[@]}
do
				echo "[+] Realizando Port Kocking no socket $host:$port."
        hping3 -S -p $port -c 1 $host 2>/dev/null
done

sleep 5

echo "[+] Realizando curl no socket $host:${portSequence[-1]}."
curl http://$host:${portSequence[-1]}

kill $tcpdump_pid
echo "[+] Tráfego capturado em $outputFile. Analise com Wireshark ou tcpdump."
