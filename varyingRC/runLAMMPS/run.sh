#! /bin/bash
module load openmpi/3.1.1
module load python3/3.6.5


lmp=/projectnb/ryanlab/mmorey/mylammps/src/lmp_mpi


dname=VerificationCase1_SE10.0
output=/projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case0/tests/${dname}
dname1=${output}
mkdir -p ${dname1}

${lmp} -in input.lmp -var dname ${dname1}

exit
