ARCHITECTURE=`uname -srvmo`
pCPU=`cat /proc/cpuinfo | grep physical\ id | wc -l`
vCPU=`cat /proc/cpuinfo | grep processor | wc -l`
TOTAL_MEMORY=`free -m | grep Mem | awk '{print $2}'`
USED_MEMORY=`free -m | grep Mem | awk '{print $3}'`
MEMORY_PERCENT=`echo $USED_MEMORY $TOTAL_MEMORY | awk '{printf "%.2f", $1*100/$2}'`
TOTAL_DISK=`df -B g --total | grep total | awk '{print $4}'`
USED_DISK=`df -B m --total | grep total | awk '{print $3}'`
DISK_PERCENT=`df --total | grep total | awk '{print $5}'`
CPU_PERCENT=`top -bn1 | grep %Cpu | cut -c 9- | xargs | awk '{printf("%.1f"), $1 + $3}'`
LAST_BOOT=`who -b | awk '{print $3 " " $4}'`
COUNT_LVM=`lsblk | grep "lvm" | wc -l`
CHECK_LVM=`if [ $COUNT_LVM -eq 0 ]; then echo no; else echo yes; fi`
TCP_NB=`cat /proc/net/sockstat | grep TCP | awk '{print $3}'`
USERS_NB=`who | wc -l`
ADD_IP=`hostname -I`
ADD_MAC=`ip address | awk '$1 == "link/ether" {print $2}'`
SUDO_NB=`journalctl _COMM=sudo | grep COMMAND | wc -l`

#-#-#

wall "
#Architecture: $ARCHITECTURE
#CPU physical: $pCPU
#vCPU: $vCPU
#Memory Usage: $USED_MEMORY/${TOTAL_MEMORY}MB (${MEMORY_PERCENT}%)
#Disk Usage: $USED_DISK/${TOTAL_DISK} (${DISK_PERCENT})
#CPU load: ${CPU_PERCENT}% 
#Last boot: $LAST_BOOT
#LVM use: $CHECK_LVM 
#Connexions TCP : $TCP_NB ESTABLISHED
#User log: $USERS_NB 
#Network: IP $ADD_IP (${ADD_MAC})
#Sudo : $SUDO_NB cmd
"
