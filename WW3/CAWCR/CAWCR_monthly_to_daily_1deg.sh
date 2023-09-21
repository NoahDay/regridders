#!/bin/bash
# Method:
#	1. Copy the JRA55 data from respective folder to interp
#	2. Rename so the dates all match
#	3. Run interp_jra55_ncdf_bilinear
#	4. Remove the copied file
#PBS -N cawcr-daily
#PBS -P ia40
#PBS -q normal
#PBS -l ncpus=1
#PBS -l mem=190GB
#PBS -l jobfs=10GB
#PBS -l walltime=10:00:00
#PBS -l wd
#PBS -M noah.day@adelaide.edu.au
#PBS -l storage=gdata/hh5+gdata/ia40+gdata/qv56


module load cdo

#echo What year would you like to format?
#read year
year=2010
cd /g/data/ia40/cice-dirs/input/CICE_data/forcing/access-om2-10/CAWCR/${year}
filename=/g/data/ia40/cice-dirs/input/CICE_data/forcing/access-om2-10/CAWCR/${year}/ww3_om2_10deg_${year}${month}.nc

# January
month="01"
x=1
x2=24
day=1
while [ $x -le 744 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# Feburary
month="02"
x=1
x2=24
day=1
while [ $x -le 672 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# March
month="03"
x=1
x2=24
day=1
while [ $x -le 744 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# April
month="04"
x=1
x2=24
day=1
while [ $x -le 720 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# May
month="05"
x=1
x2=24
day=1
while [ $x -le 744 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# June
month="06"
x=1
x2=24
day=1
while [ $x -le 720 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# July
month="07"
x=1
x2=24
day=1
while [ $x -le 744 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# August
month="08"
x=1
x2=24
day=1
while [ $x -le 744 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# September
month="09"
x=1
x2=24
day=1
while [ $x -le 720 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# October
month="10"
x=1
x2=24
day=1
while [ $x -le 744 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# November
month="11"
x=1
x2=24
day=1
while [ $x -le 720 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done

# December
month="12"
x=1
x2=24
day=1
while [ $x -le 744 ] # 28 = 672, 29 = 696, 30 = 720, 31 = 744
do
    #echo ${x}
    #echo ${day}
    if [ $x -le 216 ] # Days 1-9
    then
        echo "Day: ${day}"
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}0${day}.nc
        echo ww3_om2_10deg_${year}${month}0${day}.nc
    elif [ $x -gt 215 ]
    then 
        echo "Day 10+: ${day}"
        echo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        cdo seltimestep,${x}/${x2} MONTHLY/ww3_om2_10deg_${year}${month}.nc ww3_om2_10deg_${year}${month}${day}.nc
        echo ww3_om2_10deg_${year}${month}${day}.nc
    fi
    x=$(( $x + 24 ))
    x2=$(( $x2 + 24 ))
    day=$(( $day + 1 ))
done



