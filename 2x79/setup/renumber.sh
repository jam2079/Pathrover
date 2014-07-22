
awk -F" " '{print $6}' aligned_membrane.pdb > tmp

data=`cat tmp`

for i in $data; do echo $(( $i + $1 )); done > tmp2

