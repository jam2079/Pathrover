#!/bin/bash
#$ -N array_bootstrap
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=4G
#$ -l os=rhel5.4

n=$4
n_down=4000
psf=$1
dcd=$2
k=$3
j=$SGE_TASK_ID

regenFile=${k}_${dcd}.regen
if [ ! -e $regenFile ]
then
	cat > $regenFile
fi

lineNum=$(wc -l < $regenFile)

if [[ $lineNum -lt $j ]] 
then
	for ((i=$lineNum; i<$(($j+1));i++))
	do
		echo "NA" >> $regenFile
	done
fi

file=
regen=
for ((i=0;i<$(($n_down/$k));i++)) 
do
	let picked="$[ $RANDOM % $(($n - $k))]"
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o ${TMPDIR}/${j}_${k}_tmp_${i}.dcd -first $(($picked + 1)) -last $(($picked + $k)) $dcd
	file[$i]="${TMPDIR}/${j}_${k}_tmp_${i}.dcd"
	regen[$i]="$picked"
done
/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o ${j}_${k}_$dcd ${file[@]}
rm ./${TMPDIR}/${j}_${k}_tmp_*
sed -i "${j}s/.*/${regen[*]}/" $regenFile
/pbtech_mounts/hwlab_store011/mil2037/carma/bin/linux/carma -cov -write -atmid ALLID ${j}_${k}_$dcd $psf
rm ${j}_${k}_$dcd
rm ${j}_${k}_$dcd.varcov.ps
