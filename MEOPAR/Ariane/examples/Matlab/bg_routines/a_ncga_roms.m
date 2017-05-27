%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read global attributes which correspond to namelist parameters
% in the Ariane NetCDF outputs for ROMS model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dimensions
xi_rho          = nc.xi_rho(:);
eta_rho         = nc.eta_rho(:);
s_w             = nc.s_w(:);
time            = nc.time(:);

if strcmp(mode,'qualitative')
  if strcmp(key_region,'.FALSE.')
    imt_reg_start     = 1;
    imt_reg_end       = xi_rho-1;
    imt_reg           = imt_reg_end-imt_reg_start+1;
    jmt_reg_start     = 1;
    jmt_reg_end       = eta_rho-1;
    jmt_reg           = jmt_reg_end-jmt_reg_start+1;
    kmt_reg_start     = 1;
    kmt_reg_end       = s_w;
    kmt_reg           = kmt_reg_end-kmt_reg_start+1;
  end
else
  if strcmp(key_reducmem,'.FALSE.')
    imt_reg_start     = 1;
    imt_reg_end       = xi_rho-1;
    imt_reg           = imt_reg_end-imt_reg_start+1;
    jmt_reg_start     = 1;
    jmt_reg_end       = eta_rho-1;
    jmt_reg           = jmt_reg_end-jmt_reg_start+1;
    kmt_reg_start     = 1;
    kmt_reg_end       = s_w;
    kmt_reg           = kmt_reg_end-kmt_reg_start+1;
  end
end

% ZETA file(s)
c_dir_ze       = nc.c_dir_ze(:);
c_prefix_ze    = nc.c_prefix_ze(:);
ind0_ze        = nc.ind0_ze(:);
indn_ze        = nc.indn_ze(:);
maxsize_ze     = nc.maxsize_ze(:);
c_suffix_ze    = nc.c_suffix_ze(:);
nc_var_ze      = nc.nc_var_ze(:);
nc_att_mask_ze = nc.nc_att_mask_ze(:);

% ROMS global attributes
dir_glbatt     = nc.dir_glbatt(:);
fn_glbatt      = nc.fn_glbatt(:);
nc_glbatt_hc   = nc.nc_glbatt_hc(:);
nc_glbatt_sc_w = nc.nc_glbatt_sc_w(:);
nc_glbatt_Cs_w = nc.nc_glbatt_Cs_w(:);

% ROMS grid file and variable names
dir_grd_roms         = nc.dir_grd_roms(:);
if strcmp( dir_grd_roms(size(dir_grd_roms,2)-1:size(dir_grd_roms,2)),'\0')
  dir_grd_roms = dir_grd_roms(1:size(dir_grd_roms,2)-2);
end
fn_grd_roms          = nc.fn_grd_roms(:);
nc_var_lon_rho_roms  = nc.nc_var_lon_rho_roms(:);
nc_var_lon_u_roms    = nc.nc_var_lon_u_roms(:);
nc_var_lat_rho_roms  = nc.nc_var_lat_rho_roms(:);
nc_var_lat_v_roms    = nc.nc_var_lat_v_roms(:);
nc_var_pm_roms       = nc.nc_var_pm_roms(:);
nc_var_pn_roms       = nc.nc_var_pn_roms(:);
nc_var_h_roms        = nc.nc_var_h_roms(:);
nc_var_mask_rho_roms = nc.nc_var_mask_rho_roms(:);
