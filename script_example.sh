#!/bin/bash

if [ $1 = 1 ];
then
echo "este si es uno"
else
echo "no es uno"
fi

case $1 in
	1) 
	echo "este es uno usando case";;
	*) 
	echo "no es uno ni por nada del mundo";;
esac

for i in `seq  $1 $2`;
do
echo $i
done 
