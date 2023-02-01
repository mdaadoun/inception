# Bash et Cron 

## Mettre en place un script monitoring.sh

Nous avons besoin de créer un script qui affichera les informations suivantes:

> **A)** L’architecture de votre système d’exploitation ainsi que sa version de kernel.  
> **B)** Le nombre de processeurs physiques.  
> **B)** Le nombre de processeurs virtuels.  
> **C)** La mémoire vive disponible actuelle sur votre serveur ainsi que son taux d’utilisation sous forme de pourcentage.  
> **D)** L'espace disque disponible actuellement sur votre serveur ainsi que son taux d’utilisation sous forme de pourcentage.  
> **E)** Le taux d’utilisation actuel de vos processeurs sous forme de pourcentage.  
> **F)** La date et l’heure du dernier redémarrage.  
> **G)** Si LVM est actif ou pas.  
> **H)** Le nombre de connexions actives.  
> **I)** Le nombre d’utilisateurs utilisant le serveur.  
> **J)** L’adresse IPv4 de votre serveur, ainsi que son adresse MAC (Media Access Control).  
> **K)** Le nombre de commande executées avec le programme sudo.  

### A
La commande uname est utile pour afficher l'architecture du système d'exploitation et la version de son noyau linux :

```shell
uname -srvmo
```

### B
Le nombre de processeurs physiques et virtuels se trouvent dans le fichier */proc/cpuinfo*, il suffit de conter le nombre de ligne qui nous concerne :

```shell
cat /proc/cpuinfo | grep physical\ id | uniq | wc -l
cat /proc/cpuinfo | grep processor | uniq | wc -l
```

### C
Pour récupérer des informations sur l'utilisation de la mémoire, la commande free est utilisée :

```shell
free -m | grep Mem | awk '{print $2}' # total
free -m | grep Mem | awk '{print $3}' # used
echo used total | awk '{printf "%.2f", $1*100/$2}' # Pourcentage used/total
```

### D
Les informations concernant l'usage du disque se trouvent avec la commande df :

```shell
df -B g --total | grep total | awk '{print $4}' # Disponible en Gb
df -B m --total | grep total | awk '{print $3}' # Utilisé en Mb
df --total | grep total | awk '{print $5}' # Pourcentage utilisé
```

### E
Pour trouver le pourcentage d'utilisation du CPU, nous pouvons utiliser la commande [top](https://superuser.com/questions/575202/understanding-top-command-in-unix/575330#575330) et s'appuyer sur la ligne %Cpu.

```shell
top -bn1 | grep %Cpu | cut -c 9- | xargs | awk '{printf("%.1f"), $1 + $3}'
```

### F

La commande who -b permet de récupérer la dernière connexion au système (date et heure).

```shell
who -b | awk '{print $3 " " $4}'
```

### G

Pour vérifier si LVM est actif, on peut utiliser la commande lsblk.

On compte le nombre de ligne:
```shell
lignes=$(lsblk | grep "lvm" | wc -l)
```
Une simple condition if/else en bash permet ensuite de signaler ou non si LVM est actif.
```shell
if [ $lignes -eq 0 ]; then echo no; else echo yes; fi
```

## H

On trouve l'information relative aux connexions actives dans le fichier /proc/net/sockstat.

```shell
cat /proc/net/sockstat | grep TCP | awk '{print $3}'
```

## I

Pour compter le nombre d'utilisateurs connectés on peut simplement compter les mots de la commande users ou les lignes de la commande who.

```shell
users | wc -w
who | wc -l
```

## J

Trouver les adresses IPv4 et MAC se résolve avec la commande hostname et ip.

```shell
hostname -I
ip address | awk '$1 == "link/ether" {print $2}'
```

## K

Il existe plusieurs méthode possible de voir le nombres de commandes sudo utilisé, par la commande journalctl et en lisant le nombre de lignes trouvées.

```shell
journalctl _COMM=sudo | grep COMMAND | wc -l
cat /var/log/auth.log | grep COMMAND | wc -l
cat /var/log/sudo/sudo.log | grep COMMAND | wc -l
```

## Afficher le résultat dans la commande WALL et lance un script bash

Un résultat de commande peut se stocker dans une variable :
```shell
#pas d'espace sur les lignes suivantes
variable=$(command)
variable=`command`
```

Il est ensuite possible d'utiliser wall avec les variables créé pour afficher à tout les utilisateurs connecté la même information.
```shell
wall ma variable: $variable
```

Pour lancer notre script il suffit d'utiliser la commande bash :

```shell
sh monitoring.sh
```
ou bien de rendre le fichier .sh executable en changeant la permission pour l'utilisateur actuel :
```shell
chmod u+x monitoring.sh
./monitoring.sh
```

# Lancer son script avec cron

On peut commencer par vérifier que le service Cron est bien actif.

```shell
systemctl status cron
```

Pour éditer le fichier cron il faut passer par la commande crontab.

Par exemple, la règle pour avoir un lancement du script toute les 10 minutes:

```shell
*/10 * * * * /path/to/file/monitoring.sh
```

Pour desactiver ou reactiver un service il suffit d'utiliser la commande systemctl et de faire un reboot pour prendre en compte le changement.

```shell
systemctl disable cron
systemctl enable cron
```
