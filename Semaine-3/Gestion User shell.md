Démo suite cours :
* La gestion des utilisateurs

Sommaire :
1. Lister
2. Gestion des utilisateurs
3. Gestion de groupe
4. Verrouillage

# 1. Lister  

## Utilisateurs 

```
cat /etc/passwd | awk -F: '{print $1}' 
```

## Groupes : 

```
cat /etc/group | awk -F: '{print $1}' 
``` 

# 2. Gestion d'utilisateur 

## a. Commande adduser 

Création dossiers, répertoires, arborescence, … 
Création de compte automatiquement avec tous les dossiers 

```bash
sudo adduser toto1
```

> Vérifier avec `ls -la /home/toto1 `
## b. Commande useradd 

Création du **compte seul**
 
```
sudo useradd toto2
```
 
> sans option ==> utilisation des paramètres dans **/etc/default/useradd**

==> création d'une entrée dans : 

* **/etc/passwd**  ==> BDD textuelle sur les utilisateurs qui peuvent se connecter 
* **/etc/shadow** 
* **/etc/group**
* **/etc/gshadow**

==> option : 

**-m** --> home directory comme/home/toto 
Dedans on aura les fichiers de base (.bashrc, .profile, .bash_logout) qui viennent de /etc/skel/ (profil par défaut) 

**-m -d /opt/toto** ==> home directory dans un autre emplacement

```
sudo useradd -m -d /opt/toto3 toto3
```

> rien car le /home/toto3 n'est pas déplacé

Déplacer le /home :

```bash
sudo mv /opt/toto3 /bin/toto3
sudo usermod -d /bin/toto3 toto3
# Vérification
sudo ls -la /bin/toto3

```

**-u 1500 toto** ==> UID specifique 
`sudo useradd -u 1500 toto3`
verification : `id -u toto `

**-g** --> groupe ID specifique 
`sudo useradd -g users toto`
Vérification : `id -gn toto`

**-G** --> ajout multiples groupes 
`sudo useradd -g users -G admin,dev toto`
Vérification : `id toto`

**-c** --> commentaire/description (champs GECOS) 
`sudo useradd -c "utilisateur test" toto`
Vérification : `grep toto /etc/passwd`

**-e** --> date expiration 
`sudo useradd -e 2022-12-22 toto`
Vérification : `sudo chage -l toto`

**-s** --> shell specifique 
`sudo useradd -s /usr/bin/zsh toto`
Vérification : `grep toto /etc/passwd`

**-D** --> Option useradd par défaut 
Modification option par défaut : 
`sudo useradd -D -s /bin/bash`
Vérification : `sudo useradd -D | grep -i shell`

## Mot de passe 

On doit créer le mot de passe pour pouvoir se connecter : 
`sudo passwd toto`
==> modification du mot de passe d'un autre utilisateur 

## c. Ajout chaîne dans fichier passwd 

```bash
echo "user1:x:2000:2000:user1:/home/user1:/bin/bash" | sudo tee -a /etc/passwd > /dev/null
```

## Commande userdel 

Userdel --> Suppression compte seul (pas les groupes, …) 
`sudo userdel -r toto`

## Commande deluser 

Suppression complète 
`sudo deluser toto`
Pour supprimer le home directory (qui est conservé) ==> `sudo rm -r /home/utilisateur`

## Modification 

Même paramètres que useradd  :

* **-d** répertoire utilisateur 
* **-g** définit le GID principal 
* **-l** identifiant utilisateur 
* **-u** UID utilisateur 
* **-s** shell par défaut 
* **-G** ajoute l’utilisateur à des groupes secondaires 
* **-m** déplace le contenu du répertoire personnel vers le nouvel emplacement 

`usermod -d /home/toto3 -a -G toto3 toto3`

# 3. Gestion de groupe  

## Création de groupe 

`sudo groupadd nomgroupe`

## Ajout à un groupe (adduser et usermod) 

```shell
sudo adduser toto nomGroupe 
sudo usermod -a -G nomGroupetoto 

sudo gpasswd -a toto nomGroupe 
sudo gpasswd --add nom-utilisateur nom-groupe 
```

## Retrait d'un groupe 

```shell
sudo deluser toto nomGroupe 
sudo gpasswd --delete nom-utilisateur nom-groupe 
```

## Suppression d'un groupe

`sudo groupedel nomDuGroupe`

# 4. Verrouillage


`usermod --expiredate 1 nom_utilisateur`

Vérification : `sudo chage -l toto`

Réactivation ==> `usermod --expiredate "" nom_utilisateur`

 