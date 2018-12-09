#!/bin/sh

# this script should be put in the same directory of the files that are going to be renamed
KEYWORD=2017
file=`ls | grep KEYWORD`

for f in $file
do
	new_name='echo $f | cut -d '.' --fields=1,2,3'
	mv $f $new_name
done
