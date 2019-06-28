rm SAMPLES_LIST.txt 
rm log/*
sh bin/build_path.sh
./bin/erase_list.sh
rm final/*
sh bin/build_list.sh
echo ------------ Finished it --------------------
