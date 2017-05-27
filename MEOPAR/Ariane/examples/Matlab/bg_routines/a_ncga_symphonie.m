%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read global attributes which correspond to namelist parameters
% in the Ariane NetCDF outputs for Symphonie model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath(fullfile(pwd,'bg_routines')));

% Dimensions
x_dim            = nc.x_dim(:);
y_dim            = nc.y_dim(:);
z_dim            = nc.z_dim(:);
time             = nc.time(:);

if strcmp(mode,'qualitative')
  if strcmp(key_region,'.FALSE.')
    imt_reg_start     = 1;
    imt_reg_end       = x_dim;
    imt_reg           = x_dim;
    jmt_reg_start     = 1;
    jmt_reg_end       = y_dim;
    jmt_reg           = y_dim;
    kmt_reg_start     = 1;
    kmt_reg_end       = z_dim;
    kmt_reg           = z_dim;
  end
end

% SSE file(s)
c_dir_sse       = nc.c_dir_sse(:);
c_prefix_sse    = nc.c_prefix_sse(:);
ind0_sse        = nc.ind0_sse(:);
indn_sse        = nc.indn_sse(:);
maxsize_sse     = nc.maxsize_sse(:);
c_suffix_sse    = nc.c_suffix_sse(:);
nc_var_sse      = nc.nc_var_sse(:);
nc_att_mask_sse = nc.nc_att_mask_sse(:);

% Symphonie grid file and variable names
dir_grd_symp        = nc.dir_grd_symp(:);
fn_grd_symp         = nc.fn_grd_symp(:);
nc_var_lon_t_symp   = nc.nc_var_lon_t_symp(:);
nc_var_lon_u_symp   = nc.nc_var_lon_u_symp(:);
nc_var_lat_t_symp   = nc.nc_var_lat_t_symp(:);
nc_var_lat_v_symp   = nc.nc_var_lat_v_symp(:);
nc_var_depth_t_symp = nc.nc_var_depth_t_symp(:);
