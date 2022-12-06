#!/bin/bash
# Method:
#       1. Read in the filenames of all the raw CAWCR files
#	2. Run interpolating python script
#PBS -N format-cawcr
#PBS -P dy43
#PBS -q normal
#PBS -l ncpus=48
#PBS -l mem=190GB
#PBS -l walltime=12:00:00
#PBS -m abe
#PBS -M noah.day@adelaide.edu.au
#PBS -l storage=gdata/hh5+gdata/dy43
#PBS -l jobfs=10GB
#PBS -l wd

module load esmf/8.0.1
module load python3/3.9.2
module use /g/data/hh5/public/modules
module load conda/analysis3
module load nco
module load netcdf


for file in gridded_ww3.glob_24m.* 
do
    ncatted -a _FillValue,dir,o,f,0.0 ${file}
    ncatted -a _FillValue,hs,o,f,0.0 ${file}
    ncatted -a _FillValue,fp,o,f,0.0 ${file}
    dir=${file} # include extra folders
    echo 'Opening:' ${dir}
    var=${file##*24m.}
    ym=${var%.*} # year month
    python interp_cawcr_ncdf_bilinear.py ${ym} grid.nc ww3_om2_025deg_${ym}.nc
    #echo 'ww3_om2_025deg_'${ym}'.nc'
    echo 'Formatted: '${dir}
    mv ww3_om2_025deg_${ym}.nc MONTHLY/
    mv ${file} formatted/
done

