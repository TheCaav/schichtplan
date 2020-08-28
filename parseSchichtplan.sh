#!/bin/bash

awk '
/.*\|.*/ && !/^#.*/ {
    gsub(/\:/, "")
    gsub(/*/, "")
    gsub(/❓/, "")
    gsub(/❔/, "")
    gsub(/\|/, "")
    print "beginTable, " $0 ",placeholder"
}
/.*>.*/ && !/^#.*/ {
    gsub(/>/, "")
    gsub(/❓/, "")
    gsub(/❔/, "")
    num = split($0, splitted, ":")
    first = ""
    for (i = 1; i < num; i++) first = first splitted[i]
    split(splitted[num], posNames, ",")
    for (ind in posNames) {
        if (posNames[ind] ~ /[A-Za-z]+/) names[ind] = posNames[ind]
    }
    print first "," splitted[num] 
}
/.*\\.*/ && !/^#.*/ {
    gsub(/-/, "")
    gsub(/❓/, "")
    gsub(/❔/, "")
    gsub(/\\/, "")
    print
}
' $1