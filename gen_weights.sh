#!/bin/bash

#PBS -N run_ncl
#PBS -P dy43
#PBS -q normal
#PBS -l ncpus=48
#PBS -l mem=190GB
#PBS -l jobfs=10GB
#PBS -l walltime=10:00:00
#PBS -l wd
#PBS -m abe
#PBS -M noah.day@adelaide.edu.au
#PBS -l storage=gdata/hh5+gdata/dy43+gdata/qv56

module load esmf/8.0.1
module load ncl
module load nco
module load netcdf


#year=2001
#var="rsds"
#export YEAR=${year}
#export VARIABLE=${var}
#export DIRECTORY="/g/data/dy43/interp/pythoninterp/"
ESMF_RegridWeightGen -t GRIDSPEC -m bilinear -s JRA_grid.nc -d cice_t_025.nc  -w testWeights.nc --netcdf4

