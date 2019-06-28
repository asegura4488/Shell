ls path > list_path.dat
for x in `cat list_path.dat` ; do
rm path/$x/* -Rf
done
rm list_path.dat
