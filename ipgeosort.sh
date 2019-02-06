#!/bin/bash
TIME=$( date +%Y%m%d-%T )

        if [[ -z $1 ]] || [ $1 = "h" ] || [ $1 = "-h" ] || [ $1 = "help" ] || [ $1 = "--help" ]
        then
                echo
                echo "This app uses geoiplookup to find the country of origin"
                echo "of a single or list of IP addresses in a file separated by line."
                echo "It then outputs the results sorted by alphabetical order (according"
                echo "to its 2-character country-code) to a file named geo<date-time>.txt" 
                echo "or one of your choosing specified after the IP list"
                echo
                echo "Syntax is ipgeosort.sh <list filename> <output filename>"
                echo
                exit
        fi
        if [[ -z $2 ]]
        then
        FILENAME=( geo"$TIME".txt )
        else
        FILENAME=$2
        fi

                cat $1 | while read line
        do
                VAR=$( echo `geoiplookup $line | awk -F': '  '{print $2}'` )
                echo $VAR\: $line >> ./"$FILENAME"
        done
                sort -o "$FILENAME" ./"$FILENAME"
exit
