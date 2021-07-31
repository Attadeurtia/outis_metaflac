#!/usr/bin/env bash
######################################################
# Name:             testdate.sh
# Author:           Geoffrey Posé
# Creation:         29.07.2021
# Description:      change le format de la date de metadonnée flac en format standard exemple : 24 avril 2013 -> 2013.04.24
# Documentation:    https://github.com/Attadeurtia/outis_metaflac
######################################################
IFS=$'\n'

#recherche de fichier flac de façon récursive
for FICHIER in $(find -type f -name "*.flac"); do

    #si les metadata flac sont de la forme "date=12 juin 2010"
    if metaflac --show-tag=DATE "$FICHIER" | tr "[A-Z]" "[a-z]" | grep "date=[1-9][1-9]* [a-Z]"; then

        MOIS=$(result= metaflac --show-tag=DATE $FICHIER | tr "[A-Z]" "[a-z]" | cut -d " " -f 2)
        case $MOIS in
            "janvier") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'janvier'/'january'/');;
            "fevrier") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'frevrier'/'febuary'/');;
            "février") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'frévrier'/'febuary'/');;
            "mars"|"MARS") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'mars'/'march'/');;    
            "avril") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'avril'/'april'/');;
            "mai") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'mai'/'may'/');;
            "juin") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'juin'/'june'/');;
            "juillet") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'juillet'/'july'/');;
            "aout") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'aout'/'august'/');;
            "septembre") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'septembre'/'september'/');;
            "octobre") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'octobre'/'october'/');;
            "novembre") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'novembre'/'november'/');;
            "decembre") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'decembre'/'december'/');;
            "décembre") DATE=$(result= metaflac --show-tag=DATE $FICHIER | sed 's/'décembre'/'december'/');;
            *) DATE=$(result= metaflac --show-tag=DATE $FICHIER);;
        esac
        
        DATE=$(echo $DATE | cut -d "=" -f 2)

        #si le format de la date est valide
        if DATE=$(date -d $DATE +%F); then

            echo "DATE=$DATE" > tempo.txt

            metaflac --remove-tag=DATE "$FICHIER" 

            metaflac --import-tags-from=tempo.txt "$FICHIER"

            echo "$FICHIER" >> resultat.txt
            metaflac --show-tag=DATE "$FICHIER" >> resultat.txt
            echo "----------------------" >> resultat.txt

        else

            echo "erreur $FICHIER $DATE" >> resultat.txt
            echo "----------------------" >> resultat.txt

        fi

    fi

done

echo "——————————————————————————————————————————————————————————" >> resultat.txt

rm tempo.txt