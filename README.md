# regridders
Scripts and weight files for interpolation of global data using ESMF.


These scripts were used to interpolate to the 1-degree and 0.25-degree MOM5 grids used in ACCESS-OM2. Weight files must be generated using ESMF. I had troubles using a 1D source grid to generate weights when regridding to the 2D curvilinear MOM5 grid, so I recommend creating a meshgrid with the 1D lat/lon vectors first. The MOM/CICE grid should also be converted from radians to degrees for the weight file creation.



ESMF example: ESMF_RegridWeightGen -m bilinear -s JRA_grid_bilinear.nc -d cice_grid_025_degrees.nc -w WeightsDegrees.nc
