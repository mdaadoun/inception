# Administration des utilisateurs

## Mise en place de règles de sécurité pour les mots de passe

Il est demandé dans le projet de mettre en place ces règles:

> 1. Votre mot de passe devra expirer tous les 30 jours.
> 2. Le nombre minimum de jours avant de pouvoir modifier un mot de passe sera configuré à 2.
> 3. L’utilisateur devra recevoir un avertissement 7 jours avant que son mot de passe n’expire.
> 4. Votre mot de passe sera de 10 caractères minimums 
> 5. Il sera composé à minima d'une majuscule et d'un chiffre, et ne devra pas comporter plus de 3 caractères identiques consécutifs.
> 6. Le mot de passe ne devra pas comporter le nom de l’utilisateur.
> 7. Bien entendu votre mot de passe root devra suivre cette politique.
> 8. La règle suivante ne s’applique pas à l’utilisateur root : le mot de passe devra comporter au moins 7 caractères qui ne sont pas présents dans l’ancien mot de passe.

Pour changer les règles d'utilisation du mot de passe, on modifie le fichier */etc/login.defs* pour ce qui est relatif à la durée de vie de celui-ci:

```shell
sudo vi /etc/login.defs
```
Les différents paramètres à modifier sont:

```shell
PASS_MAX_DAYS	30 # 30 jours maximun d'utilisation d'un mot de passe
PASS_MIN_DAYS	2  # 2 jours minimum avant de pouvoir modifier un mot de passe
PASS_WARN_AGE	7  # Envoie un message 7 jour avant l'expiration du mot de passe
```

Pour les utilisateurs déjà créé il faut appliquer les modifications manuellement avec la commande chage.

```shell
sudo chage -M 30 <root|username>
sudo chage -m 2 <root|username>
sudo chage -W 7 <root|username>
```

Pour vérifier les status des passwords pour tout les utilisateurs:

```shell
sudo cat /etc/shadow
sudo cat /etc/shadow | grep <root|username>
```
ou
```shell
sudo chage -l <root|username>
```

Pour changer la force (les qualités) d'un mot de passe, nous avons besoin d'installer la bibliothèque *libpam-pwquality*.

```shell
sudo apt install libpam-pwquality
```

Nous pouvons ensuite modifier le fichier /etc/security/pwquality.conf:

```shell
sudo vi /etc/security/pwquality.conf
```

Et modifier ces paramètres en conséquence:

```shell
difok = 7
minlen = 10
dcredit = -1
ucredit = -1
maxrepeat = 3
usercheck = 1
retry = 3
enforce_for_root
```

Notes sur pam.d:  
https://www.redhat.com/sysadmin/linux-security-pam

## Administration nom de l'hôte

Pour connaître le hostname on peut utiliser la commande:

```shell
hostnamectl status
```

De la même façon il est possible de changer le nom de l'hôte avec la même commande:

```shell
hostnamectl set-hostname <hostname>
```

ou de modifier directement le fichier /etc/hostname.

```shell
sudo vi /etc/hostname
```

## Administration utilisateur

Pour voir la liste de tout les utilisateurs:

```shell
cat /etc/passwd | cut -d ":" -f 1
```
ou pour voir seulement les utilisateurs connecté:
```shell
users
```

Pour voir les informations sur un utilisateur on utilise la commande id:

```shell
id <username>
```

Pour ajouter et/ou supprimer un utilisateur:

```shell
sudo useradd <username>
sudo userdel <username>
```

Pour modifier le nom ou d'autres paramètres on utilise usermod:

```shell
sudo usermod -l <new_username> <current_username>
```

Pour pouvoir ensuite se connecter à ce nouvel utilisateur il faut lui mettre en place un mot de passe :

```shell
sudo passwd <username>
```

## Administration groupes

Pour voir la liste de tout les groupes:

```shell
sudo cat /etc/group | cut -d ":" -f 1
```
ou
```shell
getent group | awk -F: '{print $1}'
```

Pour voir les groupes auquel appartient un utilisateur:

```shell
groups <username>
```
ou
```shell
id -nG <username>
```

Pour ajouter puis supprimer un groupe:

```shell
groupadd <groupname>
groupdel <groupname>
```

Pour ajouter un utilisateur à un groupe ou le supprimer d'un groupe:

```shell
gpasswd -a <username> <groupname>
gpasswd -d <username> <groupname>
```

Pour voir les utilisateurs lié à un groupe:

```shell
getent group <groupname>
```