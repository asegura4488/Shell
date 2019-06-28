ls list > list_path.dat
for x in `cat list_path.dat` ; do
rm list/$x/* -Rf
done
rm list_path.dat
