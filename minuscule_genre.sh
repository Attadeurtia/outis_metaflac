#!/usr/bin/env bash
######################################################
# Name:             cherche_metadonnée.sh
# Author:           Geoffrey Posé
# Creation:         29.07.2021
# Description:      metre en minuscule les metadonnée flacs
# Documentation:    https://github.com/Attadeurtia/outis_metaflac
######################################################
IFS=$'\n'
for fichier in $(find -type f -name "*.flac" ); do

    metaflac --show-tag=GENRE "$fichier" | tr "[A-Z]" "[a-z]" | sed 's/genre/GENRE/' > tempo.txt

    metaflac --remove-tag=GENRE "$fichier" 

    metaflac --import-tags-from=tempo.txt "$fichier"

    echo "$fichier" >> resultat.txt

    metaflac --show-tag=GENRE "$fichier" >> resultat.txt

done

rm tempo.txt