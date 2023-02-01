# les services SSH et UFW

## **Généralités sur les services**

Pour lister les services, il existe plusieurs méthodes:

```shell
sudo service --status-all
```
ou
```shell
systemctl list-units --type=service
```

## **Installer et configurer SSH**

On installe ssh avec la commande:
```shell
sudo apt install openssh-server
```

Vérification de l'installation:
```shell
dpkg -l | grep ssh
```

Vérification du status de ssh:
```shell
sudo systemctl status ssh
```

Pour configurer le port ssh il faut modifier le fichier */etc/ssh/sshd_config* :

* changer la ligne **#Port 22** par **Port 4242**.
* mettre le **PermitRootLogin** à **no**
```shell
sudo vi /etc/ssh/sshd_config
```

La modification faite, on peut vérifier les lignes qui nous concernent :
```shell
sudo grep 'Port \|RootLogin' /etc/ssh/sshd_config
```

Il faut ensuite relancer le service ssh pour prendre en compte les modifications :

```shell
sudo service ssh restart
```
ou
```shell
sudo systemctl restart ssh
```

## **installer et configurer UFW**

Vérification du status de ufw:

```shell
sudo systemctl status ufw
```

D'une manière générale on utilise la commande status pour observer l'état des différents port ouvert.

```shell
sudo ufw status
```

Pour créer et ouvrir un port il faut utiliser la commande allow de ufw.

```shell
sudo ufw allow <port> #ex: <port> = 4242
```

Pour fermer un port sans le supprimer on utilise la commande deny de ufw.

```shell
sudo ufw deny <port>
```

Pour supprimer complètement un port il faut utiliser la commande delete de ufw en y mettant le port et son status.

```shell
ufw delete allow <port>
```

##  **Se connecter avec SSH à la VM**

Pour permettre la connexion depuis l'extérieur de VirtualBox il faut modifier les options :

```shell
VirtuaBox : Settings -> Network -> Adapter 1 -> Advanced -> Port Forwarding
Hostport = 24242
Gestport = 4242
```

Depuit un autre terminal on se connect à la VM avec la commande ssh :

```shell
ssh <login>@<host> -p <port> #ex: hostport de la VM: 24242
```

Note: Normalement, si on a bien configuré */etc/ssh/sshd_config* avec PermitRootLogin à no, il ne devrait pas être possible de se connecter depuis root.

## **Une note sur AppArmor et SELinux**

```shell
# aptitude search apparmor
# aptitude install apparmor
# aa-status 
# systemctl enable apparmor
# systemctl status apparmor
```