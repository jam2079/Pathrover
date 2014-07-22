#!/bin/bash

cd /zenodotus/hwlab/scratch/jam2079/4it/functions

rm ../Mhp1/PRi/ANA*
rm ../Mhp1/PRiBB/ANA*
rm ../Mhp1/PRo/ANA*
rm ../Mhp1/PRoBB/ANA*
rm ../Mhp1/PRoc/ANA*
rm ../Mhp1/PRocBB/ANA*

rm ../LeuT/PRo/ANA*
rm ../LeuT/PRoBB/ANA*
rm ../LeuT/PRoc/ANA*
rm ../LeuT/PRocBB/ANA*

cp * ../Mhp1/PRi
cp * ../Mhp1/PRiBB
cp * ../Mhp1/PRo
cp * ../Mhp1/PRoBB
cp * ../Mhp1/PRoc
cp * ../Mhp1/PRocBB

cp * ../LeuT/PRo
cp * ../LeuT/PRoBB
cp * ../LeuT/PRoc
cp * ../LeuT/PRocBB
