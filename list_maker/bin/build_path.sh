###################################
#### List Maker ###################
### Author: Alejandro Segura ######
### Universidad de los Andes ######
###################################

typeset -i a=0
for i in `cat config/input.in` ;
do
    path[$a]=$i
    a=$a+1
done
listpath="${path[1]}/list_maker"
samplepath="/eos/uscms/${path[3]}"

ls $samplepath > $listpath/data/list_samples.dat
typeset -i a=0
typeset -i b=0
for i in `cat $listpath/data/list_samples.dat` ;
do
    cd $samplepath/$i
    ls | wc -l > $listpath/data/number_sub.dat
    if [ `cat $listpath/data/number_sub.dat` = 1 ]; then
	one_subfolder[$a]=$i
	a=$a+1
    else
	more_subfolder[$b]=$i
	b=$b+1
    fi
done


#Filling paths with one sub-folder
echo ------------- Making paths with one sub-folder ------------------

typeset -i size=$a-1
for i in `seq 0 $size` ;
do
    ls $samplepath/${one_subfolder[$i]} > $listpath/data/subfolder_1.dat
    subfolder=`cat $listpath/data/subfolder_1.dat`
    cd $samplepath/${one_subfolder[$i]}/$subfolder
    find -name *.root > $listpath/data/root_one$i.dat
    mkdir -p $listpath/path/one_subfolder/${one_subfolder[$i]}
    cut -c 3-1000 $listpath/data/root_one$i.dat > $listpath/path/one_subfolder/${one_subfolder[$i]}/$subfolder  
    echo Processing ---- ${one_subfolder[$i]}
    echo Processing ---- ${one_subfolder[$i]} >> $listpath/log/log.txt 
done
rm $listpath/data/*

#Filling paths with more sub-folders
echo ------------- Making paths with more sub-folders ------------------

typeset -i size=$b-1
for i in `seq 0 $size` ;
do
    ls $samplepath/${more_subfolder[$i]} > $listpath/data/subfolder_2.txt
    mkdir -p $listpath/path/more_subfolder/${more_subfolder[$i]}
    typeset -i c=0
    for j in `cat $listpath/data/subfolder_2.txt` ;
    do
	subfolderplus[$c]=$j
	cd $samplepath/${more_subfolder[$i]}/${subfolderplus[$c]}
	find -name *.root > $listpath/data/root_more$c.dat
	cut -c 3-1000 $listpath/data/root_more$c.dat > $listpath/path/more_subfolder/${more_subfolder[$i]}/${subfolderplus[$c]}
        echo Processing ---- ${more_subfolder[$i]}/${subfolderplus[$c]}
        echo Processing ---- ${more_subfolder[$i]}/${subfolderplus[$c]} >> $listpath/log/log.txt
	c=$c+1
    done
done
rm $listpath/data/*





