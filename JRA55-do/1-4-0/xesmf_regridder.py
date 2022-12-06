#! /usr/bin/env python3

import xesmf as xe
from netCDF4 import Dataset
import matplotlib.pyplot as plt
import argparse
import os
import numpy             as np
import xarray            as xr
import pandas as pd
import json
import pdb
import logging
import metpy.calc        as mpc
from datetime            import datetime, timedelta
from dask.diagnostics    import ProgressBar
from datetime import datetime

######################################################
######################################################
def get_jra55_cice_var():
    '''
    Make dictionary relating JRA55 NetCDF variables
    to CICE variables.
    '''
    
    # specify output variable names
    # This is for current CICE expected names
    # it might be better to change CICE in long run
    cice_var = {"prsn" : "ttlpcp",
                "rsds" : "glbrad",
                "rlds" : "dlwsfc",
                "tas"        : "airtmp",
                "uas"       : "wndewd",
                "vas"       : "wndnwd",
                "huss"       : "spchmd"}
    
    return cice_var


####################################################

# main subroutine
if __name__ == "__main__": 

    #dstr = "Interpolate JRA55 data"
    #parser = argparse.ArgumentParser(description=dstr)
    #args = parser.parse_args()
    #year = args.year
    # add arguments
    #parser.add_argument("year",    type=str, help="year to format")
    #parser.add_argument("dstgrid", type=str, help="Destination grid file (NetCDF)")
    #parser.add_argument("ncout",   type=str, help="Output file name (NetCDF)")
    # get the arguments
    #args = parser.parse_args()

    year = "2007"
    jra55_vars = {"prsn", "rsds", "rlds", "tas", "uas", "vas", "huss"}



    #for var in jra55_vars:
    
    #F_ds = "rsds2000.nc"
    #ds = xr.open_dataset(F_ds)  # use xr.tutorial.load_dataset() for xarray<v0.11.0
    # IF YOU WANT TO MAKE A JRA GRID UNCOMMENT BELOW
    #print(ds[lon].values)
    #print(ds['lon'].values)
    #temp_lon = ds['lon'].values
    #temp_lat = ds['lat'].values
    #LN,LT         = np.meshgrid(temp_lon,temp_lat)
    #ds['lon'] = (['ny','nx'],LN,{'units':'degrees_east','_FillValue':-2e8})
    #ds['lat'] = (['ny','nx'],LT,{'units':'degrees_north','_FillValue':-2e8})
    #ds        = ds.drop(('time','rsds'))
    #filename='JRA_grid_bilinear.nc'
    #write_job = ds.to_netcdf(filename,compute=False)
    #with ProgressBar():
    #    print(f"Writing to {filename}")
    #    write_job.compute()

    # JRA grid file name
    F_JRA = "JRA_grid_bilinear.nc"
    # JRA Grid
    G_JRA = xr.open_dataset(F_JRA)

    # CICE GRID
    G_CICE = xr.open_dataset("cice_grid_025_degrees.nc")
    #G_CICE.lat.data = G_CICE.lat.data*(180/np.pi)
    #print(G_CICE)


    # Make regridder
    #regridder = xe.Regridder(ds, ds_out, "bilinear")
    #dr_out = regridder(dr)
    method = "bilinear"
    periodic = True
    F_weights = "WeightsDegrees.nc" #"xesmf_weights_jra_cice.nc" # xesmf_weights.nc
    reuse_weights = True

    print("Making regridder file: ",F_weights)
    rg = xe.Regridder(G_JRA , G_CICE, 
                      method=method, 
                      periodic=periodic, 
                      filename=F_weights, 
                      reuse_weights=reuse_weights)
    #print(rg)

    #F_ds = f"{var:s}2000.nc"  

    #print(ds)
    #dr = ds[f"{var:s}"]
    

    print("prsn")
    F_ds =f"prsn{year:s}.nc" #"prsn2000.nc"
    ds = xr.open_dataset(F_ds)
    dr = ds["prsn"]
    times = ds["time"]

    data = dr.values
    #hour1 = data[1,:,:]
    #print(hour1.shape)

    prsn_out = rg(data)

    print("rsds")
    F_ds =f"rsds{year:s}.nc"
    ds = xr.open_dataset(F_ds)
    dr = ds["rsds"]
    data = dr.values
    rsds_out = rg(data)

    print("rlds")
    F_ds =f"rlds{year:s}.nc"
    ds = xr.open_dataset(F_ds)
    dr = ds["rlds"]
    data = dr.values
    rlds_out = rg(data)

    print("tas")
    F_ds =f"tas{year:s}.nc"
    ds = xr.open_dataset(F_ds)
    dr = ds["tas"]
    data = dr.values
    tas_out = rg(data)

    print("uas")
    F_ds =f"uas{year:s}.nc"
    ds = xr.open_dataset(F_ds)
    dr = ds["uas"]
    data = dr.values
    uas_out = rg(data)

    print("vas")
    F_ds =f"vas{year:s}.nc"
    ds = xr.open_dataset(F_ds)
    dr = ds["vas"]
    data = dr.values
    vas_out = rg(data)

    print("huss")
    F_ds =f"huss{year:s}.nc"
    ds = xr.open_dataset(F_ds)
    dr = ds["huss"]
    data = dr.values
    huss_out = rg(data)


    #for t in range(1): # range(data.shape[0]):
    #    data_out[t,:,:] = rg(data[t,:,:])
    #print(data_out)


    #filename=f'JRA55_03hr_forcing_2002.nc'
    filename=f"JRA55_03hr_forcing_{year:s}.nc"

    d_vars = {"airtmp" : (['time','nj','ni'],tas_out,
                                  {'long_name' :"2 metre temperature",
                                   'units'     :"Kelvin",
                                   '_FillValue':-2e8}), 
              "dlwsfc" : (['time','nj','ni'],rlds_out,
                          {'long_name':"Mean surface downward long-wave radiation flux",
                           'units'    :"W m**-2",
                           '_FillValue':-2e8}),
              "glbrad" : (['time','nj','ni'],rsds_out,
                          {'long_name':"Mean surface downward short-wave radiation flux",
                           'units'    :"W m**-2",
                           '_FillValue':-2e8}),
              "spchmd" : (['time','nj','ni'],huss_out,
                          {'long_name':"specific humidity",
                           'units'    :"kg/kg",
                           '_FillValue':-2e8}),
              "ttlpcp" : (['time','nj','ni'],huss_out,
                          {'long_name':"Mean total precipitation rate",
                           'units'    :"kg m**-2 s**-1",
                           '_FillValue':-2e8}),
              "wndewd" : (['time','nj','ni'],uas_out,
                          {'long_name':"10 metre meridional wind component",
                           'units'    :"m s**-1",
                           '_FillValue':-2e8}),
              "wndnwd" : (['time','nj','ni'],vas_out,
                          {'long_name':"10 metre zonal wind component",
                           'units'    :"m s**-1",
                           '_FillValue':-2e8}) }
    coords = {"LON"  : (["nj","ni"],G_CICE.lon.data*(180/np.pi),{'units':'degrees_east'}),
              "LAT"  : (["nj","ni"],G_CICE.lat.data*(180/np.pi),{'units':'degrees_north'}),
              "time" : (["time"],times.data)}
    attrs = {'creation_date': datetime.now().strftime('%Y-%m-%d %H'),
             'conventions'  : "CCSM data model domain description -- for CICE6 standalone 'JRA55' atmosphere option",
             'title'        : "re-gridded JRA55 for CICE6 standalone atmospheric forcing",
             'source'       : "JRA55-do 1.4.0, https://doi.org/10.1016/j.ocemod.2018.07.002, ",
             'comment'      : "source files found on gadi, /g/data/qv56/inputs",
             'author'       : 'Noah Day',
             'email'        : 'noah.day@adelaide.edu.au'}
    enc_dict  = {'shuffle':True,'zlib':True,'complevel':5} 
    JRA_OUT = xr.Dataset(data_vars=d_vars,coords=coords,attrs=attrs)
    write_job = JRA_OUT.to_netcdf(filename,unlimited_dims=['time'],compute=False,encoding={'glbrad':enc_dict})
    with ProgressBar():
        print(f"Writing to {filename}")
        write_job.compute()

    plt.pcolormesh(prsn_out[1,:,:])
    plt.savefig('prsn.png')



