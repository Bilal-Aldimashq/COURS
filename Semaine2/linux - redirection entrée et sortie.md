On va se servir d'un fichier **text.txt** qui contient :

```
pomme
girafe
nuage
ordinateur
montagne
téléphone
café
zèbre
astronomie
citron
```

# 1. Trier un fichier texte

## a. Tri simple
```bash
sort text.txt
```
## b. Tri avec redirection de sortie vers un fichier
```bash
sort text.txt > sorted_text.txt
```

## c. Tri avec redirection d'entrée
```bash
sort < text.txt
```
## d. Tri avec redirection d'entrée et de sortie vers un fichier
```bash
sort < text.txt > sorted_text.txt
```

# 2. Compter les mots d'un fichier

Compter avec la commande `wc` (**word count**) :
* Lignes  : `-l`
* Mots : `-w`
* Caractères : `-c`
* Longueur de la ligne la plus longue : `-L`
## a. Comptage simple
```bash
wc -w text.txt
```
## b. Comptage avec redirection de sortie vers un fichier
```bash
wc -w text.txt > counted_text.txt
```
## c. Comptage avec redirection d'entrée
```bash
wc -w < text.txt
```

> Dans ce cas, il n'y a que le nombre de mots qui apparaît, pas le nom du fichier
## d. Comptage avec redirection d'entrée et de sortie vers un fichier
```bash
wc -w < text.txt > counted_text.txt
```

# 3. Rechercher dans un fichier

## a. Recherche simple (avec grep)
```bash
grep "nuage" text.txt
```
OU
```bash
cat text.txt | grep "nuage"
```

## b. Recherche avec redirection de sortie vers un fichier (avec grep)
```bash
grep "nuage" text.txt > text_results.txt
```

## c. Recherche avec redirection d'entrée (avec grep)
```bash
grep "nuage" < text.txt
```

## d. Recherche avec redirection d'entrée et de sortie vers un fichier (avec grep)
```bash
grep "nuage" < text.txt > text_results.txt
```
