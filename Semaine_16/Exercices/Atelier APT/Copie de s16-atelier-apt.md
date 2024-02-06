Prérequis :
* 1 VM Linux à base de Debian
* Un accès internet

# 1. Mise à jour de paquets

## MAJ simple

Faire une MAJ de paquets avec `sudo apt update && sudo apt upgrade`
Comment éviter de répondre `Yes` derrière la commande `apt upgrade` ?

Quelque-fois tu as l'erreur `E: dpkg a été interrompu. Il est nécessaire d'utiliser « sudo dpkg --configure -a » pour corriger le problème.
Comme indiqué, exécute la commande `sudo dpkg --configure -a`.

Explications :
- `--configure` : Utilisé pour configurer un paquet qui a été déballé mais qui n'a pas été configuré. Cela peut inclure la mise en place de fichiers de configuration, l'exécution de scripts post-installation, ou d'autres tâches nécessaires pour que le paquet fonctionne correctement.
- `-a`: Signifie "all". Lorsqu'elle est utilisée avec `--configure`, elle indique à dpkg de tenter de configurer tous les paquets qui ont été déballés mais pas encore configurés.

## MAJ full

Lance la commande `sudo apt full-upgrade`
Quelle est la différence ?
Cette commande réalise toutes les MAJ trouvées dans les dépôts, y compris les MAJ de système très importantes.

## MAJ de distribution

La commande `sudo apt dist-upgrade` met à jour ta distribution.
Il faudra derrière l’exécution de cette commande faire une MAJ de paquets pour cette distribution !

# 2. Installation d'un logiciel par APT

On va installer Chromium.

Après avoir fais la mise à jour des dépôts :
```bash
sudo apt install chromium-browser
```

Et c'est tout !

Vérifie que le logiciel est bien installé. 3 méthodes :

- Regarde dans la liste des logicels !
- Utilise **apt** :
```bash
user@UbuntuLab:~$ apt list --installed | grep chromium-browser

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

chromium-browser/jammy-updates,now 1:85.0.4183.83-0ubuntu2.22.04.1 amd64  [installé]
```
- Utilise **dpkg** :
```bash
user@UbuntuLab:~$ dpkg -l | grep chromium-browser
ii  chromium-browser                           1:85.0.4183.83-0ubuntu2.22.04.1         amd64        Transitional package - chromium-browser -> chromium snap
```

Test le pour vérifier qu'il fonctionne bien en allant sur internet avec.

# 3. Désinstallation d'un logiciel par APT

Pour le désinstaller : 

```bash
sudo apt remove chromium-browser -y
```

Est-ce qu'il reste des traces ?

```bash
user@UbuntuLab:~$ dpkg -l | grep '^rc' | grep chromium-browser
rc  chromium-browser                           1:85.0.4183.83-0ubuntu2.22.04.1         amd64        Transitional package - chromium-browser -> chromium snap
```


Comment tout supprimer ?
```bash
user@UbuntuLab:~$ sudo apt-get purge chromium-browser
```

Vérifie que les traces ont bien été supprimées avec la commande précédentes.

# 4. Utilisation d'un gestionnaire de paquets avec isolation

Tu vas utilisé **snap**.

Utilise `snap version` pour savoir si tu as snap d'installé.
Si non, installe le avec apt !

Une fois fais tu dois avoir un dossier **snap** à la racine de ton **home**.

> Astuce : le paquet s'appelle **snapd**.

Installe Chromium avec `sudo snap install chromium`
Oui le paquet n'a pas le même nom car ce n'est tout simplement pas le même gestionnaire de paquets.

Désinstalle-le avec `sudo snap remove chromium`

# 5. Ajout d'une clé GPG

Cette fois-ci on va installer Chrome.

- Installer les packages requis : 
```bash
sudo apt install software-properties-common apt-transport-https wget ca-certificates gnupg2 ubuntu-keyring -y 
```
- Importer la clé GPG de Google Chrome :
```bash
sudo wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg 
```
- Importer le référentiel Google Chrome :
```bash
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list 
```

Le plus dur est fait !

Il ne reste plus qu'à installer Chrome avec `sudo apt install google-chrome-stable -y`
N'oublie pas de faire un update de la liste des paquets avant !


