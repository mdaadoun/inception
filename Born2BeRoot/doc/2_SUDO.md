# SUDO

## **Quelques points sur l'identité de l'utilisateur**

Pour savoir sur quel compte on est actuellement connecté (le prompt du shell ne montre pas toujours toutes les informations) il est possible d'utiliser des commandes comme whoami, hostname ou d'afficher directement des variables d'environnements avec echo.

```shell
whoami #echo USER
hostname #echo $HOST
echo $SHELL $HOME $PWD
```

## **Installation de sudo**

Après l'installation de Debian et une fois connecté comme utilisateur, il est necessaire d'avoir accés à la commande sudo pour pouvoir réaliser ponctuellement des opérations de type root sans pour autant etre root à tout moment.

Pour pouvoir installer sudo il faut passer en mode root:
```shell
su -
```

Puis installer le programme sudo avec apt :
```shell
apt install sudo
```

## **Vérifier que l'installation s'est bien déroulée**

Il est possible d'avoir confirmation de l'installation en plus de quelques informations supplémentaires en utilisant apt ou dpkg.

avec dpkg:
```shell
dpkg -l | grep sudo
```

ou avec apt:
```shell
apt list --installed | grep sudo
```

## **Lister ou trouver un utilisateur**

Si l'on ne connais pas le nom de l'utilisateur, on peut les lister en lisant le fichier */etc/passwd*, ou avoir l'information sur un seul utilisateur avec la commande grep.

```shell
cat /etc/passwd
cat /etc/passwd | grep <username>
```
ou
```shell
getent passwd
getent passwd <username>
```

## **Ajouter un utilisateur au groupe sudo**

Pour donner à un utilisateur le droit d'utiliser sudo, il faut l'ajouter au groupe sudo avec la commande adduser ou usermod. (Il faudra utiliser sudo ou être connecté en root.)

```shell
adduser <username> sudo
```
ou
```shell
usermod -aG sudo <username>
```

Pour vérifier si un utilisateur fait bien parti d'un groupe on utilise la commande groups ou id
```shell
groups <username>
```
ou
```shell
id -nG <username>
```

Dans l'autre sens, pour vérifier qui est rattaché à un groupe on utilise la commande getent group <groupname>
```shell
getent group sudo
```

## **Configurer Sudo**

Nous commençons par créer un dossier qui recevra les logs de sudo.

```shell
mkdir /var/log/sudo
```

Nous pouvons ensuite modifier le fichier */etc/sudoers* avec la commande visudo pour y ajouter la règle qui donne tout les privilèges de la commande sudo aux utilisateurs faisant parti du groupe sudo.

```shell
sudo visudo
```

On ajoute la ligne si elle ne s'y trouve pas déjà :

```shell  
%sudo	ALL=(ALL) ALL
```

Pour finir on configure les règles d'utilisation de sudo dans ce même fichier en y ajoutant les règles demandées.

```shell
Defaults        passwd_tries=3
Defaults        badpass_message="<custom-error-message>"
Defaults        logfile="/var/log/sudo/<filename>"
Defaults        log_input
Defaults        log_output
Defaults        iolog_dir="/var/log/sudo"
Defaults        requiretty
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
```

Note: il est recommandé de ne pas modifier directement le fichier */etc/sudoers* mais de créer un fichier dans le dossier */etc/sudoers.d* avec les mêmes configurations.

```shell
sudo vi /etc/sudoers.d/<filename>
```
