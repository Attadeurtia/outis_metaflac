#!/usr/bin/env bash
######################################################
# Name:             changement_de_genre.sh
# Author:           Geoffrey Posé
# Creation:         29.07.2021
# Description:      changer un genre sur tout les fichers le possedant
# Documentation:    https://github.com/Attadeurtia/outis_metaflac
######################################################
echo "écrire la valeurs a changer :"
read old
echo "écrire la nouvelle valeurs"
read new

echo "$old --> $new" >> resultat.txt

IFS=$'\n'
for fichier in $(find -type f -name "*.flac"); do

    if metaflac --show-tag=GENRE "$fichier" | grep $old > tempo.txt; then

        metaflac --show-tag=GENRE  "$fichier" | sed 's/'$old'/'$new'/' > tempo.txt

        metaflac --remove-tag=GENRE "$fichier" 

        metaflac --import-tags-from=tempo.txt "$fichier"

        echo "$fichier" >> resultat.txt

        metaflac --show-tag=GENRE "$fichier" >> resultat.txt

    fi

done

echo "——————————————————————————————————————————————————————————" >> resultat.txt

rm tempo.txt

