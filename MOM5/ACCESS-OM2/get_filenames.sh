#!/bin/bash

# Testing for looping over directories
counter=1
source_dir="/g/data/ik11/outputs/access-om2-025/025deg_jra55_iaf_omip2_cycle6/"
while [ $counter -le 10 ]
do 
	echo $source_dir"output"$counter"/ocean/ocean_month.nc"
	((counter++))
done

echo All done





#for dir in /g/data/ik11/outputs/access-om2-025/025deg_jra55_iaf_omip2_cycle6/output*/
#do
#  	echo "Copying over to scratch.."
#        dir=${dir%*/}      # remove the trailing "/"
#       dir="/g/data/ik11/outputs/access-om2-025/025deg_jra55_iaf_omip2_cycle6/output"${dir}"/"
#       echo "${dir##*/}" # print everything after the final /
#        echo "${dir}"
#        ocndir="/ocean/ocean_month.nc"
#       filename=${dir##*/}$".nc"
#       echo ${filename}
#        echo "filedir:"${dir}$ocndir
#        filedir=${dir}$ocndir
#       	# 1.
#       cp ${filedir} /g/data/dy43/interp/ocean
#       # 2.
#       cdo selvar,sss,sst,u,v ocean_month.nc temp_month.nc #${filedir} temp.nc
#       # 3.
#       ncrcat -d st_ocean,1 temp_month.nc ${filename}
#       #echo "${filename} formatted!"
#       # 4.
#       rm temp_month.nc
#        ((++i < 2)) || break # Try for 5 files
#done

