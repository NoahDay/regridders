#!/usr/bin/env python
import os
import glob
import xesmf as xe
import numpy as np
import xarray as xr
from netCDF4 import Dataset


F_grd = '/g/data/dy43/cice-dirs/input/CICE_data/grid/access-om2_025/grid.nc'
F_cice_t_grd = 'cice_t_025.nc'
G_cice        = xr.open_dataset(F_grd,chunks={'ny':100,'nx':100})
G_cice = G_cice.drop(('ulat','ulon','htn','hte','angle','angleT','tarea','uarea'))
ln_tmp = G_cice.tlon.values[:,:]
lt_tmp = G_cice.tlat.values[:,:]
print(G_cice)

#G_cice['lon']                = ln_tmp
#G_cice['lat']                = lt_tmp
#G_cice['lon']                = G_cice.lon * 180/np.pi
#G_cice['lat']                = G_cice.lat * 180/np.pi

lt_tmp_deg = np.rad2deg(lt_tmp)
print(lt_tmp_deg.shape)
G_cice['lat'] = G_cice.tlat
G_cice.lat.values[:,:] = lt_tmp_deg

ln_tmp_deg = np.rad2deg(ln_tmp)
print(ln_tmp_deg.shape)
G_cice['lon'] = G_cice.tlon
G_cice.lon.values[:,:] = ln_tmp_deg

G_cice = G_cice.drop(('tlon','tlat'))
G_cice['lon'].attrs['units'] = 'degrees_east'
G_cice['lat'].attrs['units'] = 'degrees_north'
G_cice.to_netcdf(F_cice_t_grd)


filename="cice_grid_025_degrees.nc"
ds_cice_deg = Dataset(filename,'w',format='NETCDF4_CLASSIC')
nx = ds_cice_deg.createDimension('nx',1440)
ny = ds_cice_deg.createDimension('ny',1080)


lats = ds_cice_deg.createVariable('lat','f4',('ny','nx'),fill_value=0)
lons = ds_cice_deg.createVariable('lon','f4',('ny','nx'),fill_value=0)

print(ln_tmp.shape)
lons[:,:] = np.rad2deg(ln_tmp)
lats[:,:] = np.rad2deg(lt_tmp) 
lons.units = 'degrees_east'
lats.units = 'degrees_north'