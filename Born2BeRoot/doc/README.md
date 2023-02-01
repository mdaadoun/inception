# Documentation Born2BeRoot

Born2beRoot est une *introduction à la virtualisation et à l'administration système*.

L'objectif ici est de créer une machine virtuelle avec une version en mode texte de **GNU/Linux Debian**. On doit ensuite configurer quelques services et mettre en place des règles de sécurité pour les utilisateurs de ce système.

Bien que ces documents peuvent apporter quelques connaissances, il est recommandé de faire plusieurs recherches sur ces sujets et ne pas simplement se contenter de cette source seule, je crois que c'est dans le croisement de sources multiples doublé d'une mise en pratique qui permet de se confronter à ses propres erreurs, soit découvertes et expérimentations, que se trouve la plus grande valeur d'apprentissage.

**Résumé:**
1. [VM (VirtualBox) et Debian](1_DEBIAN.md)
	* Configuration VirtualBox
	* Partitions LVM
	* Gestion des packets
	* Apt et Aptitude
	* Differences avec CentOS
		* Kdump ? AppArmor et SELinux ?
		* https://www.educba.com/centos-vs-debian/
		* https://baigal.medium.com/born2beroot-e6e26dfb50ac
2. [Sudo](2_SUDO.md)
	* Installer sudo depuis root
3. [Les services SSH et UFW](3_SERVICES.md)
	* Port
4. [Administration utilisateur](4_USER.md)
	* Configuration sécurité password
	* Gestion de la machine (hostname)
	* Gestion des utilisateurs 
	* Gestion des groupes
5. [Cron et Bash](5_CRON.md)
	* Bash scripting
	* Monitoring.sh / wall
	* Le service CRON et Bash
6. [Mise en place du stack LLMP](6_LLMP.md)
	* Lighttpd
	* PHP
	* MariaDB / MySQL
		* PHPmyAdmin
		* Adminer
	* Wordpress
7. [Ajouter une service mail](7_MAIL.md)
	* Ajouter un service
		* apache, postcript, mailman ?