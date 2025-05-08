#! /bin/bash -l
#$ -l h_rt=60:00:00
#$ -P ryanlab
#$ -m bea
#$ -j y
#$ -N SEI_C0
#$ -o /projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case0/results/final/$JOB_NAME.o$JOB_ID
#$ -e /projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case0/results/final/$JOB_NAME.e$JOB_ID
#$ -pe mpi_16_tasks_per_node 32
module load openmpi/3.1.1
module load python3/3.6.5

lmp=/projectnb/ryanlab/mmorey/mylammps/src/lmp_mpi

dname1=SEI_27Feb2025_8_${JOB_ID}
output=/projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case0/newresults/${dname1}
dname=${output}
mkdir -p ${dname}

mpirun -np $NSLOTS ${lmp} -in input4.lmp -var dname ${dname}

exit

