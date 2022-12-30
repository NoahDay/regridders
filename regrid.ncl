
; Bilinear remapping of JRA55-do-1.4.0 to MOM6 0.25-degree grid used for CICE6.
; Noah Day, Nov 2022.
; Heavily inspired by https://github.com/E3SM-Project/a-prime/blob/master/ncl/esmf_regrid_ne120_CERES-EBAF_conservative_mapping.ncl
; Call sequence: ncl regrid.ncl 'field_name="huss"' 'file'

METHOD = "bilinear"
file_year  = getenv("YEAR")
field_name = getenv("VARIABLE")
directory = getenv("DIRECTORY")


wgtFileName = directory + "testWeights.nc"

;---Data file containing source grid
 ; directory = "/g/data/dy43/interp/"
  srcFilename =  directory + field_name + file_year + ".nc"
  print(srcFilename)
  sfile = addfile(srcFilename,"r")
  printVarSummary(sfile)


  srcGridName = "JRA_grid.nc"
  dstGridName = "cice_t_025.nc"

;----------------------------------------------------------------------
; Generate the weights that take you from the NCEP grid to a
; 5x5 degree grid.
;----------------------------------------------------------------------
;    Opt                      = True
;    Opt@InterpMethod         = "bilinear"     ; default
;    Opt@ForceOverwrite       = True
;    Opt@PrintTimings         = True
;
;    ESMF_regrid_gen_weights(srcGridName,dstGridName,wgtFileName,Opt)
;
;    delete(Opt)



;---Get variable to regrid
  var_name = field_name
  var_in = sfile->$var_name$ 
  vscale   = 1.
  var_in   = (/var_in*vscale/)
  src_lat  = sfile->lat
  src_lon  = sfile->lon
  ;printVarSummary(var_in)

;---Call the regridding function
  Opt = True
  Opt@Debug = False
  Opt@CopyVarCoords = True

  var_regrid = ESMF_regrid_with_weights(var_in,wgtFileName,Opt)
  ;printVarSummary(var_regrid)

;---Write regridded data
  setfileoption("nc","Format","NetCDF4Classic")
  outfile_name = directory + field_name + file_year + "_om2_025.nc"
  fout = addfile(outfile_name, "c")
  fout->$var_name$=var_regrid
