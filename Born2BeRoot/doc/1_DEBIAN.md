# DEBIAN

### Pourquoi choisir Debian ?

- Debian est une des plus ancienne distribution Linux (Initié en Septembre 1993) ce qui donne une grande maturité à sa communauté.
- Debian est reconnu pour la très grande stabilité de sa version dite stable.
- Par rapport aux autres distribution Debian offre un des plus grand dépot de logiciel (les paquets).
- Debian viens avec un grand nombre d'outils pour gérer l'installation de ces paquets et des multiples dépendances qui lui sont liées.
- L'installation est minimale, ce qui le rend très simple d'utilisation pour administer les ressources d'un serveur et sa sécurité.


### La différence avec CentOS

- En utilisant SELinux, CentOS est installé avec beaucoup de fonctionalités qui, en réduisant les vulnérabilités, protègent mieux le système des attaques cybers.
- Il supporte plusieurs plate-formes de gestion comme cPanel, WebMin, Docker, etc.
- CentOS est documenté de façon à permettre une installation et une configuration du système trés efficace.

### **installation de debian**

* LVM partitions

### **installer des outils**

Certains outils seront necessaire ou simplement utile pour la suite de ce tutoriel.

Pour les installer, il faut soit passer en mode root (avec su) soit terminer la partie sudo pour pouvoir utiliser la commande apt avec un utilisateur du groupe sudo.

```shell
sudo apt update
sudo apt upgrade
sudo apt install wget git vim zsh man build-essential neofetch apt aptitude
```

### **Dernières vérifications sur DEBIAN**

Pour avoir une information finale sur le système installé il est possible d'utiliser la commande uname ou lire le fichier */etc/os-release*.

```shell
uname -a
```
ou
```shell
cat /etc/os-release
```
ou pour une version un peu plus graphique
```shell
neofetch
```

### **Une note sur apt et aptitude**

Apt et aptitude sont des gestionnaires de packets pour debian, ils s'appuient sur les mêmes bibliothèques, apt est un programme en ligne de commande seul tandis que aptitude fournit des fonctionnalités supplémentaires dans un environnement graphique (mode texte).
