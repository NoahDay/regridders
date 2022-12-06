#!/bin/bash
# Method:
#	1. Copy the ocean data file from ik11 to scratch
#	2. Extract variables; sss,sst,u,v
#	3. Extract layer 1 of u and v
#	4. Remove the copied file
#PBS -N regrid-ocean
#PBS -P dy43
#PBS -q normal
#PBS -l ncpus=24
#PBS -l mem=100GB
#PBS -l walltime=3:00:00
#PBS -l wd
#PBS -m abe
#PBS -M noah.day@adelaide.edu.au
#PBS -l storage=gdata/hh5+gdata/dy43+gdata/qv56



module load esmf/8.0.1
module load python3/3.9.2
module use /g/data/hh5/public/modules
module load conda/analysis3
module load nco
module load netcdf
module load cdo

counter=347
year=2000
source_dir="/g/data/ik11/outputs/access-om2-025/025deg_jra55_iaf_omip2_cycle6/"
while [ $counter -le 365 ]
do
	#year = 1958 + counter - 305
   	filename=$source_dir"output"$counter"/ocean/ocean_month.nc"
        echo "Formatting "$filename
#	echo ${year}
#	echo "output"$year".nc"
	cp ${filename} /g/data/dy43/interp/ocean
	cdo selvar,sss,sst,u,v ocean_month.nc temp.nc
	ncrcat -d st_ocean,1 temp.nc output$year.nc
	rm temp.nc	
	echo output$year.nc done
	((counter++))
	((year++))
done

echo All done





# Testing for looping over directories
#i=1
#for dir in /g/data/ik11/outputs/access-om2-025/025deg_jra55_iaf_omip2_cycle6/output*/
#do
#	echo "Copying over to scratch.."
#	dir=${dir%*/}      # remove the trailing "/"
#	dir="/g/data/ik11/outputs/access-om2-025/025deg_jra55_iaf_omip2_cycle6/output"${dir}"/"
#	echo "${dir##*/}" # print everything after the final /
#	echo "${dir}"
#	ocndir="/ocean/ocean_month.nc"
#	filename=${dir##*/}$".nc"
#	echo ${filename}
#	echo "filedir:"${dir}$ocndir
#	filedir=${dir}$ocndir
#	# 1.
#	cp ${filedir} /g/data/dy43/interp/ocean
#	# 2.
#	cdo selvar,sss,sst,u,v ocean_month.nc temp_month.nc #${filedir} temp.nc
#	# 3.
#	ncrcat -d st_ocean,1 temp_month.nc ${filename}
#	#echo "${filename} formatted!"
#	# 4.
#	rm temp_month.nc
#	((++i < 2)) || break # Try for 5 files
#done

# 1.
#echo "Copying data over to scratch.."
#cp /g/data/ik11/outputs/access-om2/1deg_jra55_iaf_omip2_cycle6/output365/ocean/ocean_month.nc /scratch/df0/nd0349
#echo "Copying complete."

# 2.
#echo "Extracting sss,sst,u,v"
#cdo selvar,sss,sst,u,v ocean_month.nc temp.nc

# 3.
#echo "Taking over the surface layer"
#ncrcat -d st_ocean,1 temp.nc ${filename}
#echo "Formatting complete!"

# 4.
#rm temp.nc

