#!/bin/sh
# this s

# if some statement exit with non 0, the process will be killed 
set -e

KEYWORD1='mobile'
KEYWORD2='name'

if [ -z $1 ]
then 
    echo "please specify the path of the file to be processed"
    exit 1
fi

before = $1
# -i:Edit files in-place, saving backups with the specified extension.
sed -i.bak '/$KEYWORD1/d;/$KEYWORD2/d' $1

exit 0
