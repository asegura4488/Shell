#!/bin/bash

x=1.23232
y=4.565656

z=`echo "$x*$y" | bc`

echo $z

counter=10.
h=0.45

for i in `seq 0 10000`;
do
    temp=$counter
  #  echo "iterator" $i "value" $counter
    temp=`echo "ww=$temp;ww+=$h;ww" | bc`
    counter=$temp
done

echo $counter
