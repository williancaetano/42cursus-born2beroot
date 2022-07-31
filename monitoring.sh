#/bin/bash

ARCHITECTURE=$(uname -a)
PROCESSORS=$(lscpu | grep "Socket(s)" | awk '{printf $2}')
VCPUS=$(grep "processor" /proc/cpuinfo | uniq | wc -l)
MEMORY_TOTAL=$(free -m | grep Mem | awk '{printf $2}')
MEMORY_USE=$(free -m | grep Mem | awk '{printf $3}')
MEMORY_PERCENT=$(free -m | grep Mem | awk '{printf "%.2f", ($3*100)/$2}')
DISK_TOTAL=$(df --total -h | grep total | awk '{printf $2}')
DISK_USE=$(df --total -h | grep total | awk '{printf $3}')
DISK_PERCENT=$(df --total -h | grep total | tr "%" " " | awk '{printf $5}')
CPU_USE=$(top -bn1 | grep '%Cpu(s)' | awk '{printf $2}')
LAST_BOOT=$(who -b | awk '{printf $3 " " $4}')
LVM=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo "no"; else echo "yes"; fi) 
TCP_CONN=$(ss -t | grep "ESTAB" | wc -l)
ACTIVE_USERS=$(who -q | tr "=" " " | awk '{printf $3}')
IPV4=$(hostname -I)
MAC=$(ip a | grep "link/ether" | awk '{printf $2}')
SUDO_COUNT=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)

echo "Architecture: ${ARCHITECTURE}"
echo "Physical CPUs: ${PROCESSORS}"
echo "Virtual CPUs: ${VCPUS}"
echo "RAM usage: ${MEMORY_USE}/${MEMORY_TOTAL}  ${MEMORY_PERCENT}%"
echo "Disk usage: ${DISK_USE}/${DISK_TOTAL} ${DISK_PERCENT}%"
echo "CPU usage: ${CPU_USE}%"
echo "Last boot: ${LAST_BOOT}"
echo "LVM in use? ${LVM}"
echo "Active connections: ${TCP_CONN}"
echo "Active Users: ${ACTIVE_USERS}"
echo "IPV4: ${IPV4} MAC: ${MAC}"
echo "Sudo commands count: ${SUDO_COUNT}"
