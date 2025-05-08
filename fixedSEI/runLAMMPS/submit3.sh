#! /bin/bash -l
#$ -l h_rt=120:00:00
#$ -P ryanlab
#$ -m bea
#$ -j y
#$ -N SEI_C1
#$ -o /projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case1/results/final/$JOB_NAME.o$JOB_ID
#$ -e /projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case1/final/$JOB_NAME.e$JOB_ID
#$ -pe mpi_16_tasks_per_node 32
module load openmpi/3.1.1
module load python3/3.6.5

lmp=/projectnb/ryanlab/mmorey/mylammps/src/lmp_mpi

dname1=SEI_Case1_27Feb25_20nm_RCLo_${JOB_ID}
#dname1=SEI_Case1_21Feb25_2LF2LN_${JOB_ID}
output=/projectnb/ryanlab/mmorey/LAMMPS_BATTERY_SEI/Case1/newresults/reactionrate/${dname1}
dname=${output}
mkdir -p ${dname}

mpirun -np $NSLOTS ${lmp} -in input3.lmp -var dname ${dname}

exit

