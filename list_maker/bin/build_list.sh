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

ent1="sed s:aaa:${path[3]}:g $listpath/config/path.in"
$ent1 > $listpath/config/path_one.in
ent2="sed s:aaa:${path[3]}:g $listpath/config/path1.in"
$ent2 > $listpath/config/path_more.in

# Filling process with one sub-folder

echo --------------------- Filling process with one sub-folder ------------------------------

ls $listpath/path/one_subfolder > $listpath/data/list_samples.dat
typeset -i a=0
for i in `cat $listpath/data/list_samples.dat` ;
do
    folder=$i
    var1="sed s:bbb:$i:g $listpath/config/path_one.in"
    $var1 > $listpath/data/path_1.in 
    subfolder=`ls $listpath/path/one_subfolder/$folder`
    var2="sed s:ccc:$subfolder:g $listpath/data/path_1.in"
    $var2 > $listpath/data/path_2.in
   
    for j in `cat $listpath/path/one_subfolder/$folder/$subfolder` ;
    do
	var3="sed s:ddd:$j:g $listpath/data/path_2.in"
	$var3 >> $listpath/list/one_subfolder/$subfolder.txt 
    done 
    cp $listpath/list/one_subfolder/$subfolder.txt $listpath/final/$subfolder.txt  
   
    echo --------- Filling $folder   
    echo --------- Filling $folder >> $listpath/log/log.txt
done
rm $listpath/data/*



# Filling process with more sub-folder

echo --------------------- Filling process with more sub-folders ------------------------------

ls $listpath/path/more_subfolder > $listpath/data/list_samples_1.dat

typeset -i a=0
for i in `cat $listpath/data/list_samples_1.dat` ;
do
    folder=$i
    mkdir -p $listpath/list/more_subfolder/$folder
    ls $listpath/path/more_subfolder/$folder > $listpath/data/list_subsamples.dat 
    for j in `cat $listpath/data/list_subsamples.dat` ;
    do
	var1="sed s:bbb:$i:g $listpath/config/path_more.in"
	$var1 > $listpath/data/path_1.in
	var2="sed s:ccc:$j:g $listpath/data/path_1.in"
	$var2 > $listpath/data/path_2.in
	subfolder=`ls $listpath/path/more_subfolder/$folder/$j`
	for k in `cat $subfolder` ;
	do
	    var3="sed s:ddd:$k:g $listpath/data/path_2.in"
	    $var3 >> $listpath/list/more_subfolder/$folder/$j.txt
	done
    cp $listpath/list/more_subfolder/$folder/$j.txt $listpath/final/$j.txt
    echo --------- Filling $folder/$j
    echo --------- Filling $folder/$j >> $listpath/log/log.txt
    done
done
rm $listpath/data/*

ls $listpath/final > sample.txt
sed s:.txt::g sample.txt > SAMPLES_LIST.txt
rm sample.txt

