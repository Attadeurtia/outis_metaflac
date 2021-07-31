#!/usr/bin/env bash
######################################################
# Name:             cherche_metadonnée.sh
# Author:           Geoffrey Posé
# Creation:         29.07.2021
# Description:      fais une recherche sur les meta donné flac de façon récursive
# Documentation:    https://github.com/Attadeurtia/outis_metaflac
######################################################

IFS=$'\n'
for fichier in $(find -type f -name "*.flac"); do
    if metaflac --show-tag=DATE "$fichier" | grep "[DATEdate]=[1-9]* [a-Z]"; then
        echo $fichier
        echo "______" 
    fi
done