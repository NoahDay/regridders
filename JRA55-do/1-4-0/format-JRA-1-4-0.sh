#!/bin/bash
# Method:
#   1. Copy the JRA55 data from respective folder to interp
#   2. Rename so the dates all match
#   3. Run interp_jra55_ncdf_bilinear
#   4. Remove the copied file
#PBS -N regrid-JRA55-1.4.0
#PBS -P ia40
#PBS -q hugemembw
#PBS -l ncpus=56
#PBS -l mem=512GB
#PBS -l jobfs=10GB
#PBS -l walltime=10:00:00
#PBS -l wd
#PBS -M noah.day@adelaide.edu.au
#PBS -l storage=gdata/hh5+gdata/dy43+gdata/qv56+gdata/ik11+gdata/ia40


module load esmf/8.0.1
module load python3/3.9.2
module use /g/data/hh5/public/modules
module load conda/analysis3
module load nco
module load netcdf

#echo What year would you like to format?
#read year
year=2000
declare -a fileJRA=("/g/data/qv56/replicas/input4MIPs/CMIP6/OMIP/MRI/MRI-JRA55-do-1-4-0/atmos/3hr/prsn" "/g/data/qv56/replicas/input4MIPs/CMIP6/OMIP/MRI/MRI-JRA55-do-1-4-0/atmos/3hr/rsds" "/g/data/qv56/replicas/input4MIPs/CMIP6/OMIP/MRI/MRI-JRA55-do-1-4-0/atmos/3hr/rlds" "/g/data/qv56/replicas/input4MIPs/CMIP6/OMIP/MRI/MRI-JRA55-do-1-4-0/atmos/3hrPt/tas" "/g/data/qv56/replicas/input4MIPs/CMIP6/OMIP/MRI/MRI-JRA55-do-1-4-0/atmos/3hrPt/uas" "/g/data/qv56/replicas/input4MIPs/CMIP6/OMIP/MRI/MRI-JRA55-do-1-4-0/atmos/3hrPt/vas" "/g/data/qv56/replicas/input4MIPs/CMIP6/OMIP/MRI/MRI-JRA55-do-1-4-0/atmos/3hrPt/huss")
filenameWork=()
for dir1 in ${fileJRA[@]}
do
    dir=${dir1}/gr/v20190429/ # include extra folders
    var=${dir1##*/}
    filename=()
    # Store the filename
    # For prsn, rsds, rlds
    while IFS=  read -r -d $'\0'; do
        filename+=("$REPLY")
    done < <(find ${dir} -name "*${year}01010130*" -print0)
    # For tas, uas, vas, huss
    while IFS=  read -r -d $'\0'; do
        filename+=("$REPLY")
    done < <(find ${dir} -name "*${year}01010000*" -print0)

    # 1.
    echo " "
    echo "Copying over ${filename##*/} to interp work directory"
#    echo "Do you want to move over the files?"
#    read decision
#    if ["decision"="yes"]; then


        cp ${filename} /home/566/nd0349/regridders/JRA55-do/1-4-0/ #  # /home/566/nd0349
#       # 2.
     #   cd /scratch/ia40/nd0349/interpolation
        echo "Renaming... ${var} in ${filename##*/}"
        mv ${filename##*/} ${var}${year}.nc # Rename file in interp

#    fi
#    filenameWork+=("${var}${year}.nc")
   # 2.b) Change fill values
    #ncatted -a _FillValue,,m,f,0.0 ${var}${year}.nc
    #ncatted -a missing_value,,m,f,0.0 ${var}${year}.nc
done # Filenames
#done # Year


# 3.
#python3 interp_jra55_ncdf_bilinear.py ${year} cice_t_025.nc JRA55_om2_025deg_03hr_forcing_${year}.nc

python3 xesmf_regridder.py ${year}


# 4.
#echo Are you ready to delete the files?
#read decision
#if ["decision"="yes"]; then
for dir1 in ${filenameWork[@]}
do
    var=${dir1##*/}
    echo "Removing ${var}"
    rm ${var}${year}.nc
done
#fi



# =============================================================================================
# ========================================= EXTRA CODE ========================================
# =============================================================================================

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
    # dir=${dir%*/}      # remove the trailing "/"
   
    #echo "${dir##*/}" # print everytjhing after the final /
    #echo "${dir}"