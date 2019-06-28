

funcion () {

./PhenoAnalyzer /Disco2/Pheno/monotop/monotop_$1/Events/run_01/output_delphes.root  /home/ma.segura10/DelphesAnalyzer_staus/outputsignal/signal1/signal$1.root  
echo $1 >>salida.dat
}

export -f funcion

PARAMETERS=""
for i in {1..10} ; do
PARAMETERS="$PARAMETERS ${i}"
done 


parallel -0 -I  %% --gnu --eta "funcion  %%" ::: $PARAMETERS  

